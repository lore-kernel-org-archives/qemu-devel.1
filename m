Received: from eggs.gnu.org ([2001:4830:134:3::10]:58143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyeR3-0005qb-Bt
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyeR0-0001n1-6t
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:09:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyeR0-0001mj-1U
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:09:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1E588182D3D
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 14:09:45 +0000 (UTC)
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9efff62f-1762-12ff-02c2-6d117163a1c9@redhat.com>
Date: Wed, 21 Mar 2018 09:09:42 -0500
MIME-Version: 1.0
In-Reply-To: <20180321134005.8822-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] RFC: simplify qobject refcount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com

On 03/21/2018 08:40 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> This series aims to get rid of the distinction between QObject, that
> must use qobject_incref/qobject_decref and its various derived types
> that have to use QINCREF/QDECREF. Instead, replace it with
> qobject_ref/qobject_unref for all types.

I _like_ the fact that you don't have to use a different thing for the=20
base class compared to the derived classes.  I'm not sure I like that=20
the name got longer in the QINCREF -> qobject_ref direction, but it got=20
shorter in the qobject_incref =3D> qobject_ref direction, so maybe=20
bikeshedding on the final name is still possible?

>=20
> Marc-Andr=C3=A9 Lureau (3):
>    compiler: extend QEMU_GENERIC to handle more arguments
>    qobject: assume base of a qobject is at offset 0
>    qobject: replace qobject_incref/QINCREF qobject_decref/QDECREF

But I definitely think this is 2.13 material.  It is easy to do=20
(mechanical conversion in 3/3) but a conflict magnet, so it would need=20
to land early after the freeze is lifted.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
