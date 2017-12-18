Received: from eggs.gnu.org ([2001:4830:134:3::10]:39833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eQvAP-0000y8-K2
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eQvA7-0006Vh-JY
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:09:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eQvA7-0006Tv-Cd
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:08:55 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 899B9BDCF
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:08:54 +0000 (UTC)
References: <20171218130309.2682-1-pbonzini@redhat.com>
	<167321084.622468.1513602441314.JavaMail.zimbra@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5de0d539-37f0-5316-918f-9ac46e65aa1e@redhat.com>
Date: Mon, 18 Dec 2017 14:08:45 +0100
MIME-Version: 1.0
In-Reply-To: <167321084.622468.1513602441314.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] checkpatch: volatile with a comment or
 sig_atomic_t is okay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, famz@redhat.com

On 18/12/2017 14:07, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> ----- Original Message -----
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> This assumes that the comment gives some justification;
>> "volatile sig_atomic_t" is also self-explanatory and usually
>> correct.
>>
>> Discussed in:
>> '[Qemu-devel] [PATCH] dump-guest-memory.py: fix "You can't do that wit=
hout a
>> process to debug"'
>>
>> Suggested-by: Fam Zheng <famz@redhat.com>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Message-Id: <20171215181810.4122-1-marcandre.lureau@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> Thanks, I can add it to my 2 patches series for dump (to avoid error on=
 Peter's end)
>=20
> Unless you send a pull request with it sonnish

It is not a big deal if it is included twice.  I'm planning my pull
request for tomorrow or Wednesday.

Paolo

>=20
>=20
>> ---
>>  scripts/checkpatch.pl | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 34df753571..3dc27d9656 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -2475,8 +2475,11 @@ sub process {
>> =20
>>  # no volatiles please
>>  		my $asm_volatile =3D qr{\b(__asm__|asm)\s+(__volatile__|volatile)\b=
};
>> -		if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/) {
>> -			ERROR("Use of volatile is usually wrong: see
>> Documentation/volatile-considered-harmful.txt\n" . $herecurr);
>> +		if ($line =3D~ /\bvolatile\b/ && $line !~ /$asm_volatile/ &&
>> +                    $line !~ /sig_atomic_t/ &&
>> +                    !ctx_has_comment($first_line, $linenr)) {
>> +			my $msg =3D "Use of volatile is usually wrong, please add a commen=
t\n" .
>> $herecurr;
>> +                        ERROR($msg);
>>  		}
>> =20
>>  # warn about #if 0
>> --
>> 2.14.3
>>
>>
