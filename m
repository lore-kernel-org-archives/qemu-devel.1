Received: from eggs.gnu.org ([2001:4830:134:3::10]:56773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cZcyN-0006nR-Ka
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:28:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cZcyJ-0005sI-OD
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:28:15 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:5994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cZcyJ-0005r0-FE
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:28:11 -0500
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51inorwjjx.fsf@maestria.local.igalia.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <136bc6e7-10af-479a-6c29-c783a833cc9a@huawei.com>
Date: Fri, 3 Feb 2017 13:27:25 +0100
MIME-Version: 1.0
In-Reply-To: <w51inorwjjx.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2 v16] throttle: factor out duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org

On 2/3/2017 1:22 PM, Alberto Garcia wrote:
> On Fri 03 Feb 2017 12:57:23 PM CET, Pradeep Jagadeesh wrote:
>> This patch removes the redundant throttle code that was present in
>> block and fsdev device files. Now the common code is moved
>> to a single file.
>>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
>
>> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg04637.html
>
> This line doesn't belong in the commit message.
>

There is one false positive error in the second patch. So Greg asked me 
to put this line after SoB. Just to say that I had a positive review 
comment.

Regards.
Pradeep

> Berto
>
