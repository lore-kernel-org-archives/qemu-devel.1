Received: from eggs.gnu.org ([2001:4830:134:3::10]:48091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJ0oy-00041v-EE
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJ0ou-0005Ur-9e
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:02:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJ0ou-0005UL-4L
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:02:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EAFCD7AE9E
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 17:02:02 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
	<20170607163635.17635-17-marcandre.lureau@redhat.com>
Date: Thu, 08 Jun 2017 19:01:59 +0200
In-Reply-To: <20170607163635.17635-17-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 7 Jun 2017
	20:36:08 +0400")
Message-ID: <871squ2z20.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 16/43] qdev: wrap default property value
 in an union
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

> Wrap the Property default value (an int64_t) in a union, to prepare
> for the next patch adding a uint64_t.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Split like this, review is easy :)

Reviewed-by: Markus Armbruster <armbru@redhat.com>
