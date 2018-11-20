Received: from eggs.gnu.org ([2001:4830:134:3::10]:60379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP6lj-000707-Ex
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP6lh-0001Wu-RM
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:12:47 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:37924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP6lh-0001WV-NO
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:12:45 -0500
Received: by mail-oi1-x22a.google.com with SMTP id a77so1582024oii.5
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 06:12:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181120134908.8439-2-ehabkost@redhat.com>
References: <20181120134908.8439-1-ehabkost@redhat.com>
	<20181120134908.8439-2-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 14:12:24 +0000
Message-ID: <CAFEAcA9DbV8RR9uqp9nba7xc+VXwRqbcDHqbcmqJZFLMse2xGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 1/1] hw/i386: add pc-i440fx-3.1 & pc-q35-3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 20 November 2018 at 13:49, Eduardo Habkost <ehabkost@redhat.com> wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> We have a couple of PC_COMPAT_3_0, so we should have 3.1 PC machines,
> and update the 3.0 machines to make use of those.

As a side note, we should have 3.1 machines regardless.
Every versioned machine should have a new -x.y type
every version of QEMU. (We should also try to remember
to do this at the start of the release cycle rather than
the end :-))

thanks
-- PMM
