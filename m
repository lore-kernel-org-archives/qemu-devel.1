Received: from eggs.gnu.org ([2001:4830:134:3::10]:33074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpa@zytor.com>) id 1gLE47-0003uF-2b
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 16:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpa@zytor.com>) id 1gLE43-0003kV-CU
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 16:11:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45657 helo=mail.zytor.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpa@zytor.com>) id 1gLE43-0003ET-43
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 16:11:39 -0500
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
	<CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
	<c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
	<20181109072015.GA86700@gmail.com>
	<38905d35-29af-b522-1629-b13e98a47a42@intel.com>
	<d30b404d-624e-0497-879a-2d5df2eb9f31@suse.com>
	<b7b608dc-1743-5e1f-3b88-94d784c4cab2@intel.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <d9c293bd-b43f-999c-55f1-3b90a6020065@zytor.com>
Date: Fri, 9 Nov 2018 13:10:49 -0800
MIME-Version: 1.0
In-Reply-To: <b7b608dc-1743-5e1f-3b88-94d784c4cab2@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <zhijianx.li@intel.com>, Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, x86@kernel.org, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, QEMU Developers <qemu-devel@nongnu.org>, Philip Li <philip.li@intel.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Kees Cook <keescook@chromium.org>

On 11/9/18 5:40 AM, Li Zhijian wrote:
> Just noticed that there is a field xloadflags at recent protocol
> =C2=A0 60 Protocol 2.12:=C2=A0 (Kernel 3.8) Added the xloadflags field =
and
> extension fields
> =C2=A0 61=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to struct boot_params for loading bzIma=
ge and ramdisk
> =C2=A0 62=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 above 4G in 64bit.
> [snip]
> =C2=A0617 Field name:=C2=A0=C2=A0=C2=A0=C2=A0 xloadflags
> =C2=A0618 Type:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 read
> =C2=A0619 Offset/size:=C2=A0=C2=A0=C2=A0 0x236/2
> =C2=A0620 Protocol:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.12+
> =C2=A0621
> =C2=A0622=C2=A0=C2=A0 This field is a bitmask.
> =C2=A0623
> =C2=A0624=C2=A0=C2=A0 Bit 0 (read): XLF_KERNEL_64
> =C2=A0625=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - If 1, this =
kernel has the legacy 64-bit entry point at
> 0x200.
> =C2=A0626
> =C2=A0627=C2=A0=C2=A0 Bit 1 (read): XLF_CAN_BE_LOADED_ABOVE_4G
> =C2=A0628=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - If 1, kerne=
l/boot_params/cmdline/ramdisk can be above 4G.
> =C2=A0629
>=20
> maybe we can reuse this field and append a new Bit 5
> XLF_INITRD_MAX_SIZE_4G and increase header version.
> For the old protocol version 2.12+, if=C2=A0 XLF_CAN_BE_LOADED_ABOVE_4G=
 is
> set, we can also realize ~4GB initrd is allowed.
>=20
> bootloader side:
> if protocol >=3D 2.15
> =C2=A0=C2=A0 if XLF_INITRD_LOAD_BELOW_4G
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 support ~4G initrd
> =C2=A0=C2=A0 fi
> else if protocol >=3D2.12
> =C2=A0=C2=A0 if XLF_CAN_BE_LOADED_ABOVE_4G
> =C2=A0=C2=A0=C2=A0 support ~4G initrd
> =C2=A0=C2=A0 fi
> fi
>=20

The two are equivalent.  Obviously you have to load above 4 GB if you
have more than 4 GB of initrd.  If XLF_CAN_BE_LOADED_ABOVE_4G is not
set, then you most likely are on a 32-bit kernel and there are more
fundamental limits (even if you were to load it above the 2 GB mark, you
would be limited by the size of kernel memory.)

So, in case you are wondering: the bootloader that broke when setting
the initrd_max field above 2 GB was, of course, Grub.

So just use XLF_CAN_BE_LOADED_ABOVE_4G. There is no need for a new flag
or new field.

Also note that the ext_ramdisk_image and ext_ramdisk_size are part of
struct boot_params as opposed to struct setup_header, which means that
they are not supported when entering via the 16-bit BIOS entry point,
and I am willing to bet that there will be, ahem, "strangeness" if
entered via the 32-bit entry point if at least the command line is
loaded above the 4 GB mark; the initrd should be fine, though.

This is obviosly not an issue in EFI environments, where we enter
through the EFI handover entry point.

The main reason these were not added to struct setup_header is that
there are only 24 bytes left in that header and so space is highly
precious. One way to deal with that if we really, really need to would
be to add an initrd/initramfs type of setup_data.

	-hpa
