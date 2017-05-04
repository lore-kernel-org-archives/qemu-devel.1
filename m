Received: from eggs.gnu.org ([2001:4830:134:3::10]:48109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d6PoK-0000fs-R7
	for qemu-devel@nongnu.org; Thu, 04 May 2017 19:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d6PoJ-0006d2-RR
	for qemu-devel@nongnu.org; Thu, 04 May 2017 19:05:24 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:39604)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d6PoJ-0006cC-Kt
	for qemu-devel@nongnu.org; Thu, 04 May 2017 19:05:23 -0400
Date: Fri, 5 May 2017 01:05:20 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170504230520.k4hxva2la45cmuze@var.youpi.perso.aquilenet.fr>
References: <20170420204301.154912-1-lepton@google.com>
	<42f99074-9330-c974-e884-f0a62e63c697@redhat.com>
	<20170427132126.lkdi5owqezvlp6o2@var.youpi.perso.aquilenet.fr>
	<CALqoU4xQPynFnXH86z7+kw9fQ-3zFfesScMRYcK885HXMKKK5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALqoU4xQPynFnXH86z7+kw9fQ-3zFfesScMRYcK885HXMKKK5w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] slirp: don't zero ti_i since we
 acccess it later.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lepton <ytht.net@gmail.com>
Cc: Tao Wu <lepton@google.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Hello,

lepton, on mer. 03 mai 2017 11:35:05 -0700, wrote:
> It sounds like a bug that =C2=A0caller set up a
> right src and dst address and without set right ih_x1.

I wouldn't bet on that. ih_x1 is only a filler, the caller can be using
the structure only as a C structure, and it's only here just before the
checksum computation that we really need ih_x1 to be 0.

Samuel
