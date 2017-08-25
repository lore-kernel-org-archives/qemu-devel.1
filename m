Received: from eggs.gnu.org ([2001:4830:134:3::10]:57643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl7bE-0003He-Ht
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl7bA-0004hx-LD
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:56:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dl7bA-0004hk-Ey
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:56:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 289BF356C7
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 05:56:03 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170824103350.16400-1-marcandre.lureau@redhat.com>
	<20170824103350.16400-3-marcandre.lureau@redhat.com>
Date: Fri, 25 Aug 2017 07:55:58 +0200
In-Reply-To: <20170824103350.16400-3-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 24 Aug 2017 12:33:38 +0200")
Message-ID: <87bmn442dt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/14] qlit: move qlit from check-qjson to
 qobject/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Fix code style issues while at it, to please check-patch.

It's spelled checkpatch.  Can touch up on commit.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qmp/qlit.h | 49 +++++++++++++++++++++++++
>  qobject/qlit.c          | 89 +++++++++++++++++++++++++++++++++++++++++++=
++
>  tests/check-qjson.c     | 96 +------------------------------------------=
------
>  qobject/Makefile.objs   |  2 +-
>  4 files changed, 140 insertions(+), 96 deletions(-)
>  create mode 100644 include/qapi/qmp/qlit.h
>  create mode 100644 qobject/qlit.c
>
> diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
> new file mode 100644
> index 0000000000..4e2e760ef1
> --- /dev/null
> +++ b/include/qapi/qmp/qlit.h
> @@ -0,0 +1,49 @@
> +/*
> + * Copyright IBM, Corp. 2009
> + * Copyright (c) 2013, 2015, 2017 Red Hat Inc.
> + *
> + * Authors:
> + *  Anthony Liguori   <aliguori@us.ibm.com>
> + *  Markus Armbruster <armbru@redhat.com>
> + *  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
> + * See the COPYING.LIB file in the top-level directory.
> + *
> + */
> +#ifndef QLIT_H_
> +#define QLIT_H_

QLIT_H (no trailing _), to match the other headers in this directory.
Can touch up on commit.

[...]

With the two spelling nits corrected:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
