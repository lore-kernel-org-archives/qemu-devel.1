Received: from eggs.gnu.org ([2001:4830:134:3::10]:35619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJS0d-0000nz-Kf
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 18:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJS0Z-0007O0-O1
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 18:03:59 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dJS0Z-0007Mp-J6
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 18:03:55 -0400
Received: by mail-qt0-x242.google.com with SMTP id o21so17982810qtb.1
	for <qemu-devel@nongnu.org>; Fri, 09 Jun 2017 15:03:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170609133426.11447-1-david@redhat.com>
	<20170609133426.11447-2-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5b81423c-7034-e218-8571-25bd8360b06b@twiddle.net>
Date: Fri, 9 Jun 2017 15:03:52 -0700
MIME-Version: 1.0
In-Reply-To: <20170609133426.11447-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] target/s390x: specification
 exceptions are suppressing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com

On 06/09/2017 06:34 AM, David Hildenbrand wrote:
> The PSW in the old PSW has to point at the next instruction, as
> specification exceptions are defined to be "suppressing or completed",
> but not nullified.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   target/s390x/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index a8d20c5..42a2465 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -737,6 +737,6 @@ void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>       if (retaddr) {
>           cpu_restore_state(cs, retaddr);
>       }
> -    program_interrupt(env, PGM_SPECIFICATION, ILEN_LATER);
> +    program_interrupt(env, PGM_SPECIFICATION, ILEN_LATER_INC);

I folded this into your following patch to use ILEN_AUTO.


r~
