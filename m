Received: from eggs.gnu.org ([2001:4830:134:3::10]:36896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOmyI-0004iV-SL
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:04:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOmyD-0002fU-Cw
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:04:26 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-7-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1c54decb-3658-cf59-d2c8-b2d64b236a16@redhat.com>
Date: Mon, 19 Nov 2018 11:04:00 -0600
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

> +++ b/tests/qemu-iotests/common.nbd

> +function nbd_server_wait_for_tcp_socket()
> +{

> +        sleep 0.1
> +    done
> +    echo "Failed in check of unix socket created by qemu-nbd"

Too much copy-and-paste.  Touching up. :)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
