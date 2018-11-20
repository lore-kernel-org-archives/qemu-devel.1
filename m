Received: from eggs.gnu.org ([2001:4830:134:3::10]:53280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gP2cH-0000xn-Og
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gP2cE-0003jO-KF
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:46:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gP2cC-0003hX-Is
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:46:41 -0500
Date: Tue, 20 Nov 2018 09:46:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181120094627.GD25047@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181120005701.9304-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181120005701.9304-1-samuel.thibault@ens-lyon.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: Enable fork_exec support on Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, jan.kiszka@siemens.com, eblake@redhat.com, marcandre.lureau@redhat.com

On Tue, Nov 20, 2018 at 01:57:01AM +0100, Samuel Thibault wrote:
> g_spawn_async_with_fds is portable on Windows, so we can now enable
> fork_exec support there.
>=20
> Thanks Daniel P. Berrang=C3=A9 for the notice!
>=20
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>  slirp/misc.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

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
