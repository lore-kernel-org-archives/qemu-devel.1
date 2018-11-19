Received: from eggs.gnu.org ([2001:4830:134:3::10]:44359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1gOltc-0000Lu-0K
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1gOltX-00054M-Mk
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:55:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:60046 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <msuchanek@suse.de>) id 1gOltR-0004vy-O1
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:55:25 -0500
Date: Mon, 19 Nov 2018 16:55:16 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Message-ID: <20181119165516.388123be@naga>
In-Reply-To: <20181119142059.GP19532@redhat.com>
References: <20181119151527.4a925a75@naga> <20181119142059.GP19532@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Block format 'raw' does not support the option
 'serial'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, 19 Nov 2018 14:20:59 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, Nov 19, 2018 at 03:15:27PM +0100, Michal Such=C3=A1nek wrote:
> > Hello,
> >=20
> > I tried to run my VM with qemu git and I am greeted with:
> >=20
> > Block format 'raw' does not support the option 'serial'
> >=20
> > Is there any sensible reason to *not^ support disk serial number? =20
>=20
> The 'serial' property on -drive was deprecated in QEMU 2.10, and deleted
> in 3.1, as it is not a property that makes sense for the backend.
>=20
> It should be set on the virtual device instead via the -device arg

Is this documented anywhere?

Looking at the man page I only see serial property on smbios.

Thanks

Michal
