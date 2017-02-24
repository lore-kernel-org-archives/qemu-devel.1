Received: from eggs.gnu.org ([2001:4830:134:3::10]:43964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ch9Oo-0007Nv-BE
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ch9Ok-0008W5-Bs
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:30:38 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<913ec2bb-2fd4-3488-e142-75d3574dfaf1@twiddle.net>
	<87a89dtnox.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<98b51c07-f7b2-ddb3-7b59-336d109d005b@twiddle.net>
	<20170223225358.GD17615@umbus.fritz.box>
	<CALAZu3_3TkjFbLUAraQRgG5Ytm0a08QLzQSdYLKF5EYPD-imxA@mail.gmail.com>
	<20170224045026.GV17615@umbus.fritz.box>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e589819d-ab5e-3c45-0ed8-5783e23ea5d9@twiddle.net>
Date: Fri, 24 Feb 2017 17:30:23 +1100
MIME-Version: 1.0
In-Reply-To: <20170224045026.GV17615@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 03/10] target/ppc: support
 for 32-bit carry and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Nikunj Dadhania <nikunj.dadhania@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

On 02/24/2017 03:50 PM, David Gibson wrote:
> Although I guess they'd shrink right down again if we put an
> env->xer_mask in.  Thoughts on that option Richard?

Why would xer_mask shrink the code?  I can't see that we'd be able to eliminate 
any code using the mask.


r~
