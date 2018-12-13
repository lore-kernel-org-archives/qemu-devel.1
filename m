Received: from eggs.gnu.org ([2001:4830:134:3::10]:39485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXR5c-0000Ow-B1
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:31:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXR5Z-0001LD-NJ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:31:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXR5Z-0001KM-GA
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:31:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B89112F39
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 13:31:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181213123724.4866-1-marcandre.lureau@redhat.com>
	<20181213123724.4866-13-marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 14:31:36 +0100
In-Reply-To: <20181213123724.4866-13-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 13 Dec 2018 16:37:14 +0400")
Message-ID: <87lg4tr1s7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 12/22] qapi: add a dictionary form for
 TYPE
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

> Wherever a struct/union/alternate/command/event member with NAME: TYPE
> form is accepted, desugar it to a NAME: { 'type': TYPE } form.
>
> This will allow to add new member details, such as 'if' in the
> following patch to introduce conditionals, or 'default' for default
> values etc.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
