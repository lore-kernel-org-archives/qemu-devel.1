Received: from eggs.gnu.org ([209.51.188.92]:36308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1rZd-0000Qq-5W
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:52:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1rZX-0003ih-TB
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:52:25 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:35614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h1rZW-0003hq-20
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:52:22 -0500
Date: Thu, 7 Mar 2019 12:52:19 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190307115219.lazszb236ai7w7kr@function>
References: <20190306235850.30110-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA92uBmran70VSGvgd2dj034O5mxELSBfNSjzDg1Q=Ecyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA92uBmran70VSGvgd2dj034O5mxELSBfNSjzDg1Q=Ecyw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/12] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

Peter Maydell, le jeu. 07 mars 2019 11:27:38 +0000, a ecrit:
> Hi; this fails to build on FreeBSD, I'm afraid:
> 
> /var/tmp/qemu-test.Sn5gQz/slirp/src/libslirp.h:29:19: warning: type
> specifier missing, defaults to 'int' [-Wimplicit-int]
> typedef ssize_t (*SlirpReadCb)(void *buf, size_t len, void *opaque);
>                   ^

> I think this is a missing #include of <sys/types.h> which is where
> ssize_t comes from -- on the other OSes it likely gets dragged in
> by default.

That's probably it indeed. I have resubmitted the series with it.

Samuel
