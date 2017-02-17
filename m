Received: from eggs.gnu.org ([2001:4830:134:3::10]:38769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceoHe-0005oB-Qj
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:33:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceoHa-0007hv-SX
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:33:34 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1486636445-24109-6-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170210001035.GJ27610@umbus.fritz.box>
	<87k28yekze.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170214024331.GD2169@umbus.fritz.box>
	<87o9y5eale.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<2094c8e6-2b99-9c09-7eb2-c013dd07ec1e@twiddle.net>
	<87efyy7mex.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<1d8317b8-208f-db66-0222-bf1beaaa965e@twiddle.net>
	<87y3x51l00.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a89cd2f6-9d58-7ae4-9111-7069852f1337@twiddle.net>
Date: Sat, 18 Feb 2017 06:33:22 +1100
MIME-Version: 1.0
In-Reply-To: <87y3x51l00.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] target-ppc: support for 32-bit carry
 and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: bharata@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 02/17/2017 03:47 PM, Nikunj A Dadhania wrote:
>> Why do you want to extract these bits?
>
> Convinient to copy that to XER later.

Ideally you make the most common operation cheapest, and the more rare 
operation more expensive.  That said, I suppose even using ADDO is rare in the 
first place.  So it probably doesn't much matter.


r~
