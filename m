Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A5BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E15A2075F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QbTPhUoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E15A2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jalWu-00039P-93
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jalWB-0002EG-51
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:33:43 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jalW6-0001D9-R6
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:33:42 -0400
Received: by mail-pl1-x642.google.com with SMTP id f15so4649601plr.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 12:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GvYUoWusKR0krSbBIoHRgl0073So+unYTj9MN115Ds4=;
 b=QbTPhUoU0/t8OY6OGBiM1177WL99hI5tnAsuGNyiglBhyIDyhxYB8v61ADRECz9C32
 EW/h2qVKk7DVHGtM81rUTB7gb25zbyrVG/1SVBbvqS8B6LX4YfK5JEqn7vUin+fIuE9G
 IFaFwpuMXUerbEbyrM6UM4HF3KrSZW28gxUQrMkypx5/EMIgeCifXBmpJ9RM6bugd1Vv
 GDmmyeLeRvL0laon2vc/OB7o5OUV3W4bkx8KkMMv2v2sdVItyMaJ8Kx5DIBSOGgmy9UK
 pMKhk/wknWrU5BMMFyeJ8D3uHgtf8CoQZ4l5CwuQ+7HA56igHNsu16zMyGk9eUEngCk3
 QJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GvYUoWusKR0krSbBIoHRgl0073So+unYTj9MN115Ds4=;
 b=IHJpU6iob3sQGzyhKsScK1JHWbovHJJ7XGLhYGUX7/VNyeLsecktS3u6kFZMApyO4R
 1X6TVIXnT+mqmNLruwRbOU+5p48RH0QS81jBjbX1zcnMPsM7oTcRFLKBz20jvivEtn4U
 plA4it7K1yj+xx+6Ax8xPwQAWQINTjkCMSwhMQzGKVI3EpEUZ0WRTL3IfVrj56u0sD/g
 /Ib06IgkgcCeQkjGUzMLBsUthuWIG4npQVQgPcoN9FRPJI9ldNUcfBNZlVXcUXapgoK+
 y/eceq4Ry03o34GRjzCzNCkvCokECuyaUIWJER2UfkVgDro1XHCSweB9L2jdeRoxQcsP
 0gtg==
X-Gm-Message-State: AOAM532ym7bExS0HT9IyQEaWU70g2HznYi7g2aIVmfPxrF/tGJ9cL/sL
 XHG+N2rOK1sEI+BLuPTVnyBVuA==
X-Google-Smtp-Source: ABdhPJx+ekzBahHcRIK5XrJBE5LrZ0Vo4MFjzsCszbqL+oQIG+268MpNmVWtFJwrXz5vGVdpE0F4Tw==
X-Received: by 2002:a17:90a:5b:: with SMTP id 27mr1090052pjb.190.1589830417291; 
 Mon, 18 May 2020 12:33:37 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id m9sm8305701pgd.1.2020.05.18.12.33.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 12:33:36 -0700 (PDT)
Subject: Re: [RISU 0/9] risu cleanups and improvements
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200513180953.20376-1-richard.henderson@linaro.org>
 <CAFEAcA_xBwNPWFd3w36JnuBsZSKb+q-aWXHfrLe1Rb-29eXpjQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3cf98ff2-8256-eb3a-7ae0-3eeb1b27c331@linaro.org>
Date: Mon, 18 May 2020 12:33:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_xBwNPWFd3w36JnuBsZSKb+q-aWXHfrLe1Rb-29eXpjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 11:39 AM, Peter Maydell wrote:
> On Wed, 13 May 2020 at 19:09, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This patch set does alter the format of the trace files, and thus
>> means we'll have to re-generate these.  However, the space saved
>> for sve trace files is significant, so I consider it worthwhile.
>>
>> In addition, the new --dump option allows one to inspect the
>> contents of the trace file.
> 
> Alex, would you mind reviewing these risu patches, given that they're
> mostly trace related? (Also you're the one who'll have to regenerate
> a lot of trace files :-))
> 
> Richard: if you feed an old trace file to the new risu, what
> error message does it give?

Bah, it should have generated an error vs the magic number, but doesn't -- it
silently exits with success.  Alex, expect a v2.


r~

