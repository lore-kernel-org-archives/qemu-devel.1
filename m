Received: from eggs.gnu.org ([2001:4830:134:3::10]:40791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvONp-0003K2-4y
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvONl-0000P3-QX
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:57:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39814 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fvONl-0000Og-Ir
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:57:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40D818077102
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 14:57:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
	<20180827222322.26009-5-marcandre.lureau@redhat.com>
Date: Thu, 30 Aug 2018 16:57:10 +0200
In-Reply-To: <20180827222322.26009-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 28 Aug 2018 00:23:17 +0200")
Message-ID: <87sh2vzyux.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/9] char: update the mux hanlders in class
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Instead of handling mux chardev in a special way in
> qemu_chr_fe_set_handlers(), we may use the chr_update_read_handler
> class callback instead.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

In your subject, s/hanlders/handlers/.
