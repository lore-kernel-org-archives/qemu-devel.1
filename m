Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60921C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 17:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 337BF2184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 17:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337BF2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoWFz-0000xO-8m
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 13:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49584)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hoWFo-0000YJ-5Y
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 13:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hoWFm-0001Ky-Qn
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 13:01:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hoWFm-0001Hd-KA
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 13:01:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so7862719wrr.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 10:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6n4mntf8cfY8Tx6EZGo4AbYkeEYpwnTY74TbSgJ0IQs=;
 b=ELGp2yoCfOHUfVAFOvLZ5wc9wgI6DCBjqD5gqAhWNz7OqrruFupT64JoKAY/8PfZio
 0w08FtVtBqer8qYSiWFl/UtD11/i+Wumd2gZ77GM++d+gtW6JgmCIuwM5BF0CvEzhU1K
 wzJO/bLR8LIKw32vaUS1aP+5jSX/5FP8QVPWhT1IYOclzCaV+o3bstYE/Mylsic3ZJ83
 g335EiAdR0/RM/AgLBVqNQdLML2cRn87ICwA2kY3Pm81syvmoE9iWWwf18N3AzonRtbW
 JaAs4Vh+4E6M3TBsy0RUT+CSzUKtiLxcrI0dQD2W8CvEivX68NT42Ungr7q/oqfmDHnD
 LG7g==
X-Gm-Message-State: APjAAAXpJt5yGqaHTM6ynLqJ4qOZctRDl+Q+aTNJDUwgd3vM2hhJyWRV
 mJlaU/lo3XX0ay/LEifV/2FSTw==
X-Google-Smtp-Source: APXvYqz8L0mCX7VYzgxyQ0FmUSM7Ekz5Jt+i4830ERItt2GTvqyW70jW6NF8MTwVBLlJO+c18fs8Gw==
X-Received: by 2002:adf:f281:: with SMTP id k1mr21393359wro.154.1563555656787; 
 Fri, 19 Jul 2019 10:00:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8501:6b03:f18c:74f8?
 ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id f12sm34268609wrg.5.2019.07.19.10.00.55
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 10:00:56 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA-Q6siS3gTRdq7+f0vx-Vd7-DmX1rW6+cS1yR7OqLHYyw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5010dfd7-7608-8640-8767-85a57a0a0b85@redhat.com>
Date: Fri, 19 Jul 2019 19:00:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Q6siS3gTRdq7+f0vx-Vd7-DmX1rW6+cS1yR7OqLHYyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PULL 00/19] Bugfix/cleanup patches for 2019-07-16
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
Cc: Julio Montes <julio.montes@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/07/19 18:15, Peter Maydell wrote:
> Hi Paolo -- it looks like this may have broken the
> travis config "--without-default-devices":

Alex Bennée already has a queued patch for this (and I did too but I
removed it in favor of his).  You can apply it directly from message-id
<20190717134335.15351-18-alex.bennee@linaro.org>.

Paolo

> Here's a sample failing build:
> https://travis-ci.org/qemu/qemu/jobs/559509325
> 
> minikconf barfs with "contradiction between clauses"
> 
> Traceback (most recent call last):
>   File "/home/travis/build/qemu/qemu/scripts/minikconf.py", line 703,
> in <module>
>     config = data.compute_config()
>   File "/home/travis/build/qemu/qemu/scripts/minikconf.py", line 253,
> in compute_config
>     clause.process()
>   File "/home/travis/build/qemu/qemu/scripts/minikconf.py", line 188, in process
>     self.dest.set_value(False, self)
>   File "/home/travis/build/qemu/qemu/scripts/minikconf.py", line 118,
> in set_value
>     raise KconfigDataError('contradiction between clauses when setting
> %s' % self)
> __main__.KconfigDataError: contradiction between clauses when setting VMMOUSE
> 
> 
> I guess this is Julio's commit 97fd1ea8c10658?
> 
> thanks
> -- PMM
> 


