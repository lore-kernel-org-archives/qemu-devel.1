Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DDBECE596
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED332067B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED332067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKP3q-0005Zi-JK
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 11:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKOu9-0002AS-EV
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKOu8-0003TL-4q
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:38:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49038)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKOu7-0003St-Uc
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:38:32 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1579F7FDE5
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 15:38:31 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id 190so8833859wme.4
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 08:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=upOn3asxmol8cSGc3dBEkTNu+0iKxNhIe5Q65bgvlLA=;
 b=iQ+bgWRyh/GeJUeOS9S0bUhQSHW/Vd/kA3YA1h21y7mbeB5ceXeoofLI8nVCutcX3M
 nVBRw1xVHP/muyWvGvPLB10ATTSlxPe2zhYTWjQO4aNUPRT62y91Hp2TLOUSiv+x2U3s
 3uJFMp4PuAHBWmfwn3E0dX9wKJpZ7cERYzPp5fEYgmfUBeSuz+8hHKEh2ID1B1P8G1pQ
 ZZIQywSRADlgRzTSEqKpHiksO7S2Ksd+KsZbSaCNe+JIXorQUEM+YAsZXd+ZKSRBule1
 aYQOLwO2Iv4YnfCChMd10hvwutqAJ9zypDIFP7oHEnNfjgXUsauX+n/Xe/HXcWgL/eRG
 lESQ==
X-Gm-Message-State: APjAAAUISAoXEgrxSo++a0WEpnWF6CDXekob/reOovQ4WeKsv/05M9H6
 B0hhJkHOV4RZaeMuIzsehzI5ifUjF5umJq41GR+xRy3DYvRNE8m3imG/j+Nbo4cUOWjHEwtnn//
 Cp/KwgRppRuxeWMQ=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr20739775wmb.125.1571153909852; 
 Tue, 15 Oct 2019 08:38:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx7LPFkBpcL7wY5sOYl6tOx79Wi+b3+a3QRPSD9zRAU8OiFm3AEcfOEn8uWtf6jllUEUsiVzw==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr20739759wmb.125.1571153909663; 
 Tue, 15 Oct 2019 08:38:29 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id b144sm25445476wmb.3.2019.10.15.08.38.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2019 08:38:29 -0700 (PDT)
Subject: Re: [PULL 0/2] Tracing patches
To: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20191014085709.26812-1-stefanha@redhat.com>
 <CAFEAcA_tPs_hfO3GVSf2CsYTFvBH5-RWe+JsR5vfqkh5HjAVNQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f13e94c3-5ebc-3c55-3c3d-d9cef9233514@redhat.com>
Date: Tue, 15 Oct 2019 17:38:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_tPs_hfO3GVSf2CsYTFvBH5-RWe+JsR5vfqkh5HjAVNQ@mail.gmail.com>
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/19 2:24 PM, Peter Maydell wrote:
> On Mon, 14 Oct 2019 at 09:57, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>> The following changes since commit 98b2e3c9ab3abfe476a2b02f8f51813edb90e72d:
>>
>>    Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-10-08 16:08:35 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/stefanha/qemu.git tags/tracing-pull-request
>>
>> for you to fetch changes up to a1f4fc951a277c49a25418cafb028ec5529707fa:
>>
>>    trace: avoid "is" with a literal Python 3.8 warnings (2019-10-14 09:54:46 +0100)
>>
>> ----------------------------------------------------------------
>> Pull request
>>
>> ----------------------------------------------------------------
>>
>> Stefan Hajnoczi (2):
>>    trace: add --group=all to tracing.txt
>>    trace: avoid "is" with a literal Python 3.8 warnings
>>
> 
> 
> Applied, thanks.

Buh, v2 missed :(

