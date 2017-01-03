Received: from eggs.gnu.org ([2001:4830:134:3::10]:59196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOOrT-0001Ez-S1
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 08:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOOrN-0005ub-K7
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 08:10:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOOrN-0005uC-EP
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 08:10:37 -0500
Message-ID: <1483449034.24493.31.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 03 Jan 2017 14:10:34 +0100
In-Reply-To: <20161221131403.0718dd35@kitsune.suse.cz>
References: <20161221131403.0718dd35@kitsune.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] QXL VGA on ppc64?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: qemu-devel@nongnu.org

On Mi, 2016-12-21 at 13:14 +0100, Michal Such=C3=A1nek wrote:
> Hello,
>=20
> I heard this configuration is not working very well.
>=20
> However, just enabling QXL in configuration and spapr.c I get a kvm
> emulation error.
>=20
> So what issues does the configuration have and what is needed to enable
> it?

spice is little endian for historical reasons.  There was (still is?)
ongoing work in both qxl emulation and spice code base to fix this, but
I don't think anyone went on testing and fixing things systematically on
bigendian machines.  You might want try asking on spice-devel though.

There also used to be some x86 dependency, but that was a small issue
compared to the byteordering and it got fixed while spice was enabled
for arm.

qxl + spice on ppc64le should do just fine, but only in case both host
and guest are le.

> I am interested in resizing guest display to match client screen size.

virtio-gpu is another option for that one.

cheers,
  Gerd
