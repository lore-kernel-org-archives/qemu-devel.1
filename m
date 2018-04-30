Received: from eggs.gnu.org ([2001:4830:134:3::10]:56499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fD8SD-0005Kx-1i
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fD8S9-0000MR-53
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:02:53 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:54577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fD8S8-0000Ly-Sn
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 09:02:49 -0400
Received: by mail-wm0-x229.google.com with SMTP id f6so13031012wmc.4
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 06:02:48 -0700 (PDT)
Date: Mon, 30 Apr 2018 14:02:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180430130246.GB10576@stefanha-x1.localdomain>
References: <20180420181951.7252-1-ehabkost@redhat.com>
	<20180420181951.7252-14-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <20180420181951.7252-14-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC 13/24] avocado_qemu: Functional test for
 RHBZ#1431939
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Amador Pahim <apahim@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2018 at 03:19:40PM -0300, Eduardo Habkost wrote:
> +    def test_hotplug_memory_default_policy(self):
> +        """
> +        According to the RHBZ1431939, the issue is 'host nodes'
> +        returning '128'. It should return empty value when memory
> +        hotplug default policy is used.
> +
> +        Fixed in commit d81d857f4421d205395d55200425daa6591c28a5.
> +        :avocado: tags=RHBZ1431939
> +        """
> +
> +        cmd = 'object_add memory-backend-ram,id=mem1,size=1G'
> +        res = self.vm.qmp('human-monitor-command', command_line=cmd)
> +        self.assertEqual('', res['return'])

General question about QMP test coding style:

What happens if res['return'] does not exist because the QMP command
failed?

I tend to use dict.get() to prevent KeyError.  That way the
assertEqual() will fail instead of an unhandled KeyError in the test
code.

Stefan

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa5xP2AAoJEJykq7OBq3PIyEUH/3J5IyFTTWKpyGy2LTG0MBJ6
7QZPchqN78YX1ER0uHiUvgynOz7yM67VDxj9F4ml2DdRVw+n8qx/LxtCKvtwltWW
dWWsxvzDyDQo8ne/4KHetbWzU4SPpdWsYqotGYkqnyt4/TumwODcdQVQ9XQXHnJS
+cJbJ/C+wZbBH/aA4Q6pLjpnMGKrjMEDHQOme1FQrmOLSV/1RInf0hGM4sqo2gtl
tndYuNNYCg6DF/NrgBnCUNunx0awpvV/YvULosUyjdIuq/4MChWEigCiJwmoxQXc
jOO3dVICkW/pxF8AsXMJ8yTj0FHJA3A6LN3JXizmfhMnxZuemQwLcQ8mky0bm5w=
=8mF5
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
