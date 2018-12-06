Received: from eggs.gnu.org ([2001:4830:134:3::10]:50588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUzPl-0003Zx-72
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 14:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUzPh-00038M-3D
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 14:34:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:31433)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gUzPg-00033E-Ji
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 14:34:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B90BC0270B4
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 19:34:18 +0000 (UTC)
References: <1544114998-1513-1-git-send-email-thuth@redhat.com>
	<1544114998-1513-2-git-send-email-thuth@redhat.com>
	<794f00c2-661d-3534-b3c0-a52d626c1c75@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fe108439-5ddb-1c8c-2d04-bb2a8b134ba0@redhat.com>
Date: Thu, 6 Dec 2018 20:34:14 +0100
MIME-Version: 1.0
In-Reply-To: <794f00c2-661d-3534-b3c0-a52d626c1c75@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 1/5] tests/boot-serial: Get rid of
 global_qtest variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 2018-12-06 19:42, Eric Blake wrote:
> On 12/6/18 10:49 AM, Thomas Huth wrote:
>> The test does not use any of the functions that require global_qtest,
>> so we can simply get rid of this global variable here.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 tests/boot-serial-test.c | 13 +++++++------
>> =C2=A0 1 file changed, 7 insertions(+), 6 deletions(-)
>>
>=20
>> -=C2=A0=C2=A0=C2=A0 global_qtest =3D qtest_initf("%s %s -M %s,accel=3D=
tcg:kvm "
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-chardev file,id=3Dserial0,path=3D%=
s "
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-no-shutdown -serial chardev:serial=
0
>> %s",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 codeparam, code ? codetmp : "",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test->machine, serialtmp, test->extr=
a);
>> +=C2=A0=C2=A0=C2=A0 qts =3D qtest_initf("%s %s -M %s,accel=3Dtcg:kvm -=
no-shutdown "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-chardev file,=
id=3Dserial0,path=3D%s "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " -serial chard=
ev:serial0 %s",
>=20
> What happened to -no-shutdown?

Moved to the first line (since there was some more space there now).

 Thomas
