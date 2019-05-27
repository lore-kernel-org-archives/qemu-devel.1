Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C80C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 13:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1710620859
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 13:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1710620859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46094 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVFpj-0000FT-BB
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 09:38:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hVFoq-0008KK-3p
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hVFop-0000KV-2W
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:37:40 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:37473)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hVFoo-0000K1-Qk; Mon, 27 May 2019 09:37:39 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MUokB-1h4TZt1bv7-00Qj49; Mon, 27 May 2019 15:36:52 +0200
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190525225013.13916-1-laurent@vivier.eu>
	<20190525225013.13916-11-laurent@vivier.eu>
	<CAL1e-=gMHkc5yj5R5gP-yBy1Lf7Q9okEPkovLfbpT0UcdC6kbQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <998b759a-5f97-0c24-6ce5-3dcae5ecff36@vivier.eu>
Date: Mon, 27 May 2019 15:36:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gMHkc5yj5R5gP-yBy1Lf7Q9okEPkovLfbpT0UcdC6kbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3FtbgILM3eqgDn1kKM6b3YPmPZjPs9V9fQYSVCmOj7VqsaQLeMX
	+LpSN8altjjF3K2MKTO8frb1yVAiQ799M7+ofL45E3LT4lKXgcmX7TPPlYgJxkjWd4pwDMM
	6yeVxWfCT+/Cndq31KnMtbxmiefluDXU5z/7d2ZuMru+A56bNMX/Rv4AaO2pHvPrCQyGFWj
	QZxoXA9MDEoLmFSleaRLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7J/crCkYoHk=:9SW9p7XOOnvQz67Ids7Nmm
	+gDCgDoWudcwLRLif04sTeYokba2p82E+cVKp+QuunGkVAqVazLSpaT92Vx/a/lzMXE4Z637u
	1pgpE21hMgQu522/aNI1BnI1u35Nxs3q6m/hWg1X+WpfkOxL+Sxa/ZLLdvy74Jzymdl7+al6W
	cwhLam+F8YohOMfsss41SAWOwLDUyhSw3I7wFzxb7Au0Qn1CFIZ95rvLjjf7rS0cdGKXow8IV
	B59uz+QILwMiv9gN4FeXQN7ahDU5JvDo46A9iRg5zEPQQObaQ1q9GrKn9vPQIaawicW2sZJ8l
	FVwWNGCiCEtex7HEKMr95UH8NdNrBXxEJJDJXi8bg1F5ObAS676SGUXXMkH+GQOVMaZcktS1h
	52oIUBRdB8l6W/rWRXJSpydHjRKwGqk0n/yN7+R/ie5FIUxOdrAVs+F/jxCuvt1lNum46Cx/d
	uTDydDwZPWRcdpPYeuVYfUfnOGkQeC+c+Xevv74vgpM/Pb3B7sdhF+5JFyiSS7ZoD2vy+DxOa
	zl5GyOJ9ZkbyKocczRQq4mod8Jbo4mOs51MfL/lTY2/rkFbqrgrHQ1/GP/NKq0cigxr+qhiT/
	Hx3AJ8wqcNsllFkQlXBQK/cjkZe9tf1nvNaV7WbH/NQHTE2yPkRnlsfukn0TvlsfNAnIj8QgA
	uPtF6xhPGxm5nDq0PwFkbr1k+0zbAnw6LLiWKfRG8l7LmkcgE405H3qd0Z78fPNw5HMQubCuA
	SCzvNSjoD7VAKLJz3WMnffJYnpBZw30auqYCRuKFvtmXUoggmNg3nDuJCK4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] [PATCH v7 10/10] hw/m68k: define Macintosh Quadra
 800
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
	qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
	Jason Wang <jasowang@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	=?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	Max Reitz <mreitz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/05/2019 15:32, Aleksandar Markovic wrote:
> 
> On May 26, 2019 1:07 AM, "Laurent Vivier" <laurent@vivier.eu 
> <mailto:laurent@vivier.eu>> wrote:
>  >
>  > If you want to test the machine, it doesn't yet boot a MacROM, but 
> you can
>  > boot a linux kernel from the command line.
>  >
>  > You can install your own disk using debian-installer with:
>  >
>  >     ./qemu-system-m68k \
>  >     -M q800 \
>  >     -serial none -serial mon:stdio \
>  >     -m 1000M -drive file=m68k.qcow2,format=qcow2 \
>  >     -net nic,model=dp83932,addr=09:00:07:12:34:57 \
>  >     -append "console=ttyS0 vga=off" \
>  >     -kernel vmlinux-4.15.0-2-m68k \
>  >     -initrd initrd.gz \
>  >     -drive file=debian-9.0-m68k-NETINST-1.iso \
>  >     -drive file=m68k.qcow2,format=qcow2 \
>  >     -nographic
>  >
> 
> Hello Laurent,

Hello Aleksandar,

> How does one obtain vmlinux-4.15.0-2-m68 and init.rd?
> 

you can find more details in the cover letter:

  You can get the ISO from:

    https://cdimage.debian.org/cdimage/ports/10.0/m68k/iso-cd/debian-10.0-m68k-NETINST-1.iso

  and extract the kernel and initrd.gz:

    guestfish --add debian-10.0-m68k-NETINST-1.iso --ro \
              --mount /dev/sda:/ <<_EOF_
    copy-out /install/cdrom/initrd.gz .
    copy-out /install/kernels/vmlinux-4.16.0-1-m68k .
    _EOF_

  The mirror to use is: http://ftp.ports.debian.org/debian-ports/
  when it fails, continue without boot loader.

  In the same way, you can extract the kernel and the initramfs from the qcow2
  image to use it with "-kernel" and "-initrd":

    guestfish --add m68k.qcow2 --mount /dev/sda2:/ <<_EOF_
    copy-out /boot/vmlinux-4.16.0-1-m68k .
    copy-out /boot/initrd.img-4.16.0-1-m68k .
    _EOF_

Thanks,
Laurent

