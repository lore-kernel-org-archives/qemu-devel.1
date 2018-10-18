Received: from eggs.gnu.org ([2001:4830:134:3::10]:50109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gD6zS-0001xC-E2
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gD6zM-0003Q7-RN
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:01:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gD6zM-0003MV-K0
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:01:16 -0400
Date: Thu, 18 Oct 2018 17:31:07 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <e8f2f7c5-936f-9949-a6b3-55988482cab3@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1810181727570.18164@xnncv>
References: <20181017205848.2525-1-ppandit@redhat.com>
	<e8f2f7c5-936f-9949-a6b3-55988482cab3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] bt: use size_t type for length parameters
 instead of signed int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Arash TC <tohidi.arash@gmail.com>, Philippe Mathieu Daude <pmathieu@redhat.com>

+-- On Thu, 18 Oct 2018, Paolo Bonzini wrote --+
| So you have to first find out all places where something is subtracted
| from the length, and ensure it's okay or add assertions.
| 
| Then you have to check a much more important issue: places that use a 
| fixed-size buffer such as vhci_host_send should range check len first, again 
| with an assertion if needed.

  Okay. There are routines which range check 'len', checking others.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
