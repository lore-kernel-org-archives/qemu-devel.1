Received: from eggs.gnu.org ([2001:4830:134:3::10]:33158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yzlyourself@gmail.com>) id 1ciiTd-0005cX-5B
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yzlyourself@gmail.com>) id 1ciiTc-0004CV-86
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:10:05 -0500
Received: from mail-io0-x22f.google.com ([2607:f8b0:4001:c06::22f]:35478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yzlyourself@gmail.com>)
	id 1ciiTc-0004Bb-0J
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:10:04 -0500
Received: by mail-io0-x22f.google.com with SMTP id j18so9819540ioe.2
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 06:10:02 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?6KKB5Luy?= <yzlyourself@gmail.com>
Date: Tue, 28 Feb 2017 22:10:00 +0800
Message-ID: <CAHwzzTr=qcMA7jfajxMDzhLHx3GoP2SWM_Tvi3irznrW=U6vZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] failed to install win2008 with usb,
 qemu report: cpage out of range(EHCI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I use qemu-2.5.0.

This is a part of my xml:
......

  <vcpu placement=3D'static' current=3D"1">64</vcpu>

  <cpu>

    <topology sockets=3D'4' cores=3D'8' threads=3D'2'/>

      <numa>

          <cell cpus=3D'0-3' memory=3D'524288'/>

          <cell cpus=3D'4-7' memory=3D'524288'/>

      </numa>

  </cpu>

.....

    <hostdev mode=3D'subsystem' type=3D'usb' managed=3D'yes'>

      <source missing=3D'yes'>

        <address bus=3D'1' device=3D'5'/>

      </source>

      <address type=3D'usb' bus=3D'0' port=3D'4'/>

    </hostdev>

....

and this xml will failed to install win2008 with usb, and qemu reports in
its log: cpage out of range(EHCI) =E3=80=82

but if the part of xml above:  <vcpu placement=3D'static' current=3D"1">64<=
/vcpu>
  changes to  <vcpu placement=3D'static' cpuset=3D'0-1' current=3D"1">64</v=
cpu> ,
and other part of xml stay the same.

Then it works, I can install win2008 with usb successfully.


I change my qemu to 2.8.0, and the first xml can work too, but I don't know
the reason, and which part of qemu code fix this bug.


Ask for help
