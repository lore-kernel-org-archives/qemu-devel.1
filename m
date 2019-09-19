Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BB4C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FEB2208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="re0uUSRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEB2208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4Cc-00041K-Oi
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 17:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3w8-00043V-Oj
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iB3w7-0001DF-Mv
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:26:00 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iB3w7-0001D0-H6
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:25:59 -0400
Received: by mail-wm1-x344.google.com with SMTP id i16so1003wmd.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+/zE7hHZ9aJQcN4nbEleENNfHMt0Vbd0u+M4I6feD0I=;
 b=re0uUSRssAR9M7SOTSGh7FHnhYotSPcMsKi+oPUyfbaf+WQFRqPMG7O2jlYaer2Vve
 3bt5Ivy2uTD05SH0BFUHXihuJjPXdnjyFQ6RgWGNb/mCkT2LWOOFih+/sV4+3ucNbqe8
 sCXxT/1GgTfD8hBDHtbLAdVosI4rof7GPWCdeobAc9gjUz4FascD0TI0MlD5bi2OGcAZ
 nvHEx8hSu1yBMKHmTMeNgDQ8MKr9ALqHUK9W1Sqc01sjHG1jvLSiHzrMmvD/+vzVgJgh
 y505jfY/D9wu8d1RDWHCQdI7xx0mt8OdUMBUy2q9w371lSSdoLeleuGWtSDXDbeRoBiz
 tGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+/zE7hHZ9aJQcN4nbEleENNfHMt0Vbd0u+M4I6feD0I=;
 b=VLVIWFsM17ihAfxyV0ToAuNJrgJ8H/yFk4yGjygpPMzZxsE4aCgQGabn8J5VElNYaY
 o0DH5k9XyPWZb/XdSW282Fk2y50uuNONpHz2y6pD5T0jezpYi6U+xRwrxY8fQUIxoEtJ
 AynfYMFU5HvKZHgO4o/gSCpC/7Pa/8L5qIBfVcgmKDneDKSiEunHwTCckR/j68Dvbm07
 T7BNvE3Mg4y/P4a0c5ermQXKk+HxfdWCzMsxSMT+bT2us9MJQ4GaNzKUMwptlRlUbhgA
 1rD2EgbroapaA80LkeIl+K24wPY5qIvEW7oacSwNH9zAXuz2Qq1VWu0X19iG/MN+M3AC
 GOXA==
X-Gm-Message-State: APjAAAVSYTThyjAthrveCBll9wd0S3y7HWn6vbbGXfP7ochfQ/ghU4YJ
 p+v2oUeO2ncwJ69BQ5O9Ant/70oo
X-Google-Smtp-Source: APXvYqyrY23Cal4A+HdRdpTjeMpErwwNijELut/qorOGWjQCOR2oK6LyEgi2yn3x3hl+eCe0KSV1Zg==
X-Received: by 2002:a1c:f615:: with SMTP id w21mr69788wmc.35.1568928358547;
 Thu, 19 Sep 2019 14:25:58 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc::5?
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.googlemail.com with ESMTPSA id l9sm7819027wme.45.2019.09.19.14.25.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Sep 2019 14:25:58 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/26] Audio 20190919 patches
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
References: <20190919083629.29998-1-kraxel@redhat.com>
 <CAFEAcA96outvEdRasZM-LdTSs7QCRZracTvWUZ3gG5x23kh+1w@mail.gmail.com>
 <6691e81f-3122-a13c-d3bf-7f1762b2d69e@redhat.com>
Message-ID: <ed1f234f-9876-781b-2584-65be1f6c6882@gmail.com>
Date: Thu, 19 Sep 2019 23:26:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6691e81f-3122-a13c-d3bf-7f1762b2d69e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-09-19 17:28, Eric Blake wrote:
> On 9/19/19 10:15 AM, Peter Maydell wrote:
>> On Thu, 19 Sep 2019 at 09:38, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>>
>>> The following changes since commit f8c3db33a5e863291182f8862ddf81618a7c6194:
>>>
>>>    target/sparc: Switch to do_transaction_failed() hook (2019-09-17 12:01:00 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>    git://git.kraxel.org/qemu tags/audio-20190919-pull-request
>>>
>>> for you to fetch changes up to cf0c1c2aa32db5d658c3c797ad995a6d571bad96:
>>>
>>>    audio: fix ALSA period-length typo in documentation (2019-09-19 10:32:48 +0200)
>>>
>>> ----------------------------------------------------------------
>>> audio: make mixeng optional.
>>> audio: add surround sound support.
>>> audio: documentation fixes.
>>>
>>
>> Hi; I'm afraid this fails to build on OSX/FreeBSD/OpenBSD/Windows,
>> with format string issues:
>>
>> /Users/pm215/src/qemu-for-merges/audio/wavaudio.c:50:15: error: format
>> specifies type 'size_t' (aka 'unsigned long') but the argument has
>> type 'int64_t' (aka 'long long') [-Werror,-Wformat]
>>                bytes, strerror(errno));
>>                ^~~~~
> 
> As long as you spin a v2, it's also worth fixing a typo I found in 15/26.
> 

Thanks, fixed in v4, along with the compilation problem.

