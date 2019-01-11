Received: from eggs.gnu.org ([209.51.188.92]:58616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ghuuP-0003Nd-UW
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ghuuP-0001aV-B6
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:23:29 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ghuuN-0001YK-98
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:23:29 -0500
Received: by mail-wr1-x442.google.com with SMTP id t27so14773508wra.6
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 03:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20190111081909.11896-1-ppandit@redhat.com>
	<CAJ+F1C+VM8KCw3uqphK3PrJ386jABmHDJLe0dySg6T1RVMuZiw@mail.gmail.com>
	<nycvar.YSQ.7.76.1901111444171.11857@xnncv>
In-Reply-To: <nycvar.YSQ.7.76.1901111444171.11857@xnncv>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 11 Jan 2019 15:23:06 +0400
Message-ID: <CAJ+F1CLWzB7TGGstPZOVekfQ=pEbeu52mZU3FMnnhr2uUydrrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: check data length while emulating
 ident function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, Kira <864786842@qq.com>

Hi

On Fri, Jan 11, 2019 at 1:18 PM P J P <ppandit@redhat.com> wrote:
>
> +-- On Fri, 11 Jan 2019, Marc-Andr=C3=A9 Lureau wrote --+
> | > +            if (m->m_len > so_rcv->sb_datalen
> | > +                            - (so_rcv->sb_wptr - so_rcv->sb_data)) {
> | > +                m_free(m);
> | > +                return 0;
> | > +            }
> |
> | Check looks correct, it should probably return 1.
>
> Function comment says return 1 if 'm' is valid and should be appended via
> sbappend(). Not sure if unprocessed 'm' should go to sbappend().

If you look at the rest of the function, many similar error cases return 1.

> | Is there a reproducer?
>
> Yes, I have one.

Ok, could you add it to the commit message ? :)

>
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F



--=20
Marc-Andr=C3=A9 Lureau
