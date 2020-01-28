Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1651CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E173B214D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E173B214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwULl-0006sk-3W
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iwUL4-0006MX-H2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:07:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iwUL3-0003pq-Ba
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:07:46 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:39253)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iwUL3-0003oZ-2R
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:07:45 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MC2k1-1irE5L0PeP-00CPhf; Tue, 28 Jan 2020 18:07:34 +0100
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200117192808.129398-1-jkz@google.com>
 <20200117192808.129398-2-jkz@google.com>
 <295472c5-4378-4ae1-1e9f-854b15075cf6@vivier.eu> <871rrjfrok.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 1/4] linux-user: Use `qemu_log' for non-strace logging
Message-ID: <1aeb55ef-3563-9b97-7f15-59cd8408bd2a@vivier.eu>
Date: Tue, 28 Jan 2020 18:07:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <871rrjfrok.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t1+Gua8NRtFM/jOkIcWZSsplueMx7xIHPlud+gHQo0CzGqS5qjC
 cICG7PjbVw4vbleGi2kcv6ZE/oAoKRJx0iJe2zP51IF6WOMdJvMqEDbTnzpEdhjY7QXt+go
 4GPiK+NCLBSr5YOGO7GuVfenIsPDvaaqsnk8DxL9scRzbbjvozRkk3PfNnypLeW1q2v9Vmi
 UsBAZ+A1gt6W8HnhQa4jg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4PTYNAQms+U=:kyEOnxxYwR9S0VP4aXB74N
 fZSt/fFEyBN1OGFJfkq4Idm5Y1YmxBOo16KV3fokO3s4Sq1DRVSW3BpgYp3UNfx8ckBEwZVXN
 YLl3u4hBsGEbnF8L3+uZsmnqYVidnq8RASiI1GDb6e/S6DVRUuBx5Kj9VK0be6quCYah97Dqm
 0vxlf6aa6z3jUyhyY5l41utlI8fqcBEtRa+q6FuiyIZTo+vjNRn7kOLRkRWy8L8OLWD0paDkm
 hStLkjWAf+cIRCjT0eoCWe9AGZB9cCVOFqxbvlfIXYKNhiZKvcf2lOscbLFOtSj+mGemWL3DN
 jAO7qV+ycBbM0M9BTAcTb6OqquRE5r9IXZAp1CUPkBxwEYHzDa+VI7ryef4YS7poqa8OHouc5
 NQr/3Cy8vNM/sLw4OX9dOKaSYhJCgMWRwrmVgtJ51JuPE3RFrfvDK11vhCvuqBBsNZlr8YJKD
 oXILZ7/xskF3zSsEuAwLVx3i9emGgP3Rt6lamAIRiS6DZ9dGDn85g0NU766DQQ52MM0JGPTAR
 LJ/nzJXwEv2HU9VJBzyA4qpt3JEhPuCz1ZvBakkwwbwz9TrXQoDWSzrtj5j1L3UpEnP7638AZ
 oHkj3Pi+avHfSrihh78WY27HRk106E4bx1NVH4nltoFjLDyxeoCdaI0zFNyraublfQHpMjB07
 0RHV3ishYokMAqgBUGw614Lgy8kk5sNT3aJEYmZQaGrb6bGE2AnSB/X0YCiKsewqW/ZDMJncX
 doj0JNt7j0ZsG79+nl2spJcpjywLelYQuGRt87+RQmkjDfZHzLE3+0BwcUh3AYGMki64WXe3Z
 8q+XhH1aEU154fii0pnF6AQOqepqMOctwsCK5wPx6FV4HCVrvVvzOHgOBQ81Yqx7XzTAVFO
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: Josh Kunz <jkz@google.com>, riku.voipio@iki.fi, qemu-devel@nongnu.org,
 imp@bsdimp.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 28/01/2020 à 17:53, Alex Bennée a écrit :
> 
> Laurent Vivier <laurent@vivier.eu> writes:
> 
>> Le 17/01/2020 à 20:28, Josh Kunz a écrit :
>>> Since most calls to `gemu_log` are actually logging unimplemented features,
>>> this change replaces most non-strace calls to `gemu_log` with calls to
>>> `qemu_log_mask(LOG_UNIMP, ...)`.  This allows the user to easily log to
>>> a file, and to mask out these log messages if they desire.
>>>
>>> Note: This change is slightly backwards incompatible, since now these
>>> "unimplemented" log messages will not be logged by default.
>>
>> This is a good incompatibility as these messages were unexpected by  the
>> tools catching stderr. They don't happen on "real" systems.
>>
>> ...
>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>> index 249e4b95fc..629f3a21b5 100644
>>> --- a/linux-user/syscall.c
>>> +++ b/linux-user/syscall.c
>>> @@ -1545,20 +1545,18 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
>>>              - sizeof(struct target_cmsghdr);
>>>  
>>>          space += CMSG_SPACE(len);
>>> -        if (space > msgh->msg_controllen) {
>>> -            space -= CMSG_SPACE(len);
>>> -            /* This is a QEMU bug, since we allocated the payload
>>> -             * area ourselves (unlike overflow in host-to-target
>>> -             * conversion, which is just the guest giving us a buffer
>>> -             * that's too small). It can't happen for the payload types
>>> -             * we currently support; if it becomes an issue in future
>>> -             * we would need to improve our allocation strategy to
>>> -             * something more intelligent than "twice the size of the
>>> -             * target buffer we're reading from".
>>> -             */
>>> -            gemu_log("Host cmsg overflow\n");
>>> -            break;
>>> -        }
>>> +
>>> +        /*
>>> +         * This is a QEMU bug, since we allocated the payload
>>> +         * area ourselves (unlike overflow in host-to-target
>>> +         * conversion, which is just the guest giving us a buffer
>>> +         * that's too small). It can't happen for the payload types
>>> +         * we currently support; if it becomes an issue in future
>>> +         * we would need to improve our allocation strategy to
>>> +         * something more intelligent than "twice the size of the
>>> +         * target buffer we're reading from".
>>> +         */
>>> +        assert(space > msgh->msg_controllen && "Host cmsg overflow");

Should it be in fact :

  assert(space <= msgh->msg_controllen && "Host cmsg overflow");

>>>          if (tswap32(target_cmsg->cmsg_level) == TARGET_SOL_SOCKET) {
>>>              cmsg->cmsg_level = SOL_SOCKET;
>>
>> Could you move this to a separate patch: you are not using qemu_log()
>> here and I'm not convinced that crashing is better than ignoring the
>> remaining part of the buffer.
> 
> I suggested it should be an assert in the first place. It certainly
> makes sense to keep it in a separate patch though. I guess you could
> argue for:
> 
>   qemu_log_mask(LOG_UNIMP, "%s: unhandled message size");
> 
> but is it really better to partially work and continue? It seems like
> you would get more subtle hidden bugs.

ok, you're right. crash seems to be a better solution.

So, we only need to move this change to a separate patch.

Thanks,
Laurent


