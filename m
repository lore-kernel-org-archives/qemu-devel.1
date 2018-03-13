Received: from eggs.gnu.org ([2001:4830:134:3::10]:52115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1evngX-000142-1A
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1evngU-0001Ev-E4
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:26:01 -0400
References: <20171128121055.6954-1-den@openvz.org>
	<36e5edb4-f9c9-de14-2134-fd8d0eb102f4@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <331011c4-be57-5166-f5ca-5b25ac200f7e@openvz.org>
Date: Tue, 13 Mar 2018 20:25:48 +0300
MIME-Version: 1.0
In-Reply-To: <36e5edb4-f9c9-de14-2134-fd8d0eb102f4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for 2.11 0/2] QEMU crashes with CD device
 without media
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 03/13/2018 08:18 PM, John Snow wrote:
>
> On 11/28/2017 07:10 AM, Denis V. Lunev wrote:
>> There are 2 cases I have spotted so far:
>> 1) IDE ATAPI read processing. Actually this was reported from field
>> 2) QEMU IO hmp command (found during evaluation of (1))
>>
>> SCSI code checks during access that blk_is_available(). These patches add
>> same checks on different code paths.
>>
>> Pls decide whether these patches should go through sub-system trees or via
>> block tree.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> CC: John Snow <jsnow@redhat.com>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>
>>
> Denis, I was never able to figure this out, but Stefan added a more
> rigorous block-wide fix that should prevent these crashes. If you see
> any anomalies in the ATAPI device again please let me know.
>
> Sorry I wasn't able to help any faster.
ok, no prob. Thank you for a feedback

Den
