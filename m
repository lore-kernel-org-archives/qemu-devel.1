Received: from eggs.gnu.org ([2001:4830:134:3::10]:43236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPoh2-0003KR-OP
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPogx-0007ow-6u
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:06:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gPogw-0007oj-WD
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:06:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6312931256D1
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 13:06:46 +0000 (UTC)
References: <20181121182725.4263-1-pbonzini@redhat.com>
	<8a8dd805-7ec7-1cf5-afc3-ac78d54b1501@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <540f5d7f-3f69-edaf-9e0b-dfb33a2a12e9@redhat.com>
Date: Thu, 22 Nov 2018 14:06:40 +0100
MIME-Version: 1.0
In-Reply-To: <8a8dd805-7ec7-1cf5-afc3-ac78d54b1501@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] checkpatch: g_test_message does not need a
 a trailing newline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com

On 21/11/18 19:38, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
>=20
> On 21/11/18 19:27, Paolo Bonzini wrote:
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> =C2=A0 scripts/checkpatch.pl | 3 ++-
>> =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index eccd656c41..d27bc51f8c 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -2802,7 +2802,8 @@ sub process {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info_vreport|
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report|
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_report|
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 info_report}x;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 info_report|
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_test_message}x;
>=20
> This perl file use <tab> here, shouldn't we keep the same style?
>=20
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ($rawline =3D~ /\b(?:$qemu_er=
ror_funcs)\s*\(.*\".*\\n/) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ERROR("Error me=
ssages should not contain newlines\n" .
>> $herecurr);
>>
>=20
> $ ./scripts/checkpatch.pl -f tests/ipmi-bt-test.c
> ERROR: Error messages should not contain newlines
> #408: FILE: tests/ipmi-bt-test.c:408:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_test_message("Skipping te=
st for non-x86\n");
> total: 1 errors, 0 warnings, 430 lines checked
>=20
> Nice :)
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Queued then, thanks. :)

Paolo
