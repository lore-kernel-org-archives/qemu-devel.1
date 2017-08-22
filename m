Received: from eggs.gnu.org ([2001:4830:134:3::10]:33781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk9fv-0003Cq-E9
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk9fu-0004Mw-Ap
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:56:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dk9fu-0004Ma-1M
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:56:58 -0400
References: <20170818142613.32394-1-ldoktor@redhat.com>
	<f8f1684a-0684-7261-57c3-63aa58892000@redhat.com>
	<87bmn8qd3z.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc249ce1-5707-ddaf-8df7-fe960e86038f@redhat.com>
Date: Tue, 22 Aug 2017 15:56:42 +0200
MIME-Version: 1.0
In-Reply-To: <87bmn8qd3z.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/10] qemu.py: Pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, qemu-devel@nongnu.org, famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, f4bug@amsat.org, mreitz@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 22/08/2017 09:24, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
>=20
>> On 08/18/2017 10:26 AM, Luk=C3=A1=C5=A1 Doktor wrote:
>>> Hello guys,
>>>
>>> I'm reading the available python modules to exercise qemu and while r=
eading them
>>> I fixed some issues that caught my attention. It usually starts with =
a simple
>>> pylint/docstring fixes and slowly graduates to more controversial one=
s so I'm
>>> open to suggestion to remove some of them.
>>>
>>> Kind regards,
>>> Luk=C3=A1=C5=A1
>>>
>>> Changes in v2
>>> - Squashed 2nd and 10th patches into 2nd one
>>> - Use repr() in MonitorResponseError's description
>>> - Improved commit message of the 6th patch
>>> - Two tweaks to docstrings changed in the 6th patch
>>> - Also updated qmp-shell to use new-style super calls (7th patch)
>>> - Fixed the accidental rename of qmp `cmd_id` (kept the id->cmd_id pa=
tch)
>>> - Changed the style of the style-fix in the 10th commit
>>>
>>> Changes in v3
>>> - Don't use repr in the 5th patch in MonitorResponseError
>>>
>>> Changes in v4
>>> - Use correct git base (remove unwanted commits)
>>>
>>> Changes in v5
>>> - Avoid bool comparison
>>> - Change report to return in one docstring
>>> - Removed the unnecessary spaces around single-line docstring
>>>
>>> Changes in v6
>>> - Bunch of docstring tweaks by Markus Armbruster
>>> - Line break in <80 chars
>>> - result dict =3D> response dict
>>> - Removed the "event_match" rename
>>>
>>
>> Looks like all ten patches have an R-B despite changes; but it looks
>> like nothing particularly major was changed anyway.
>>
>> Does this fall under Markus's jurisdiction?
>>
>> (Well, except for qtest.py which seemingly has double-extra-no
>> maintainer...!)
>=20
> qemu.py is about starting and controlling QEMU, commonly for testing
> purposes.  It's related to QMP only by virtue of using QMP for control
> (well, what else could it use?); if that makes me maintainer, I'll soon
> maintain basically all tests :)
>=20
> As far as I can tell, qemu.py's main user is still qemu-iotests, via
> qtest.py.  Dan factored it out to make it available for
> tests/migration/guestperf/.
>=20
> Options for maintaining qemu.py and qtest.py:
>=20
> * Maintain them with qemu-iotest
>=20
>   Currently mainained with the block layer core, by Kevin and Max.
>=20
>   - Keep it that way
>=20
>   - Appoint qemu-iotest maintainer(s).
>=20
> * Maintain them separately, say as "Python qtest support", appoint
>   maintainer(s)
>=20
>   Dan appears to be a hot contender:
>=20
>     $ scripts/get_maintainer.pl -f --git-blame scripts/qtest.py=20
>     Fam Zheng <famz@redhat.com> (authored lines:71/110=3D65%,commits:1/=
3=3D33%)
>     "Daniel P. Berrange" <berrange@redhat.com> (authored lines:39/110=3D=
35%,commits:2/3=3D67%)
>     Max Reitz <mreitz@redhat.com> (commits:2/3=3D67%)
>     Amit Shah <amit.shah@redhat.com> (commits:1/3=3D33%)
>     Stefan Hajnoczi <stefanha@redhat.com> (commits:1/3=3D33%)
>     qemu-devel@nongnu.org (open list:All patches CC here)
>     $ scripts/get_maintainer.pl -f --git-blame scripts/qemu.py=20
>     "Daniel P. Berrange" <berrange@redhat.com> (authored lines:217/229=3D=
95%,commits:2/4=3D50%)
>     Eduardo Habkost <ehabkost@redhat.com> (authored lines:12/229=3D5%,c=
ommits:4/4=3D100%)
>     Markus Armbruster <armbru@redhat.com> (commits:1/4=3D25%)
>     Max Reitz <mreitz@redhat.com> (commits:1/4=3D25%)
>     Amit Shah <amit.shah@redhat.com> (commits:1/4=3D25%)
>     qemu-devel@nongnu.org (open list:All patches CC here)
>=20
>   Eduardo made the mistake^W^W^Wgraciously volunteered to maintain
>   scripts/qmp/qmp-shell, which is also used for testing.  Perhaps he'd
>   be willing to maintain these guys as well.
>=20
> * Do nothing
>=20
>   Hope "somebody" will take pity and merge patches.  A common value of
>   "somebody" would be Paolo.

Paolo is disappearing for two weeks starting Saturday, so you have
plenty of time to find another solution. :)

Paolo
