Received: from eggs.gnu.org ([2001:4830:134:3::10]:46157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fgOs5-0003WH-Mg
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fgOs2-0005ML-JI
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:26:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52800 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fgOs2-0005MA-F4
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:26:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1076B4DF
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 06:26:29 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
	<20180719184111.5129-8-marcandre.lureau@redhat.com>
Date: Fri, 20 Jul 2018 08:26:26 +0200
In-Reply-To: <20180719184111.5129-8-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 19 Jul 2018 20:41:00 +0200")
Message-ID: <87sh4etobx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/18] qmp: drop json_parser_parse()
 wrapper
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

> Stupid wrapper that's used exactly once, in libqtest.c.  Let's use
> json_parser_parse_err() there, and drop the wrapper.  Let's rename
> json_parser_parse_err() to json_parser_parse() then.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
