Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166F2C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E111620867
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E111620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGMh5-0006oo-2a
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 08:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iGMO8-0002xy-LF
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iGMO6-0003Nt-7f
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:08:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38596)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iGMO6-0003Mv-1P
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:08:46 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D416E8E3C0
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 12:08:44 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id c188so1527700wmd.9
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 05:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/oQT8DN4K81lAulpObLL8omqgqhNuiPwlAvoiwKSXCE=;
 b=dA5VDw0qCZX4N6zn6/dK9O5393u/9j7A/t/uh4WZUUk8l1Q7DX3f1PLaS5Uu7vpf/9
 nOsCYs/+E95ZavXQYBxPVarYvi4y5L2v9Z11/8j46dKuDd8kZpId13LwTByF360/1xyr
 7KVO/xmXmAkaEd6YmFiZd8y3Y2LIhYkcOSkrfoWPDnGViyH15uMbCXBYS0K5x3jIMHpo
 GUmxKx7bfMLvlbvBrkcUfqhjOuS4Fx7yq/XW/c1ZKmPdPMnfrF9aXpWLsbPAfjwF5e6t
 +yskCrrzImIXUsv153ON53+C1FrIDLNOOhMbGbgHQ+/d+mQxwM/a0rbZhmQaf27SF77H
 ZsvA==
X-Gm-Message-State: APjAAAXUSwIzNc7EkmG7TtCciMYs0g1l8o3ERgiRwQN8S562549PzH6F
 BifNiZmKsu7AzJTPi5ZMpeBOsgt8v0WFsO5KIlauPoNqCSRIQ3UsuXwvbGG/Uw4QZrNjUkgtqDr
 oOj/UNpSSjKNapyM=
X-Received: by 2002:a05:600c:2:: with SMTP id
 g2mr10605882wmc.111.1570190923475; 
 Fri, 04 Oct 2019 05:08:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzb8TJ8bZIa07XYG+5NBuItVpbfkFWcfbl2spRrMORjVy58XxGgbQxl4HJw6PwBC1Br+zK3zw==
X-Received: by 2002:a05:600c:2:: with SMTP id
 g2mr10605862wmc.111.1570190923216; 
 Fri, 04 Oct 2019 05:08:43 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id w17sm919268wmi.30.2019.10.04.05.08.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2019 05:08:42 -0700 (PDT)
Subject: Re: [RFC 0/4] transaction-based ptimer API
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191004114848.16831-1-peter.maydell@linaro.org>
 <2edcfdab-0682-2728-2632-e4f5bb6cd7e2@redhat.com>
 <CAFEAcA_cReY=9a40pJ3J1esWTEise-Q29DPqVgm9AAHx9FesvQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1a424c17-4ec0-5cf2-4fb7-b8b8bb357f6c@redhat.com>
Date: Fri, 4 Oct 2019 14:08:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_cReY=9a40pJ3J1esWTEise-Q29DPqVgm9AAHx9FesvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/10/19 14:00, Peter Maydell wrote:
> No, because stop/run causes the ptimer to "lose time"
> (we stop the underlying timer and restart it). It's
> very common for a device to want to change the ptimer
> properties without a stop/restart -- "set the ptimer
> count value when the guest writes to the device's counter
> register" is the common one. Of the three begin/commit
> blocks in the arm_timer.c conversion, only one of those
> involves calls to stop/run, and even there we only
> call stop/run if the write to the control register
> modified the enable bit.

Ok, thanks.

Paolo

