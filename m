Received: from eggs.gnu.org ([209.51.188.92]:45259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzQ9f-00069T-Ua
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:11:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzQ9c-0007X8-02
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:11:33 -0500
References: <20190227162035.18543-1-berrange@redhat.com>
	<20190227162035.18543-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e6944ece-e00e-643a-fa71-deb18841e2fb@redhat.com>
Date: Thu, 28 Feb 2019 12:11:00 -0600
MIME-Version: 1.0
In-Reply-To: <20190227162035.18543-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 1/3] qemu-nbd: add support for
 authorization of TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Juan Quintela <quintela@redhat.com>

On 2/27/19 10:20 AM, Daniel P. Berrang=C3=A9 wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> Currently any client which can complete the TLS handshake is able to us=
e
> the NBD server. The server admin can turn on the 'verify-peer' option
> for the x509 creds to require the client to provide a x509 certificate.
> This means the client will have to acquire a certificate from the CA
> before they are permitted to use the NBD server. This is still a fairly
> low bar to cross.
>=20
> This adds a '--tls-authz OBJECT-ID' option to the qemu-nbd command whic=
h
> takes the ID of a previously added 'QAuthZ' object instance. This will
> be used to validate the client's x509 distinguished name. Clients
> failing the authorization check will not be permitted to use the NBD
> server.

It doesn't hold up this patch, but I note that with the qemu QMP command
changes you make in 2/3, you document that the object can be
created/removed on the fly, and the server will adjust which clients can
then subsequently connect. Is there any need for the same sort of
runtime configurability in qemu-nbd, and if so, how would we accomplish
it?  Perhaps by having a command-line option to parse --tls-authz from a
file, where you can send SIGHUP to qemu-nbd to force it to re-read the
file?  Or am I worrying about something unlikely to be needed in practice=
?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
