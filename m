Received: from eggs.gnu.org ([2001:4830:134:3::10]:54526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gUSkS-0006Sl-0C
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gUSkR-0007Qh-AU
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:41:35 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gUSkR-0007Q5-2y
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:41:35 -0500
Received: by mail-wm1-x343.google.com with SMTP id y139so12229429wmc.5
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 00:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20181204131802.16885-1-marcandre.lureau@redhat.com>
	<20181204131802.16885-3-marcandre.lureau@redhat.com>
	<87lg541j7h.fsf@dusky.pond.sub.org>
In-Reply-To: <87lg541j7h.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 5 Dec 2018 12:41:20 +0400
Message-ID: <CAJ+F1CJjpMiC60tQtM5JSagndTHkrgKKE3syFG53h6BsX=W6Hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Dec 5, 2018 at 12:21 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Chardev backends may not handle safely IO events from concurrent
> > threads (they are not thread-safe in general, only the write path is
>
> Suggest "may not handle I/O events from concurrent threads safely".
>
> > since commit > 9005b2a7589540a3733b3abdcfbccfe7746cd1a1). Better to
> > wake up the chardev from the monitor IO thread if it's being used as
> > the chardev context.
> >
> > Unify code paths by using a BH in all cases.
> >
> > Drop the now redundant aio_notify() call.
> >
> > Simplify the condition, based on mon->use_io_thread (only QMP so far).
>
> Suggest
>
>   Clean up control flow not to rely on mon->use_io_thread implying
>   monitor_is_qmp(mon).
>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
>
> Happy to improve the commit message in my tree.
>
> Preferably with commit message improvements:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>


ack, thanks


--=20
Marc-Andr=C3=A9 Lureau
