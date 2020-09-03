Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD898C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81DF3206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qdFJPZ4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DF3206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsYH-0001mM-H3
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsXY-0000yh-Un
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:56:48 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsXW-0006nl-BA
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:56:48 -0400
Received: by mail-pf1-x443.google.com with SMTP id m8so2811791pfh.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cjIdqLQcUMYDb+bcyvP3ApB1osar4DQnehLkTcfKpig=;
 b=qdFJPZ4Im5itVmvsUbakrAzYnuszP8+w4T23PyX3bldn0wwhTkyWiLkqLE2YutS/0s
 xiy4DMfVVwjWq8wnV4MP9WXHb20L5eocWhekuALDdmIRCRe+LjFoe/86229UtAwxLz+i
 NmXe/wWTzEyZPP2FSJMnA62K/s+FHsJ5QuRVk/AeXqucZ91JvTU/LT8r7ud/U+3ORQjg
 yAGB9vdsOMTHoncSZEZRsIkXkyvu9Se1yWsp5EjbXD8bPht4L6vFshOO2L6H1a0ksDyz
 Cd5ecSja3xdErK5mifK9WK35DwANF5mxFH9XsbyEUs0QtLy3SsTtqQpiAvfCgyL+kTNv
 hgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cjIdqLQcUMYDb+bcyvP3ApB1osar4DQnehLkTcfKpig=;
 b=Tm/HQoJHeS1RW+qz9uAS3mSF9OUMPxk+3H5SMwIM921Rxgoz4+qngkKquUicZDczbo
 bYMFhif93lxJZG2BuyXY4zh5dn5vBVhRSgaf1PeQmn5zwxGis08IrtsA0s0EdGpoSfrz
 pF5hmgaKYrso1//jAeSP7evo7ejeRktpKhj08pBvgj+MYmccr30mKD1mjhUlsSiRmJnD
 pq+8mmnCQlIB7djL1OnoEYkM6e71aL+JJ5PiUcJqqX5BtNzIShE0LQyyBBz4nuG4t+pS
 Hh/8hrMABYQcKedMOH/Qc2oLcApv1t67lQksNudiq6TV8Quod7sYhgtHgOoielR1sBEc
 9aYg==
X-Gm-Message-State: AOAM533zOuhVp7o3laPtpLQFL85s/Bka5QpkCQFHzUWYOgQHKIY3SG0i
 Lcm253dRr/6kgezUwO5cVWduYw==
X-Google-Smtp-Source: ABdhPJw+5C/WWThYIKYqGZmWIlhsYquDKC2ay9FobZF6fcIGY971eM77T/S457X2JVTYlw3yWUt5bQ==
X-Received: by 2002:a17:902:c286:: with SMTP id
 i6mr4774177pld.63.1599152201269; 
 Thu, 03 Sep 2020 09:56:41 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id lt23sm3022471pjb.52.2020.09.03.09.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 09:56:40 -0700 (PDT)
Subject: Re: [PATCH v6 8/8] block/file: switch to use qemu_open/qemu_create
 for improved errors
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200903152210.1917355-1-berrange@redhat.com>
 <20200903152210.1917355-9-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <58e969bd-13cf-5313-ce87-4fcf3cd27a11@linaro.org>
Date: Thu, 3 Sep 2020 09:56:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903152210.1917355-9-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 8:22 AM, Daniel P. Berrangé wrote:
> Currently at startup if using cache=none on a filesystem lacking
> O_DIRECT such as tmpfs, at startup QEMU prints
> 
> qemu-system-x86_64: -drive file=/tmp/foo.img,cache=none: file system may not support O_DIRECT
> qemu-system-x86_64: -drive file=/tmp/foo.img,cache=none: Could not open '/tmp/foo.img': Invalid argument
> 
> while at QMP level the hint is missing, so QEMU reports just
> 
>   "error": {
>       "class": "GenericError",
>       "desc": "Could not open '/tmp/foo.img': Invalid argument"
>   }
> 
> which is close to useless for the end user trying to figure out what
> they did wrong.
> 
> With this change at startup QEMU prints
> 
> qemu-system-x86_64: -drive file=/tmp/foo.img,cache=none: Unable to open '/tmp/foo.img': filesystem does not support O_DIRECT
> 
> while at the QMP level QEMU reports a massively more informative
> 
>   "error": {
>      "class": "GenericError",
>      "desc": "Unable to open '/tmp/foo.img': filesystem does not support O_DIRECT"
>   }
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


