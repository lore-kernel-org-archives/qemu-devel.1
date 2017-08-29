Received: from eggs.gnu.org ([2001:4830:134:3::10]:56364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dmitZ-0001wN-FP
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dmitV-0005ad-Jz
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:57:41 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:36302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1dmitV-0005Zk-9F
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:57:37 -0400
Date: Tue, 29 Aug 2017 17:57:35 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170829155735.3prsi4ig5omdxudw@var.youpi.perso.aquilenet.fr>
References: <20170827230506.12683-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA8LYZ28FFmb=HLvoBbx=w60OjBAKFogGScxV1bL8bee-Q@mail.gmail.com>
	<20170829092226.4zxhyfgagkyrj2go@var.youpi.perso.aquilenet.fr>
	<CAFEAcA_a9+U_otb6AhB=hQvRR1tPF=KQy4y77x8ZP4Mbf+nkMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_a9+U_otb6AhB=hQvRR1tPF=KQy4y77x8ZP4Mbf+nkMQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/1] slirp updates
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

Peter Maydell, on mar. 29 août 2017 16:31:03 +0100, wrote:
> On 29 August 2017 at 10:22, Samuel Thibault <samuel.thibault@gnu.org> wrote:
> > Peter Maydell, on mar. 29 août 2017 10:20:31 +0100, wrote:
> >> On 28 August 2017 at 00:05, Samuel Thibault
> >> <samuel.thibault@ens-lyon.org> wrote:
> >> > warning: redirection vers https://people.debian.org/~sthibault/qemu.git/
> >> > The following changes since commit 04d74e07b4542aad5aa4ad03951b38b767f5314a:
> >> >
> >> >   slirp: fix clearing ifq_so from pending packets (2017-08-26 01:04:12 +0200)
> >> >
> >> > are available in the git repository at:
> >> >
> >> >   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
> >> >
> >> > for you to fetch changes up to 04d74e07b4542aad5aa4ad03951b38b767f5314a:
> >> >
> >> >   slirp: fix clearing ifq_so from pending packets (2017-08-26 01:04:12 +0200)
> >> >
> >> > ----------------------------------------------------------------
> >> > slirp updates
> >> >
> >> > ----------------------------------------------------------------
> >>
> >> Is this pull request intended to be for 2.10 (in which
> >> case it needs justification) or for 2.11 (in which case
> >> it's a bit early) ?
> >
> > It is for 2.10. It fixes at least a DOS: userland can at least crash
> > qemu with specially-crafted packets.
> 
> It's really really hard to justify putting this in now.

Alright, it's up to the release managers to decide anyway.

Samuel
