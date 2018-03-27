Received: from eggs.gnu.org ([2001:4830:134:3::10]:50419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0rRO-0004gq-LA
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0rRK-00057W-C4
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:27:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36316 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f0rRK-00057B-84
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:27:14 -0400
References: <4502cb42-45cc-26b0-7101-3587345c32c6@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <07e8dff9-b459-ed58-d5d5-04afcf7980d9@redhat.com>
Date: Tue, 27 Mar 2018 18:27:06 +0200
MIME-Version: 1.0
In-Reply-To: <4502cb42-45cc-26b0-7101-3587345c32c6@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] correct path for qemu-*-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 27/03/2018 18:15, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> <th_huth> is there are reason that qemu-bridge-helper is installed into
> $libexecdir but qemu-pr-helper is rather installed into $bindir instead=
?
>=20
> I'm not familiar with these utilities, but my understanding is $bindir
> is for user executable binaries.
>=20
> These helpers aren't expected to be started directly by user but by
> daemon/systemd, so both would belong to $libexecdir.

qemu-bridge-helper is started by QEMU itself, the user doesn't know
about it.  So it goes in $libexecdir.

qemu-pr-helper is started by systemd, so it goes in either $bindir or
$sbindir.  The distinction between $bindir and $sbindir has never been
clear, though.

Paolo
