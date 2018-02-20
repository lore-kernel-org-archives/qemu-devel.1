Received: from eggs.gnu.org ([2001:4830:134:3::10]:47210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eoAEe-0008Ci-6K
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eoAEZ-0002nr-7V
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:53:40 -0500
Date: Tue, 20 Feb 2018 16:53:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180220165323.02898d8a.cohuck@redhat.com>
In-Reply-To: <20180220150713.6056-1-pasic@linux.vnet.ibm.com>
References: <20180220150713.6056-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/1] 390x/cpumodel: document
 S390FeatDef.bit not applicable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On Tue, 20 Feb 2018 16:07:13 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> The 'bit' field of the 'S390FeatDef' structure is not applicable to all
> it's instances. Currently a this field is not applicable, and remains

s/it's/its/

s/a this/this/

> unused, iff the feature is of type S390_FEAT_TYPE_MISC. Having the value 0
> specified for multiple such feature definition  was a little confusing,
> as it's a perfectly legit bit value, and as usually the value of the bit
> field is ought to be unique for each feature.
> 
> Let's document this, and hopefully reduce the potential for confusion.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
> 
> Hi!
> 
> This may be an overkill. A comment where the misc features
> are defined would do to, but I think this is nicer. So
> I decided to try it with this approach first.

Is there likely to be anything else than FEAT_MISC _not_ using .bit? If
not, would it be better to at a comment to the FEAT_MISC definition?

> 
> ---
>  target/s390x/cpu_features.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index a5619f2893..34fddfe78b 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -23,6 +23,13 @@
>          .desc = _desc,                               \
>      }
>  
> +/*
> + * For some feature types (e.g. S390_FEAT_TYPE_MISC) S390FeatDef.bit
> + * is not applicable, as there is no corresponding feature block. See
> + * s390_fill_feat_block() and it's usages.
> + */
> +#define FEAT_BIT_NA -1
> +
>  /* indexed by feature number for easy lookup */
>  static const S390FeatDef s390_features[] = {
>      FEAT_INIT("esan3", S390_FEAT_TYPE_STFL, 0, "Instructions marked as n3"),
> @@ -123,8 +130,8 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("ib", S390_FEAT_TYPE_SCLP_CPU, 42, "SIE: Intervention bypass facility"),
>      FEAT_INIT("cei", S390_FEAT_TYPE_SCLP_CPU, 43, "SIE: Conditional-external-interception facility"),
>  
> -    FEAT_INIT("dateh2", S390_FEAT_TYPE_MISC, 0, "DAT-enhancement facility 2"),
> -    FEAT_INIT("cmm", S390_FEAT_TYPE_MISC, 0, "Collaborative-memory-management facility"),
> +    FEAT_INIT("dateh2", S390_FEAT_TYPE_MISC, FEAT_BIT_NA, "DAT-enhancement facility 2"),
> +    FEAT_INIT("cmm", S390_FEAT_TYPE_MISC, FEAT_BIT_NA, "Collaborative-memory-management facility"),
>  
>      FEAT_INIT("plo-cl", S390_FEAT_TYPE_PLO, 0, "PLO Compare and load (32 bit in general registers)"),
>      FEAT_INIT("plo-clg", S390_FEAT_TYPE_PLO, 1, "PLO Compare and load (64 bit in parameter list)"),
