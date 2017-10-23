Received: from eggs.gnu.org ([2001:4830:134:3::10]:42961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6ZL2-0001Dm-IM
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6ZL0-0006sl-Sc
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:48:03 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:50858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e6ZL0-0006sX-LX
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:48:02 -0400
Received: by mail-wr0-x231.google.com with SMTP id p96so2795712wrb.7
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 02:48:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADHp1NxzGr_ijvGrUbmZf0NuUv+JwJZeA=8h4tZNn++SBA1yUw@mail.gmail.com>
References: <CADHp1NwU=HowMfgBGtcwnY25v_fL6qZ2gd469a2oZY+QQi2uFw@mail.gmail.com>
	<20171019205409.GA4170@flamenco>
	<545610a4882f4c5494b30b7eab66b984@EXCHCS32.ornl.gov>
	<CADHp1NxzGr_ijvGrUbmZf0NuUv+JwJZeA=8h4tZNn++SBA1yUw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Oct 2017 10:47:41 +0100
Message-ID: <CAFEAcA-d_g2f20R18sJHwXU_NM4xtNM=n5HL2BF8G4YEzeghnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Running Qemu in discrete time/step by step
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matt <mattator@gmail.com>
Cc: "Nutaro, James J." <nutarojj@ornl.gov>, "Emilio G. Cota" <cota@braap.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Hajime Tazaki <tazaki@wide.ad.jp>

On 23 October 2017 at 10:38, Matt <mattator@gmail.com> wrote:
> I did not know about Qemu's record/replay mode which is an interesting
> feature but unneeded if a  2nd qemu run with the same inputs generated
> the same outputs (as it's the case with DCE).

Depends what you're trying to do. Deterministic execution is
a prerequisite for record-and-replay, and sometimes determinism
is all you need, but record-and-replay can provide more than that.

thanks
-- PMM
