Received: from eggs.gnu.org ([2001:4830:134:3::10]:57744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gWoQR-0005BN-1g
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:14:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gWoQN-0006Oo-Su
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:14:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gWoQN-0006OP-N8
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 15:14:35 -0500
Date: Wed, 12 Dec 2018 01:44:30 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20181211172244.GD2923@lap1>
Message-ID: <nycvar.YSQ.7.76.1812120137210.7578@xnncv>
References: <20181211132642.3027-1-ppandit@redhat.com>
	<20181211132642.3027-5-ppandit@redhat.com>
	<20181211164742.GA2923@lap1> <20181211172244.GD2923@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 4/5] pvrdma: release ring object in case of
 an error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>

  Hello Yuval,

+-- On Tue, 11 Dec 2018, Yuval Shaia wrote --+
| > Ditto, here send rind and recv rings stays mapped.
| > Look at how QP's ring is destroyed in destroy_qp.
| > 
| > For both case suggesting to define a new static function that destroy rings
| > and call it from both error flow of create_* and from destroy_*
| > 

I see, okay.

Similar resource clean-up required in pvrdma_realize(). In case of an error it 
does: 'goto out;', but nothing is free'd there.

Is another destroy_ routine required there?
 
| Also, can you rebase this patch on top of the patchset i posted last week:
| https://patchwork.kernel.org/patch/10705439/

Okay, I'll send revised patch set. Thanks so much for the prompt review.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
