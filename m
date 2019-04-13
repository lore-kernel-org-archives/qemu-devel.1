Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC51DC10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C66218AF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n2hWkg4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C66218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44353 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF6Bb-0004R9-Tz
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 20:06:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6AW-0003Vq-Bg
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6AU-0002qQ-Fg
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:05:16 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6AU-0002pf-0C
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:05:14 -0400
Received: by mail-pg1-x541.google.com with SMTP id g8so5925796pgf.2
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=p6yk4aFjLD8HZfAczFk2SJoDvPhZ3qlQJdTpY1nCJo8=;
	b=n2hWkg4RJ8JdIilO+8uuT189nCotnq1s6HWkhDJvpX+onhi+96TNw2LkUuTSectV11
	vobtY5hak54DANEs4imkwncG6Ja1YSCbd8HPyt4UFAFsGK9WLNkwkSnJLjfe3HyM0jjI
	6TE8edbRU/Qdjz/VJnR/KfSNGJKSFcFizxV9+uFITKA2QF+39Gz2jdXSnaDbwhAa7Zxh
	Zgwu4yTgDea1v18VzGA54w5OynOoGWNflnhWGC08vXoqx+mJQntmZqwoZo66/1eAkfaJ
	LY0qjOzYx01qB9oF572MnXpSokYK+FovXZOsZcv8hOVCO02nUavik9NAwTDxWIKBC4y+
	VczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=p6yk4aFjLD8HZfAczFk2SJoDvPhZ3qlQJdTpY1nCJo8=;
	b=PbTJQkum4IcJQ86kk1fakqUlfgrMGT0PsqlztBorchXtH+yS8FsUo4pZM8iq39JPrl
	ThD+RMZTYV0yTIVESGTbInLxfkJ/ovXrSLkNFC8iVTU77bYEUar0bAAxp3/hqe/U2Wfi
	vQq7PUR8WsOSwes2altEaFRMOt2dtvPre21KUL8OEENqWwXABDs76zzwHMEuF5nvA5N9
	id7Q3r95tKSmu25PEmNULHfg7/0YB8/F+ypdKUcs/7GgRfSL1qQENjjvoQhfh+VqqDsN
	8/iwnKbCMmtg+2NbiVD2KYRc3UXUy+ypCy2+6QKj6hoNFKQx43rqp0w2neMcWjThZEto
	JHtQ==
X-Gm-Message-State: APjAAAVd7xw98LYTa0ki0UCzC4T06i96AA6mdrD2DiUXWqT1XMSraTTI
	22XtXA/VWw1dUmwp3Ep95DKlqg==
X-Google-Smtp-Source: APXvYqwUhWcqAXXQTa1M/b58Qv+YnjxKlsS+xinGibymchLpqW728E1PfW4Mj3gJg79/DQb7ybluRQ==
X-Received: by 2002:a63:3d4c:: with SMTP id k73mr56671479pga.154.1555113912664;
	Fri, 12 Apr 2019 17:05:12 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	j22sm57284374pfn.129.2019.04.12.17.05.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 17:05:12 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-22-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8d46a58e-ad28-68c6-9c53-e5a3c2526f8c@linaro.org>
Date: Fri, 12 Apr 2019 14:05:09 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-22-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v1 21/41] s390x/tcg: Implement VECTOR NAND
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413000509.i03kXKwlnk_AH2aX-MfnDHuj98kFCV7apva7oo1i_do@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Part of vector enhancements facility 1, but easy to implement.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      | 2 ++
>  target/s390x/translate.c        | 1 +
>  target/s390x/translate_vx.inc.c | 7 +++++++
>  3 files changed, 10 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

