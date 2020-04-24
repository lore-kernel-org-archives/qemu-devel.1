Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFB7C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 04:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9F420767
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 04:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="EUKn+ZxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9F420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRq63-0007n8-Vk
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 00:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dereksu@qnap.com>) id 1jRq5E-0007Cb-Ph
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 00:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dereksu@qnap.com>) id 1jRq5A-0003Ir-2e
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 00:37:00 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1jRq59-00035s-CQ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 00:36:55 -0400
Received: by mail-pl1-x642.google.com with SMTP id c21so2472776plz.4
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 21:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=P5JH0nNweQJ74BRnj82CAT20MQ5UJYwf+BQqHFLRzDU=;
 b=EUKn+ZxKbDVnU8U4ow8VnrBNidFE8O2/HURTyd3/KU8dpIgwfZ7I/GKKpXMrRMv1iJ
 iiaWuvFjlLb7qDcv8tarFabSfGXeAOVw3tM4hKzvliJKVfIGCJxp09cJ5bCX9K05ZXJY
 NC08iZSyTpwIOPYj5vMliRGzqsLxiwmTSTzbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P5JH0nNweQJ74BRnj82CAT20MQ5UJYwf+BQqHFLRzDU=;
 b=SQxPgJFsr6+G/lggZjEPGoywRSK/asalfXzgYCbQbaBoS4K0GivXF5jgi1LrXEzTLL
 PNORdCRlVTQv43UmyVUmzZjptTazI3rIa+AvkQoTp/d0kVrI/FKWXl2BVRfj5PyosMYx
 ifOYuk1eJNNshz2T+k0t9e38nCu7PP3fcoJznGCM2HC2oiXM1Pd12IaZivw3J8Q5UHIj
 vhzuHczqzeGSdQMy5AsB9TOntyvEJiWY3T7hvHNd6Cko+7g7SUTQmSENgHHCSOZ4lfBU
 6Eig1rnWWORTyKSUwnsruXgvA9NY89P3Cky8c4TrQqjwmGAZqhIE5TMIBpSmGywr1IZ4
 JS7Q==
X-Gm-Message-State: AGi0Puaj53mX/Z1/lAhWqAD0+uwlauB6QfFF2DXVDX1XSG6wsSWnlkcn
 G7oRnriP2BweHrG/n9rHxn5vMA==
X-Google-Smtp-Source: APiQypIcUnY/aZgn4px4BIQ1Y7STxktQuAAIH8VcigE3P7PBkcdkS7CxZDCctmM5fHlogKKXswPRVQ==
X-Received: by 2002:a17:90a:d703:: with SMTP id
 y3mr4604915pju.75.1587703013051; 
 Thu, 23 Apr 2020 21:36:53 -0700 (PDT)
Received: from Jing-Weide-MacBook-Pro-3.local
 (202-39-79-13.HINET-IP.hinet.net. [202.39.79.13])
 by smtp.gmail.com with ESMTPSA id o40sm3937041pjb.18.2020.04.23.21.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 21:36:52 -0700 (PDT)
From: Derek Su <dereksu@qnap.com>
Subject: Re: [PATCH 1/3] net/colo-compare.c: Create event_bh with the right
 AioContext
To: "Zhang, Chen" <chen.zhang@intel.com>, Lukas Straub <lukasstraub2@web.de>
References: <cover.1586370737.git.lukasstraub2@web.de>
 <b86f80bb47ac66b73b2afe80218c9913722c606a.1586370737.git.lukasstraub2@web.de>
 <5ab3bd6649a44354b087c31bb9fcd5a4@intel.com> <20200422104325.64659930@luklap>
 <0a075de2dc2f4e8c919478762e9a97da@intel.com> <20200422114020.3d479899@luklap>
 <8d0e2a591f1d48baa84d79e7a0f1cbb6@intel.com>
Message-ID: <b1c85547-1a7b-b5a8-739b-e19eceffce45@qnap.com>
Date: Fri, 24 Apr 2020 12:36:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8d0e2a591f1d48baa84d79e7a0f1cbb6@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=dereksu@qnap.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::642
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/4/23 下午3:29, Zhang, Chen wrote:
> 
> 
>> -----Original Message-----
>> From: Lukas Straub <lukasstraub2@web.de>
>> Sent: Wednesday, April 22, 2020 5:40 PM
>> To: Zhang, Chen <chen.zhang@intel.com>
>> Cc: qemu-devel <qemu-devel@nongnu.org>; Li Zhijian
>> <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
>> André Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
>> <pbonzini@redhat.com>
>> Subject: Re: [PATCH 1/3] net/colo-compare.c: Create event_bh with the right
>> AioContext
>>
>> On Wed, 22 Apr 2020 09:03:00 +0000
>> "Zhang, Chen" <chen.zhang@intel.com> wrote:
>>
>>>> -----Original Message-----
>>>> From: Lukas Straub <lukasstraub2@web.de>
>>>> Sent: Wednesday, April 22, 2020 4:43 PM
>>>> To: Zhang, Chen <chen.zhang@intel.com>
>>>> Cc: qemu-devel <qemu-devel@nongnu.org>; Li Zhijian
>>>> <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
>>>> André Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
>>>> <pbonzini@redhat.com>
>>>> Subject: Re: [PATCH 1/3] net/colo-compare.c: Create event_bh with
>>>> the right AioContext
>>>>
>>>> On Wed, 22 Apr 2020 08:29:39 +0000
>>>> "Zhang, Chen" <chen.zhang@intel.com> wrote:
>>>>
>>>>>> -----Original Message-----
>>>>>> From: Lukas Straub <lukasstraub2@web.de>
>>>>>> Sent: Thursday, April 9, 2020 2:34 AM
>>>>>> To: qemu-devel <qemu-devel@nongnu.org>
>>>>>> Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
>>>>>> <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>;
>>>>>> Marc- André Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
>>>>>> <pbonzini@redhat.com>
>>>>>> Subject: [PATCH 1/3] net/colo-compare.c: Create event_bh with
>>>>>> the right AioContext
>>>>>>
>>>>>> qemu_bh_new will set the bh to be executed in the main loop.
>>>>>> This causes problems as colo_compare_handle_event assumes that
>>>>>> it has exclusive access the queues, which are also accessed in
>>>>>> the iothread. It also assumes that it runs in a different thread
>>>>>> than the caller and takes the appropriate locks.
>>>>>>
>>>>>> Create the bh with the AioContext of the iothread to fulfill
>>>>>> these assumptions.
>>>>>>
>>>>>
>>>>> Looks good for me, I assume it will increase performance. Do you
>>>>> have
>>>> related data?
>>>>
>>>> No, this fixes several crashes because the queues where accessed
>>>> concurrently from multiple threads. Sorry for my bad wording.
>>>
>>> Can you describe some details about the crash? Step by step?
>>> Maybe I can re-produce and test it for this patch.
>>
>> There is no clear test case. For me the crashes happened after 1-20h of
>> runtime with lots of checkpoints (800ms) and some network traffic. The
>> coredump always showed that two threads where doing operations on the
>> queues simultaneously.
>> Unfortunately, I don't have the coredumps anymore.
> 
> OK, Although I have not encountered the problem you described.
> I have test this patch, looks running fine.
> 
> Reviewed-by: Zhang Chen <chen.zhang@intel.com>
> 
> Thanks
> Zhang Chen


Hi,

I encountered PVM crash caused by the race condition issue in v4.2.0.
Here is the coredump for reference.

```
warning: core file may not match specified executable file.
  Core was generated by `qemu-system-x86_64 -name source -enable-kvm 
-cpu core2duo -m 1024 -global kvm-a'.
  Program terminated with signal SIGSEGV, Segmentation fault.
  #0 0x000055cb478bcd25 in qemu_hexdump (buf=0x0, fp=0x7f6e9122b680 
<IO_2_1_stderr>, prefix=0x55cb47a388f5 "colo-compare spkt", size=1514) 
at util/hexdump.c:34
  34 fprintf(fp, " %02x", (unsigned char)buf[b + i]);
  [Current thread is 1 (Thread 0x7f6da1ade700 (LWP 6119))]
  (gdb) where
  #0 0x000055cb478bcd25 in qemu_hexdump (buf=0x0, fp=0x7f6e9122b680 
<IO_2_1_stderr>, prefix=0x55cb47a388f5 "colo-compare spkt", size=1514) 
at util/hexdump.c:34
  #1 0x000055cb476fa1b5 in colo_compare_tcp (s=0x55cb496429f0, 
conn=0x7f6e78003e30) at net/colo-compare.c:462
  #2 0x000055cb476fa8c1 in colo_compare_connection 
(opaque=0x7f6e78003e30, user_data=0x55cb496429f0) at net/colo-compare.c:687
  #3 0x000055cb476fb4ab in compare_pri_rs_finalize 
(pri_rs=0x55cb49642b18) at net/colo-compare.c:1001
  #4 0x000055cb476eb46f in net_fill_rstate (rs=0x55cb49642b18, 
buf=0x7f6da1add2c8 "", size=1064) at net/net.c:1764
  #5 0x000055cb476faafa in compare_pri_chr_in (opaque=0x55cb496429f0, 
buf=0x7f6da1adc6f0 "`E˧V\210RT", size=4096) at net/colo-compare.c:776
  #6 0x000055cb47815363 in qemu_chr_be_write_impl (s=0x55cb48c87ec0, 
buf=0x7f6da1adc6f0 "`E˧V\210RT", len=4096) at chardev/char.c:177
  #7 0x000055cb478153c7 in qemu_chr_be_write (s=0x55cb48c87ec0, 
buf=0x7f6da1adc6f0 "`E˧V\210RT", len=4096) at chardev/char.c:189
  #8 0x000055cb4781e002 in tcp_chr_read (chan=0x55cb48ef7690, 
cond=G_IO_IN, opaque=0x55cb48c87ec0) at chardev/char-socket.c:525
  #9 0x000055cb47839655 in qio_channel_fd_source_dispatch 
(source=0x7f6e78002050, callback=0x55cb4781de53 <tcp_chr_read>, 
user_data=0x55cb48c87ec0) at io/channel-watch.c:84
  #10 0x00007f6e950e1285 in g_main_context_dispatch () at 
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
  #11 0x00007f6e950e1650 in () at /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
  #12 0x00007f6e950e1962 in g_main_loop_run () at 
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
  #13 0x000055cb474920ae in iothread_run (opaque=0x55cb48c67f10) at 
iothread.c:82
  #14 0x000055cb478a699d in qemu_thread_start (args=0x55cb498035d0) at 
util/qemu-thread-posix.c:519
  #15 0x00007f6e912376db in start_thread (arg=0x7f6da1ade700) at 
pthread_create.c:463
  #16 0x00007f6e90f6088f in clone () at 
../sysdeps/unix/sysv/linux/x86_64/clone.S:95
  (gdb)
```

COLO works well after applying this patch in my tests.

Reviewed-by: Derek Su <dereksu@qnap.com>
Tested-by: Derek Su <dereksu@qnap.com>

Regards,
Derek




> 
>>
>> Regards,
>> Lukas Straub
>>
>>> Thanks
>>> Zhang Chen
>>>
>>>>
>>>> Regards,
>>>> Lukas Straub
>>>>
>>>>> Thanks
>>>>> Zhang Chen
>>>>>
>>>>>> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
>>>>>> ---
>>>>>>   net/colo-compare.c | 3 ++-
>>>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/net/colo-compare.c b/net/colo-compare.c index
>>>>>> 10c0239f9d..1de4220fe2 100644
>>>>>> --- a/net/colo-compare.c
>>>>>> +++ b/net/colo-compare.c
>>>>>> @@ -890,6 +890,7 @@ static void colo_compare_handle_event(void
>>>>>> *opaque)
>>>>>>
>>>>>>   static void colo_compare_iothread(CompareState *s)  {
>>>>>> +    AioContext *ctx = iothread_get_aio_context(s->iothread);
>>>>>>       object_ref(OBJECT(s->iothread));
>>>>>>       s->worker_context =
>>>>>> iothread_get_g_main_context(s->iothread);
>>>>>>
>>>>>> @@ -906,7 +907,7 @@ static void
>>>>>> colo_compare_iothread(CompareState
>>>> *s)
>>>>>>       }
>>>>>>
>>>>>>       colo_compare_timer_init(s);
>>>>>> -    s->event_bh = qemu_bh_new(colo_compare_handle_event, s);
>>>>>> +    s->event_bh = aio_bh_new(ctx, colo_compare_handle_event,
>>>>>> + s);
>>>>>>   }
>>>>>>
>>>>>>   static char *compare_get_pri_indev(Object *obj, Error **errp)
>>>>>> --
>>>>>> 2.20.1
>>>>>
>>>
> 


