Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE04C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 21:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A722070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 21:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A722070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHxAO-0006My-Fs
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 17:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iHx9B-0005nq-In
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 17:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iHx97-0008VM-Pk
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 17:35:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39616)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1iHx8v-0008M4-DB; Tue, 08 Oct 2019 17:35:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 19F2410DCC9D;
 Tue,  8 Oct 2019 21:35:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-151.rdu2.redhat.com
 [10.10.122.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AF625D70D;
 Tue,  8 Oct 2019 21:35:33 +0000 (UTC)
Date: Tue, 8 Oct 2019 17:35:31 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 1/5] tests/boot_linux_console: Add initrd test for the
 Exynos4210
Message-ID: <20191008213531.GA11091@localhost.localdomain>
References: <20191005154748.21718-1-f4bug@amsat.org>
 <20191005154748.21718-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191005154748.21718-2-f4bug@amsat.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Tue, 08 Oct 2019 21:35:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Basse <contact@fredericb.info>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Evgeny Voevodin <e.voevodin@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-devel@nongnu.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Dmitry Solodkiy <d.solodkiy@samsung.com>, Maksim Kozlov <m.kozlov@samsung.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 05, 2019 at 05:47:44PM +0200, Philippe Mathieu-Daud=E9 wrote:
> This test boots a Linux kernel on a smdkc210 board and verify
> the serial output is working.
>=20
> The cpio image used comes from the linux-build-test project:
> https://github.com/groeck/linux-build-test
>=20
> If ARM is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:arm" tags.
>=20
> This test can be run using:
>=20
>   $ avocado --show=3Dapp,console run -t machine:smdkc210 tests/acceptan=
ce/boot_linux_console.py
>   console: Booting Linux on physical CPU 0x900
>   console: Linux version 4.19.0-6-armmp (debian-kernel@lists.debian.org=
) (gcc version 8.3.0 (Debian 8.3.0-6)) #1 SMP Debian 4.19.67-2+deb10u1 (2=
019-09-20)
>   console: CPU: ARMv7 Processor [410fc090] revision 0 (ARMv7), cr=3D10c=
5387d
>   console: CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing in=
struction cache
>   console: OF: fdt: Machine model: Samsung smdkv310 evaluation board ba=
sed on Exynos4210
>   [...]
>   console: Samsung CPU ID: 0x43210211
>   console: random: get_random_bytes called from start_kernel+0xa0/0x504=
 with crng_init=3D0
>   console: percpu: Embedded 17 pages/cpu s39756 r8192 d21684 u69632
>   console: Built 1 zonelists, mobility grouping on.  Total pages: 24915=
2
>   console: Kernel command line: printk.time=3D0 console=3DttySAC0,11520=
0n8 earlyprintk random.trust_cpu=3Doff cryptomgr.notests cpuidle.off=3D1 =
panic=3D-1 noreboot
>   [...]
>   console: L2C: platform modifies aux control register: 0x02020000 -> 0=
x3e420001
>   console: L2C: platform provided aux values permit register corruption=
.
>   console: L2C: DT/platform modifies aux control register: 0x02020000 -=
> 0x3e420001
>   console: L2C-310 erratum 769419 enabled
>   console: L2C-310 enabling early BRESP for Cortex-A9
>   console: L2C-310: enabling full line of zeros but not enabled in Cort=
ex-A9
>   console: L2C-310 ID prefetch enabled, offset 1 lines
>   console: L2C-310 dynamic clock gating disabled, standby mode disabled
>   console: L2C-310 cache controller enabled, 8 ways, 128 kB
>   console: L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x7e420001
>   console: Exynos4210 clocks: sclk_apll =3D 12000000, sclk_mpll =3D 120=
00000
>   console: sclk_epll =3D 12000000, sclk_vpll =3D 12000000, arm_clk =3D =
12000000
>   [...]
>   console: s3c-i2c 13860000.i2c: slave address 0x00
>   console: s3c-i2c 13860000.i2c: bus frequency set to 93 KHz
>   console: s3c-i2c 13860000.i2c: i2c-0: S3C I2C adapter
>   [...]
>   console: dma-pl330 12680000.pdma: Loaded driver for PL330 DMAC-241330
>   console: dma-pl330 12680000.pdma:       DBUFF-256x8bytes Num_Chans-8 =
Num_Peri-32 Num_Events-16
>   console: dma-pl330 12690000.pdma: Loaded driver for PL330 DMAC-241330
>   console: dma-pl330 12690000.pdma:       DBUFF-256x8bytes Num_Chans-8 =
Num_Peri-32 Num_Events-16
>   console: dma-pl330 12850000.mdma: Loaded driver for PL330 DMAC-241330
>   console: dma-pl330 12850000.mdma:       DBUFF-256x8bytes Num_Chans-8 =
Num_Peri-1 Num_Events-16
>   console: dma-pl330 12850000.mdma: PM domain LCD0 will not be powered =
off
>   console: Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
>   console: Serial: AMBA driver
>   console: 13800000.serial: ttySAC0 at MMIO 0x13800000 (irq =3D 40, bas=
e_baud =3D 0) is a S3C6400/10
>   console: console [ttySAC0] enabled
>   console: 13810000.serial: ttySAC1 at MMIO 0x13810000 (irq =3D 41, bas=
e_baud =3D 0) is a S3C6400/10
>   console: 13820000.serial: ttySAC2 at MMIO 0x13820000 (irq =3D 42, bas=
e_baud =3D 0) is a S3C6400/10
>   console: 13830000.serial: ttySAC3 at MMIO 0x13830000 (irq =3D 43, bas=
e_baud =3D 0) is a S3C6400/10
>   [...]
>   console: Freeing unused kernel memory: 2048K
>   console: Run /init as init process
>   console: mount: mounting devtmpfs on /dev failed: Device or resource =
busy
>   console: Starting logging: OK
>   console: Initializing random number generator... random: dd: uninitia=
lized urandom read (512 bytes read)
>   console: done.
>   console: Starting network: OK
>   console: Found console ttySAC0
>   console: Linux version 4.19.0-6-armmp (debian-kernel@lists.debian.org=
) (gcc version 8.3.0 (Debian 8.3.0-6)) #1 SMP Debian 4.19.67-2+deb10u1 (2=
019-09-20)
>   console: Boot successful.
>   PASS (37.98 s)
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> serial input is not working :(
>=20
> I sometime get (not always):
>=20
> Starting network: OK
> [   70.403690] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [   70.423212] rcu:     0-...!: (36 GPs behind) idle=3Dc7a/1/0x40000000=
 softirq=3D287/288 fqs=3D1
> [   70.428209] rcu:     (detected by 1, t=3D2602 jiffies, g=3D-443, q=3D=
2209)
> [   70.432826] Sending NMI from CPU 1 to CPUs 0:
> [   70.473866] NMI backtrace for cpu 0
> [   70.476621] CPU: 0 PID: 112 Comm: cat Not tainted 4.19.0 #1
> [   70.476711] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [   70.476916] PC is at mntput_no_expire+0x88/0x464
> [   70.476996] LR is at rcu_is_watching+0x24/0x78
> [   70.477074] pc : [<c02b256c>]    lr : [<c01a2fb4>]    psr: a0000013
> [   70.477150] sp : ee2afdb0  ip : 9dff9a2f  fp : ee2aff70
> [   70.477225] r10: 00000142  r9 : ee219dc0  r8 : ee2afec0
> [   70.477302] r7 : ee2afec0  r6 : c0298d6c  r5 : ef02c400  r4 : ef0182=
00
> [   70.477385] r3 : c0f99274  r2 : 00000031  r1 : 2e87c000  r0 : a00000=
13
> [   70.477461] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Seg=
ment none
> [   70.477537] Control: 10c5387d  Table: 6e30806a  DAC: 00000051
> [   70.477613] CPU: 0 PID: 112 Comm: cat Not tainted 4.19.0 #1
> [   70.477688] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [   70.477765] [<c01128f4>] (unwind_backtrace) from [<c010e5b4>] (show_=
stack+0x10/0x14)
> [   70.477847] [<c010e5b4>] (show_stack) from [<c0a36160>] (dump_stack+=
0x98/0xc4)
> [   70.477925] [<c0a36160>] (dump_stack) from [<c0a3cc90>] (nmi_cpu_bac=
ktrace+0x6c/0xb4)
> [   70.478000] [<c0a3cc90>] (nmi_cpu_backtrace) from [<c0111530>] (hand=
le_IPI+0x108/0x420)
> [   70.478076] [<c0111530>] (handle_IPI) from [<c04950a8>] (gic_handle_=
irq+0x98/0x9c)
> [   70.478151] [<c04950a8>] (gic_handle_irq) from [<c01019f0>] (__irq_s=
vc+0x70/0xb0)
> [   70.478226] Exception stack(0xee2afd60 to 0xee2afda8)
> [   70.478303] fd60: a0000013 2e87c000 00000031 c0f99274 ef018200 ef02c=
400 c0298d6c ee2afec0
> [   70.478378] fd80: ee2afec0 ee219dc0 00000142 ee2aff70 9dff9a2f ee2af=
db0 c01a2fb4 c02b256c
> [   70.478453] fda0: a0000013 ffffffff
> [   70.478529] [<c01019f0>] (__irq_svc) from [<c02b256c>] (mntput_no_ex=
pire+0x88/0x464)
> [   70.478605] [<c02b256c>] (mntput_no_expire) from [<c0298d6c>] (termi=
nate_walk+0x154/0x160)
> [   70.478681] [<c0298d6c>] (terminate_walk) from [<c029ce3c>] (path_op=
enat+0x324/0xfe4)
> [   70.478759] [<c029ce3c>] (path_openat) from [<c029ea9c>] (do_filp_op=
en+0x70/0xdc)
> [   70.478835] [<c029ea9c>] (do_filp_open) from [<c028b36c>] (do_sys_op=
en+0x134/0x1e4)
> [   70.478911] [<c028b36c>] (do_sys_open) from [<c0101000>] (ret_fast_s=
yscall+0x0/0x28)
> [   70.478989] Exception stack(0xee2affa8 to 0xee2afff0)
> [   70.479064] ffa0:                   b6fc7d6c 0000000a ffffff9c bebbf=
268 000a0000 00000000
> [   70.479139] ffc0: b6fc7d6c 0000000a 00000050 00000142 bebbf268 b6fc6=
970 b6fc6b28 bebbf254
> [   70.479214] ffe0: b6fc6970 bebbf1e0 b6f9dd94 b6fb0c0c
> [   70.484892] rcu: rcu_preempt kthread starved for 2600 jiffies! g-443=
 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D0
> [   70.514943] rcu: RCU grace-period kthread stack dump:
> [   70.516687] rcu_preempt     I    0    10      2 0x00000000
> [   70.523711] [<c0a4caac>] (__schedule) from [<c0a4d28c>] (schedule+0x=
4c/0xac)
> [   70.525103] [<c0a4d28c>] (schedule) from [<c0a52c34>] (schedule_time=
out+0x230/0x564)
> [   70.526472] [<c0a52c34>] (schedule_timeout) from [<c01a7818>] (rcu_g=
p_kthread+0x6e4/0xbf0)
> [   70.527784] [<c01a7818>] (rcu_gp_kthread) from [<c014d7f0>] (kthread=
+0x138/0x168)
> [   70.528989] [<c014d7f0>] (kthread) from [<c01010b4>] (ret_from_fork+=
0x14/0x20)
> [   70.530387] Exception stack(0xef111fb0 to 0xef111ff8)
> [   70.532556] 1fa0:                                     00000000 00000=
000 00000000 00000000
> [   70.534904] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000=
000 00000000 00000000
> [   70.536920] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000=
000
> Found console ttySAC0
>=20
> Linux version 4.19.0 (root@591d0a36fd03) (gcc version 6.3.0 20170516 (D=
ebian 6.3.0-18)) #1 SMP PREEMPT Fri Oct 4 19:53:43 UTC 2019
> Boot successful.
> / #
>=20
> Also:
>=20
> [   73.000405] [<c01128f4>] (unwind_backtrace) from [<c010e5b4>] (show_=
stack+0x10/0x14)
> [   73.000537] [<c010e5b4>] (show_stack) from [<c0a36160>] (dump_stack+=
0x98/0xc4)
> [   73.000631] [<c0a36160>] (dump_stack) from [<c0a3cc90>] (nmi_cpu_bac=
ktrace+0x6c/0xb4)
> [   73.000701] [<c0a3cc90>] (nmi_cpu_backtrace) from [<c0111530>] (hand=
le_IPI+0x108/0x420)
> [   73.000823] [<c0111530>] (handle_IPI) from [<c04950a8>] (gic_handle_=
irq+0x98/0x9c)
> [   73.000924] [<c04950a8>] (gic_handle_irq) from [<c01019f0>] (__irq_s=
vc+0x70/0xb0)
> [   73.000990] Exception stack(0xef123f80 to 0xef123fc8)
> [   73.001064] 3f80: 00000001 00000001 00000000 ef11b300 ef122000 c1007=
470 c10074b4 00000002
> [   73.001131] 3fa0: 4000406a 410fc090 00000000 00000000 00000000 ef123=
fd0 c018759c c010a4c8
> [   73.001196] 3fc0: 20000013 ffffffff
> [   73.001262] [<c01019f0>] (__irq_svc) from [<c010a4c8>] (arch_cpu_idl=
e+0x24/0x3c)
> [   73.001328] [<c010a4c8>] (arch_cpu_idle) from [<c015f1f0>] (do_idle+=
0xcc/0x168)
> [   73.001394] [<c015f1f0>] (do_idle) from [<c015f60c>] (cpu_startup_en=
try+0x18/0x1c)
> [   73.001462] [<c015f60c>] (cpu_startup_entry) from [<4010276c>] (0x40=
10276c)
>

I did not run into this, but I did run into one execution that reached
no further than:

   17:14:18 DEBUG| Power domain MFC disable failed
   17:14:18 DEBUG| Freeing unused kernel memory: 2048K
   17:14:43 DEBUG| random: crng init done

And then Avocado's timeout handler kicked in.  This means that, upon
inclusion, those tests should not run by default.  We've discussed a
few approaches before, but I guess it's time to implement *something*
on that matter, and then refine it later.

> Based-on: 20190926173428.10713-16-f4bug@amsat.org
> "tests/boot_linux_console: Extract the gunzip() helper"

With Avocado 72.0 (which is now pinned in requirements.txt) there
should be no need for this helper.

> ---
>  tests/acceptance/boot_linux_console.py | 41 ++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index 079590f0c8..197358a69c 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -318,6 +318,47 @@ class BootLinuxConsole(Test):
>          self.vm.launch()
>          self.wait_for_console_pattern('init started: BusyBox')
> =20
> +    def test_arm_exynos4210_initrd(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:smdkc210
> +        """
> +        deb_url =3D ('https://snapshot.debian.org/archive/debian/'
> +                   '20190928T224601Z/pool/main/l/linux/'
> +                   'linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf=
.deb')
> +        deb_hash =3D 'fa9df4a0d38936cb50084838f2cb933f570d7d82'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        kernel_path =3D self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinuz-4.19.0-6-ar=
mmp')
> +        dtb_path =3D '/usr/lib/linux-image-4.19.0-6-armmp/exynos4210-s=
mdkv310.dtb'
> +        dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> +
> +        initrd_url =3D ('https://github.com/groeck/linux-build-test/ra=
w/'
> +                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs=
/'
> +                      'arm/rootfs-armv5.cpio.gz')
> +        initrd_hash =3D '2b50f1873e113523967806f4da2afe385462ff9b'
> +        initrd_path_gz =3D self.fetch_asset(initrd_url, asset_hash=3Di=
nitrd_hash)
> +        initrd_path =3D os.path.join(self.workdir, 'rootfs.cpio')
> +        gunzip(initrd_path_gz, initrd_path)

With Avocado 72.0 you can simply use:

   archive.uncompress(initrd_path_gz, initrd_path)

> +
> +        self.vm.set_machine('smdkc210')

I'm longing for the day where this won't be necessary anymore:

  https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg05634.html

- Cleber.

> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'earlycon=3Dexynos4210,0x13800000 early=
printk ' +
> +                               'console=3DttySAC0,115200n8 ' +
> +                               'random.trust_cpu=3Doff cryptomgr.notes=
ts ' +
> +                               'cpuidle.off=3D1 panic=3D-1 noreboot')
> +
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-initrd', initrd_path,
> +                         '-append', kernel_command_line,
> +                         '-no-reboot')
> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern('Boot successful.')
> +        # TODO user command, for now the uart is stuck
> +
>      def test_s390x_s390_ccw_virtio(self):
>          """
>          :avocado: tags=3Darch:s390x
> --=20
> 2.20.1
>=20
>=20


