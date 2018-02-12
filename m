Received: from eggs.gnu.org ([2001:4830:134:3::10]:39552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elK9J-0001lx-Lz
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elK9F-0004O9-JE
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:52:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57540 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elK9F-0004Ni-ET
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:52:21 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-14-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <718b374f-91bf-7b5d-9ce1-a5076aac9d4a@redhat.com>
Date: Mon, 12 Feb 2018 13:52:17 -0600
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-14-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 13/29] qapi: Lift error reporting from
 QAPISchema.__init__() to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com

On 02/11/2018 03:35 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   scripts/qapi-gen.py            |  8 ++++++--
>   scripts/qapi/common.py         | 23 +++++++++--------------
>   tests/qapi-schema/test-qapi.py | 10 ++++++++--
>   3 files changed, 23 insertions(+), 18 deletions(-)

The commit message didn't say why, but the change is reasonable.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
