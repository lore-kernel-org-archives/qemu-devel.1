Received: from eggs.gnu.org ([2001:4830:134:3::10]:53338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gO94k-0004Oy-83
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 17:28:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gO94j-0007D5-EN
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 17:28:26 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-7-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <353b130c-aefb-ec4c-411b-571a79ec76e2@redhat.com>
Date: Sat, 17 Nov 2018 14:49:22 -0600
MIME-Version: 1.0
In-Reply-To: <20181116155325.22428-7-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 11/16/18 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
> Add tests that validate it is possible to connect to an NBD server
> running TLS mode. Also test mis-matched TLS vs non-TLS connections
> correctly fail.
> ---

Missing your Signed-off-by. Can you please supply that, so I can include=20
this in my pull request?

Also, I'm getting failures when trying to test it:

@@ -17,9 +17,9 @@

  =3D=3D check plain client to TLS server fails =3D=3D
  option negotiation failed: read failed: Unexpected end-of-file before=20
all bytes were read
+write failed (error message): Unable to write to socket: Broken pipe
  qemu-img: Could not open 'nbd://localhost:10809': TLS negotiation=20
required before option 8 (structured reply)
  server reported: Option 0x8 not permitted before TLS
-write failed (error message): Unable to write to socket: Broken pipe


which looks like an output race. :(

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
