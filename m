Received: from eggs.gnu.org ([2001:4830:134:3::10]:36542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fkqs3-0007Bq-MN
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fkqs0-0005Ng-IB
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:08:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44472 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fkqs0-0005Mm-A6
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:08:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2F7F40216E8
	for <qemu-devel@nongnu.org>; Wed,  1 Aug 2018 13:08:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180801092508.4927-1-marcandre.lureau@redhat.com>
Date: Wed, 01 Aug 2018 15:08:38 +0200
In-Reply-To: <20180801092508.4927-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 1 Aug 2018 11:25:08 +0200")
Message-ID: <87bmam8ca1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ui: use enum to string helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Minor code simplification.

It's also a bit more robust: FOO_str(VAL) checks VAL is in range,
FOO_lookup.array[VAL] doesn't.

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
