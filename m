Received: from eggs.gnu.org ([2001:4830:134:3::10]:43924)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dxXYz-0007wC-BF
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dxXYt-0007D7-KS
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:05:09 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:41655 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dxXYt-0007Bx-C6
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:05:03 -0400
References: <1505997152-16980-1-git-send-email-pl@kamp.de>
	<150637280903.26688.16951846700405077637@sif>
From: Peter Lieven <pl@kamp.de>
Message-ID: <7c08ecb4-7139-30b1-2b56-de491e89e31e@kamp.de>
Date: Thu, 28 Sep 2017 14:04:58 +0200
MIME-Version: 1.0
In-Reply-To: <150637280903.26688.16951846700405077637@sif>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH] migration: disable
 auto-converge during bulk block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, qemu-stable@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

Am 25.09.2017 um 22:53 schrieb Michael Roth:
> Quoting Peter Lieven (2017-09-21 07:32:32)
>> auto-converge and block migration currently do not play well together.
>> During block migration the auto-converge logic detects that ram
>> migration makes no progress and thus throttles down the vm until
>> it nearly stalls completely. Avoid this by disabling the throttling
>> logic during the bulk phase of the block migration.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Peter Lieven <pl@kamp.de>
> FYI: this patch has been tagged for stable 2.10.1, but is not yet
> upstream. Patch freeze for 2.10.1 is September 27th.

Hi Michael,

the patch went upstream yesterday.

Peter
