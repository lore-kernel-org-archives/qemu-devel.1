Received: from eggs.gnu.org ([2001:4830:134:3::10]:33333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eMQEj-00007s-Gk
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eMQEe-0001QD-C1
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 22:19:05 -0500
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
	<20171120032420.9134-3-mdavidsaver@gmail.com>
	<20171122033643.GH2380@umbus.fritz.box>
	<20171206031228.GR3057@umbus.fritz.box>
From: Michael Davidsaver <mdavidsaver@gmail.com>
Message-ID: <19583e28-9078-3f88-d5e6-49ad0c7ef937@gmail.com>
Date: Tue, 5 Dec 2017 22:18:56 -0500
MIME-Version: 1.0
In-Reply-To: <20171206031228.GR3057@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/12] e500: consolidate mpc8540 guts with
 e500-ccsr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 12/05/2017 10:12 PM, David Gibson wrote:
> On Wed, Nov 22, 2017 at 02:36:43PM +1100, David Gibson wrote:
>> On Sun, Nov 19, 2017 at 09:24:10PM -0600, Michael Davidsaver wrote:
>>> Preparation for adding more MPCxxxx control
>>> registers.
>>>
>>> Use e500 SVR to enable part specific registers.
>>> Only the mpc8544 reset register at present.
>>>
>>> Expose CCSR as SysBusDevice region to eliminate
>>> e500-ccsr.h.
>>>
>>> Track CCSR base address within device, and map on reset,
>>> in preparation for CCSRBAR.
>>>
>>> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
>>
>> Applied to ppc-for-2.12.
> 
> Sorry.  I've now pulled this from ppc-for-2.12, because it caused a
> breakage of make check (specifically the boot-serial-test with ppc64).

Oops, I'll begin running this test myself.  So far I've only been running
tests for i386, amd64, arm, and ppc.
