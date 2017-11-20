Received: from eggs.gnu.org ([2001:4830:134:3::10]:37175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eGn3b-0003vy-1g
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:28:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eGn3a-0003eC-5W
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:28:19 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1511184421-23535-1-git-send-email-peter.maydell@linaro.org>
	<1511184421-23535-2-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e0b4b129-bc85-ff0e-f967-5d8f261689a8@twiddle.net>
Date: Mon, 20 Nov 2017 15:28:11 +0100
MIME-Version: 1.0
In-Reply-To: <1511184421-23535-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 1/2] exec.c: Factor out
 before/after actions for notdirty memory writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stuart Monteith <stuart.monteith@linaro.org>

On 11/20/2017 02:27 PM, Peter Maydell wrote:
> The function notdirty_mem_write() has a sequence of actions
> it has to do before and after the actual business of writing
> data to host RAM to ensure that dirty flags are correctly
> updated and we flush any TCG translations for the region.
> We need to do this also in other places that write directly
> to host RAM, most notably the TCG atomic helper functions.
> Pull out the before and after pieces into their own functions.
> 
> We use an API where the prepare function stashes the various
> bits of information about the write into a struct for the
> complete function to use, because in the calls for the atomic
> helpers the place where the complete function will be called
> doesn't have the information to hand.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
