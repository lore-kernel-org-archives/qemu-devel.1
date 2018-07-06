Received: from eggs.gnu.org ([2001:4830:134:3::10]:36085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fbJng-0003N0-1G
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fbJnc-00047l-Vx
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:01:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39572 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fbJnc-00046D-RV
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:00:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 10B5572647
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 06:00:56 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180705164201.9853-1-marcandre.lureau@redhat.com>
Date: Fri, 06 Jul 2018 08:00:54 +0200
In-Reply-To: <20180705164201.9853-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 5 Jul 2018 18:42:01 +0200")
Message-ID: <871scg52eh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: fix double-free of request error
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

> qmp_error_response() will free the given error. Fix double-free in
> later qmp_request_free().
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Broken in commit 1cc37471525 by yours truly.  I'll add that to the
commit message when I apply.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
