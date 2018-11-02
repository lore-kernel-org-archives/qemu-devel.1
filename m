Received: from eggs.gnu.org ([2001:4830:134:3::10]:32857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gIW98-0006es-Ms
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gIW95-0005WD-BE
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:53:42 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1gIW93-0005Up-AK
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:53:38 -0400
Received: by mail-wr1-x442.google.com with SMTP id z16-v6so1353801wrv.2
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 02:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <1536163920-2443-1-git-send-email-zhangckid@gmail.com>
	<CAK3tnvK6T8fxdAmtFuB9o7Gc8oyFYuDEsCn_mv-+V7uyf3cQFw@mail.gmail.com>
In-Reply-To: <CAK3tnvK6T8fxdAmtFuB9o7Gc8oyFYuDEsCn_mv-+V7uyf3cQFw@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 2 Nov 2018 17:53:22 +0800
Message-ID: <CAK3tnvKtrcMSyYZS_U61XNqq7dKX3bwYkyzY9fGBLQA2p2qrXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] docs/block-replication.txt: Add more
 detail about replication_do_checkpoint_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Hi All,

Maybe we have forgot this patch? Ping again.

Related discussion:
https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03352.html

Thanks
Zhang Chen

On Fri, Sep 14, 2018 at 2:32 PM Zhang Chen <zhangckid@gmail.com> wrote:

> Hi All,
>
> No news update?
> Ping...
>
> Thanks
> Zhang Chen
>
> On Thu, Sep 6, 2018 at 12:12 AM Zhang Chen <zhangckid@gmail.com> wrote:
>
>> Add more detail description for COLO checkpoint use case.
>> Suggested by Dr. David Alan Gilbert <dgilbert@redhat.com>
>>
>> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> ---
>>  docs/block-replication.txt | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/block-replication.txt b/docs/block-replication.txt
>> index 6bde6737fb..b6c5e94764 100644
>> --- a/docs/block-replication.txt
>> +++ b/docs/block-replication.txt
>> @@ -131,9 +131,10 @@ a. replication_start_all()
>>     thread.
>>  b. replication_do_checkpoint_all()
>>     This interface is called after all VM state is transferred to
>> -   Secondary QEMU. The Disk buffer will be dropped in this interface.
>> -   The caller must hold the I/O mutex lock if it is in
>> migration/checkpoint
>> -   thread.
>> +   secondary node, and in primary node this interface no need to
>> +   called after synchronizing all the states. The Disk buffer will be
>> dropped
>> +   in this interface. The caller must hold the I/O mutex lock if it is
>> +   in migration/checkpoint thread.
>>  c. replication_get_error_all()
>>     This interface is called to check if error happened in replication.
>>     The caller must hold the I/O mutex lock if it is in
>> migration/checkpoint
>> --
>> 2.17.GIT
>>
>>
