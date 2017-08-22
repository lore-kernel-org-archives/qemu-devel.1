Received: from eggs.gnu.org ([2001:4830:134:3::10]:56631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dk3Y6-0006k1-9W
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 03:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dk3Y2-0000zX-9p
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 03:24:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dk3Y2-0000zK-0q
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 03:24:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170818142613.32394-1-ldoktor@redhat.com>
	<f8f1684a-0684-7261-57c3-63aa58892000@redhat.com>
Date: Tue, 22 Aug 2017 09:24:16 +0200
In-Reply-To: <f8f1684a-0684-7261-57c3-63aa58892000@redhat.com> (John Snow's
	message of "Mon, 21 Aug 2017 17:51:19 -0400")
Message-ID: <87bmn8qd3z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: John Snow <jsnow@redhat.com>
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, qemu-devel@nongnu.org, famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, f4bug@amsat.org, mreitz@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

John Snow <jsnow@redhat.com> writes:

> On 08/18/2017 10:26 AM, Luk=C3=A1=C5=A1 Doktor wrote:
>> Hello guys,
>>=20
>> I'm reading the available python modules to exercise qemu and while read=
ing them
>> I fixed some issues that caught my attention. It usually starts with a s=
imple
>> pylint/docstring fixes and slowly graduates to more controversial ones s=
o I'm
>> open to suggestion to remove some of them.
>>=20
>> Kind regards,
>> Luk=C3=A1=C5=A1
>>=20
>> Changes in v2
>> - Squashed 2nd and 10th patches into 2nd one
>> - Use repr() in MonitorResponseError's description
>> - Improved commit message of the 6th patch
>> - Two tweaks to docstrings changed in the 6th patch
>> - Also updated qmp-shell to use new-style super calls (7th patch)
>> - Fixed the accidental rename of qmp `cmd_id` (kept the id->cmd_id patch)
>> - Changed the style of the style-fix in the 10th commit
>>=20
>> Changes in v3
>> - Don't use repr in the 5th patch in MonitorResponseError
>>=20
>> Changes in v4
>> - Use correct git base (remove unwanted commits)
>>=20
>> Changes in v5
>> - Avoid bool comparison
>> - Change report to return in one docstring
>> - Removed the unnecessary spaces around single-line docstring
>>=20
>> Changes in v6
>> - Bunch of docstring tweaks by Markus Armbruster
>> - Line break in <80 chars
>> - result dict =3D> response dict
>> - Removed the "event_match" rename
>>=20
>
> Looks like all ten patches have an R-B despite changes; but it looks
> like nothing particularly major was changed anyway.
>
> Does this fall under Markus's jurisdiction?
>
> (Well, except for qtest.py which seemingly has double-extra-no
> maintainer...!)

qemu.py is about starting and controlling QEMU, commonly for testing
purposes.  It's related to QMP only by virtue of using QMP for control
(well, what else could it use?); if that makes me maintainer, I'll soon
maintain basically all tests :)

As far as I can tell, qemu.py's main user is still qemu-iotests, via
qtest.py.  Dan factored it out to make it available for
tests/migration/guestperf/.

Options for maintaining qemu.py and qtest.py:

* Maintain them with qemu-iotest

  Currently mainained with the block layer core, by Kevin and Max.

  - Keep it that way

  - Appoint qemu-iotest maintainer(s).

* Maintain them separately, say as "Python qtest support", appoint
  maintainer(s)

  Dan appears to be a hot contender:

    $ scripts/get_maintainer.pl -f --git-blame scripts/qtest.py=20
    Fam Zheng <famz@redhat.com> (authored lines:71/110=3D65%,commits:1/3=3D=
33%)
    "Daniel P. Berrange" <berrange@redhat.com> (authored lines:39/110=3D35%=
,commits:2/3=3D67%)
    Max Reitz <mreitz@redhat.com> (commits:2/3=3D67%)
    Amit Shah <amit.shah@redhat.com> (commits:1/3=3D33%)
    Stefan Hajnoczi <stefanha@redhat.com> (commits:1/3=3D33%)
    qemu-devel@nongnu.org (open list:All patches CC here)
    $ scripts/get_maintainer.pl -f --git-blame scripts/qemu.py=20
    "Daniel P. Berrange" <berrange@redhat.com> (authored lines:217/229=3D95=
%,commits:2/4=3D50%)
    Eduardo Habkost <ehabkost@redhat.com> (authored lines:12/229=3D5%,commi=
ts:4/4=3D100%)
    Markus Armbruster <armbru@redhat.com> (commits:1/4=3D25%)
    Max Reitz <mreitz@redhat.com> (commits:1/4=3D25%)
    Amit Shah <amit.shah@redhat.com> (commits:1/4=3D25%)
    qemu-devel@nongnu.org (open list:All patches CC here)

  Eduardo made the mistake^W^W^Wgraciously volunteered to maintain
  scripts/qmp/qmp-shell, which is also used for testing.  Perhaps he'd
  be willing to maintain these guys as well.

* Do nothing

  Hope "somebody" will take pity and merge patches.  A common value of
  "somebody" would be Paolo.
