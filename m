Received: from eggs.gnu.org ([2001:4830:134:3::10]:57001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxCGr-0008EU-EO
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxCGq-0007ol-Ab
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:21:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxCGq-0007oZ-4F
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:21:00 -0400
Date: Wed, 27 Sep 2017 14:20:52 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170927132052.GJ12223@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170927130339.21444-1-ehabkost@redhat.com>
	<20170927130339.21444-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927130339.21444-5-ehabkost@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/5] scripts: Remove debug parameter from
 QEMUMonitorProtocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>

On Wed, Sep 27, 2017 at 10:03:38AM -0300, Eduardo Habkost wrote:
> Use logging module for the QMP debug messages.  The only scripts
> that set debug=3DTrue are iotests.py and guestperf/engine.py, and
> they already call logging.basicConfig() to set up logging.
>=20
> Scripts that don't configure logging are safe as long as they
> don't need debugging output, because debug messages don't trigger
> the "No handlers could be found for logger" message from the
> Python logging module.
>=20
> Scripts that already configure logging but don't use debug=3DTrue
> (e.g. scripts/vm/basevm.py) will get QMP debugging enabled for
> free.
>=20
> Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qemu.py    |  3 +--
>  scripts/qmp/qmp.py | 13 ++++++-------
>  2 files changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
