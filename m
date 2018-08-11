Received: from eggs.gnu.org ([2001:4830:134:3::10]:51006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1foHOT-0005jz-3Z
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 20:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1foHOP-0004ap-50
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 20:04:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1foHOO-0004aC-RL
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 20:04:29 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20180810101438.5yfxte2yojhaivtj@sirius.home.kraxel.org>
Date: Sat, 11 Aug 2018 03:04:21 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1C2761F-F9A0-442C-8B11-21EB645FEC5C@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
	<20180810101438.5yfxte2yojhaivtj@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH 00/29]: vmsvga: Various fixes and
 enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, habkost@redhat.com



> On 10 Aug 2018, at 13:14, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> On Thu, Aug 09, 2018 at 02:46:13PM +0300, Liran Alon wrote:
>> Hi,
>>=20
>> This patch series aim to fix many issues in vmware-svga emulation
>> which have prevented it from being fully functional in a wide-variety
>> of guests.
>=20
> Nice job in modernizing the vmware svga emulation.
>=20
> What guests this was tested with?  I've tried Fedora 28.  The vmware =
kms
> driver loads fine, fbcon runs fine.  Nice.

This was tested with a wide-variety of various Windows versions & Linux =
distributions
which we have encountered that had issues with current vmware-svga =
emulation.
If it=E2=80=99s important, we can provide the exact test-matrix we have =
run against this code.

>=20
> But gdm doesn't start, neither with X11 nor with wayland.  Which is a
> regression, because the xorg vmware driver manages to handle the =
current
> qemu emulation just fine so gnome @ X11 works.

Interesting. Thanks for finding this out. Will have a look.
Can you give more exact details about how you reproduced this issue?
I prefer to have a similar setup to make sure we have fixed the =
regression in this series.

>=20
> cheers,
>  Gerd
>=20

Thanks for the detailed review and feedback.
-Liran
