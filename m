Received: from eggs.gnu.org ([2001:4830:134:3::10]:40201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dcC8L-0007Us-Eq
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dcC8K-0007JM-Kr
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:57:25 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100553345.27487.10049014405920351882.stgit@bahia>
	<20170726035838.GQ8978@umbus.fritz.box>
	<9a4c0fee-68b7-bf36-674a-2868b827f428@amsat.org>
	<20170731123441.488afecf@bahia.lan>
	<20170731125331.GI2652@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5f8b99d0-5db1-ff8e-ed80-7f6575fa34d9@amsat.org>
Date: Mon, 31 Jul 2017 11:57:16 -0300
MIME-Version: 1.0
In-Reply-To: <20170731125331.GI2652@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [for-2.11 PATCH 04/26] spapr_drc: use
 g_strdup_printf() instead of snprintf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

On 07/31/2017 09:53 AM, David Gibson wrote:
> On Mon, Jul 31, 2017 at 12:34:41PM +0200, Greg Kurz wrote:
>> On Mon, 31 Jul 2017 07:11:45 -0300
>> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>>> Hi David,
>>>
>>> On 07/26/2017 12:58 AM, David Gibson wrote:
>>>> On Tue, Jul 25, 2017 at 07:58:53PM +0200, Greg Kurz wrote:
>>>>> Passing a stack allocated buffer of arbitrary length to snprintf()
>>>>> without checking the return value can cause the resultant strings
>>>>> to be silently truncated.
>>>>>
>>>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>>>
>>>> Applied to ppc-for-2.11.
>>>
>>> Isn't it 2.10 material?
>>>
>>
>> Hi Philippe,
>>
>> Well... this patch doesn't fix any bug actually since the stack buffers
>> are large enough. It is more a question of coding style.
>>
>> Something like below would have been more appropriate I guess:
>>
>> "Building strings with g_strdup_printf() is a QEMU common practice."
>>
>> No big deal.
> 
> Exactly.  It's not a bugfix, so it doesn't go into 2.10 - we've passed
> the hard freeze.

Fair enough :)
