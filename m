Received: from eggs.gnu.org ([209.51.188.92]:47008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gteYe-0007FA-OY
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:21:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gteYd-0000pG-5Y
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:21:32 -0500
Received: from mail-eopbgr820120.outbound.protection.outlook.com
	([40.107.82.120]:21325
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gteYc-0000gj-Ed
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:21:31 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 12 Feb 2019 20:21:24 +0000
Message-ID: <BN6PR2201MB1251FFEF6EBFC040A66E4245C6650@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1550001205-7883-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1550001205-7883-2-git-send-email-aleksandar.markovic@rt-rk.com>,
	<14ccdc5c-3b80-c60d-86e0-ddd90050e9e6@redhat.com>
In-Reply-To: <14ccdc5c-3b80-c60d-86e0-ddd90050e9e6@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/5] tests/tcg: target/mips: Remove an
 unnecessary file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>

> From: Eric Blake <eblake@redhat.com>
> Sent: Tuesday, February 12, 2019 9:04 PM
> To: Aleksandar Markovic; qemu-devel@nongnu.org
> Cc: Aleksandar Rikalo; alex.bennee@linaro.org; Aleksandar Markovic; aurel=
ien@aurel32.net
> Subject: Re: [Qemu-devel] [PATCH 1/5] tests/tcg: target/mips: Remove an u=
nnecessary file
>=20
> On 2/12/19 1:53 PM, Aleksandar Markovic wrote:
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Remove a file that was added long time ago by mistake.
>=20
> Might be worth mentioning commit d70080c4 (in 2012).

I am going to mention it in the next version of this series.

>=20
> Is this the sort of file that is likely enough to be created during
> typical workflows that it should be listed in the project's .gitignore
> for everyone?  Or is it particular enough to your environment that you
> could 'echo .directory >> .git/info/exclude' to ensure it doesn't happen
> again for your setup, without bothering other developers with your
> exclusion?
>=20

It is particular enough, no need to update .gitingnore for everyone, IMHO.

> Either way, the cleanup itself makes sense.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org

Thanks,
Aleksandar
