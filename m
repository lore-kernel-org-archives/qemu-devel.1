Received: from eggs.gnu.org ([2001:4830:134:3::10]:50540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben.hekster@foghorn.io>) id 1gZfvD-0002cz-3X
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben.hekster@foghorn.io>) id 1gZfv8-00050s-Ur
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:46:14 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:40123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben.hekster@foghorn.io>)
	id 1gZfv8-000506-8F
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:46:10 -0500
Received: by mail-pg1-x533.google.com with SMTP id z10so9754369pgp.7
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 09:46:09 -0800 (PST)
From: Ben Hekster <ben.hekster@foghorn.io>
Message-Id: <ECFBC025-CD7F-444B-BF7F-62E20954A85A@foghorn.io>
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Date: Wed, 19 Dec 2018 09:46:05 -0800
In-Reply-To: <CAFEAcA-PJadBG0sE43N9wEx9Qm3Nxu2am_0Zy2Zqtz66C9SJ-w@mail.gmail.com>
References: <83206F6D-0BA5-4781-8635-84D48DD33A2A@foghorn.io>
	<CAFEAcA-PJadBG0sE43N9wEx9Qm3Nxu2am_0Zy2Zqtz66C9SJ-w@mail.gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Booting Raspbian on RPi emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>

> On Dec 19, 2018, at 05:17, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
>=20
> OSX works for me, though I don't test it thoroughly. If you
> are getting a crash that you can reproduce, please could
> you repro it under a debugger with a debug build of QEMU
> and send the all-threads backtrace for the crash?
>=20
> thanks
> -- PMM

Still reproducible with current master on OS X Mojave 10.14.1.  Command =
line:

$ arm-softmmu/qemu-system-arm -M raspi2 -append "console=3DttyAMA0,115200 =
root=3D/dev/mmcblk0p2 rootwait rw" -cpu cortex-a7 -dtb =
bcm2709-rpi-2-b.dtb -drive =
file=3D2018-11-13-raspbian-stretch-lite.img,if=3Dsd,format=3Draw -kernel =
kernel7.img -m 256m -no-reboot

Stack trace of crashing thread:

2018-12-19 09:33:01.348 qemu-system-arm[93254:2731556] *** Terminating =
app due to uncaught exception 'NSInternalInconsistencyException', =
reason: 'NSWindow drag regions should only be invalidated on the Main =
Thread!'
*** First throw call stack:
(
	0   CoreFoundation                      0x00007fff35291e65 =
__exceptionPreprocess + 256
	1   libobjc.A.dylib                     0x00007fff612ed720 =
objc_exception_throw + 48
	2   CoreFoundation                      0x00007fff352ab8e5 =
-[NSException raise] + 9
	3   AppKit                              0x00007fff327b07e6 =
-[NSWindow(NSWindow_Theme) =
_postWindowNeedsToResetDragMarginsUnlessPostingDisabled] + 324
	4   AppKit                              0x00007fff327b5c40 =
-[NSView setFrameSize:] + 2082
	5   AppKit                              0x00007fff32826975 =
-[NSVisualEffectView setFrameSize:] + 171
	6   AppKit                              0x00007fff328806a5 =
-[NSTitlebarView setFrameSize:] + 84
	7   AppKit                              0x00007fff327b4c49 =
-[NSView setFrame:] + 478
	8   AppKit                              0x00007fff32880648 =
-[NSTitlebarView resizeWithOldSuperviewSize:] + 100
	9   AppKit                              0x00007fff327bbde6 =
-[NSView resizeSubviewsWithOldSize:] + 502
	10  AppKit                              0x00007fff327b5ac9 =
-[NSView setFrameSize:] + 1707
	11  AppKit                              0x00007fff3317604c =
-[NSTitlebarContainerView setFrameSize:] + 142
	12  AppKit                              0x00007fff327b4c49 =
-[NSView setFrame:] + 478
	13  AppKit                              0x00007fff327bc23d =
-[NSView resizeWithOldSuperviewSize:] + 776
	14  AppKit                              0x00007fff327bbde6 =
-[NSView resizeSubviewsWithOldSize:] + 502
	15  AppKit                              0x00007fff327b5ac9 =
-[NSView setFrameSize:] + 1707
	16  AppKit                              0x00007fff32823a5e =
-[NSThemeFrame setFrameSize:] + 495
	17  AppKit                              0x00007fff3281070b =
-[NSWindow _setFrame:updateBorderViewSize:] + 966
	18  AppKit                              0x00007fff3281002e =
-[NSWindow _oldPlaceWindow:] + 547
	19  AppKit                              0x00007fff3280f639 =
-[NSWindow _setFrameCommon:display:stashSize:] + 3006
	20  AppKit                              0x00007fff3280ea65 =
-[NSWindow _setFrame:display:allowImplicitAnimation:stashSize:] + 192
	21  AppKit                              0x00007fff3280e99e =
-[NSWindow setFrame:display:] + 51
	22  AppKit                              0x00007fff3281932f =
-[NSWindow setFrame:display:animate:] + 130
	23  qemu-system-arm                     0x00000001035cb13a =
-[QemuCocoaView switchSurface:] + 2282
	24  qemu-system-arm                     0x00000001035d102e =
cocoa_switch + 94
	25  qemu-system-arm                     0x00000001035bfa46 =
dpy_gfx_replace_surface + 278
	26  qemu-system-arm                     0x00000001035c1721 =
qemu_console_resize + 209
	27  qemu-system-arm                     0x000000010310be80 =
bcm2835_fb_reconfigure + 112
	28  qemu-system-arm                     0x000000010315a65c =
bcm2835_property_mbox_push + 4156
	29  qemu-system-arm                     0x0000000103159584 =
bcm2835_property_write + 148
	30  qemu-system-arm                     0x0000000103097cf3 =
memory_region_write_accessor + 243
	31  qemu-system-arm                     0x0000000103097bd6 =
access_with_adjusted_size + 454
	32  qemu-system-arm                     0x0000000103097702 =
memory_region_dispatch_write + 258
	33  qemu-system-arm                     0x000000010301bb84 =
address_space_stl_internal + 212
	34  qemu-system-arm                     0x000000010301bca7 =
address_space_stl_le + 55
	35  qemu-system-arm                     0x0000000103158fd4 =
stl_le_phys + 84
	36  qemu-system-arm                     0x0000000103158a6c =
bcm2835_mbox_write + 428
	37  qemu-system-arm                     0x0000000103097cf3 =
memory_region_write_accessor + 243
	38  qemu-system-arm                     0x0000000103097bd6 =
access_with_adjusted_size + 454
	39  qemu-system-arm                     0x0000000103097702 =
memory_region_dispatch_write + 258
	40  qemu-system-arm                     0x00000001030e00d5 =
io_writex + 805
	41  qemu-system-arm                     0x00000001030c06d7 =
io_writel + 151
	42  qemu-system-arm                     0x00000001030c02f7 =
helper_le_stl_mmu + 1015
	43  ???                                 0x00000001091aa705 0x0 + =
4447708933
)
libc++abi.dylib: terminating with uncaught exception of type NSException
Abort trap: 6

The stack trace looks pretty self-explanatory ("NSWindow drag regions =
should only be invalidated on the Main Thread!"); probably a =
manifestation of https://bugs.launchpad.net/qemu/+bug/1802684 =
<https://bugs.launchpad.net/qemu/+bug/1802684>.  Let me know if there's =
anything else I can do,

Ben
