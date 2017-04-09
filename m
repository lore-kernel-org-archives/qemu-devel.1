Received: from eggs.gnu.org ([2001:4830:134:3::10]:37487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cxGCZ-0000KI-7p
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 13:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cxGCY-0005on-FZ
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 13:00:35 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
	<20170408065107.GG27571@umbus>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4b5db053-9cd9-2a3d-dc44-298be538d9dc@twiddle.net>
Date: Sun, 9 Apr 2017 10:00:28 -0700
MIME-Version: 1.0
In-Reply-To: <20170408065107.GG27571@umbus>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, alex.bennee@linaro.org, programmingkidx@gmail.com, bharata@linux.vnet.ibm.com

On 04/07/2017 11:51 PM, David Gibson wrote:
> On Fri, Apr 07, 2017 at 11:37:49AM +0530, Nikunj A Dadhania wrote:
>> The series enables Multi-Threaded TCG on PPC64
>>
>> Patch 01: Use atomic_cmpxchg in store conditional
>>       02: Handle first write to page during atomic operation
>>       03: Generate memory barriers for sync/isync and load/store conditional
>>
>> Patches are based on ppc-for-2.10
>
> Applied to ppc-for-2.10.  Anyone object to that for 2/3, which isn't
> within ppc code?

Please go ahead.  If there was another queue it might have gone in, it would 
probably be tcg-next, and I don't have anything else pending at the moment.


r~
