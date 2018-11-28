Received: from eggs.gnu.org ([2001:4830:134:3::10]:48716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gS0sK-00022m-5X
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gS0sG-0000I0-V8
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:31:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gS0sG-0000H9-OI
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:31:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so20883421wrr.0
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 06:31:32 -0800 (PST)
References: <1543412590-29716-1-git-send-email-stefan.markovic@rt-rk.com>
	<1543412590-29716-2-git-send-email-stefan.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3ef23076-d0b4-4df3-d023-bf18ba33aade@redhat.com>
Date: Wed, 28 Nov 2018 15:31:28 +0100
MIME-Version: 1.0
In-Reply-To: <1543412590-29716-2-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-doc: Add nanoMIPS ISA information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pburton@wavecomp.com, smarkovic@wavecomp.com, jhogan@kernel.org, huth@tuxfamily.org, hpoussin@reactos.org, amarkovic@wavecomp.com, pjovanovic@wavecomp.com, Richard Henderson <richard.henderson@linaro.org>

Hi Stefan,

On 28/11/18 14:43, Stefan Markovic wrote:
> From: Stefan Markovic <smarkovic@wavecomp.com>
> 
> Add nanoMIPS information in qemu-doc.texi with example of usage
> included.
> 
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  qemu-doc.texi | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index f7ad1df..6ef593d 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -1994,6 +1994,10 @@ Set the emulated machine type. The default is sun4u.
>  @section MIPS System emulator
>  @cindex system emulation (MIPS)
>  
> +@menu
> +* nanoMIPS System emulator ::
> +@end menu
> +
>  Four executables cover simulation of 32 and 64-bit MIPS systems in
>  both endian options, @file{qemu-system-mips}, @file{qemu-system-mipsel}
>  @file{qemu-system-mips64} and @file{qemu-system-mips64el}.
> @@ -2085,6 +2089,31 @@ SCSI controller
>  G364 framebuffer
>  @end itemize
>  
> +@node nanoMIPS System emulator
> +@subsection nanoMIPS System emulator
> +@cindex system emulation (nanoMIPS)
> +
> +Executable @file{qemu-system-mipsel} also covers simulation of
> +32-bit nanoMIPS system in little endian mode:
> +
> +@itemize @minus
> +@item
> +nanoMIPS I7200 CPU
> +@end itemize
> +
> +Example of @file{qemu-system-mipsel} usage for nanoMIPS is shown below:
> +
> +Download @code{<disk_image_file>} from @url{https://mipsdistros.mips.com/LinuxDistro/nanomips/buildroot/index.html}.
> +
> +Download @code{<kernel_image_file>} from @url{https://mipsdistros.mips.com/LinuxDistro/nanomips/kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/index.html}.
> +
> +Start system emulation of Malta board with nanoMIPS I7200 CPU:
> +@example
> +qemu-system-mipsel -cpu I7200 -kernel @code{<kernel_image_file>} \
> +    -M malta -serial stdio -m @code{<memory_size>} -hda @code{<disk_image_file>} \
> +    -append "mem=256m@@0x0 rw console=ttyS0 vga=cirrus vesa=0x111 root=/dev/sda"

Trying your example with generic_nano32r6el_page64k_dbg current master
(c56606684) I'm getting:

IN: cgroup_init_early
0x8087ae64:  84f0 8050      LW a3, 0x50(s0)
0x8087ae68:  a630 2c48      SWM s1, 72(s0), 0x2
0x8087ae6c:  bb84           BNEZC a3, 0x8087ae72

OP:
 ld_i32 tmp0,env,$0xffffffffffffffe4
 movi_i32 tmp1,$0x0
 brcond_i32 tmp0,tmp1,lt,$L0

 ---- 8087ae64 00000000 00000000
 movi_i32 tmp0,$0x50
 add_i32 tmp0,s0,tmp0
 qemu_ld_i32 tmp0,tmp0,un+leul,0
 mov_i32 a3,tmp0

 ---- 8087ae68 00000000 00000000
 movi_i32 tmp0,$0x48
 add_i32 tmp0,s0,tmp0
 mov_i32 tmp1,s1
 qemu_st_i32 tmp1,tmp0,leul,0
 movi_i32 tmp0,$0x4c
 add_i32 tmp0,s0,tmp0
 mov_i32 tmp1,s2
 qemu_st_i32 tmp1,tmp0,leul,0

 ---- 8087ae6c 00000000 00000000
 mov_i32 tmp0,a3
 movi_i32 tmp1,$0x0
 setcond_i32 bcond,tmp0,tmp1,ne
 movi_i32 tmp0,$0x0
 brcond_i32 bcond,tmp0,ne,$L1
 goto_tb $0x1
 movi_i32 PC,$0xffffffff8087ae6e
 exit_tb $0x7f80a2005f01
 set_label $L1
 goto_tb $0x0
 movi_i32 PC,$0xffffffff8087ae72
 exit_tb $0x7f80a2005f00
 set_label $L0
 exit_tb $0x7f80a2005f03

qemu-system-mipsel: tcg/tcg-op.c:2607: tcg_gen_goto_tb: Assertion
`(tcg_ctx->goto_tb_issue_mask & (1 << idx)) == 0' failed.

Richard said on IRC "it means that it has issued two goto_tb with the
same idx."

I built QEMU on a x86_64 host, using the following options:

./configure --disable-user \
 --enable-vnc-sasl --enable-trace-backends=log \
 --extra-cflags=-ggdb --enable-debug

Regards,

Phil.

> +@end example
> +
>  
>  @node ARM System emulator
>  @section ARM System emulator
> 
