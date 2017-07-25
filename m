Received: from eggs.gnu.org ([2001:4830:134:3::10]:53491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dZpIP-0007vK-HD
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dZpIM-0002B4-7b
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:10:01 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dZpIL-0002Af-Ud
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:09:58 -0400
Received: by mail-pg0-x243.google.com with SMTP id v190so13229320pgv.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 19:09:57 -0700 (PDT)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-18-git-send-email-clg@kaod.org>
	<64a506b0-9ba0-0fce-9285-534710a492b4@ozlabs.ru>
	<14dc225b-5dd3-a1a4-542b-247495735af1@kaod.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <481a3b52-c063-1dd3-f451-7c272c7bd990@ozlabs.ru>
Date: Tue, 25 Jul 2017 12:09:51 +1000
MIME-Version: 1.0
In-Reply-To: <14dc225b-5dd3-a1a4-542b-247495735af1@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 17/26] ppc/xive: add hcalls
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 25/07/17 00:55, Cédric Le Goater wrote:
> On 07/24/2017 11:39 AM, Alexey Kardashevskiy wrote:
>> On 06/07/17 03:13, Cédric Le Goater wrote:
>>> A set of Hypervisor's call are used to configure the interrupt sources
>>> and the event/notification queues of the guest:
>>>
>>>    H_INT_GET_SOURCE_INFO
>>>    H_INT_SET_SOURCE_CONFIG
>>>    H_INT_GET_SOURCE_CONFIG
>>>    H_INT_GET_QUEUE_INFO
>>>    H_INT_SET_QUEUE_CONFIG
>>>    H_INT_GET_QUEUE_CONFIG
>>>    H_INT_RESET
>>>    H_INT_ESB
>>>
>>> Calls that still need to be addressed :
>>>
>>>    H_INT_SET_OS_REPORTING_LINE
>>>    H_INT_GET_OS_REPORTING_LINE
>>>    H_INT_SYNC
>>>
>>> See below for the documentation on each hcall.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> ---

[...]

>>
>> R6 is missing but you added it in your github tree so never mind :)
>>
> 
> Yes. I have updated the hcalls in my github tree with some fixes and 
> also some small recent changes in the specs.


This was rather a note for other reviewers if they read the specs and find
mismatches (18/26 is also updated), really :)


-- 
Alexey
