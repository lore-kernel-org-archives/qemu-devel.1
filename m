Received: from eggs.gnu.org ([2001:4830:134:3::10]:60186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cVgmD-0004F9-M7
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:43:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cVgmA-0001iK-IG
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:43:25 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:5844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cVgmA-0001i8-AD
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:43:22 -0500
References: <1485163195-17547-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<f72e7a6d-72eb-5ac0-d63d-a0fb0bf773fa@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <7e5d6f22-9d24-f2de-6873-241d71757966@huawei.com>
Date: Mon, 23 Jan 2017 16:43:11 +0100
MIME-Version: 1.0
In-Reply-To: <f72e7a6d-72eb-5ac0-d63d-a0fb0bf773fa@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V1] throttle:Removed duplicate throtlle
 code from block and 9p files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

On 1/23/2017 4:19 PM, Eric Blake wrote:
> On 01/23/2017 03:19 AM, Pradeep Jagadeesh wrote:
>
> s/throtlle/throttle/ in the subject line (as is, the subject is rather
> long, and missing a space after ':')
>
Thanks for reviewing the code. I fixed the subject and shortened it.

-Pradeep

>> This will allow other subsystems (i.e. fsdev) to implement throttling
>> without duplicating the command line options.
>>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>> ---
>
