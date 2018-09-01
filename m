Received: from eggs.gnu.org ([2001:4830:134:3::10]:49993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fw3pT-0008GM-Kb
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 07:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fw3cw-0001l7-OI
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 06:59:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50818 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fw3cw-0001kp-JL
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 06:59:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 244B540241EA
	for <qemu-devel@nongnu.org>; Sat,  1 Sep 2018 10:59:38 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
	<20180829134043.31706-11-marcandre.lureau@redhat.com>
Date: Sat, 01 Sep 2018 12:59:32 +0200
In-Reply-To: <20180829134043.31706-11-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 29 Aug 2018
	15:40:43 +0200")
Message-ID: <87o9dhiiuj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 10/10] qmp: common 'id' handling & make
 QGA conform to QMP spec
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

> Let qmp_dispatch() copy the 'id' field. That way any qmp client will
> conform to the specification, including QGA. Furthermore, it
> simplifies the work for qemu monitor.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  monitor.c           | 33 ++++++++++++---------------------
>  qapi/qmp-dispatch.c | 10 ++++++++--
>  tests/test-qga.c    | 13 +++++--------
>  3 files changed, 25 insertions(+), 31 deletions(-)

Let's squash in

diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
index 8f7da0245d..5fdfb2a4d0 100644
--- a/docs/interop/qmp-spec.txt
+++ b/docs/interop/qmp-spec.txt
@@ -109,6 +109,7 @@ or
   command execution, it is optional and will be part of the response
   if provided.  The "id" member can be any json-value.  A json-number
   incremented for each successive command works fine.
+- Older versions of the QEMU Guest agent do not support "id".
=20
 2.3.1 Out-of-band execution
 ---------------------------
