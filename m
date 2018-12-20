Received: from eggs.gnu.org ([2001:4830:134:3::10]:33339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZxaE-00020f-Vo
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:37:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZxaB-0001rm-0l
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:37:46 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:57794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZxaA-0001qr-M8
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:37:42 -0500
Date: Thu, 20 Dec 2018 13:37:40 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181220123739.s3t5trh3pymhrxzl@function>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA89ZxboWWDn3iDh_8u-ejMKjhWmmA_ckLMH7si+yU_icw@mail.gmail.com>
	<CAJ+F1CKhFNo9UGuuvcV0ErFoQmHSCxO6jUfo6et3vT9wD4e21A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKhFNo9UGuuvcV0ErFoQmHSCxO6jUfo6et3vT9wD4e21A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/64] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Marc-André Lureau, le jeu. 20 déc. 2018 16:01:44 +0400, a ecrit:
> > declaration of 'inet_pton' [-Werror=nested-externs]
> >      if (!inet_pton(AF_INET6, vprefix6, &ip6_prefix)) {
> >      ^
> >
> 
> This one is easy, it needs "build-sys: require Vista API by default
> globally" series that Paolo has been sending in his last pullreqs.

Ok, let's wait for it for that part then.

> there is an obvious
> mistake in "build-sys: use a seperate slirp-obj-y && slirp.mo" (Sam,
> you should squash that fix)

Ok, squashed in my tree.

Samuel
