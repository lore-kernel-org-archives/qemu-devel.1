Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854BDFA372B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AEA3205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEA3205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKiSr-0006u9-Az
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 08:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKiRB-00068w-JU
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKiR9-0007IB-8m
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:29:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKiR8-0007HD-8w
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:29:55 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A43842A09AC
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 12:29:52 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id m14so11658076wru.17
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 05:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KTNVPCfAtsBJaymnRnOuNp99smFnFCwT4/Aboxj1660=;
 b=Y8NKEXb1D5+aFyjts/qveOB93rohadTT4hPugbTyWAHbO38st9rUVr8JZ4jYq5158g
 YsxkP2e/iBv5DaQzavePLymo/BITituMhNMd8mlvGhWBjDFAJofO5E3DpWXhjbVS7b9b
 ujW8yGc+oRGwUTLeoVaDMyLF3Rfe7LSxdESVQpls8picYrNmhZVArcZKTG22zqR2711Z
 eObBY9/dBJxDzkmQeUjP/ceqMKdnCyz3qbEGLQ7VmPa24IzEi3Km/xvjtDlO9b5XuVky
 cLr372H37lh2WJZuLakds45LDj9OSjKH6bTLd6x+8HT/8MyaPtNmlPKYo01moNAcYCph
 DpiQ==
X-Gm-Message-State: APjAAAWpzdfP5NRqWhC7PNnZdNO62jYhdByJvV4Qpjvivxn5VUXFCiX5
 j1wBEFz5S5LV5t+dVkmrJEyvY9roY0PK7IcuJUeVRU7dMrotJBR6xMUSC0X33eyo9QsfSyCkPUE
 1si5HW4JnJm0VBJA=
X-Received: by 2002:adf:fa47:: with SMTP id y7mr2508101wrr.93.1571228990754;
 Wed, 16 Oct 2019 05:29:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxc2nXzmk6yIjbeRBl0Svkc9E0JGB/HpxPmfbGKYLOyAWKroEjKLBRyzLpwtF5U+gOJqWfFAw==
X-Received: by 2002:adf:fa47:: with SMTP id y7mr2508088wrr.93.1571228990558;
 Wed, 16 Oct 2019 05:29:50 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id x5sm31394714wrt.75.2019.10.16.05.29.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2019 05:29:49 -0700 (PDT)
Subject: Re: [SeaBIOS] Re: [PATCH v7 7/8] bootdevice: FW_CFG interface for
 LCHS values
To: Laszlo Ersek <lersek@redhat.com>, Sam Eiderman <sameid@google.com>
References: <20190925110639.100699-1-sameid@google.com>
 <20190925110639.100699-8-sameid@google.com>
 <ffff9a59-3cbf-8b04-f4e5-8a01dad8d381@redhat.com>
 <7dc7b14c-8e89-4851-6d05-d69b1bf36e3e@redhat.com>
 <92b719a7-3838-b019-cd51-5f5b2120a431@redhat.com>
 <1d863ce2-0e45-63e4-ceb2-d2eb2d9aa03a@redhat.com>
 <CAFr6bU=2B9JcmfJZ25BTYkhnw2V+YAghyAyK9YHto18KRptPAg@mail.gmail.com>
 <1dc0c7cd-cf9f-0c33-04f5-ed8d89119c9f@redhat.com>
 <CAFr6bUnsxhqBqHgRdw3dtv0rEvfCVn0oM4XD8Vb1xv_UGKvepg@mail.gmail.com>
 <CAFr6bUm53A+gBVBRr00XKDkt=GiJ5QSOEEXPFfuUJ2PcLeG04w@mail.gmail.com>
 <bf6ff260-f8ca-a593-dd3e-e78fa0551101@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eb3cc776-b8d9-f8da-269a-2fc0f8c21662@redhat.com>
Date: Wed, 16 Oct 2019 14:29:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <bf6ff260-f8ca-a593-dd3e-e78fa0551101@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, qemu-devel@nongnu.org, kraxel@redhat.com,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/19 2:14 PM, Laszlo Ersek wrote:
> Hi Sam,
> 
> On 10/16/19 13:02, Sam Eiderman wrote:
>> Gentle Ping,
>>
>> Philippe, John?
>>
>> Just wondering if the series is okay, as Gerd pointed out this series
>> is a blocker for the corresponding changes in SeaBIOS for v 1.13
> 
> The QEMU series is still not merged, due to a bug in the last patch
> (namely, the test case, "hd-geo-test: Add tests for lchs override").
> 
> To my knowledge, SeaBIOS prefers to merge patches with the underlying
> QEMU patches merged first, so you'll likely have to fix that QEMU issue
> first.
> 
> I explained the bug in the QEMU test case here:
> 
>    http://mid.mail-archive.com/6b00dc74-7267-8ce8-3271-5db269edb1b7@redhat.com
>    http://mid.mail-archive.com/700cd594-1446-e478-fb03-d2e6b862dc6c@redhat.com

Yes, I was expecting a respin with find_fw_cfg_file() fixed per Laszlo 
detailed review.

> (Alternative links to the same:
> 
>    https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01790.html
>    https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01793.html
> )
> 
> I've never received feedback to those messages, and I think you must
> have missed them.
> 
> FWIW, when I hit "Reply All" in that thread, you were on the "To:" list
> with:
> 
>    Sam Eiderman <shmuel.eiderman@oracle.com>
> 
> but here you are present with
> 
>    Sam Eiderman <sameid@google.com>
> 
> In addition, when I posted those messages, I got the following
> auto-response ("Undelivered Mail Returned to Sender"):
> 
>> This is the mail system at host mx1.redhat.com.
>>
>> I'm sorry to have to inform you that your message could not
>> be delivered to one or more recipients. It's attached below.
>>
>> For further assistance, please send mail to postmaster.
>>
>> If you do so, please include this problem report. You can
>> delete your own text from the attached returned message.
>>
>>                     The mail system
>>
>> <shmuel.eiderman@oracle.com>: host
>> aserp2030.oracle.com[141.146.126.74] said:
>>      550 5.1.1 Unknown recipient address. (in reply to RCPT TO command)

That explains it :)

> 
> I didn't know your new address, so I could only hope you'd find my
> feedback on qemu-devel.
> 
> Thanks
> Laszlo
> 

