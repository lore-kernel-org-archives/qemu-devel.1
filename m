Received: from eggs.gnu.org ([209.51.188.92]:59691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gkRxZ-0001cz-9i
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gkRxY-0005EQ-MN
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:05:13 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:37187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gkRxY-0005CM-EC
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:05:12 -0500
Received: by mail-wr1-x435.google.com with SMTP id s12so14548163wrt.4
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 03:05:12 -0800 (PST)
MIME-Version: 1.0
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
	<20190117114359.5164-2-marcandre.lureau@redhat.com>
	<20190117230415.jmxjox3breoqj3g3@function>
In-Reply-To: <20190117230415.jmxjox3breoqj3g3@function>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 18 Jan 2019 15:04:59 +0400
Message-ID: <CAJ+F1CK3t51L+Qga3R+G1HSS-2jJAV8DYO2PVA5PC8Ebt+qCLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/27] slirp: generalize guestfwd with a
 callback based approach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, QEMU <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Fri, Jan 18, 2019 at 3:07 AM Samuel Thibault <samuel.thibault@gnu.org> w=
rote:
>
> Marc-Andr=C3=A9 Lureau, le jeu. 17 janv. 2019 15:43:33 +0400, a ecrit:
> >          /* XXX this blocks entire thread. Rewrite to use
> >           * qemu_chr_fe_write and background I/O callbacks */
>
> Seeing this, I guess a whole pass will be useful to turn these qemu
> comment references into something that does not require knowledge of
> qemu internals :)

Sure, we will have to do some doc/comments update. I can look at it.
That's not a blocker imho.

thanks


--=20
Marc-Andr=C3=A9 Lureau
