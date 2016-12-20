Received: from eggs.gnu.org ([2001:4830:134:3::10]:49551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1cJ8VB-0006p6-I5
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 19:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1cJ8VA-0001MF-Px
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 19:41:57 -0500
References: <1482187106-85065-1-git-send-email-sochin.jiang@huawei.com>
	<59e42380-f605-2a93-c4bc-17cec914fcfe@redhat.com>
From: "sochin.jiang" <sochin.jiang@huawei.com>
Message-ID: <e5b78a60-f388-1194-d03c-eb299c3a7768@huawei.com>
Date: Tue, 20 Dec 2016 08:41:14 +0800
MIME-Version: 1.0
In-Reply-To: <59e42380-f605-2a93-c4bc-17cec914fcfe@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] mirror: prevent 'top' mode mirroring when
 no backing file specified on the destination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Cc: xieyingtai@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, eric.fangyi@huawei.com, qemu-devel@nongnu.org, wangjie88@huawei.com

 Well, that makes sense, I lose my consideration, thanks.




Sochin Jiang

On 2016/12/19 23:31, Eric Blake wrote:
> On 12/19/2016 04:38 PM, sochin jiang wrote:
>>  Mirroring using 'top' mode without backing file specified on the target can be success,
>>  but end with a disaster.
>>
>>  For example:
>>    Migration can be success in this situation while the virtual machine on the destination
>>  is no longer usable because of backing lost.
>>
> 
> I think this is a premature policy decision.  Even though the user can
> abuse it to lose data, I think there is still enough technical reason
> for why a user might have a valid use case for doing this (perhaps for
> creating incremental backups, where the user plans on re-chaining data
> back together using 'qemu-img rebase -u'), so I don't think we should
> forbid it at the qemu level.
> 
