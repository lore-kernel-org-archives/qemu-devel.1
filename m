Received: from eggs.gnu.org ([2001:4830:134:3::10]:33159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1estKM-00057N-TR
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1estKI-0001iV-H9
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:51:06 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49884 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1estKI-0001hn-D0
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:51:02 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E1034063641
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 16:50:58 +0000 (UTC)
References: <1520267868-31778-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <710eb2ec-8585-900f-6829-67765c188252@redhat.com>
Date: Mon, 5 Mar 2018 10:50:51 -0600
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

s/an/a/

> a 'head' parameter to the HMP and QMP commands to be able to specify
> alternative devices and heads with the screendump command, too.
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
