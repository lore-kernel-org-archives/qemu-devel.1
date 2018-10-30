Received: from eggs.gnu.org ([2001:4830:134:3::10]:53284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gHQQT-0000vd-Mz
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gHQQN-0004Gh-QK
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:35:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gHQQN-0004GM-KV
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:34:59 -0400
Date: Tue, 30 Oct 2018 15:04:50 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <fb59b1b6-f273-4df5-4b05-60e6d54e80ac@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1810301503260.30516@xnncv>
References: <20181030062842.9792-1-ppandit@redhat.com>
	<fb59b1b6-f273-4df5-4b05-60e6d54e80ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2] lsi53c895a: check message length value
 is valid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Ameya More <ameya.more@oracle.com>

+-- On Tue, 30 Oct 2018, Paolo Bonzini wrote --+
| 
| Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
| 
| with one change below:
| 
| > +        if ((s->sstat1 & PHASE_MASK) == PHASE_MI) {
| > +            assert(s->msg_len >= 0);
| 
| should be > 0 as well.

Sent patch v3. Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
