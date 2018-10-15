Received: from eggs.gnu.org ([2001:4830:134:3::10]:47384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gBydm-0001Vy-DF
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gBydg-0001cv-SE
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:54:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gBydg-0001ZE-BS
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:54:12 -0400
References: <cover.1539528213.git.artem.k.pisarenko@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6d5c6b1e-c52b-815c-6579-1992d4a963b0@redhat.com>
Date: Mon, 15 Oct 2018 10:54:05 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1539528213.git.artem.k.pisarenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] Introduce attributes for timers
 subsystem and remove QEMU_CLOCK_VIRTUAL_EXT clock type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>, qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On 14/10/2018 16:55, Artem Pisarenko wrote:
> 
> Current implementation of timers/clock processing is confusing (at
> least for me) because of exceptions from design concept behind them,
> introduced by icount mode (which adds QEMU_CLOCK_VIRTUAL_RT). Adding
> QEMU_CLOCK_VIRTUAL_EXT just made things even more complicated. I
> consider these "alternative" virtual clocks to be some kind of hacks
> being convinient only to authors of relevant qemu features. Lets
> don't touch fundamental clock types and keep them orthogonal to
> special cases of timers handling.

VIRTUAL_RT is clear I believe, and it's used even beyond record/replay.
 However, I agree that VIRTUAL_EXT is messy and I like this series a lot.

Paolo
