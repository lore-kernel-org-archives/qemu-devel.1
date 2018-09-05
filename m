Received: from eggs.gnu.org ([2001:4830:134:3::10]:43256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fxZDh-0001uI-Pl
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fxZ4i-0003g9-Qk
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:46:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:37286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fxZ4i-0003fm-KE
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:46:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fxZ4h-0004az-Ps
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 14:46:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B03802E80C9
	for <qemu-devel@nongnu.org>; Wed,  5 Sep 2018 14:46:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Sep 2018 14:26:55 -0000
From: "Emilio G. Cota" <1529173@bugs.launchpad.net>
Reply-To: Bug 1529173 <1529173@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151225043457.25603.20738.malonedeb@gac.canonical.com>
Message-Id: <153615761591.31966.12427895485293022832.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1529173] Re: Absolutely slow Windows XP SP3
 installation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For integer workloads such as installing an OS you should expect TCG to
be about 12x slower than KVM on average. That is on current master; note
that TCG has gotten faster in the last couple of years. See a
performance comparison from v2.7.0 to v2.11.0 for SPEC06 here:
https://imgur.com/a/5P5zj

I've therefore marked the report as invalid, as I don't think the
aforementioned speedups will change your experience dramatically.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1529173

Title:
  Absolutely slow Windows XP SP3 installation

Status in QEMU:
  Invalid

Bug description:
  Host: Linux 4.3.3 vanilla x86-64/Qemu 2.5 i686 (mixed env)
  Guest: Windows XP Professional SP3 (i686)

  This is my launch string:

  $ qemu-system-i386 \
  -name "Windows XP Professional SP3" \
  -vga std \
  -net nic,model=3Dpcnet \
  -cpu core2duo \
  -smp cores=3D2 \
  -cdrom /tmp/en_winxp_pro_with_sp3_vl.iso \
  -hda Windows_XP.qcow \
  -boot d \
  -net nic \
  -net user \
  -m 1536 \
  -localtime

  Console output:

  warning: TCG doesn't support requested feature: CPUID.01H:EDX.vme [bit 1]
  warning: TCG doesn't support requested feature: CPUID.80000001H:EDX.sysca=
ll [bit 11]
  warning: TCG doesn't support requested feature: CPUID.80000001H:EDX.lm|i6=
4 [bit 29]
  warning: TCG doesn't support requested feature: CPUID.01H:EDX.vme [bit 1]
  warning: TCG doesn't support requested feature: CPUID.80000001H:EDX.sysca=
ll [bit 11]
  warning: TCG doesn't support requested feature: CPUID.80000001H:EDX.lm|i6=
4 [bit 29]

  After hitting 35% installation more or less stalls (it actually
  doesn't but it progresses 1% a minute which is totally unacceptable).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1529173/+subscriptions
