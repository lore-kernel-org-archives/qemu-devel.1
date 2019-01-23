Received: from eggs.gnu.org ([209.51.188.92]:52494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmJxZ-0007sZ-AM
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmJxY-00006z-Fz
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:56:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmJxY-00006S-A9
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:56:56 -0500
Date: Wed, 23 Jan 2019 14:56:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190123145644.GK27270@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190123120759.7162-1-jusual@mail.ru>
	<20190123120759.7162-2-jusual@mail.ru> <87zhrrzc8l.fsf@linaro.org>
	<8f1c4cff-c186-9fc3-10ee-7f628882ef82@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f1c4cff-c186-9fc3-10ee-7f628882ef82@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/3] tests/libqtest: Introduce
 qtest_init_with_serial()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Steffen =?utf-8?B?R8O2cnR6?= <contrib@steffen-goertz.de>, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mussared <jim@groklearning.com>

On Wed, Jan 23, 2019 at 08:44:12AM -0600, Eric Blake wrote:
> On 1/23/19 8:20 AM, Alex Benn=C3=A9e wrote:
> >=20
> > Julia Suvorova <jusual@mail.ru> writes:
> >=20
> >> Run qtest with a socket that connects QEMU chardev and test code.
> >>
> >> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> >> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >=20
>=20
> >> +QTestState *qtest_init_with_serial(const char *extra_args, int *soc=
k_fd)
> >> +{
> >> +    int sock_fd_init;
> >> +    char *sock_path, sock_dir[] =3D "/tmp/qtest-serial-XXXXXX";
> >> +    QTestState *qts;
> >> +
> >> +    g_assert_true(mkdtemp(sock_dir) !=3D NULL);
> >> +    sock_path =3D g_strdup_printf("%s/sock", sock_dir);
> >> +
> >> +    sock_fd_init =3D init_socket(sock_path);
> >> +
> >> +    qts =3D qtest_initf("-chardev socket,id=3Ds0,path=3D%s -serial =
chardev:s0 %s",
> >> +                      sock_path, extra_args);
>=20
> EWWWW.  Please, let's not bake in this interface.  Relying on shell
> splitting is nasty.

qtest_initf() is long a standing interface that's relied on
shell splitting for years :-( I agree we should fix that, but
its a pre-existing problem that this patch doesn't make worse.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
