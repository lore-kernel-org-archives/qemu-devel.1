Received: from eggs.gnu.org ([2001:4830:134:3::10]:32802)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1duJh9-0006uE-QZ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1duJh5-0004I9-L6
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:40:15 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:46112 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1duJh5-0004GU-CW
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:40:11 -0400
References: <6cc4a99c-0212-6b7b-4a12-3e898215bea9@kamp.de>
	<20170919143829.GH2107@work-vm>
From: Peter Lieven <pl@kamp.de>
Message-ID: <48cdd8ff-4940-9aa1-9aba-1acf8ce74ebe@kamp.de>
Date: Tue, 19 Sep 2017 16:40:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170919143829.GH2107@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Block Migration and CPU throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu block <qemu-block@nongnu.org>, jjherne@linux.vnet.ibm.com

Am 19.09.2017 um 16:38 schrieb Dr. David Alan Gilbert:
> * Peter Lieven (pl@kamp.de) wrote:
>> Hi,
>>
>> I just noticed that CPU throttling and Block Migration don't work together very well.
>> During block migration the throttling heuristic detects that we obviously make no progress
>> in ram transfer. But the reason is the running block migration and not a too high dirty pages rate.
>>
>> The result is that any VM is throttled by 99% during block migration.
> Hmm that's unfortunate; do you have a bandwidth set lower than your
> actual network connection? I'm just wondering if it's actually going
> between the block and RAM iterative sections or getting stuck in ne.

It happens also if source and dest are on the same machine and speed is set to 100G.

Peter
