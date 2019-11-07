Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2717C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EC72085B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EC72085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSmz1-0005Rv-0R
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 13:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iSmy2-00050l-Eh
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:57:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iSmxy-00032y-Ti
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:57:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50337)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iSmxy-00032n-O5
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:57:10 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ACFE1859FB
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 18:57:09 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id l184so1680739wmf.6
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 10:57:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/jLKXuzKGz9RILwtzMXbN1RLeTrSEDuTb8xFL8vuiNU=;
 b=Q86khvDK+lIxaAAGzsxusYqzkljMe1ebuektt3Ud7pKAWFC0QRjpvok26TRjvTkXYf
 ZbukjC+G5axO2UHGS19tlY5vhbPO7OXuWuwjZnI2hpZKpObKLTKY94rkPcbuyIUF88am
 oNuxi2u84Qs9kGHdqbth7wR4IAZFZxRq65BszmANvvGi7rXloV0NgslD7Xoyat5B320h
 GyZef5Oj6SB6x7cuX8/ZQXva56HzlYY9d9zvfOCNG4FZvDNkwOaDznORQn8oc+vestfj
 7cciw9SK0UwIXAHB1ndQWbZbd8RRHDBdqqFdC0uuvYSffs94G2ETsAatx85Ja/1dl89n
 JMxw==
X-Gm-Message-State: APjAAAXxF7T5fnJPPj2TnPp8bGMV7USJLhEDVANsV3ifIdGkTAIEssnQ
 f5NoJwpPHrD1We7v27PxqW2XrJaFZ6iqDsugqx4HfpqSEGVnwk84OKvWGc+kiljeZvMKue/odgl
 DQCFF/FDP6CikLCU=
X-Received: by 2002:a5d:5011:: with SMTP id e17mr3831541wrt.160.1573153028094; 
 Thu, 07 Nov 2019 10:57:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqw+YmpFrSHn4NYUXnDZcKCYTK4yexwkf6dS2cSB8dks0Yl0ax3opCO32DPI4FcN3cAupjaF7w==
X-Received: by 2002:a5d:5011:: with SMTP id e17mr3831530wrt.160.1573153027894; 
 Thu, 07 Nov 2019 10:57:07 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id r5sm3223917wrl.86.2019.11.07.10.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2019 10:57:07 -0800 (PST)
Subject: Re: [PULL 0/1] Usb 20191107 patches
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20191107085525.30902-1-kraxel@redhat.com>
 <CAFEAcA-N=c5ghYz3y9vaG0yx-rAGHLdFUcxqWf4vnW7uX37LiQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <418ce09f-cb48-b338-24b0-c6f9a3efcf08@redhat.com>
Date: Thu, 7 Nov 2019 19:57:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-N=c5ghYz3y9vaG0yx-rAGHLdFUcxqWf4vnW7uX37LiQ@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 11/7/19 7:26 PM, Peter Maydell wrote:
> On Thu, 7 Nov 2019 at 08:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>
>> The following changes since commit 412fbef3d076c43e56451bacb28c4544858c66a3:
>>
>>    Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-next-pull-request' into staging (2019-11-05 20:17:11 +0000)
>>
>> are available in the Git repository at:
>>
>>    git://git.kraxel.org/qemu tags/usb-20191107-pull-request
>>
>> for you to fetch changes up to 1dfe2b91dcb1633d0ba450a8139d53006e700a9b:
>>
>>    usb-host: add option to allow all resets. (2019-11-06 13:26:04 +0100)
>>
>> ----------------------------------------------------------------
>> usb: fix for usb-host
>>
>> ----------------------------------------------------------------
>>
>> Gerd Hoffmann (1):
>>    usb-host: add option to allow all resets.
>>
>>   hw/usb/host-libusb.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> This didn't quite make rc0 but it'll go in for rc1.

Won't this make bisection confusing?

