Received: from eggs.gnu.org ([2001:4830:134:3::10]:55537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zir_blazer@hotmail.com>) id 1e0fKQ-0002Rp-Om
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 22:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zir_blazer@hotmail.com>) id 1e0fKM-00078Z-Rs
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 22:59:02 -0400
Received: from mail-oln040092004096.outbound.protection.outlook.com
	([40.92.4.96]:11569
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zir_blazer@hotmail.com>)
	id 1e0fKM-00076F-Fj
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 22:58:58 -0400
From: Zir Blazer <zir_blazer@hotmail.com>
Date: Sat, 7 Oct 2017 02:58:55 +0000
Message-ID: <CY4PR15MB1464F1EE43FD8CA97C728FD3F3760@CY4PR15MB1464.namprd15.prod.outlook.com>
Content-Language: es-AR
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] What is the status of the QEMU sound rework?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

I'm a VGA Passthrough user that uses a QEMU VM to fully replace a Windows n=
ative install as the main OS.


Currently, one of the biggest hazzles for many users is that sound is hard =
to get working properly with the emulated AC'97 and Intel HDA Sound Cards d=
ue to crackle or latency issues (Latency issues heavily affects recording s=
cenarios, like voice chat applications in a VM). An example here, through t=
here are far more: https://www.reddit.com/r/VFIO/comments/746t4h/getting_ri=
d_of_audio_crackling_once_and_for_all/


Some people managed to get sound working at acceptable levels by meddling w=
ith the environmental variables, but most of the solutions come from a tria=
l-and-error esoteric procedure instead of structured troubleshooting, as ea=
ch user has to figure out which settings makes the emulated Sound Cards wor=
k decently in his system. For those that failed getting the desired results=
 with emulation, they have to throw Hardware at the issue by using PCI Pass=
through of a Sound Card, or an USB Sound Card via USB Passthrough (Or even =
have it plugged to an USB Controller passed to the VM via PCI Passthrough),=
 or using the passthroughed Video Card HDMI with a Monitor with speakers, j=
ust to solve the sound issues. The problem is that this complicates this ty=
pe of setups a lot, and it makes impossible a typical use case that would b=
e that all the VMs output the sound to the host, which has control of the M=
otherboard integrated Sound Card, and it mixes it to use a single set of sp=
eakers for the entire system.



I have been googling around and found that at several times, there were ide=
as and proposal, and even some code, that were intended to overhaul QEMU so=
und system. Examples includes:

GSoC 2011 Xen PV Audio, a paravirtualized Sound Card https://wiki.xenprojec=
t.org/wiki/Archived/GSoc_2011_Ideas
GSoC 2015 QEMU rework of the sound environmental variables https://wiki.qem=
u.org/Google_Summer_of_Code_2015#QEMU_audio_backend
GSoC 2017 QEMU rework a patch series that did precisely that https://wiki.q=
emu.org/Google_Summer_of_Code_2017#QEMU_audio_backend
https://lists.nongnu.org/archive/html/qemu-devel/2016-01/msg02451.html



Basically, what happened with all the previous ideas and proposals? Did any=
 of that work ever get into upstream QEMU?
Is anyone tinkering with the idea of making a paravirtualized Sound Card an=
d its associated Drivers for the mainstream OSes to try to fix once and for=
 all the sound issues?
