Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37990C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 22:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9C12072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 22:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Odn6Ko1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9C12072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv7Tg-0000Ip-4I
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 17:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iv7Sm-0008EH-LC
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 17:30:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iv7Sl-00034u-HV
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 17:30:04 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:37076)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iv7Sl-00031P-B2
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 17:30:03 -0500
Received: by mail-pj1-x1031.google.com with SMTP id m13so455344pjb.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 14:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BKsswJKYOb9gGScy5M6SFelkoye4DJhjKamCn7/JI4M=;
 b=Odn6Ko1g7HdkmIs7WvY+yCvDDuvz+pyC5PKfaGjwBZOWHXcTbQUowpRJTy2/wE6DXn
 NExV5MGNcqQqLpORmpoCQzAkjdRfh49pRxIqyRNiiJ/cLTA2vHfkvIAWM1ynunpUn87n
 jaMAYlEK4ohTqeWgRZXFL1q24Bt0I2SWEkDR3hbN0E/wMTQyT14vxgcB3Gcaz4iu8Es3
 SzGQEM+vI4bM8gKfq6ZgBtjPRZBisZWkcqOHzyx7PHp5b77OoB5NS1vqVcsZEy7+VEHZ
 o8uMzBZEMBwBjO3TXQxOeL4gchbpmS2HOHboaWzHXK1M4JG7wK6QFPqn+P0xN43N80H8
 KykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BKsswJKYOb9gGScy5M6SFelkoye4DJhjKamCn7/JI4M=;
 b=Yrt7BSqFTNTe+Q14Aavm7LoYBcjUxLU4ZJ6yWu6A9bKbJgTP/9XdwXeBd5bSyfllub
 DLijjqImcweVlLTu4Cr1WtHTensTPSgMyYohu2InDINmlkbjXylmVekPOlFolrg82XLt
 SaOUm3D18r/U+vq4lO37hu0x5K5SyvPXtDVecW+3u/pDt0LLTIwrg1KJCoyU6SpUxvLO
 Pv6Lof6BmTZSE8NA4uhGsarGPky+Ij/FmlJD2cqktPIrzSM9UooaVs9ZvV8nqV8JYklo
 blztZXuiYW0iH1zFdVUXuYdQaxpDBH+O3mCbS7ZJvcQCKUFgiAUx7n3PGWwKYTobo5dM
 i+jA==
X-Gm-Message-State: APjAAAUh2bWscAHlMwauS1Ihlnwhr90+L9EJy6UiQQ02hBlhqSoLeSzX
 BgiZQ2NZt4B2PNPIFRLlh6Uwfg==
X-Google-Smtp-Source: APXvYqzJL5rIC5cH5FVNisJ9KK2vw7uE6rDL2FU7gyqe7xyhz0PVbxcwxCPdJLnVXPW0no9zlfYj6g==
X-Received: by 2002:a17:90a:be0d:: with SMTP id
 a13mr1661635pjs.78.1579905001845; 
 Fri, 24 Jan 2020 14:30:01 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id v10sm7691175pgk.24.2020.01.24.14.29.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 14:30:01 -0800 (PST)
Subject: Re: [PATCH v1 12/13] tests/docker: re-enable cross-compiling for
 x86_64 hosts
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200124204026.2107-1-alex.bennee@linaro.org>
 <20200124204026.2107-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7b3d8af5-0c37-9ba9-6503-0f15cba4d451@linaro.org>
Date: Fri, 24 Jan 2020 12:29:57 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124204026.2107-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1031
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, f4bug@amsat.org,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 10:40 AM, Alex Bennée wrote:
> +../dockerfiles.cross/fedora-i386-build-qemu.docker
> \ No newline at end of file

Lots of no trailing newlines.  Probably not intentional?


r~

