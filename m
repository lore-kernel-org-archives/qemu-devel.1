Received: from eggs.gnu.org ([209.51.188.92]:55750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gsR08-0005Qj-Ex
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 06:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gsR07-0000kO-9a
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 06:40:52 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gsR06-0000gV-UB
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 06:40:51 -0500
Date: Sat, 9 Feb 2019 12:40:41 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190209114041.ibd3adln5vw4iky5@function>
References: <20190208181122.23393-1-marcandre.lureau@redhat.com>
	<20190208181122.23393-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208181122.23393-5-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH slirp 4/5] slirp: add state saving/loading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org

marcandre.lureau@redhat.com, le ven. 08 f=C3=A9vr. 2019 19:11:21 +0100, a=
 ecrit:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Based on qemu vmstate serialization code. At this point it should
> produce the same result. However, with future state versions, slirp
> should be free to change its format, by bumping the reported state
> version.

Mmm, then qemu needs to be taught to call slirp_state_save/load/version?

Samuel
