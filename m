Received: from eggs.gnu.org ([2001:4830:134:3::10]:48864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBz5B-0001o9-O9
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 04:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBz56-00026l-Qk
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 04:50:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33312 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fBz56-00025W-Ml
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 04:50:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86ADE722FE
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 08:50:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<20180419150145.24795-5-marcandre.lureau@redhat.com>
Date: Fri, 27 Apr 2018 10:50:06 +0200
In-Reply-To: <20180419150145.24795-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 19 Apr 2018 17:01:44 +0200")
Message-ID: <87lgd9qbi9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 4/5] qobject: modify qobject_ref() to
 return obj
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

> For convenience and clarity, make it possible to call qobject_ref() at
> the time when the reference is associated with a variable, or
> argument, by making qobject_ref() return the same pointer as given.

For me, the text doesn't make clear that you went through all the
callers.  What about inserting "Use that to simplify the callers" here?

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Preferably with a clarified commit message:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
