Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ADEC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C3322CF7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsdSwWPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C3322CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i55aX-0007WX-31
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 05:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1i55YX-0005w4-Al
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1i55YW-0001hS-4e
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:56:57 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:36831)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1i55YV-0001hB-Ve
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:56:56 -0400
Received: by mail-qt1-x842.google.com with SMTP id o12so7440732qtf.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 02:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=txXxcdVcEhNz+yLM/minDvL7t1RUbWB/sTGnSDsHuxc=;
 b=RsdSwWPSdAE67YwbdSBQTiWQfzmD64Ctp64hz6gs30Os3Td3WtMFv/GIXq1OdP/mNm
 xdyJJj/sfqIcLzX60XJ9wWluNd3UExQOIfc1TjgH8obXP1rIw62u5zyXV12RUFeCvy3x
 GreUVLwSogF8PbRyPdi4bUxrUwLScn1onoZLafnBd10Db5PYpcP+pobx+ke24hilDDhp
 YqG9w0OaRxrFnJjcBjbNIaaL2lG20TWi5IiUGOe4sxqEwhk5K3v3drpzeQPVl77/KVsw
 4wfK0lInsNFJPjSQTlXPIUKUkSgsCQTSnJh1cuBRS/gko1vyU+ev5qngiLxbtdQHjiH9
 VKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=txXxcdVcEhNz+yLM/minDvL7t1RUbWB/sTGnSDsHuxc=;
 b=R8Pr/04mgUWt2M8rwTMIn5kWxHiE49ME4wkJ6Ngr9M7T+98jdI104y35VWpHgAhcHK
 DFeHZFrexUDVfek4NKqWUJn2hbaT/Nl7cvPJMbuZGS2+UJNhVN8lqkqzRwy2UehYlyKw
 R5qWqesWUHfVDnciEC3jzf2TaQSRt82yiorss/2hgDz9o1A3VoHfViucELAon8+gX3qi
 kvHW5SKSuulLfd0mNKPStHSHai7mi4gDOnLr5HfAMgG/CWiALpJqO5vezzrvJoufuNAo
 dSm2mykpYLkc+nNUxDb9H0P+apvUJrEC/9txqLKlgHkPAVdnaGqPTcPrXWgkl1E1IXqK
 CcYg==
X-Gm-Message-State: APjAAAWaXRxLMTVMfYP75YsbanlLMvvqCZUW++fOjhU1o/HNo3ceTqOB
 4X4j+tKZb53qiaIpO+9xIRs=
X-Google-Smtp-Source: APXvYqyQWOkOBOLpswqQ3Mi/b7lgtlu7euyAUR0+/ElHfISc+/M8z2f7QmDaRmVpzo8TRdeNArWOGg==
X-Received: by 2002:ac8:2d09:: with SMTP id n9mr8768334qta.10.1567504615248;
 Tue, 03 Sep 2019 02:56:55 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:9589:1351:c7eb:87b:c9d5?
 ([2804:431:c7c6:9589:1351:c7eb:87b:c9d5])
 by smtp.gmail.com with ESMTPSA id h4sm8251596qkf.126.2019.09.03.02.56.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2019 02:56:54 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190902205842.1884-1-danielhb413@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <4903f3cb-8ece-15b6-3d34-24fdc864566c@gmail.com>
Date: Tue, 3 Sep 2019 06:56:52 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902205842.1884-1-danielhb413@gmail.com>
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v6 0/4] delete created files when
 block_crypto_co_create_opts_luks fails
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
Cc: kwolf@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please ignore this series. I'll respin a v7 to actually do what
Kevin suggested in the v4 review.

Thanks,


DHB

On 9/2/19 5:58 PM, Daniel Henrique Barboza wrote:
> Changes from previous version 5 [1] suggested by John Snow:
> - patch 2: return ENOMEDIUM with !drv, return negative error
> codes in bdrv_delete_file
> - patch 3: clarify the meaning of returning ENOENT in the
> comment
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg01173.html
>
>
> Daniel Henrique Barboza (4):
>    block: introducing 'bdrv_co_delete_file' interface
>    block.c: adding bdrv_delete_file
>    crypto.c: cleanup created file when block_crypto_co_create_opts_luks
>      fails
>    qemu-iotests: adding LUKS cleanup for non-UTF8 secret error
>
>   block.c                    | 78 ++++++++++++++++++++++++++++++++++++++
>   block/crypto.c             | 22 +++++++++++
>   block/file-posix.c         | 28 ++++++++++++++
>   include/block/block.h      |  1 +
>   include/block/block_int.h  |  6 +++
>   tests/qemu-iotests/259     | 67 ++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/259.out | 11 ++++++
>   tests/qemu-iotests/group   |  1 +
>   8 files changed, 214 insertions(+)
>   create mode 100755 tests/qemu-iotests/259
>   create mode 100644 tests/qemu-iotests/259.out
>

