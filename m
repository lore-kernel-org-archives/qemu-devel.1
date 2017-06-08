Received: from eggs.gnu.org ([2001:4830:134:3::10]:37224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dIs0c-00029R-5M
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dIs0b-0002DP-6r
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:37:34 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dIs0a-0002D6-VL
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:37:33 -0400
Received: by mail-lf0-x243.google.com with SMTP id v20so2463978lfa.2
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 00:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
	<20170607074632.13162-3-marcandre.lureau@redhat.com>
	<9bf29800-aecc-aeca-44d2-7a208fcc602f@redhat.com>
In-Reply-To: <9bf29800-aecc-aeca-44d2-7a208fcc602f@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 08 Jun 2017 07:37:20 +0000
Message-ID: <CAJ+F1CLSPp7=af+tB84m18LwUOVuKHst_qdsLgZ3uqAZU+64TA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] coccinelle: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org

Hi

On Thu, Jun 8, 2017 at 1:50 AM Eric Blake <eblake@redhat.com> wrote:

> On 06/07/2017 02:46 AM, Marc-Andr=C3=A9 Lureau wrote:
> > The coccinelle/round.cocci script doesn't catch hard coded values.
> >
> > I used the following script over qemu code base:
> >
> > (
> > - ((e1) + 3) / (4)
> > + DIV_ROUND_UP(e1,4)
>
> As in 1/5, can't you also write a search for ((e1) + (e2) - 1) / e2, to
> cover non-constant divisions?
>

That one is covered by scripts/coccinelle/round.cocci

I can merge my script there, but I would need to spend some time to clean
it up (help welcome).

--=20
Marc-Andr=C3=A9 Lureau
