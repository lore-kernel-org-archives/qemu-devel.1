Received: from eggs.gnu.org ([2001:4830:134:3::10]:33430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT5zI-0008UI-Q9
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT5zE-0005xl-Ht
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:39:00 -0400
Date: Wed, 13 Jun 2018 14:38:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180613133840.GK24528@stefanha-x1.localdomain>
References: <1528866321-23886-1-git-send-email-thuth@redhat.com>
	<1528866321-23886-5-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ee6FjwWxuMujAVRe"
Content-Disposition: inline
In-Reply-To: <1528866321-23886-5-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] qemu-options: Do not show
 -enable-kvm and -enable-hax in the docs anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, zhang.zhanghailiang@huawei.com, Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org


--ee6FjwWxuMujAVRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 07:05:21AM +0200, Thomas Huth wrote:
> We've got three ways of enabling an accelerator: -machine accel=3Dxyz,
> -accel xyz and -enable-xyz. For new QEMU users, this must be very
> confusing ("Which one do I have to use? Is there a difference between
> the options?"). While -enable-kvm was useful in the past, there is no
> real good reason for using it anymore today ("-accel kvm" is even less
> to type than "-enable-kvm"), so let's decrease the confusing amount of
> options in our documenation a little bit by removing the -enable-xyz
> here. Note that the option itself is neither removed nor marked as
> deprecated - since -enable-kvm is likely used in a lot of scripts and
> since its code is easy to maintain, we should keep it around to avoid
> to break old setups.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  PS: I guess Paolo won't like this patch ... let's try it anyway ;-)

It's widely used and we're removing the documentation for it?!  That is
likely to cause issues for new users who refer to the man page to
understand the QEMU command-lines they see online, in scripts, etc.

IMO -enable-kvm is not worth inconveniencing users about.  We gain very
little from abolishing it from docs and/or code, but its absence will
annoy our users.

--ee6FjwWxuMujAVRe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbIR5gAAoJEJykq7OBq3PIfgwH/jGywT2Fgt1Fe2pqG3iOy0UK
ldqsd+MwKklAvqdrlxiI9huOaKXuEziRTK6QOWbyfwkxNqMTcR0kJdzSV+Ca7vRo
oaS+cuWnkF0x5YRKhdX/xxxIQj57aOvksqXul2EfTrUOCoG82r6NR0phIu09isG0
xEvjqTpIp1XEUm9YHszgQBpbTGVxk/b9HRUHkMahQoXEZptKFHPwSxxD86+wdCOs
car1rhbdFf85JU+ca8+G+29HHT4FxULkFdblvWht6yjU2gsOwFkHEhdo9SUAHCGR
/jXDZHHmCsAP0C+bLax1oXRXLdXdHTKKOoTmneycX7GOLdlWPaBDVeKZv7onaoY=
=rdhw
-----END PGP SIGNATURE-----

--ee6FjwWxuMujAVRe--
