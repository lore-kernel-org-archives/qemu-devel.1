Received: from eggs.gnu.org ([2001:4830:134:3::10]:51051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1difof-00017x-Ts
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1difoc-0003Rz-Sk
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:51:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1difoc-0003Rf-MA
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:51:50 -0400
References: <20170818114844.30061-1-cohuck@redhat.com>
	<20170818114844.30061-2-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5bb8d597-2217-4cf5-3066-358714923f16@redhat.com>
Date: Fri, 18 Aug 2017 13:51:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170818114844.30061-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] s390x/tcg: specification exception
 for unknown diag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, borntraeger@de.ibm.com

On 18.08.2017 13:48, Cornelia Huck wrote:
> While the PoP is silent on the issue, z/VM documentation states
> that unknown diagnose codes trigger a specification exception.
> We already do that when running with kvm, so change tcg to do so
> as well.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/s390x/misc_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index d23ffcd890..5a1eba02ab 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -109,7 +109,7 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
>      }
>  
>      if (r) {
> -        program_interrupt(env, PGM_OPERATION, ILEN_AUTO);
> +        program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
>      }
>  }

Reviewed-by: Thomas Huth <thuth@redhat.com>
