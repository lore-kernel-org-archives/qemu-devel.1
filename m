Received: from eggs.gnu.org ([209.51.188.92]:59238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gkRvQ-0000Tr-3l
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:03:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gkRvP-0002vv-D2
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:03:00 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gkRvP-0002ur-6W
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:02:59 -0500
Received: by mail-wr1-x442.google.com with SMTP id r10so14479019wrs.10
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 03:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
	<20190117230853.lbuqljd5srd6wcpu@function>
In-Reply-To: <20190117230853.lbuqljd5srd6wcpu@function>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 18 Jan 2019 15:02:46 +0400
Message-ID: <CAJ+F1CKOT8Ph=F3btQFWA=d_KU7iC3_+dk0b5mNAGUJ3XkucFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/27] slirp: make it again a standalone
 project (part 2)
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

On Fri, Jan 18, 2019 at 3:09 AM Samuel Thibault <samuel.thibault@gnu.org> w=
rote:
>
> Also thinking about it: I guess we'd want to make the usage of libslirp
> optional, at least because (I guess) at some points the future libslirp

There is already --disable-slirp. My upcoming patches for external
libslirp honor that too.

> may want to change the API (nobody can do something perfect at first
> try), and when that breaks qemu build it would nasty if people couldn't
> just disable libslirp usage to get qemu built for needs which don't
> require slirp.

Certainly, however we will be careful to keep a stable API/ABI and
have library deprecation policies.

Major API/ABI break / rewrite could also use a different soname.

>
> Also some people would really like to see the dreaded slirp stack off
> their qemu binaries :)
>

Fortunately, that's already possible with --disable-slirp.

--=20
Marc-Andr=C3=A9 Lureau
