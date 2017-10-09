Received: from eggs.gnu.org ([2001:4830:134:3::10]:40708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e1Qwx-0004eo-7G
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 01:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e1Qwt-0002dP-Ux
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 01:49:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1e1Qwt-0002cT-Mh
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 01:49:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <CY4PR15MB1464F1EE43FD8CA97C728FD3F3760@CY4PR15MB1464.namprd15.prod.outlook.com>
Date: Mon, 09 Oct 2017 07:49:50 +0200
In-Reply-To: <CY4PR15MB1464F1EE43FD8CA97C728FD3F3760@CY4PR15MB1464.namprd15.prod.outlook.com>
	(Zir Blazer's message of "Sat, 7 Oct 2017 02:58:55 +0000")
Message-ID: <87376suayp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] What is the status of the QEMU sound rework?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zir Blazer <zir_blazer@hotmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Copying Gerd...

Zir Blazer <zir_blazer@hotmail.com> writes:

> I'm a VGA Passthrough user that uses a QEMU VM to fully replace a Windows=
 native install as the main OS.
>
>
> Currently, one of the biggest hazzles for many users is that sound is har=
d to get working properly with the emulated AC'97 and Intel HDA Sound Cards=
 due to crackle or latency issues (Latency issues heavily affects recording=
 scenarios, like voice chat applications in a VM). An example here, through=
 there are far more: https://www.reddit.com/r/VFIO/comments/746t4h/getting_=
rid_of_audio_crackling_once_and_for_all/
>
>
> Some people managed to get sound working at acceptable levels by meddling=
 with the environmental variables, but most of the solutions come from a tr=
ial-and-error esoteric procedure instead of structured troubleshooting, as =
each user has to figure out which settings makes the emulated Sound Cards w=
ork decently in his system. For those that failed getting the desired resul=
ts with emulation, they have to throw Hardware at the issue by using PCI Pa=
ssthrough of a Sound Card, or an USB Sound Card via USB Passthrough (Or eve=
n have it plugged to an USB Controller passed to the VM via PCI Passthrough=
), or using the passthroughed Video Card HDMI with a Monitor with speakers,=
 just to solve the sound issues. The problem is that this complicates this =
type of setups a lot, and it makes impossible a typical use case that would=
 be that all the VMs output the sound to the host, which has control of the=
 Motherboard integrated Sound Card, and it mixes it to use a single set of =
speakers for the entire system.
>
>
>
> I have been googling around and found that at several times, there were i=
deas and proposal, and even some code, that were intended to overhaul QEMU =
sound system. Examples includes:
>
> GSoC 2011 Xen PV Audio, a paravirtualized Sound Card https://wiki.xenproj=
ect.org/wiki/Archived/GSoc_2011_Ideas
> GSoC 2015 QEMU rework of the sound environmental variables https://wiki.q=
emu.org/Google_Summer_of_Code_2015#QEMU_audio_backend
> GSoC 2017 QEMU rework a patch series that did precisely that https://wiki=
.qemu.org/Google_Summer_of_Code_2017#QEMU_audio_backend
> https://lists.nongnu.org/archive/html/qemu-devel/2016-01/msg02451.html
>
>
>
> Basically, what happened with all the previous ideas and proposals? Did a=
ny of that work ever get into upstream QEMU?
> Is anyone tinkering with the idea of making a paravirtualized Sound Card =
and its associated Drivers for the mainstream OSes to try to fix once and f=
or all the sound issues?
