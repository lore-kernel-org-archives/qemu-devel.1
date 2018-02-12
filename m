Received: from eggs.gnu.org ([2001:4830:134:3::10]:43549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elKDh-0004D3-2u
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elKDd-0001ZY-8q
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:56:57 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elKDd-0001ZE-4b
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:56:53 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-15-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bbfb5831-8055-6ac2-5654-026471875f18@redhat.com>
Date: Mon, 12 Feb 2018 13:56:34 -0600
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-15-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 14/29] qapi: Concentrate
 QAPISchemaParser.exprs updates in .__init__()
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
>   scripts/qapi/common.py | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)

Again, not much mention of 'why' in the commit message.  But=20
centralizing the initialization operations in one place rather than=20
having to chase down multiple places is good.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
