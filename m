Received: from eggs.gnu.org ([2001:4830:134:3::10]:47453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUSQy-0001s0-Fb
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUSMv-0004yb-Ks
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:17:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20783)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUSMv-0004xm-Cd
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:17:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41B0881129
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 08:17:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181204131802.16885-1-marcandre.lureau@redhat.com>
	<20181204131802.16885-3-marcandre.lureau@redhat.com>
Date: Wed, 05 Dec 2018 09:17:06 +0100
In-Reply-To: <20181204131802.16885-3-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 4 Dec 2018 17:17:58 +0400")
Message-ID: <87lg541j7h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/6] monitor: accept chardev input from
 iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Chardev backends may not handle safely IO events from concurrent
> threads (they are not thread-safe in general, only the write path is

Suggest "may not handle I/O events from concurrent threads safely".

> since commit > 9005b2a7589540a3733b3abdcfbccfe7746cd1a1). Better to
> wake up the chardev from the monitor IO thread if it's being used as
> the chardev context.
>
> Unify code paths by using a BH in all cases.
>
> Drop the now redundant aio_notify() call.
>
> Simplify the condition, based on mon->use_io_thread (only QMP so far).

Suggest

  Clean up control flow not to rely on mon->use_io_thread implying
  monitor_is_qmp(mon).

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Happy to improve the commit message in my tree.

Preferably with commit message improvements:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
