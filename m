Received: from eggs.gnu.org ([2001:4830:134:3::10]:54359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaKbt-00069B-Ip
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:13:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gaKbs-0003A9-PL
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:13:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gaKbs-00038x-Io
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 08:13:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC3487EBD5
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 13:12:59 +0000 (UTC)
Date: Fri, 21 Dec 2018 14:12:53 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181221141253.42f1a5df.cohuck@redhat.com>
In-Reply-To: <20181221090410.27250-22-marcandre.lureau@redhat.com>
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<20181221090410.27250-22-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 21/28] compat: remove remaining
 PC_COMPAT macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, ehabkost@redhat.com

On Fri, 21 Dec 2018 13:04:03 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Use static arrays instead.  I decided to rename the conflicting
> pc_compat_2_1() function with pc_compat_2_1_fn().
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/i386/pc.h | 236 +++----------------------------------------
>  hw/i386/pc.c         | 232 ++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/pc_piix.c    |  57 ++++-------
>  3 files changed, 267 insertions(+), 258 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
