Received: from eggs.gnu.org ([2001:4830:134:3::10]:34501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cEAkW-0000BE-Vf
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:05:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cEAkS-000670-1e
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:05:16 -0500
Received: from [59.151.112.132] (port=65086 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cEAkR-00065n-K5
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:05:11 -0500
References: <a503e0f2-79ad-b8c5-9418-ac0502514581@cn.fujitsu.com>
	<20161205115339.GG22443@stefanha-x1.localdomain>
	<4b6c0772-f03c-1d30-0036-c37a97d83daf@redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <fe2c4831-eb54-eee4-1c7f-b575b319078c@cn.fujitsu.com>
Date: Tue, 6 Dec 2016 16:05:06 +0800
MIME-Version: 1.0
In-Reply-To: <4b6c0772-f03c-1d30-0036-c37a97d83daf@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] a suggestion to extend the query block stats
 commands for multi-disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: danpb@redhat.com, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, stefanha@redhat.com, armbru@redhat.com

Hi Paolo,Stefan,

At 12/05/2016 07:57 PM, Paolo Bonzini wrote:
>
>
> On 05/12/2016 12:53, Stefan Hajnoczi wrote:
>> Adding the BlockBackend *query_blk parameter is a reasonable short-term
>> workaround.  I wonder if the polling stats APIs need to be rethought in
>> the longer term.
>>
>> Regarding the low-level details of block statistics inside QEMU, we can
>> probably collect statistics without requiring the AioContext lock.  This
>> means guest I/O processing does not need to be interrupted.  There
>> should be some RCU-style scheme that can be used to extract the stats.
>
> The question is also what level of consistency you want.  Perhaps as
> long as you can access it atomically (so no tearing of values) you don't
> need a lock at all, blk_ref/unref is enough.

Yes, that is what I want to express. When I use the command frequently,
I may want to sacrifice consistency, in exchange for performance.


Thanks,

   Liyang.
