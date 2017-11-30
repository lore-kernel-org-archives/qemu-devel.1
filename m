Received: from eggs.gnu.org ([2001:4830:134:3::10]:36834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKNRT-0000na-CI
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 06:55:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKNRQ-0007Wm-AQ
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 06:55:47 -0500
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-14-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <12a3abb4-6510-fea5-f4e3-d71ce07213a5@redhat.com>
Date: Thu, 30 Nov 2017 12:55:37 +0100
MIME-Version: 1.0
In-Reply-To: <20171129202701.16117-14-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 for-2.12 13/16] s390x/tcg:
 use s390_program_interrupt() in SACF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On 29.11.2017 21:26, David Hildenbrand wrote:
> Convert this user, too.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cc_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
> index f008897e84..5d91e458a8 100644
> --- a/target/s390x/cc_helper.c
> +++ b/target/s390x/cc_helper.c
> @@ -564,7 +564,7 @@ void HELPER(sacf)(CPUS390XState *env, uint64_t a1)
>          break;
>      default:
>          HELPER_LOG("unknown sacf mode: %" PRIx64 "\n", a1);
> -        program_interrupt(env, PGM_SPECIFICATION, 2);
> +        s390_program_interrupt(env, PGM_SPECIFICATION, 2, GETPC());
>          break;
>      }
>  }
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
