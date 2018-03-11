Received: from eggs.gnu.org ([2001:4830:134:3::10]:59152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eurJL-0007KI-35
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eurJG-00038U-Oq
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:06:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33282 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eurJG-00038A-KN
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:06:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3C3B4022909
	for <qemu-devel@nongnu.org>; Sun, 11 Mar 2018 03:05:54 +0000 (UTC)
References: <1520267868-31778-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2eb04741-4dcd-1f57-4786-ca8328502b79@redhat.com>
Date: Sat, 10 Mar 2018 21:05:47 -0600
MIME-Version: 1.0
In-Reply-To: <1520267868-31778-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] qapi: Add device ID and head parameters
 to screendump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

On 03/05/2018 10:37 AM, Thomas Huth wrote:
> QEMU's screendump command can only take dumps from the primary display.
> When using multiple VGA cards, there is no way to get a dump from a
> secondary card or other display heads yet. So let's add an 'device' and
> a 'head' parameter to the HMP and QMP commands to be able to specify
> alternative devices and heads with the screendump command, too.
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v4:
>   - Improved the documentation of the parameters in ui.json a little bi=
t
>     (according to the suggestions from Eric)

We're getting close to soft freeze; I'll include this in my QAPI tree,=20
since I have an upcoming pull request, rather than figuring out if Gerd=20
is also doing one more pull (but of course, if he does, it doesn't hurt;=20
git handles patches on multiple merge branches just fine, or I can=20
rebase it out of mine if Gerd's tree goes in first).

Queued:

git://repo.or.cz/qemu/ericb.git qapi
http://repo.or.cz/qemu/ericb.git/shortlog/refs/heads/qapi

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
