Received: from eggs.gnu.org ([2001:4830:134:3::10]:53254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d6ckR-0007R5-1L
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d6ckQ-0005CI-58
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:54:15 -0400
Received: from mail-lf0-x235.google.com ([2a00:1450:4010:c07::235]:35171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d6ckP-0005Ba-Td
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:54:14 -0400
Received: by mail-lf0-x235.google.com with SMTP id j1so2958882lfh.2
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 05:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<87mvaszbsu.fsf@dusky.pond.sub.org>
	<CAJ+F1C+MvHoMtaUUWDDmoFJWEXiaK1FxeZ8csqTOEB76WSPDRA@mail.gmail.com>
	<877f1viir6.fsf@dusky.pond.sub.org>
In-Reply-To: <877f1viir6.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 05 May 2017 12:54:01 +0000
Message-ID: <CAJ+F1CKFkp5JMHHwjrNJZNuVSnBT5w-AQMdY62+JZ3PaCyanRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/25] qmp: add async command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, kraxel@redhat.com

On Fri, May 5, 2017 at 4:35 PM Markus Armbruster <armbru@redhat.com> wrote:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> >> One of the most important maintainer duties is saying "no".  It's also
> >> one of the least fun duties.
> >>
> >>
> > It doesn't sound like a "no" :)
>
> Well, it's as close to "no" as you can get in a situation that's going
> to change!  It's a straight "no" for the current situation, and a
> "maybe" for a future situation that will be different in ways we don't
> yet understand.
>
> I'm *not* encouraging you to pursue asynchronous QMP commands.  In fact,
> I never did, at least not knowingly.  It's your decision.  All I offer
> is what I offer to all patch submitters: my best effort at a fair
> hearing.
>

My understanding is that you are mainly against the new client 'async'
capability. We disagree on the added complexity for the client though, as
in my opinion it already exists today in some hidden form. So would you
revisit the conclusion if the client 'async' capability is removed? The
series would still bring internal async capability, fix screendump bug and
do a bit of cleanup.


--=20
Marc-Andr=C3=A9 Lureau
