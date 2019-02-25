Received: from eggs.gnu.org ([209.51.188.92]:52980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyIt6-0001s6-N0
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyIt4-0004tD-S4
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:13:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16675)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gyIt3-0004pW-2q
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:13:50 -0500
References: <87d0o24u0s.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b3a486f6-6b72-2950-9fdd-706c2f69c616@redhat.com>
Date: Mon, 25 Feb 2019 10:13:32 -0600
MIME-Version: 1.0
In-Reply-To: <87d0o24u0s.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Maintainers, please git-am -m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 2/8/19 1:30 AM, Markus Armbruster wrote:
> Short story: please add
>=20
>     [am]
>             messageid =3D true
>=20
> to your .gitconfig.
>=20
> Long story.  git-am can add a Message-id: tag.  Looks like this:
>=20

>=20
>         Signed-off-by: Thomas Huth <thuth@redhat.com>
>         Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>         Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>         Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>         Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> --->    Message-id: 1549268743-18502-1-git-send-email-thuth@redhat.com
>         Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> The Message-id identifies the patch e-mail.  It makes finding the revie=
w
> thread easier and more reliable.  It's also a valid key on Patchew[*].

I find the tag valuable enough in later git searches that I don't mind
feeding my own patches back through the mailing list to add it (patchew
helps with that, of course).  But for it to become mandatory, we'd need
to enhance scripts/checkpatch.pl to enforce it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
