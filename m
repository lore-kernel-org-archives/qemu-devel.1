Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C0EC4740C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C20A620882
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20A620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCKFb-0001AU-Jm
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 05:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCJqz-0005XC-I2
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCJqv-0003Vt-Bv
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:37:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCJqt-0003QJ-Ok
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:37:49 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BC4E681F22
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 08:37:45 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id m16so1366829wmg.8
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 01:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RFYnWbkfz1MBbuANm+asXdk8SH26k+1g537UA+wKKKM=;
 b=KNbBjPztzBSR5ISOMqr0J9BFrLvtyaDPnZ0IgsH6/lehhrX7lSdL9Lg5GCBRmMpuTi
 p+HzDVaz8O8p+5pLTvU/D+nhRnO+oENi6VlCsEDhm9vOcwWlC3cd2xM6zmVT97Fbk2O6
 xm6nP3X7/Jt4melzgy9v/VaCZwWru3HSrPsSHnPz02uvS044L4gO0DGWN579HqdZAGHk
 tg7YOaAZhVKD7hhFS6qSC+Hx+i1jmPB6Fjz8NiEkmZtMkTFEiethRX1/48q7E0OoFrwP
 Mkxm0yy7fuMokGHnzlKFVZyqoRi+K6ZOxmPNBykIpU8YPALHljSnDmU5RfziUkSHFC38
 /D8g==
X-Gm-Message-State: APjAAAUi7WRAoiGRF9CnGmAvP9FvMUu+fxweESzU/HsH2kADXYByzozs
 fH2DZLnMPBQzR53jFXCNux+nZw82CixvK86yg2sco8+gVKGarfSBAQ/bo4zRNyPYGdIapN8sUdt
 CqmoTA1nsZGyLwjc=
X-Received: by 2002:a05:600c:1089:: with SMTP id
 e9mr13192389wmd.176.1569227864571; 
 Mon, 23 Sep 2019 01:37:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxy2/mF1IAPr+/0FgpPwWHDBxfG2Koz3G2a0LwjRyenpOj0po/0KHlY0mo2H8GEJAKt+5gA+A==
X-Received: by 2002:a05:600c:1089:: with SMTP id
 e9mr13192373wmd.176.1569227864356; 
 Mon, 23 Sep 2019 01:37:44 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id s9sm10303619wme.36.2019.09.23.01.37.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 01:37:43 -0700 (PDT)
Subject: Re: [PATCH 0/4] Make it possible to compile with CONFIG_ARM_V7M=n
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190921150420.30743-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <faa7f493-6c40-a5ac-cc70-8cba6e016cb8@redhat.com>
Date: Mon, 23 Sep 2019 10:37:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190921150420.30743-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas,

On 9/21/19 5:04 PM, Thomas Huth wrote:
> We've got CONFIG_ARM_V7M, but it currently can't be disabled.
> Here are some patches that should allow to disable the switch
> (if the corresponding boards are disabled, too).

What about the ARMv4/v5/v6/v7r?

