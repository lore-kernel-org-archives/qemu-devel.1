Received: from eggs.gnu.org ([2001:4830:134:3::10]:59222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gP9oC-0007EG-Jx
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:27:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gP9nz-0007XM-CN
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:27:23 -0500
Date: Tue, 20 Nov 2018 18:27:01 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181120172701.GC7513@localhost.localdomain>
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-7-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181116155325.22428-7-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] tests: exercise NBD server in TLS mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 16.11.2018 um 16:53 hat Daniel P. Berrang=E9 geschrieben:
> Add tests that validate it is possible to connect to an NBD server
> running TLS mode. Also test mis-matched TLS vs non-TLS connections
> correctly fail.

> +echo
> +echo "=3D=3D preparing TLS creds =3D=3D"
> +
> +tls_x509_create_root_ca "ca1"
> +tls_x509_create_root_ca "ca2"
> +tls_x509_create_server "ca1" "server1"
> +tls_x509_create_client "ca1" "client1"
> +tls_x509_create_client "ca2" "client2"

Looks like we can't blindly assume that certtool exists. This test case
fails for me, starting with the following diff:

@@ -1,30 +1,21 @@
 QA output created by 233

 =3D=3D preparing TLS creds =3D=3D
-Generating a self signed certificate...
-Generating a self signed certificate...
-Generating a signed certificate...
-Generating a signed certificate...
-Generating a signed certificate...
+./common.tls: line 71: certtool: command not found
+./common.tls: line 71: certtool: command not found
+./common.tls: line 98: certtool: command not found
+./common.tls: line 127: certtool: command not found
+./common.tls: line 127: certtool: command not found

Of course, after that everything else fails as well.

Kevin
