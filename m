Received: from eggs.gnu.org ([2001:4830:134:3::10]:58404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1dFmlW-0002Z1-4F
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1dFmlS-0002Ih-6H
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:25:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:51302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1dFmlR-0002Fs-SQ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:25:10 -0400
References: <20170311175019.GA7195@ls3530.fritz.box>
	<b4ca5292-bee3-1e3b-13ba-7dd6c1f00f8a@twiddle.net>
	<20170519135905.GA19553@kos.to>
From: Helge Deller <deller@gmx.de>
Message-ID: <b9c75e27-1694-5aae-7eb7-30074e6c8b4b@gmx.de>
Date: Tue, 30 May 2017 21:24:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170519135905.GA19553@kos.to>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix TARGET_MAP* and
 TARGET_F_??LCK for hppa arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On 19.05.2017 15:59, Riku Voipio wrote:
> On Sun, Mar 12, 2017 at 08:17:46AM +1000, Richard Henderson wrote:
>> On 03/12/2017 03:50 AM, Helge Deller wrote:
>>> TARGET_MAP_TYPE needs to be 0x03 instead of 0x0f on the hppa
>>> architecture, otherwise it conflicts with MAP_FIXED which is 0x04.
>>>
>>> Add missing TARGET_MAP_STACK and TARGET_MAP_HUGETLB values.
>>>
>>> Fix TARGET_F_RDLCK, TARGET_F_WRLCK and TARGET_F_UNLCK.
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> I applied the MAP_FIXED and TARGET_F_* parts separately in my tree.  I'd
>> like to see what others think about the other MAP_* defines before including
>> that.
> 
> What's the current state of these patches? Are these patches still waiting for
> opinions?

It would be nice to get them included (if it hasn't happened yet).

Helge
