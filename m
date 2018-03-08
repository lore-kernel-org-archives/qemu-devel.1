Received: from eggs.gnu.org ([2001:4830:134:3::10]:37721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eu4nz-0006FS-GG
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 18:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eu4nw-0001SX-9i
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 18:18:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44816 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eu4nw-0001SO-4y
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 18:18:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 344D8402242D
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 23:18:20 +0000 (UTC)
References: <20180305172951.2150-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fed214c9-7e17-0691-09ae-c2f0bb6599c7@redhat.com>
Date: Thu, 8 Mar 2018 17:18:15 -0600
MIME-Version: 1.0
In-Reply-To: <20180305172951.2150-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] qapi: generate a literal qobject for
 introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

On 03/05/2018 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> This is a small series of a few preliminary patches taken off the
> "[PATCH v4 00/51]" qapi-conditional series that were already reviewed
> by Markus. They are improvements worthwhile for 2.12 inclusion.
>=20
> Marc-Andr=C3=A9 Lureau (4):
>    qapi2texi: minor python code simplification
>    qlit: use QType instead of int
>    qlit: add qobject_from_qlit()
>    qapi: generate a literal qobject for introspection

Thanks; I've queued this on my QAPI tree (with the python 3 fix), and=20
will submit a pull request before soft freeze.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
