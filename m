Received: from eggs.gnu.org ([2001:4830:134:3::10]:39917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ettXp-0003QM-Ot
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ettXo-0000yl-R8
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:17:09 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:40171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ettXo-0000yZ-Kz
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:17:08 -0500
Received: by mail-ot0-x243.google.com with SMTP id l12so5056088otj.7
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 03:17:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180307180358.30393-1-marcandre.lureau@redhat.com>
References: <20180307180358.30393-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Mar 2018 11:16:47 +0000
Message-ID: <CAFEAcA8WmSL1WLb=KAHDVo=N7gMSju_oOcP2Tn7b=nYzc2GLhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] arm: fix load ELF error leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 7 March 2018 at 18:03, Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.c=
om> wrote:
> Spotted by ASAN:
> QTEST_QEMU_BINARY=3Daarch64-softmmu/qemu-system-aarch64 tests/boot-serial=
-test
>
> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>     #0 0x7ff8a9b0ca38 in __interceptor_calloc (/lib64/libasan.so.4+0xdea3=
8)
>     #1 0x7ff8a8ea7f75 in g_malloc0 ../glib/gmem.c:124
>     #2 0x55fef3d99129 in error_setv /home/elmarco/src/qemu/util/error.c:5=
9
>     #3 0x55fef3d99738 in error_setg_internal /home/elmarco/src/qemu/util/=
error.c:95
>     #4 0x55fef323acb2 in load_elf_hdr /home/elmarco/src/qemu/hw/core/load=
er.c:393
>     #5 0x55fef2d15776 in arm_load_elf /home/elmarco/src/qemu/hw/arm/boot.=
c:830
>     #6 0x55fef2d16d39 in arm_load_kernel_notify /home/elmarco/src/qemu/hw=
/arm/boot.c:1022
>     #7 0x55fef3dc634d in notifier_list_notify /home/elmarco/src/qemu/util=
/notify.c:40
>     #8 0x55fef2fc3182 in qemu_run_machine_init_done_notifiers /home/elmar=
co/src/qemu/vl.c:2716
>     #9 0x55fef2fcbbd1 in main /home/elmarco/src/qemu/vl.c:4679
>     #10 0x7ff89dfed009 in __libc_start_main (/lib64/libc.so.6+0x21009)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks, applied patches 1 and 2 to target-arm.next.

For the future, when you're sending a patchset that's more than one
patch can you make sure you send a cover letter, please? The automated
tooling wants to see the cover letter, and if there isn't one I have
to mess about with fishing the patches out of email and applying them
by hand, which is a faff.

thanks
-- PMM
