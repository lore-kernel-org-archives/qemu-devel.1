Received: from eggs.gnu.org ([2001:4830:134:3::10]:44718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chzigotzky@xenosoft.de>) id 1fJtxN-00069Y-PZ
	for qemu-devel@nongnu.org; Sat, 19 May 2018 00:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chzigotzky@xenosoft.de>) id 1fJtxM-0002On-Iq
	for qemu-devel@nongnu.org; Sat, 19 May 2018 00:59:01 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <3db651e3-a237-fbaa-6ffe-ecc5db43ad0f@tuxfamily.org>
Date: Sat, 19 May 2018 06:58:45 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <E9FA9AA6-FDA6-467F-9B72-B331756464A7@xenosoft.de>
References: <4521b265-855f-7f06-ffff-3fa394380922@xenosoft.de>
	<b3243bab-58b6-0b43-67b5-94a2f90d9199@tuxfamily.org>
	<5BD35D0B-E490-4693-8858-E11B7401709F@xenosoft.de>
	<1821476d-7724-ad71-eb3f-69c731633582@tuxfamily.org>
	<886dc490-c96a-ad5a-e1f7-8e41a686a53e@xenosoft.de>
	<20180518131303.6f0778eb@bahia.lan>
	<e9333edf-fa2a-6ad8-412b-459b0b8002e9@xenosoft.de>
	<20180518141642.6ad639ac@bahia.lan>
	<8bde9b6f-b80f-e87e-e4d3-ace15454cf3d@xenosoft.de>
	<3db651e3-a237-fbaa-6ffe-ecc5db43ad0f@tuxfamily.org>
Subject: [Qemu-devel] [PPC64] P5020DS: Booting from img possible (-drive)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

Thomas wrote:

No clue, so just a blind guess: Is "CoreNet Generic" the right machine?
What happens if you set "CONFIG_CORENET_GENERIC=3Dn" in your kernel config?

Thomas

=E2=80=94=E2=80=94

I think it=E2=80=98s the right machine.

CONFIG_CORENET_GENERIC:

This option enables support for the FSL CoreNet based boards. For 32bit kern=
el, the following boards are supported: P2041 RDB, P3041 DS, P4080 DS, kmcog=
e4, and OCA4080 For 64bit kernel, the following boards are supported: T208x Q=
DS/RDB, T4240 QDS/RDB and B4 QDS The following boards are supported for both=
 32bit and 64bit kernel: P5020 DS, P5040 DS, T102x QDS/RDB, T104x QDS/RDB

Any other ideas?

=E2=80=94 Christian=
