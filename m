Received: from eggs.gnu.org ([2001:4830:134:3::10]:53331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fo3PJ-0002nr-0c
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fo3PF-0003Hq-RZ
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:08:28 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:43466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fo3PF-0003D4-DF
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:08:25 -0400
Date: Fri, 10 Aug 2018 11:08:21 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180810090821.l6r4vlisx7htbvv3@var.youpi.perso.aquilenet.fr>
References: <20180807114501.12370-1-peter.maydell@linaro.org>
	<20180809111233.GA2619@work-vm>
	<CAFEAcA-+5xFDMuvK2W8v=Ufs2E1K4y9onZY_4x6RMYbHLFpkxA@mail.gmail.com>
	<20180809113204.GB2618@work-vm>
	<20180809215421.hexdewc3igklwvob@var.youpi.perso.aquilenet.fr>
	<CAFEAcA9hquE5jck7=-c6Xd36uDfm7Z_Kw39P1vCkZRqE1M4EDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9hquE5jck7=-c6Xd36uDfm7Z_Kw39P1vCkZRqE1M4EDQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH for-3.0] slirp: Correct size check in
 m_inc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Prasad J Pandit <pjp@fedoraproject.org>, liqsub1 <liqsub1@163.com>

Peter Maydell, le ven. 10 août 2018 10:02:37 +0100, a ecrit:
> (a) you should add a comment describing what 'gapsize'
> is, ie that there may be a gap between the in-use data and the
> start of the allocated buffer, and
> (b) m_inc() should change its variable name to match.

Right, I have done so in my tree.  Do you prefer to have it pushed for
qemu 3.0?

Samuel
