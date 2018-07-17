Received: from eggs.gnu.org ([2001:4830:134:3::10]:50637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffReJ-000181-Hg
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffReI-0002nB-GR
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:12:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54354 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ffReI-0002mw-B8
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:12:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04C7A4075767
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 15:12:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
	<20180706121354.2021-11-marcandre.lureau@redhat.com>
Date: Tue, 17 Jul 2018 17:12:20 +0200
In-Reply-To: <20180706121354.2021-11-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 6 Jul 2018 14:13:52 +0200")
Message-ID: <87601ddhgr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/12] tests: add a qmp success-response
 test
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

> Verify the usage of this schema feature and the API behaviour.  This
> should be the only case where qmp_dispatch() returns NULL without
> error.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
