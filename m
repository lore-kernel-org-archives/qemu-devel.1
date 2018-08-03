Received: from eggs.gnu.org ([2001:4830:134:3::10]:51598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fledv-0003oh-Ca
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fleds-00030p-5M
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:17:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42782 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fledr-00030e-WF
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:17:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95C957A7EF
	for <qemu-devel@nongnu.org>; Fri,  3 Aug 2018 18:17:35 +0000 (UTC)
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
	<20180803173614.12358-4-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b5cb3e5f-d046-20e3-ada6-7d007b5be755@redhat.com>
Date: Fri, 3 Aug 2018 13:17:29 -0500
MIME-Version: 1.0
In-Reply-To: <20180803173614.12358-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/10] configure: bump spice-server
 required version to 0.12.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 08/03/2018 12:36 PM, Marc-Andr=C3=A9 Lureau wrote:
> Looking at chardev/spice.c code, I realize compilation was broken for
> a while with spice-server < 0.12.3. I propose to bump required version
> to 0.12.6, released 3y ago, instead of adding more #ifdef.

Can you please also investigate which version is shipping in various=20
distros? Look at commit e7b3af81 for a good example of justifying a=20
minimum version bump, by calling out the versions in use according to=20
the supported platforms doc.

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
