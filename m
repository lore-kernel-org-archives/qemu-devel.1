Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498CBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16741206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUh8NeaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16741206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADkP-0007Gr-7W
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kADXU-0006Ro-OO
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:33:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kADXS-0003V1-0G
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598279613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FlmQUhs2c6SvKBOxR3BiIdGHFakglNGy1Xso9J+a3a0=;
 b=AUh8NeaQmDu5G5AG/NWfD7Pa3bifDup28o5M7HsdOGQuYAQcb6z3vMIouUzTjL90fIe7S/
 JIn8Lnx78VDkEYr7hGMd8v8IYig0ErxboY0gavG5EvFVXrc+hZdwymEZFzWCu3JKNuruHL
 d4a7MaGUE7FEnEbf6jL+cH3HX9q9YyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-Pn46juQANJy691iZMNtwmA-1; Mon, 24 Aug 2020 10:33:30 -0400
X-MC-Unique: Pn46juQANJy691iZMNtwmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A20D110ABDA6;
 Mon, 24 Aug 2020 14:33:29 +0000 (UTC)
Received: from [10.3.112.126] (ovpn-112-126.phx2.redhat.com [10.3.112.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EEC260BF1;
 Mon, 24 Aug 2020 14:33:29 +0000 (UTC)
Subject: Re: [PATCH RFC 01/10] qemu/: fix some comment spelling errors
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 zhaolichang <zhaolichang@huawei.com>
References: <20200812101500.2066-1-zhaolichang@huawei.com>
 <20200812101500.2066-2-zhaolichang@huawei.com> <87eeoc0x7i.fsf@linaro.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <750785b2-c912-489c-f0f0-ad9f2d5801a2@redhat.com>
Date: Mon, 24 Aug 2020 09:33:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87eeoc0x7i.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 06:48:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 9:12 AM, Alex Bennée wrote:
> 
> zhaolichang <zhaolichang@huawei.com> writes:
> 
>> I found that there are many spelling errors in the comments of qemu,
>> so I used the spellcheck tool to check the spelling errors
>> and finally found some spelling errors in the folder.
>>
>> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
>> ---
> <snip>
> 
>> diff --git a/gdbstub.c b/gdbstub.c
>> index f3a318c..bbe66b5 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -698,7 +698,7 @@ static uint32_t gdb_get_cpu_pid(CPUState *cpu)
>>   {
>>       /* TODO: In user mode, we should use the task state PID */
>>       if (cpu->cluster_index == UNASSIGNED_CLUSTER_INDEX) {
>> -        /* Return the default process' PID */
>> +        /* Return the default process's PID */
> 
> Hmm I thought this was correct usage as s's -> s' but apparently that is
> only a given rule for possessive plural nouns (processes' PIDs) -
> although apparently it is possible to have singular nouns in plural
> forms so what do I know :-/

Yes, this is one case where s's is valid.  But if it bothers you, you 
can always rewrite to:

/* Return the PID of the default process */

> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


