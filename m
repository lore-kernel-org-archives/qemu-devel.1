Received: from eggs.gnu.org ([2001:4830:134:3::10]:47675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkR5v-0007YR-9x
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkR5r-00072W-Tk
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:37:31 -0400
Date: Tue, 31 Jul 2018 11:37:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180731113723.65473b77.cohuck@redhat.com>
In-Reply-To: <20180731090448.36662-3-borntraeger@de.ibm.com>
References: <20180731090448.36662-1-borntraeger@de.ibm.com>
	<20180731090448.36662-3-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x/kvm: add etoken facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>

On Tue, 31 Jul 2018 11:04:48 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Provide the etoken facility. We need to handle cpu model, migration and
> clear reset.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/cpu.h              |  3 +++
>  target/s390x/cpu_features.c     |  3 ++-
>  target/s390x/cpu_features_def.h |  3 ++-
>  target/s390x/gen-features.c     |  3 ++-
>  target/s390x/kvm.c              | 11 +++++++++++
>  target/s390x/machine.c          | 20 +++++++++++++++++++-
>  6 files changed, 39 insertions(+), 4 deletions(-)

> @@ -106,6 +106,7 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("irbm", S390_FEAT_TYPE_STFL, 145, "Insert-reference-bits-multiple facility"),
>      FEAT_INIT("msa8-base", S390_FEAT_TYPE_STFL, 146, "Message-security-assist-extension-8 facility (excluding subfunctions)"),
>      FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement (no translate) facility"),
> +    FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "etoken facility"),

Don't facilities usually start with a capital letter?

>  
>      /* SCLP SCCB Byte 80 - 98  (bit numbers relative to byte-80) */
>      FEAT_INIT("gsls", S390_FEAT_TYPE_SCLP_CONF_CHAR, 40, "SIE: Guest-storage-limit-suppression facility"),
