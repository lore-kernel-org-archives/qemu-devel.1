Received: from eggs.gnu.org ([2001:4830:134:3::10]:54667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1eKH8k-0002iQ-JD
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 00:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1eKH8i-00023v-Fm
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 00:12:02 -0500
References: <20171129224421.18192-1-jsnow@redhat.com>
	<691790b7-4e9f-ab9c-43eb-9f26a401ef02@redhat.com>
	<5b769683-c840-ff48-0e20-969f0cac4475@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <60223b98-5924-7a44-fdbd-e777cdbb9c6f@redhat.com>
Date: Thu, 30 Nov 2017 06:11:40 +0100
MIME-Version: 1.0
In-Reply-To: <5b769683-c840-ff48-0e20-969f0cac4475@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rW56OrOmCm47HmjBjL9tMibOTUDNMVR5s"
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 197 for vpc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rW56OrOmCm47HmjBjL9tMibOTUDNMVR5s
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <60223b98-5924-7a44-fdbd-e777cdbb9c6f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 197 for vpc
References: <20171129224421.18192-1-jsnow@redhat.com>
 <691790b7-4e9f-ab9c-43eb-9f26a401ef02@redhat.com>
 <5b769683-c840-ff48-0e20-969f0cac4475@redhat.com>
In-Reply-To: <5b769683-c840-ff48-0e20-969f0cac4475@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 30.11.2017 v 00:12 John Snow napsal(a):
>=20
>=20
> On 11/29/2017 06:02 PM, Eric Blake wrote:
>> On 11/29/2017 04:44 PM, John Snow wrote:
>>> VPC has some difficulty creating geometries of particular size.
>>> However, we can indeed force it to use a literal one, so let's
>>> do that for the sake of test 197, which is testing some specific
>>> offsets.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>> =C2=A0 tests/qemu-iotests/197=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 3 +++
>>> =C2=A0 tests/qemu-iotests/common.filter | 3 ++-
>>> =C2=A0 2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> [Does it show that I seldom run ./check -vpc?]
>>
>=20
> True of all of us...

We don't have the POWER to ran all combinations, but at least these are c=
overed weekly by the POWER team ;-)

avocado run --xunit /home/jenkins/workspace/rhelsa-wup-ppc64le-qemu-iotes=
ts/results.xml --job-results-dir /home/jenkins/workspace/rhelsa-wup-ppc64=
le-qemu-iotests --mux-inject /run:timeout:360 --loaders external:./iotest=
=2Esh -- '-file -raw 001' '-file -qcow2 001' '-nbd -raw 001' '-nbd -qcow2=
 001' '-file -raw 002' '-file -qcow2 002' '-nbd -raw 002' '-nbd -qcow2 00=
2' '-file -raw 003' '-file -qcow2 003' '-nbd -raw 003' '-nbd -qcow2 003' =
'-file -raw 004' '-file -qcow2 004' '-nbd -raw 004' '-nbd -qcow2 004' '-f=
ile -raw 005' '-file -qcow2 005' '-nbd -raw 005' '-nbd -qcow2 005' '-file=
 -raw 007' '-file -qcow2 007' '-nbd -raw 007' '-nbd -qcow2 007' '-file -r=
aw 008' '-file -qcow2 008' '-nbd -raw 008' '-nbd -qcow2 008' '-file -raw =
009' '-file -qcow2 009' '-nbd -raw 009' '-nbd -qcow2 009' '-file -raw 010=
' '-file -qcow2 010' '-nbd -raw 010' '-nbd -qcow2 010' '-file -raw 011' '=
-file -qcow2 011' '-nbd -raw 011' '-nbd -qcow2 011' '-file -raw 012' '-fi=
le -qcow2 012' '-nbd -raw 012' '-nbd -qcow2 012' '-file -raw 013' '-file =
-qcow2 013' '-nbd -raw 013' '-nbd -qcow2 013' '-file -raw 014' '-file -qc=
ow2 014' '-nbd -raw 014' '-nbd -qcow2 014' '-file -raw 015' '-file -qcow2=
 015' '-nbd -raw 015' '-nbd -qcow2 015' '-file -raw 017' '-file -qcow2 01=
7' '-nbd -raw 017' '-nbd -qcow2 017' '-file -raw 018' '-file -qcow2 018' =
'-nbd -raw 018' '-nbd -qcow2 018' '-file -raw 019' '-file -qcow2 019' '-n=
bd -raw 019' '-nbd -qcow2 019' '-file -raw 020' '-file -qcow2 020' '-nbd =
-raw 020' '-nbd -qcow2 020' '-file -raw 021' '-file -qcow2 021' '-nbd -ra=
w 021' '-nbd -qcow2 021' '-file -raw 022' '-file -qcow2 022' '-nbd -raw 0=
22' '-nbd -qcow2 022' '-file -raw 023' '-file -qcow2 023' '-nbd -raw 023'=
 '-nbd -qcow2 023' '-file -raw 024' '-file -qcow2 024' '-nbd -raw 024' '-=
nbd -qcow2 024' '-file -raw 025' '-file -qcow2 025' '-nbd -raw 025' '-nbd=
 -qcow2 025' '-file -raw 026' '-file -qcow2 026' '-nbd -raw 026' '-nbd -q=
cow2 026' '-file -raw 027' '-file -qcow2 027' '-nbd -raw 027' '-nbd -qcow=
2 027' '-file -raw 028' '-file -qcow2 028' '-nbd -raw 028' '-nbd -qcow2 0=
28' '-file -raw 029' '-file -qcow2 029' '-nbd -raw 029' '-nbd -qcow2 029'=
 '-file -raw 030' '-file -qcow2 030' '-nbd -raw 030' '-nbd -qcow2 030' '-=
file -raw 031' '-file -qcow2 031' '-nbd -raw 031' '-nbd -qcow2 031' '-fil=
e -raw 032' '-file -qcow2 032' '-nbd -raw 032' '-nbd -qcow2 032' '-file -=
raw 033' '-file -qcow2 033' '-nbd -raw 033' '-nbd -qcow2 033' '-file -raw=
 034' '-file -qcow2 034' '-nbd -raw 034' '-nbd -qcow2 034' '-file -raw 03=
5' '-file -qcow2 035' '-nbd -raw 035' '-nbd -qcow2 035' '-file -raw 036' =
'-file -qcow2 036' '-nbd -raw 036' '-nbd -qcow2 036' '-file -raw 037' '-f=
ile -qcow2 037' '-nbd -raw 037' '-nbd -qcow2 037' '-file -raw 038' '-file=
 -qcow2 038' '-nbd -raw 038' '-nbd -qcow2 038' '-file -raw 039' '-file -q=
cow2 039' '-nbd -raw 039' '-nbd -qcow2 039' '-file -raw 040' '-file -qcow=
2 040' '-nbd -raw 040' '-nbd -qcow2 040' '-file -raw 041' '-file -qcow2 0=
41' '-nbd -raw 041' '-nbd -qcow2 041' '-file -raw 042' '-file -qcow2 042'=
 '-nbd -raw 042' '-nbd -qcow2 042' '-file -raw 043' '-file -qcow2 043' '-=
nbd -raw 043' '-nbd -qcow2 043' '-file -raw 044' '-file -qcow2 044' '-nbd=
 -raw 044' '-nbd -qcow2 044' '-file -raw 045' '-file -qcow2 045' '-nbd -r=
aw 045' '-nbd -qcow2 045' '-file -raw 046' '-file -qcow2 046' '-nbd -raw =
046' '-nbd -qcow2 046' '-file -raw 047' '-file -qcow2 047' '-nbd -raw 047=
' '-nbd -qcow2 047' '-file -raw 048' '-file -qcow2 048' '-nbd -raw 048' '=
-nbd -qcow2 048' '-file -raw 049' '-file -qcow2 049' '-nbd -raw 049' '-nb=
d -qcow2 049' '-file -raw 050' '-file -qcow2 050' '-nbd -raw 050' '-nbd -=
qcow2 050' '-file -raw 051' '-file -qcow2 051' '-nbd -raw 051' '-nbd -qco=
w2 051' '-file -raw 052' '-file -qcow2 052' '-nbd -raw 052' '-nbd -qcow2 =
052' '-file -raw 053' '-file -qcow2 053' '-nbd -raw 053' '-nbd -qcow2 053=
' '-file -raw 054' '-file -qcow2 054' '-nbd -raw 054' '-nbd -qcow2 054' '=
-file -raw 055' '-file -qcow2 055' '-nbd -raw 055' '-nbd -qcow2 055' '-fi=
le -raw 056' '-file -qcow2 056' '-nbd -raw 056' '-nbd -qcow2 056' '-file =
-raw 057' '-file -qcow2 057' '-nbd -raw 057' '-nbd -qcow2 057' '-file -ra=
w 058' '-file -qcow2 058' '-nbd -raw 058' '-nbd -qcow2 058' '-file -raw 0=
59' '-file -qcow2 059' '-nbd -raw 059' '-nbd -qcow2 059' '-file -raw 060'=
 '-file -qcow2 060' '-nbd -raw 060' '-nbd -qcow2 060' '-file -raw 061' '-=
file -qcow2 061' '-nbd -raw 061' '-nbd -qcow2 061' '-file -raw 062' '-fil=
e -qcow2 062' '-nbd -raw 062' '-nbd -qcow2 062' '-file -raw 063' '-file -=
qcow2 063' '-nbd -raw 063' '-nbd -qcow2 063' '-file -raw 064' '-file -qco=
w2 064' '-nbd -raw 064' '-nbd -qcow2 064' '-file -raw 065' '-file -qcow2 =
065' '-nbd -raw 065' '-nbd -qcow2 065' '-file -raw 066' '-file -qcow2 066=
' '-nbd -raw 066' '-nbd -qcow2 066' '-file -raw 067' '-file -qcow2 067' '=
-nbd -raw 067' '-nbd -qcow2 067' '-file -raw 068' '-file -qcow2 068' '-nb=
d -raw 068' '-nbd -qcow2 068' '-file -raw 069' '-file -qcow2 069' '-nbd -=
raw 069' '-nbd -qcow2 069' '-file -raw 070' '-file -qcow2 070' '-nbd -raw=
 070' '-nbd -qcow2 070' '-file -raw 071' '-file -qcow2 071' '-nbd -raw 07=
1' '-nbd -qcow2 071' '-file -raw 072' '-file -qcow2 072' '-nbd -raw 072' =
'-nbd -qcow2 072' '-file -raw 073' '-file -qcow2 073' '-nbd -raw 073' '-n=
bd -qcow2 073' '-file -raw 074' '-file -qcow2 074' '-nbd -raw 074' '-nbd =
-qcow2 074' '-file -raw 075' '-file -qcow2 075' '-nbd -raw 075' '-nbd -qc=
ow2 075' '-file -raw 076' '-file -qcow2 076' '-nbd -raw 076' '-nbd -qcow2=
 076' '-file -raw 077' '-file -qcow2 077' '-nbd -raw 077' '-nbd -qcow2 07=
7' '-file -raw 078' '-file -qcow2 078' '-nbd -raw 078' '-nbd -qcow2 078' =
'-file -raw 079' '-file -qcow2 079' '-nbd -raw 079' '-nbd -qcow2 079' '-f=
ile -raw 080' '-file -qcow2 080' '-nbd -raw 080' '-nbd -qcow2 080' '-file=
 -raw 081' '-file -qcow2 081' '-nbd -raw 081' '-nbd -qcow2 081' '-file -r=
aw 082' '-file -qcow2 082' '-nbd -raw 082' '-nbd -qcow2 082' '-file -raw =
083' '-file -qcow2 083' '-nbd -raw 083' '-nbd -qcow2 083' '-file -raw 084=
' '-file -qcow2 084' '-nbd -raw 084' '-nbd -qcow2 084' '-file -raw 085' '=
-file -qcow2 085' '-nbd -raw 085' '-nbd -qcow2 085' '-file -raw 086' '-fi=
le -qcow2 086' '-nbd -raw 086' '-nbd -qcow2 086' '-file -raw 087' '-file =
-qcow2 087' '-nbd -raw 087' '-nbd -qcow2 087' '-file -raw 088' '-file -qc=
ow2 088' '-nbd -raw 088' '-nbd -qcow2 088' '-file -raw 089' '-file -qcow2=
 089' '-nbd -raw 089' '-nbd -qcow2 089' '-file -raw 090' '-file -qcow2 09=
0' '-nbd -raw 090' '-nbd -qcow2 090' '-file -raw 091' '-file -qcow2 091' =
'-nbd -raw 091' '-nbd -qcow2 091' '-file -raw 092' '-file -qcow2 092' '-n=
bd -raw 092' '-nbd -qcow2 092' '-file -raw 093' '-file -qcow2 093' '-nbd =
-raw 093' '-nbd -qcow2 093' '-file -raw 094' '-file -qcow2 094' '-nbd -ra=
w 094' '-nbd -qcow2 094' '-file -raw 095' '-file -qcow2 095' '-nbd -raw 0=
95' '-nbd -qcow2 095' '-file -raw 096' '-file -qcow2 096' '-nbd -raw 096'=
 '-nbd -qcow2 096' '-file -raw 097' '-file -qcow2 097' '-nbd -raw 097' '-=
nbd -qcow2 097' '-file -raw 098' '-file -qcow2 098' '-nbd -raw 098' '-nbd=
 -qcow2 098' '-file -raw 099' '-file -qcow2 099' '-nbd -raw 099' '-nbd -q=
cow2 099' '-file -raw 101' '-file -qcow2 101' '-nbd -raw 101' '-nbd -qcow=
2 101' '-file -raw 102' '-file -qcow2 102' '-nbd -raw 102' '-nbd -qcow2 1=
02' '-file -raw 103' '-file -qcow2 103' '-nbd -raw 103' '-nbd -qcow2 103'=
 '-file -raw 104' '-file -qcow2 104' '-nbd -raw 104' '-nbd -qcow2 104' '-=
file -raw 105' '-file -qcow2 105' '-nbd -raw 105' '-nbd -qcow2 105' '-fil=
e -raw 106' '-file -qcow2 106' '-nbd -raw 106' '-nbd -qcow2 106' '-file -=
raw 107' '-file -qcow2 107' '-nbd -raw 107' '-nbd -qcow2 107' '-file -raw=
 108' '-file -qcow2 108' '-nbd -raw 108' '-nbd -qcow2 108' '-file -raw 10=
9' '-file -qcow2 109' '-nbd -raw 109' '-nbd -qcow2 109' '-file -raw 110' =
'-file -qcow2 110' '-nbd -raw 110' '-nbd -qcow2 110' '-file -raw 111' '-f=
ile -qcow2 111' '-nbd -raw 111' '-nbd -qcow2 111' '-file -raw 112' '-file=
 -qcow2 112' '-nbd -raw 112' '-nbd -qcow2 112' '-file -raw 113' '-file -q=
cow2 113' '-nbd -raw 113' '-nbd -qcow2 113' '-file -raw 114' '-file -qcow=
2 114' '-nbd -raw 114' '-nbd -qcow2 114' '-file -raw 115' '-file -qcow2 1=
15' '-nbd -raw 115' '-nbd -qcow2 115' '-file -raw 116' '-file -qcow2 116'=
 '-nbd -raw 116' '-nbd -qcow2 116' '-file -raw 117' '-file -qcow2 117' '-=
nbd -raw 117' '-nbd -qcow2 117' '-file -raw 118' '-file -qcow2 118' '-nbd=
 -raw 118' '-nbd -qcow2 118' '-file -raw 119' '-file -qcow2 119' '-nbd -r=
aw 119' '-nbd -qcow2 119' '-file -raw 120' '-file -qcow2 120' '-nbd -raw =
120' '-nbd -qcow2 120' '-file -raw 121' '-file -qcow2 121' '-nbd -raw 121=
' '-nbd -qcow2 121' '-file -raw 122' '-file -qcow2 122' '-nbd -raw 122' '=
-nbd -qcow2 122' '-file -raw 123' '-file -qcow2 123' '-nbd -raw 123' '-nb=
d -qcow2 123' '-file -raw 124' '-file -qcow2 124' '-nbd -raw 124' '-nbd -=
qcow2 124' '-file -raw 125' '-file -qcow2 125' '-nbd -raw 125' '-nbd -qco=
w2 125' '-file -raw 126' '-file -qcow2 126' '-nbd -raw 126' '-nbd -qcow2 =
126' '-file -raw 127' '-file -qcow2 127' '-nbd -raw 127' '-nbd -qcow2 127=
' '-file -raw 128' '-file -qcow2 128' '-nbd -raw 128' '-nbd -qcow2 128' '=
-file -raw 129' '-file -qcow2 129' '-nbd -raw 129' '-nbd -qcow2 129' '-fi=
le -raw 130' '-file -qcow2 130' '-nbd -raw 130' '-nbd -qcow2 130' '-file =
-raw 131' '-file -qcow2 131' '-nbd -raw 131' '-nbd -qcow2 131' '-file -ra=
w 132' '-file -qcow2 132' '-nbd -raw 132' '-nbd -qcow2 132' '-file -raw 1=
33' '-file -qcow2 133' '-nbd -raw 133' '-nbd -qcow2 133' '-file -raw 134'=
 '-file -qcow2 134' '-nbd -raw 134' '-nbd -qcow2 134' '-file -raw 135' '-=
file -qcow2 135' '-nbd -raw 135' '-nbd -qcow2 135' '-file -raw 136' '-fil=
e -qcow2 136' '-nbd -raw 136' '-nbd -qcow2 136' '-file -raw 137' '-file -=
qcow2 137' '-nbd -raw 137' '-nbd -qcow2 137' '-file -raw 138' '-file -qco=
w2 138' '-nbd -raw 138' '-nbd -qcow2 138' '-file -raw 139' '-file -qcow2 =
139' '-nbd -raw 139' '-nbd -qcow2 139' '-file -raw 140' '-file -qcow2 140=
' '-nbd -raw 140' '-nbd -qcow2 140' '-file -raw 141' '-file -qcow2 141' '=
-nbd -raw 141' '-nbd -qcow2 141' '-file -raw 142' '-file -qcow2 142' '-nb=
d -raw 142' '-nbd -qcow2 142' '-file -raw 143' '-file -qcow2 143' '-nbd -=
raw 143' '-nbd -qcow2 143' '-file -raw 144' '-file -qcow2 144' '-nbd -raw=
 144' '-nbd -qcow2 144' '-file -raw 145' '-file -qcow2 145' '-nbd -raw 14=
5' '-nbd -qcow2 145' '-file -raw 146' '-file -qcow2 146' '-nbd -raw 146' =
'-nbd -qcow2 146' '-file -raw 147' '-file -qcow2 147' '-nbd -raw 147' '-n=
bd -qcow2 147' '-file -raw 148' '-file -qcow2 148' '-nbd -raw 148' '-nbd =
-qcow2 148' '-file -raw 149' '-file -qcow2 149' '-nbd -raw 149' '-nbd -qc=
ow2 149' '-file -raw 150' '-file -qcow2 150' '-nbd -raw 150' '-nbd -qcow2=
 150' '-file -raw 152' '-file -qcow2 152' '-nbd -raw 152' '-nbd -qcow2 15=
2' '-file -raw 153' '-file -qcow2 153' '-nbd -raw 153' '-nbd -qcow2 153' =
'-file -raw 154' '-file -qcow2 154' '-nbd -raw 154' '-nbd -qcow2 154' '-f=
ile -raw 155' '-file -qcow2 155' '-nbd -raw 155' '-nbd -qcow2 155' '-file=
 -raw 156' '-file -qcow2 156' '-nbd -raw 156' '-nbd -qcow2 156' '-file -r=
aw 157' '-file -qcow2 157' '-nbd -raw 157' '-nbd -qcow2 157' '-file -raw =
158' '-file -qcow2 158' '-nbd -raw 158' '-nbd -qcow2 158' '-file -raw 159=
' '-file -qcow2 159' '-nbd -raw 159' '-nbd -qcow2 159' '-file -raw 160' '=
-file -qcow2 160' '-nbd -raw 160' '-nbd -qcow2 160' '-file -raw 162' '-fi=
le -qcow2 162' '-nbd -raw 162' '-nbd -qcow2 162' '-file -raw 163' '-file =
-qcow2 163' '-nbd -raw 163' '-nbd -qcow2 163' '-file -raw 165' '-file -qc=
ow2 165' '-nbd -raw 165' '-nbd -qcow2 165' '-file -raw 170' '-file -qcow2=
 170' '-nbd -raw 170' '-nbd -qcow2 170' '-file -raw 171' '-file -qcow2 17=
1' '-nbd -raw 171' '-nbd -qcow2 171' '-file -raw 172' '-file -qcow2 172' =
'-nbd -raw 172' '-nbd -qcow2 172' '-file -raw 173' '-file -qcow2 173' '-n=
bd -raw 173' '-nbd -qcow2 173' '-file -raw 174' '-file -qcow2 174' '-nbd =
-raw 174' '-nbd -qcow2 174' '-file -raw 175' '-file -qcow2 175' '-nbd -ra=
w 175' '-nbd -qcow2 175' '-file -raw 176' '-file -qcow2 176' '-nbd -raw 1=
76' '-nbd -qcow2 176' '-file -raw 177' '-file -qcow2 177' '-nbd -raw 177'=
 '-nbd -qcow2 177' '-file -raw 178' '-file -qcow2 178' '-nbd -raw 178' '-=
nbd -qcow2 178' '-file -raw 179' '-file -qcow2 179' '-nbd -raw 179' '-nbd=
 -qcow2 179' '-file -raw 181' '-file -qcow2 181' '-nbd -raw 181' '-nbd -q=
cow2 181' '-file -raw 182' '-file -qcow2 182' '-nbd -raw 182' '-nbd -qcow=
2 182' '-file -raw 183' '-file -qcow2 183' '-nbd -raw 183' '-nbd -qcow2 1=
83' '-file -raw 184' '-file -qcow2 184' '-nbd -raw 184' '-nbd -qcow2 184'=
 '-file -raw 185' '-file -qcow2 185' '-nbd -raw 185' '-nbd -qcow2 185' '-=
file -raw 186' '-file -qcow2 186' '-nbd -raw 186' '-nbd -qcow2 186' '-fil=
e -raw 187' '-file -qcow2 187' '-nbd -raw 187' '-nbd -qcow2 187' '-file -=
raw 188' '-file -qcow2 188' '-nbd -raw 188' '-nbd -qcow2 188' '-file -raw=
 189' '-file -qcow2 189' '-nbd -raw 189' '-nbd -qcow2 189' '-file -raw 19=
0' '-file -qcow2 190' '-nbd -raw 190' '-nbd -qcow2 190' '-file -raw 191' =
'-file -qcow2 191' '-nbd -raw 191' '-nbd -qcow2 191' '-file -raw 192' '-f=
ile -qcow2 192' '-nbd -raw 192' '-nbd -qcow2 192' '-file -raw 194' '-file=
 -qcow2 194' '-nbd -raw 194' '-nbd -qcow2 194' '-file -raw 195' '-file -q=
cow2 195' '-nbd -raw 195' '-nbd -qcow2 195' '-file -raw 196' '-file -qcow=
2 196' '-nbd -raw 196' '-nbd -qcow2 196' '-file -raw 197' '-file -qcow2 1=
97' '-nbd -raw 197' '-nbd -qcow2 197' '-file -raw 198' '-file -qcow2 198'=
 '-nbd -raw 198' '-nbd -qcow2 198' '-file -raw 200' '-file -qcow2 200' '-=
nbd -raw 200' '-nbd -qcow2 200' '-vmdk 059' '-vhdx 064' '-vhdx 070' '-clo=
op 075' '-parallels 076' '-bochs 078' '-vdi 084' '-vpc 088' '-qcow 092' '=
-qed 116' '-parallels 131' '-vpc 135' '-vpc 146'

(plus when I get resolution for "-nfs 172" it'll be also included)

Luk=C3=A1=C5=A1

>=20
> Thanks!
>=20



--rW56OrOmCm47HmjBjL9tMibOTUDNMVR5s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJaH5MMExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsHK
eQgArMjjcd1YRw6J+ea6tUE064RH+6cRNHIlHNtnVbdYnRYTkH02W3V+jKTfZro7
dtLWpvDV+cCVpZThd80xNRSZQMrclrvaY2Qh/uzhPl1Ep0WmhG9QbCMjkiLs0mZz
rEr/vd6F4Bi5Y5WYxrFlKvKJudzoHHO1b5Y7Us2lvfEE2/0nS2RN3YYMzQxBYUOL
CGbZ7J8NKKAB0X02ALHlOkWO3UEugSzwiHNCLx7N+licU1CXHxpZRJ4dS+oxaS46
ljLkwViTxeDRqOuXz/mcDmwdbeQy3Da3j2usLNZTxxcW43x5ybC2X/uDcIM0kkpn
NR9lMYpqdCE9erp/ShsRz3Ub7Q==
=gRJk
-----END PGP SIGNATURE-----

--rW56OrOmCm47HmjBjL9tMibOTUDNMVR5s--
