Received: from eggs.gnu.org ([2001:4830:134:3::10]:59064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVCQ0-0004WK-RN
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 04:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVCPx-0003Fg-2Y
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 04:55:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fVCPw-0003Fb-U1
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 04:55:12 -0400
Date: Tue, 19 Jun 2018 09:55:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180619085502.GH20929@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180618225131.13113-1-ehabkost@redhat.com>
	<20180618225131.13113-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180618225131.13113-3-ehabkost@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] Revert "docker.py: Python 2.6 argparse
 compatibility"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, Jun 18, 2018 at 07:51:30PM -0300, Eduardo Habkost wrote:
> This reverts commit c2d3189667409561772e8c1e5615c5166cd8aa2c.
>=20
> scripts/argparse.py was removed from the tree, so we don't need
> this hack anymore.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/docker/docker.py | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

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
