Received: from eggs.gnu.org ([2001:4830:134:3::10]:51599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1d43gC-0001Jy-Aw
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 07:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1d43g9-0000rb-5Y
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 07:03:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1d43g8-0000r1-VW
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 07:03:13 -0400
Date: Fri, 28 Apr 2017 16:33:05 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <5e640542-7e44-dac9-85af-e11f893dbd75@redhat.com>
Message-ID: <alpine.LFD.2.20.1704281632350.1071@wniryva>
References: <20170424120634.12268-1-ppandit@redhat.com>
	<alpine.LFD.2.20.1704281403310.29240@wniryva>
	<5e640542-7e44-dac9-85af-e11f893dbd75@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] scsi: avoid an off-by-one error in
 megasas_mmio_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, YY Z <bigbird475958471@gmail.com>

+-- On Fri, 28 Apr 2017, Paolo Bonzini wrote --+
| > |          /* Magic sequence to start ADP reset */
| > | -        if (adp_reset_seq[s->adp_reset] == val) {
| > | -            s->adp_reset++;
| > | +        if (adp_reset_seq[s->adp_reset++] == val) {
| > | +            if (s->adp_reset == 6) {
| > | +                s->adp_reset = 0;
| > | +                s->diag = MFI_DIAG_WRITE_ENABLE;
| > | +            }
| > |          } else {
| > |              s->adp_reset = 0;
| > |              s->diag = 0;
| > |          }
| > | -        if (s->adp_reset == 6) {
| > | -            s->diag = MFI_DIAG_WRITE_ENABLE;
| > | -        }
| > |          break;
| 
| I've already queued this patch.

Oh, okay. Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
