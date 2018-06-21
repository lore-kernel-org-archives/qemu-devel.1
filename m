Received: from eggs.gnu.org ([2001:4830:134:3::10]:36199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVvjj-00018p-8u
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 05:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVvjg-0005N4-3s
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 05:18:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45902 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fVvjf-0005Mr-Ul
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 05:18:36 -0400
Date: Thu, 21 Jun 2018 10:18:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180621091831.GF3615@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180621083551.775-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180621083551.775-1-armbru@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qapi: Fix some pycodestyle-3 complaints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

On Thu, Jun 21, 2018 at 10:35:51AM +0200, Markus Armbruster wrote:
> Fix the following issues:
>=20
>     common.py:873:13: E129 visually indented line with same indent as n=
ext logical line
>     common.py:1766:5: E741 ambiguous variable name 'l'
>     common.py:1784:1: E305 expected 2 blank lines after class or functi=
on definition, found 1
>     common.py:1833:1: E305 expected 2 blank lines after class or functi=
on definition, found 1
>     common.py:1843:1: E305 expected 2 blank lines after class or functi=
on definition, found 1
>     visit.py:181:18: E127 continuation line over-indented for visual in=
dent
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/common.py | 15 +++++++++------
>  scripts/qapi/visit.py  |  2 +-
>  2 files changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


If we care about pycodestyle-3 compliance, it is probably worth adding
that to 'make check' to avoid people introducing regressions.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
