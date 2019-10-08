Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5395FC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2625E206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2625E206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHngl-0007uV-7n
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 07:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHnfx-0007Jj-Hl
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHnfu-0007pK-OP
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:29:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHnfu-0007o8-FR
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:29:06 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 824A846288
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 11:29:02 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id s19so869021wmj.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 04:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZQLU46f6QNi939Lm+/VqdtwZQrD4/TAynnh+DrV/JsU=;
 b=kdrUwqyLLm0FFZYhFris/EkG6CX1KzWhNIla2/Heg3As5yheVEzJXxS/X1SzZC3Uig
 Z/V8wEQJVuWTIHOCisREFKRPbW7v28CRHlYi2P89q2OkeZMbx5Tm0rCsG+9IAKosw1Ez
 p9vDZqvUABZd7f4eDbuvQirCqJwdC3xKONQ7OB2vf5ljtlkJqNCutojAOLIV95755Ne4
 R/QHO91pHLHXNlzL6MTYShp1Nwgswami9RcGzn+Xin6z5FIBJt9oJhOXS3cFo32ZktyU
 aeTHH4qGt74muxf3eXwngPeKbPTnoaOPtsn8vW2rOToqjXhQNoM3TECHrVzUtEimaOUA
 LPMA==
X-Gm-Message-State: APjAAAWoiSCxsczUiytyVAQyfaAdcEKPOLBul2vox9weYkunjPFrmWx1
 v7jshe2Zwde7smlD6QH5kSjuZoc7YiuuVq5TrzGzxhU8kMc9iGqyMIG8NWdHQiXJlLsPohTPTaU
 8l1v/83qSTD+Tg9o=
X-Received: by 2002:a1c:4d0e:: with SMTP id o14mr3341546wmh.172.1570534141235; 
 Tue, 08 Oct 2019 04:29:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyb5rvHtRpR27ynwXajelUxQEXeMFp5/FzNkqd004p9payIa4ViysO6gYE/+bPTyZqHAusVqQ==
X-Received: by 2002:a1c:4d0e:: with SMTP id o14mr3341533wmh.172.1570534141032; 
 Tue, 08 Oct 2019 04:29:01 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id o9sm41820624wrh.46.2019.10.08.04.29.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2019 04:29:00 -0700 (PDT)
Subject: Re: Peculiar reply from mail list handler???
To: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
References: <CALvKS=EoaNnNQCmdp3rjjbaAYOoow8txsn1KX=Mb37Vk3he5Kw@mail.gmail.com>
 <5ef2c575-0bae-9f0b-cf2b-437280914cec@redhat.com>
 <CAFEAcA8bs-DZPsxzE=kJ-gRT-1i6wZ4FvkK+-MaygE0Zg3A4Yw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e01f0c12-cd2f-d2f0-aac3-b8145239c45b@redhat.com>
Date: Tue, 8 Oct 2019 13:28:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8bs-DZPsxzE=kJ-gRT-1i6wZ4FvkK+-MaygE0Zg3A4Yw@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/19 9:09 PM, Peter Maydell wrote:
> On Sat, 5 Oct 2019 at 18:13, John Snow <jsnow@redhat.com> wrote:
>> I'm not clear on the particulars of mail delivery protocols or what
>> lists.sr.ht is, but we indeed do not like HTML mail sent to this list.
> 
> I suspect the lists.sr.ht address is just some subscriber to the
> QEMU mailing list -- the list server sent your mail to all
> the subscribers, including that one, which then complained
> to you. But the QEMU list itself is OK with HTML email
> (we prefer plain text, but we don't reject HTML).

I subscribed to sr.ht some time ago to test the service because they 
provide a CI, git hosting, mailing list, so this might come from my 
account. If so, I'm surprise it send email on the subscriber behalf.

Per https://man.sr.ht/lists.sr.ht/etiquette.md#plain-text:

   Rich text is not desirable for development-oriented email
   conversations, so you should disable this feature and send
   your email as "plain text". Every email client is different,
   you should research the options for your specific client.
   HTML emails are rejected by all sr.ht services.

Surprisingly there is no option to allow HTML... (plain text is a design 
feature).

