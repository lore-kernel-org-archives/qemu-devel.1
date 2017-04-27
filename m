Received: from eggs.gnu.org ([2001:4830:134:3::10]:58609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3k5H-0006ag-5s
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3k5C-0005Mb-Tz
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:07:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1493298053-17140-1-git-send-email-armbru@redhat.com>
	<b7a05120-f94d-a99b-aab2-6208715d47ff@cn.fujitsu.com>
Date: Thu, 27 Apr 2017 16:07:43 +0200
In-Reply-To: <b7a05120-f94d-a99b-aab2-6208715d47ff@cn.fujitsu.com> (Zhang
	Chen's message of "Thu, 27 Apr 2017 21:30:53 +0800")
Message-ID: <87zif20wr4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] replication: Make --disable-replication
 compile again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, wencongyang@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, zhang.zhanghailiang@huawei.com, qemu-stable@nongnu.org

Zhang Chen <zhangchen.fnst@cn.fujitsu.com> writes:

> On 04/27/2017 09:00 PM, Markus Armbruster wrote:
>> Broken in commit daa33c5.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> About this bug I remember have discussed with paolo.
>
> https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg01326.html

If I understand that discussion correctly, it's about replacing
--enable-replication (and possibly other stuff) by --enable-colo.
Sounds fair to me, patches welcome.

> And about this patch content.
>
> Reviewed-by:Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Thanks!
