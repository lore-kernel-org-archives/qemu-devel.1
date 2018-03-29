Received: from eggs.gnu.org ([2001:4830:134:3::10]:41158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1aD0-0007pW-Ai
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1aCw-00040t-SD
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:15:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f1aCw-0003zS-LP
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:15:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C6FA406804A
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 16:15:22 +0000 (UTC)
References: <20180329154833.566-1-marcandre.lureau@redhat.com>
	<20180329154833.566-3-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a82b9c0-61b2-83b8-75c5-c748bbde029e@redhat.com>
Date: Thu, 29 Mar 2018 11:15:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180329154833.566-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/4] qobject: introduce QObjectCommon
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

On 03/29/2018 10:48 AM, Marc-Andr=C3=A9 Lureau wrote:
> By moving the common fields to a QObjectCommon, QObject can be a type
> which also has a 'base' QObjectCommon field. This allows to write a
> generic QOBJECT() macro that will work with any QObject type,
> including QObject itself. The container_of() macro ensures that the
> object to cast has a QObjectCommon base field, give me some type
> safety guarantees. However, for it to work properly, all QObject types
> must have 'base' at offset 0 (which is ensured by static checking from
> previous patch)

Commit message should mention the rationale you gave in v2 of NOT using=20
a typedef for QObjectCommon (which was intentional so as to minimize the=20
chance that the type gets abused).  We could even go so far as to name=20
it QObject_, with trailing underscore, rather than QObjectCommon, to=20
make it obvious it is not for normal use.

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
