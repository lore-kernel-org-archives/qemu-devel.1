Received: from eggs.gnu.org ([2001:4830:134:3::10]:43292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnkiW-0004pb-6F
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnkiS-00056Q-4q
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:06:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnkiR-00056C-Ux
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:06:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C9DFC0587D4
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:06:26 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
Date: Fri, 01 Sep 2017 14:06:21 +0200
In-Reply-To: <20170825105913.4060-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 25 Aug 2017 12:58:59 +0200")
Message-ID: <87ziae62te.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/14] Generate a literal qobject for
 introspection
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

> Hi,
>
> This series is based on patches 2-5 from "[PATCH v2 00/54] qapi: add #if
> pre-processor conditions to generated code". Generating a literal qobject
> will allow to easily introduce #if conditionals from the original series.
>
> v2:
> - use QLIST_FOREACH_ENTRY for list comparison
> - update qdict comparison to check for the size instead of doing a
>   qdict copy
> - commit message update
> - add r-b tags
>
> Marc-Andr=C3=A9 Lureau (14):
>   qdict: add qdict_put_null() helper
>   qlit: move qlit from check-qjson to qobject/
>   qlit: use QLit prefix consistently
>   qlit: remove compound literals
>   qlit: rename compare_litqobj_to_qobj() to qlit_equal_qobject()
>   qlit: make qlit_equal_qobject return a bool
>   qlit: make qlit_equal_qobject() take const arguments
>   qlit: add QLIT_QNULL and QLIT_BOOL
>   qlit: Replace open-coded qnum_get_int() by call
>   tests: add qlit tests
>   qlit: improve QLit dict vs qdict comparison
>   qlit: improve QLit list vs qlist comparison
>   qlit: add qobject_form_qlit()
>   qapi: generate a literal qobject for introspection

PATCH 14 makes sense only together with work mentioned in its commit
message.  Without PATCH 14, PATCH 13 is left without a user.
Fortunately, PATCH 01-12 make sense on their own: applied to qapi-next.
PATCH 13-14 applied to qapi-not-next, to give you a suitable base for
respins of the remainder of "qapi: add #if pre-processor conditions to
generated code".
