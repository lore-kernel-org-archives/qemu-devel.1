Received: from eggs.gnu.org ([2001:4830:134:3::10]:48377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWUd-0008CX-IO
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWUY-0007Y4-95
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:43:46 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWUY-0007XO-4I
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:43:42 -0400
Received: by mail-qk0-x242.google.com with SMTP id o77so6195495qke.2
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 14:43:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1505158760.git.alistair.francis@xilinx.com>
	<e6acff8db6d264f913a18c86858b9aa600554e51.1505158760.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <54d9d7e5-b28e-092d-5579-d35e60c55240@amsat.org>
Date: Mon, 11 Sep 2017 18:43:32 -0300
MIME-Version: 1.0
In-Reply-To: <e6acff8db6d264f913a18c86858b9aa600554e51.1505158760.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 6/8] target/mips: Convert VM clock
 update prints to warn_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, James Hogan <james.hogan@imgtec.com>, pbonzini@redhat.com, armbru@redhat.com

(Cc'ing Yongbok and Aurelien from get_maintainer.pl)

On 09/11/2017 04:52 PM, Alistair Francis wrote:
> Convert the fprintf() messages in kvm_mips_update_state() to use
> warn_report() as they aren't errors, but are just warnings.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Cc: James Hogan <james.hogan@imgtec.com>
> ---
> 
>   target/mips/kvm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index a23aa438d2..3b7b1d962a 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -526,7 +526,7 @@ static void kvm_mips_update_state(void *opaque, int running, RunState state)
>           if (!cs->vcpu_dirty) {
>               ret = kvm_mips_save_count(cs);
>               if (ret < 0) {
> -                fprintf(stderr, "Failed saving count\n");
> +                warn_report("Failed saving count");
>               }
>           }
>       } else {
> @@ -535,14 +535,14 @@ static void kvm_mips_update_state(void *opaque, int running, RunState state)
>           ret = kvm_mips_put_one_ureg64(cs, KVM_REG_MIPS_COUNT_RESUME,
>                                         &count_resume);
>           if (ret < 0) {
> -            fprintf(stderr, "Failed setting COUNT_RESUME\n");
> +            warn_report("Failed setting COUNT_RESUME");
>               return;
>           }
>   
>           if (!cs->vcpu_dirty) {
>               ret = kvm_mips_restore_count(cs);
>               if (ret < 0) {
> -                fprintf(stderr, "Failed restoring count\n");
> +                warn_report("Failed restoring count");
>               }
>           }
>       }
> 
