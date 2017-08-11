Received: from eggs.gnu.org ([2001:4830:134:3::10]:33430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dg61u-00069S-HX
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dg61r-0004ii-EP
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:14:54 -0400
References: <1502121048-1816-1-git-send-email-frederic.konrad@adacore.com>
	<20170809071315.GN13670@umbus.fritz.box>
From: Alexander Graf <agraf@suse.de>
Message-ID: <d64a5e9f-6d4f-42f0-d771-966fbf3d294e@suse.de>
Date: Fri, 11 Aug 2017 10:14:47 +0100
MIME-Version: 1.0
In-Reply-To: <20170809071315.GN13670@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 0/4] ppc64: add e6500
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, KONRAD Frederic <frederic.konrad@adacore.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org



On 09.08.17 08:13, David Gibson wrote:
> On Mon, Aug 07, 2017 at 05:50:44PM +0200, KONRAD Frederic wrote:
>> Hi,
>>
>> Those are some patches to add basic e6500 support for the moment e5500 with a
>> correct MMU configuration and supported instructions.
>> Some (maybe a lot of) things are missing (ie: the thread support) but it is
>> enough to boot a propietary OS on my side.
>>
>> The first two patches are fixes when using MAV 2.0 MMU.
>> The two last patches introduces the e6500.
>>
>> This can be cloned here:
>> https://github.com/FredKonrad/qemu.git branch e6500
> 
> Looks sane as best as my minimal knowledge of e500 goes.  Applied to
> ppc-for-2.11.  Alex, if you (or anyone with knowledge of this
> platform) has objections, I'll reconsider.

I think it's good enough. We're missing a *lot* of e6500 features, but 
if this is useful to Frederic, I don't see a good reason to hold it back.

Alex
