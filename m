Received: from eggs.gnu.org ([2001:4830:134:3::10]:38942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fazzL-0004Hq-Qv
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fazzI-0003u0-G1
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:51:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40868 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fazzI-0003qx-7z
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:51:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4208F406E81E
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 08:51:39 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180704084507.14560-1-peterx@redhat.com>
	<20180704084507.14560-5-peterx@redhat.com>
Date: Thu, 05 Jul 2018 10:51:33 +0200
In-Reply-To: <20180704084507.14560-5-peterx@redhat.com> (Peter Xu's message of
	"Wed, 4 Jul 2018 16:45:02 +0800")
Message-ID: <87woua9iay.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/9] monitor: move need_resume flag into
 monitor struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> It was put into the request object to show whether we'll need to resume
> the monitor after dispatching the command.  Now we move that into the
> monitor struct so that it might be even used in other places in the
> future, e.g., out-of-band message flow controls.
>
> One thing to mention is that there is no lock needed before when
> accessing the flag since the request object will always be owned by a
> single thread.  After we move it into monitor struct we need to protect
> that flag since it might be accessed by multiple threads now.  Renaming
> the qmp_queue_lock into qmp_lock to protect the flag as well.
>
> No functional change.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Marc-Andr=C3=A9's "[PATCH v3 04/38] monitor: no need to save need_resume" a=
nd
"[PATCH v3 05/38] monitor: further simplify previous patch" also mess
with need_resume.  Marc-Andr=C3=A9, could you have a look at this patch and
the next one?
