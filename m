Received: from eggs.gnu.org ([2001:4830:134:3::10]:56761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fajol-0005MQ-7N
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fajoh-0001Hm-99
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:35:43 -0400
Received: from mail-by2nam05on0708.outbound.protection.outlook.com
	([2a01:111:f400:fe52::708]:49847
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fajog-0001Ei-TC
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:35:39 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 4 Jul 2018 15:35:18 +0000
Message-ID: <BN7PR08MB4868C0F99A12534DE079C256C6410@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [BUG] checkpatch.pl hangs on target/mips/msa_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>

If  checkpatch.pl is applied (using switch "-f") on file target/mips/msa_he=
lper.c, it will hang.

There is a workaround for this particular file:

These lines in msa_helper.c:

        uint## BITS ##_t S =3D _S, T =3D _T;                            \
        uint## BITS ##_t as, at, xs, xt, xd;                        \

should be replaced with:

        uint## BITS ## _t S =3D _S, T =3D _T;                           \
        uint## BITS ## _t as, at, xs, xt, xd;                       \

(a space is added after the second "##" in each line)

The workaround is found by partial deleting and undeleting of the code in m=
sa_helper.c in binary search fashion.

This workaround will soon be submitted by me as a patch within a series on =
misc MIPS issues.

I took a look at checkpatch.pl code, and it looks it is fairly complicated =
to fix the issue, since it happens in the code segment involving intricate =
logic conditions.

Regards,
Aleksandar
