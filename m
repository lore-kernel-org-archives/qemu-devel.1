Received: from eggs.gnu.org ([2001:4830:134:3::10]:42234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvNRl-0004Mc-K8
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvNRh-0002kk-I6
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:57:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48316 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fvNRh-0002kT-Bl
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:57:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66AF0DFEC
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 13:57:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
	<20180829134043.31706-10-marcandre.lureau@redhat.com>
Date: Thu, 30 Aug 2018 15:57:07 +0200
In-Reply-To: <20180829134043.31706-10-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 29 Aug 2018
	15:40:42 +0200")
Message-ID: <87mut42c0c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/10] qga: process_event()
 simplification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Simplify the code around qmp_dispatch():
> - rely on qmp_dispatch/check_obj() for message checking
> - have a single send_response() point
> - constify send_response() argument
>
> It changes a couple of error messages:
>
> * When @req isn't a dictionary, from
>     Invalid JSON syntax
>   to
>     QMP input must be a JSON object
>
> * When @req lacks member "execute", from
>     this feature or command is not currently supported
>   to
>     QMP input lacks member 'execute'
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
