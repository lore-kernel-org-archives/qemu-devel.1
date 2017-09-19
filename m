Received: from eggs.gnu.org ([2001:4830:134:3::10]:53910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1duOXx-00025L-Fx
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1duOXw-0001Gt-FM
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:51:05 -0400
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505668548-16616-8-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170918224423.GF27153@umbus>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <67a77fd3-b8a9-6584-694a-fc4679c37102@ilande.co.uk>
Date: Tue, 19 Sep 2017 20:50:49 +0100
MIME-Version: 1.0
In-Reply-To: <20170918224423.GF27153@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 7/8] openpic: add missing timer fields to
 vmstate_openpic_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, benh@kernel.crashing.org

On 18/09/17 23:44, David Gibson wrote:

> So, adding new things to the migration stream always requires some
> thought.  The commit message should contain a rationale for why the
> proposed representation is a good one.  In particular is it one that's
> unlikely to be difficult if the device changes internal details in
> future.  When possible it's best to stick to architected documented
> state of the modelled hardware, though I can see you're probably going
> to need some extras in this case.

Yes, I think that's the case here. Definitely the timer can't be armed
correctly without origin_time, and if qemu_timer_active isn't present
and migration occurs with an active timer then a subsequent call to
openpic_tmr_get_timer() will be incorrect. Does that sound right to you?


ATB,

Mark.
