Received: from eggs.gnu.org ([2001:4830:134:3::10]:60436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gHVws-0000ZR-VF
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gHVwp-0000K1-9Y
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:28:54 -0400
Received: from mail-eopbgr690113.outbound.protection.outlook.com
	([40.107.69.113]:26893
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gHVwo-0007ah-UG
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:28:51 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 30 Oct 2018 15:28:28 +0000
Message-ID: <BN6PR2201MB1251A4CED886A03273BD08B5C6CC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540899411-16761-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540899411-16761-6-git-send-email-aleksandar.markovic@rt-rk.com>,
	<95050205-8dbe-cf95-61c5-25e8d3b55817@redhat.com>
In-Reply-To: <95050205-8dbe-cf95-61c5-25e8d3b55817@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 5/5] target/mips: Enable only tested
 modes for R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>
> > +#if defined(CONFIG_USER_ONLY)
>
> > +#if !defined(TARGET_MIPS64)
>=20
> Can you explain this change in the commit message? I don't understand
why you want to disable this CPU.

These limitations are meant to expose to end-user only features that make s=
ense and are appropriately tested. People like you can easily comment out t=
heses lines and do whatever experimentation they like.

About defined(CONFIG_USER_ONLY), it is just because a reasonable testing wa=
s not provided for system mode. It is not enough to add a code, and then en=
able system mode. A reasonable ("acceptance") testing should be done, and m=
ade available to others. I know, we do not have strict acceptance rules. Bu=
t I would say a system image, kernel, and command line + plus some relative=
ly mild testing of system mode should suffice. It would be nice to formaliz=
e that.

About !defined(TARGET_MIPS64), this is because O32 is the only supported us=
er-mode ABI for this CPU.

One missing part is documentation update - unfortunately often forgotten.

Aleksandar=
