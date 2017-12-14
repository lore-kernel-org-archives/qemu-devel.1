Received: from eggs.gnu.org ([2001:4830:134:3::10]:49010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePSUJ-0005jJ-2D
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePSUF-0008DR-3t
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:19:43 -0500
Date: Thu, 14 Dec 2017 13:19:34 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171214131934.20f77443.cohuck@redhat.com>
In-Reply-To: <20171213171512.17601-1-david@redhat.com>
References: <20171208165529.14124-1-david@redhat.com>
	<20171213171512.17601-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/tcg: don't include z13 features
 in the qemu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Wed, 13 Dec 2017 18:15:12 +0100
David Hildenbrand <david@redhat.com> wrote:

> As Cornelia noticed, -cpu qemu will not boot on a z12 machine. Don't
> enable z13 features as default for now (as we are emulating a z12 in
> TCG for now).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/gen-features.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index deace660e1..b24f6ada5b 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -570,13 +570,14 @@ static uint16_t qemu_LATEST[] = {
>      S390_FEAT_STFLE_49,
>      S390_FEAT_LOCAL_TLB_CLEARING,
>      S390_FEAT_INTERLOCKED_ACCESS_2,
> -    S390_FEAT_STFLE_53,
>      S390_FEAT_MSA_EXT_4,
>      S390_FEAT_MSA_EXT_3,
>  };
>  
>  /* add all new definitions before this point */
>  static uint16_t qemu_MAX[] = {
> +    /* z13+ features */
> +    S390_FEAT_STFLE_53,
>      /* generates a dependency warning, leave it out for now */
>      S390_FEAT_MSA_EXT_5,
>  };

Squashed into "s390x: change the QEMU cpu model to a stripped down z12"
and pushed out to s390-next.
