Received: from eggs.gnu.org ([2001:4830:134:3::10]:41727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1djubb-00031i-7j
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 17:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1djubX-0003J0-Bj
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 17:51:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1djubX-0003Gs-4U
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 17:51:27 -0400
References: <20170818142613.32394-1-ldoktor@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f8f1684a-0684-7261-57c3-63aa58892000@redhat.com>
Date: Mon, 21 Aug 2017 17:51:19 -0400
MIME-Version: 1.0
In-Reply-To: <20170818142613.32394-1-ldoktor@redhat.com>
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
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, armbru@redhat.com, mreitz@redhat.com, f4bug@amsat.org



On 08/18/2017 10:26 AM, Luk=C3=A1=C5=A1 Doktor wrote:
> Hello guys,
>=20
> I'm reading the available python modules to exercise qemu and while rea=
ding them
> I fixed some issues that caught my attention. It usually starts with a =
simple
> pylint/docstring fixes and slowly graduates to more controversial ones =
so I'm
> open to suggestion to remove some of them.
>=20
> Kind regards,
> Luk=C3=A1=C5=A1
>=20
> Changes in v2
> - Squashed 2nd and 10th patches into 2nd one
> - Use repr() in MonitorResponseError's description
> - Improved commit message of the 6th patch
> - Two tweaks to docstrings changed in the 6th patch
> - Also updated qmp-shell to use new-style super calls (7th patch)
> - Fixed the accidental rename of qmp `cmd_id` (kept the id->cmd_id patc=
h)
> - Changed the style of the style-fix in the 10th commit
>=20
> Changes in v3
> - Don't use repr in the 5th patch in MonitorResponseError
>=20
> Changes in v4
> - Use correct git base (remove unwanted commits)
>=20
> Changes in v5
> - Avoid bool comparison
> - Change report to return in one docstring
> - Removed the unnecessary spaces around single-line docstring
>=20
> Changes in v6
> - Bunch of docstring tweaks by Markus Armbruster
> - Line break in <80 chars
> - result dict =3D> response dict
> - Removed the "event_match" rename
>=20

Looks like all ten patches have an R-B despite changes; but it looks
like nothing particularly major was changed anyway.

Does this fall under Markus's jurisdiction?

(Well, except for qtest.py which seemingly has double-extra-no
maintainer...!)

--js
