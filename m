Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25FDC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 07:40:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D12206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 07:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="Sd/72Zpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D12206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=comstyle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvc2D-0004Ke-Ms
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 03:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>)
 id 1jvc1a-0003i5-Ej; Wed, 15 Jul 2020 03:40:18 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]:10281
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>)
 id 1jvc1Y-0000v1-T0; Wed, 15 Jul 2020 03:40:18 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4B68Sr0X6sz8PbJ;
 Wed, 15 Jul 2020 03:41:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=comstyle.com; h=subject:to
 :references:from:message-id:date:mime-version:in-reply-to
 :content-type:content-transfer-encoding; s=default; bh=C/m/CD2EZ
 Eyto99h8bZ4OJyBPvo=; b=Sd/72ZppfhwrQyRy0aKqw27ZlDGz/aXJAzxzbBeID
 3uJcgE6nUTrU6q4RLX20huweVHbK9fq4cMgiFjeLDCS66094J1SIzfh6sYzf2c0j
 beW6Wc3uilAp+Ha7hclr1nrVmyY0WbORAzDXJQlTHsiZNT/FiL6czI6apt9soC6i
 g4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=subject:to
 :references:from:message-id:date:mime-version:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=SrQ
 y5Un+Q9srL5I4edU5i6YzZVzmAEPKK+xymOxzacSYUH3/paf+vYWpSAWqQ8h2PWx
 XYMxsmjWdAtqEI9zHSgkQqgAst255ra+0n7aXwTD/sD2qaBmvIfIU46jcCW//e9P
 RHFE7F7dkqSkTPtgYxaXJgcr+yAWTPp5ciKhodUg=
Received: from [192.168.6.32]
 (toroon2719w-lp140-03-142-112-151-177.dsl.bell.ca [142.112.151.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4B68Sq6ZRSz8Pb7;
 Wed, 15 Jul 2020 03:40:59 -0400 (EDT)
Subject: Re: [PATCH] util: qemu_get_thread_id for OpenBSD
To: Thomas Huth <thuth@redhat.com>, David CARLIER <devnexen@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>
References: <CA+XhMqxD6gQDBaj8tX0CMEj3si7qYKsM8u1km47e_-U7MC37Pg@mail.gmail.com>
 <631dad16-66cd-3f7b-90bc-969c52d29aa1@redhat.com>
From: Brad Smith <brad@comstyle.com>
Message-ID: <51a660f2-2241-d27f-afd5-a02ce5bd0e73@comstyle.com>
Date: Wed, 15 Jul 2020 03:39:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <631dad16-66cd-3f7b-90bc-969c52d29aa1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/15/2020 12:54 AM, Thomas Huth wrote:
> On 14/07/2020 23.26, David CARLIER wrote:
>>  From 9c7f54c67d40fae0174ba795fbaad829cd59c264 Mon Sep 17 00:00:00 2001
>> From: David Carlier <devnexen@gmail.com>
>> Date: Tue, 14 Jul 2020 23:23:55 +0100
>> Subject: [PATCH] util: qemu_get_thread_id implementation for OpenBSD.
>>
>> ussage of getthrid syscall.
>>
>> Signed-off-by: David Carlier <devnexen@gmail.com>
>> ---
>>   util/oslib-posix.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index 72907d4d7f..b4f7de83c8 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -100,6 +100,8 @@ int qemu_get_thread_id(void)
>>       return (int)tid;
>>   #elif defined(__NetBSD__)
>>       return _lwp_self();
>> +#elif defined(__OpenBSD__)
>> +    return getthrid();
>>   #else
>>       return getpid();
>>   #endif
>>
>   Brad,
>
> since you're listed as OpenBSD maintainer, could you please review above
> patch?

Thank you David and Thomas.

Reviewed-by: Brad Smith <brad@comstyle.com>


