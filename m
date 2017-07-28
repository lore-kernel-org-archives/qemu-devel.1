Received: from eggs.gnu.org ([2001:4830:134:3::10]:39908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4xe-0002du-PD
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4xa-00069P-4T
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:05:46 -0400
Date: Fri, 28 Jul 2017 14:05:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170728130538.GQ12364@stefanha-x1.localdomain>
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-10-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eBTWNsZZiigckDWV"
Content-Disposition: inline
In-Reply-To: <20170725211523.3998-10-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/12] tests/libqos/pci: Clean up string
 interpolation into QMP input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:virtio-blk" <qemu-block@nongnu.org>, armbru@redhat.com, stefanha@redhat.com


--eBTWNsZZiigckDWV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 25, 2017 at 04:15:20PM -0500, Eric Blake wrote:
> @@ -419,19 +420,18 @@ static void test_ivshmem_server_irq(void)
>  static void test_ivshmem_hotplug(void)
>  {
>      const char *arch = qtest_get_arch();
> -    gchar *opts;
> +    QObject *extra_args = qobject_from_jsonf("{ 'shm': '%s', 'size': '1M' }",
> +                                             tmpshm);

Is there a difference between:

  qobject_from_jsonf("{ 'shm': '%s' }", tmpshm);

and:

  qobject_from_jsonf("{ 'shm': %s }", tmpshm);

?

Below you use %s instead of '%s'.

--eBTWNsZZiigckDWV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZezaiAAoJEJykq7OBq3PIT2AH/0Q+tQLXcLEkc3OVhgOCEijR
nmVy8ybw7YI9DwpRjRwLyzq29A6bBAe0kvxE1KHyYRVV1pXAzfL6oMn35gyiyTkd
tHaCP5uUS+tz97PThF+MI9Xe/Wu/IDa2efyBvsS71BUcF2AsgBXtSNi9XOJGJC1s
j9PqLLtL/3yaBc+Aqf95PHOQL/StfSkAzOLIQ0qfnxPHBVGoK7V7h6rCVJlmCkjP
Co4mqg8Iw/UxsZ6t0O5WH5+cobRqsvkUL8nJPiMcbNkiAT/jCGnh5tUzToBJGyWo
5HbbRnV9om5y+aFBuJwZgi7lKeWCJ4P4ebbpCpgnRhZ2meegty6jXLhFktN7l34=
=Q4VD
-----END PGP SIGNATURE-----

--eBTWNsZZiigckDWV--
