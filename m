Received: from eggs.gnu.org ([2001:4830:134:3::10]:50634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d0dgX-0005kK-NK
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 20:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d0dgS-0000YC-Qu
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 20:41:29 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3440
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d0dgS-0000X6-6H
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 20:41:24 -0400
References: <1492141282-28708-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1167061760.27389486.1492164610590.JavaMail.zimbra@redhat.com>
	<be3b415e-9f51-e2e1-a06e-6d44cdc3baa3@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58F6B1FF.6010302@huawei.com>
Date: Wed, 19 Apr 2017 08:40:31 +0800
MIME-Version: 1.0
In-Reply-To: <be3b415e-9f51-e2e1-a06e-6d44cdc3baa3@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] char: Fix removing wrong GSource that be
 found by fd_in_tag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: xuquan8@huawei.com, pbonzini@redhat.com, qemu-devel@nongnu.org, zhangchen fnst <zhangchen.fnst@cn.fujitsu.com>

On 2017/4/18 21:36, Eric Blake wrote:
> On 04/14/2017 05:10 AM, Marc-André Lureau wrote:
>> Hi
>>
>> ----- Original Message -----
>>> We use fd_in_tag to find a GSource, fd_in_tag is return value of
>>> g_source_attach(GSource *source, GMainContext *context), the return
>>> value is unique only in the same context, so we may get the same
>>> values with different 'context' parameters.
>>>
>>> It is no problem to find the right fd_in_tag by using
>>>   g_main_context_find_source_by_id(GMainContext *context, guint source_id)
>>> while there is only one default main context.
>>>
>>> But colo-compare tries to create/use its own context, and if we pass wrong
>>> 'context' parameter with right fd_in_tag, we will find a wrong GSource
>>> to handle. We tied to fix the related codes in commit b43dec, but it didn't
>> tied->tried
>>
>> Please use a bit longer commit sha1, or full sha1, it will likely conflict otherwise in the future.
> 6 chars is indeed short, 7 is git's default as usually long enough,
> although I've encountered collisions that require 8 chars.  [And google
> has proved that you can have a collision across the entire hash,

Thanks for your explanation.  I didn't notice that before,
I have been always using the 6 chars hash to get the commit ...

> although that is harder to generate.] I generally use 8 or so when
> writing commit messages.  Fortunately, even if a collision is introduces
> later, someone that is motivated enough can still resolve the collision
> by filtering out any collisions that resolve to non-commits, and among
> the remaining colliding SHA1 focus on the one that has a commit date
> which predates the message with the reference.

Agreed, but I'd better to update the comment to make it clearer. thanks.
