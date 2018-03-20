Received: from eggs.gnu.org ([2001:4830:134:3::10]:53431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyDi5-000483-Td
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyDi2-0004e1-Lv
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:37:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37202 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eyDi2-0004c4-GK
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:37:34 -0400
Date: Tue, 20 Mar 2018 09:37:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180320093715.GC4530@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180319205040.1113423-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180319205040.1113423-1-eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] qapi: Force UTF8 encoding when
 parsing qapi files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Mon, Mar 19, 2018 at 03:50:40PM -0500, Eric Blake wrote:
> Commit d4e5ec877 already fixed things to work around Python 3's
> lame bug of having LC_ALL=3DC not be 8-bit clean, when parsing the
> main QMP qapi files; but failed to do likewise in the tests
> directory.  As a result, running 'LC_ALL=3DC make check' fails on
> escape-too-big and unicode-str when using python 3 with a nasty
> stack trace instead of the intended graceful error message that
> QAPI doesn't yet support 8-bit data (the two tests contain
> Unicode =C3=A9, when parsed in UTF-8; they represent something
> different when parsed in a proper single-byte C locale, but that
> doesn't matter to the error message printed out, provided that
> brain-dead Python hasn't first choked on the input instead of
> being 8-bit clean).
>=20
> Ideally, we'd teach the qapi generator scripts to automatically
> slurp things in using UTF-8 regardless of locale, and to honor
> content that is not limited to 7 bit data rather than gracefully
> erroring out; but until then, since our graceful error depends
> on python parsing 8-bit data (even if nothing we generate uses
> 8-bit data), our quick fix is to use the right locale when
> running these tests.
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> Will go through my QAPI tree for post-freeze bug fixes
>=20
>  tests/Makefile.include | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
