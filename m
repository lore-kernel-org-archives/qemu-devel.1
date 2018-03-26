Received: from eggs.gnu.org ([2001:4830:134:3::10]:34479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Xql-0000ks-Qt
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Xqi-0000mN-Nv
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:32:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56224 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0Xqi-0000m2-JP
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:32:08 -0400
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
	<20180326150916.9602-7-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <68fdcef1-d8d3-69cc-04ce-c0c3d2094d26@redhat.com>
Date: Mon, 26 Mar 2018 14:31:59 -0500
MIME-Version: 1.0
In-Reply-To: <20180326150916.9602-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 06/38] monitor: no need to remove desc
 before replacing it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 03/26/2018 10:08 AM, Marc-Andr=C3=A9 Lureau wrote:
> The following qdict_put() line does replace the value, as the
> documentation says.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   monitor.c | 1 -
>   1 file changed, 1 deletion(-)

This patch is unneeded once Peter's change lands:
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06513.html
as that patch also deletes the line in question.

It may be worth waiting for the OOB stuff to settle and then rebase the=20
remaining cleanups as a separate series from the async command addition,=20
especially if some of the cleanups are still relevant as minor bug fixes=20
for 2.12.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
