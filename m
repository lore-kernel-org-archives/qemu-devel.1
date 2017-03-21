Received: from eggs.gnu.org ([2001:4830:134:3::10]:35633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cqA7P-0007RL-Gy
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cqA7M-0001yP-Bo
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:05:55 -0400
Received: from [59.151.112.132] (port=39600 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cqA7L-0001pC-E7
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:05:52 -0400
References: <1490064541056-474448.post@n7.nabble.com>
	<d866690e-fa74-147b-93d1-df60348df653@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <8b24aeea-a32e-6aac-8898-9b8c1b13748b@cn.fujitsu.com>
Date: Tue, 21 Mar 2017 11:04:54 +0800
MIME-Version: 1.0
In-Reply-To: <d866690e-fa74-147b-93d1-df60348df653@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Subject: [PATCH]COLO: Fix spell error in Colo doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, wangguang <wang.guang55@zte.com.cn>, qemu-devel@nongnu.org
Cc: zhangchen.fnst@cn.fujitsu.com

Hi~~ Wang.

This is a doc typo, but I found we forgot to update command in this doc,
Recently COLO use this command:
{'execute': 'nbd-server-add', 'arguments': {'device': 'colo-disk0', 
'writable': true } }

You can see it in http://wiki.qemu-project.org/Features/COLO.
So I think this patch is not necessary, I will update new command in 
docs/COLO-FT.txt later.

Please next time use scripts/get_maintainer.pl to cc related maintainers.

Thanks
Zhang Chen


On 03/21/2017 11:01 AM, Eric Blake wrote:
> On 03/20/2017 09:49 PM, wangguang wrote:
>> This is an error in COLO-FT.txt.
>> secondeary-disk0 should be secondary-disk0.
>>
>> Signed-off-by: Guang Wang <wang.guang55@zte.com.cn>
> This is now version 6 of a patch, but failed to include that information
> in the subject line.  'git send-email -v6' would do that automatically
> for you.
>
>> ---
> I already gave a positive review on v4, and repeated that on v5.  If you
> are going to continue sending revisions to the list (rather than relying
> on a maintainer to fix things up), then please remember to add
> Reviewed-by tags from earlier revisions if you didn't change any code,
> or else to include a changelog highlighting your code changes.
>
> Other advice on sending a good patch can be seen at:
> http://wiki.qemu-project.org/Contribute/SubmitAPatch
>

-- 
Thanks
Zhang Chen
