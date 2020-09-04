Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33EAC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55F5206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JC2nMATX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55F5206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEEZr-0001uf-PC
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kEEYP-0007aO-5N
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:27:09 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kEEYN-0006HQ-Bh
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:27:08 -0400
Received: by mail-wm1-x342.google.com with SMTP id a9so6635771wmm.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FDgjATz2hkLLkr5+NwdHM1uLmFg0lD0qlJ/FT8CZRsE=;
 b=JC2nMATXE91UYLXbMubeDttAZbd33+HiDNrqobW8EmuO8ts2qXB5sPhbXBBYz0R7nR
 5owbI6gKRwyeQ7xfyV9PoJEQ2wzDhX2UShbIcwYMNcAfnSxVQSdxfo4AJA1xRqCUlo0r
 D5u5/EPn0tKg/mDZHc2mCs/tX21HWS/uE51LfoIpeLInxioJ1lWSA4ccFhp+ssmYQMWM
 0MZBX6fJPA0PG3ceHDKGtulWKGtqoBOSJcGy4jS5fBLfDnqmyoyfkD+uN9/DuR5oc3my
 dlIZnskRfqaumOC05JbLe8+LAuxsPD89fzhw9y1y/GvKEQ0tr5ysxTbNiqpirEqMLH5h
 MrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FDgjATz2hkLLkr5+NwdHM1uLmFg0lD0qlJ/FT8CZRsE=;
 b=lY8itVIIgTUA1Ch10FMFrEfVk4IZeeiFxG50rNLxuZr4v/PvohRyfvOGogkrpVOVk4
 4l2QNRxYRezYfd8xRSj2Met7uQOzycr0uiW3lpGgjalcErxSg0xvqECVkQHvMsINA8F8
 oFkkzk2b3C4vXqENLxBl3B18h85qZv+3tDx00hebAKp77hZQfy5nSgIAcbyEfH1FdeNz
 c4xsbEa7pRbCnxHgvOtRoXaFtDi2kkQNEUQ3sT4RPbQJ7+ZsyrbDBIlK4ALGjIznC17L
 9/bEMwfSM/HG3vh0f2fS+Mu2XceWIERHetOL3ji1q3EIGKd4oMS+yBLZZsfbNWeV7kA/
 C7jw==
X-Gm-Message-State: AOAM530ZNBF2b0PuxNkXN4nk8BFj534RD6VntWhLZd0BinpyzNQYbFfF
 vhg9nHsXHvuA+hA2KYEwtnbpMw==
X-Google-Smtp-Source: ABdhPJwh4B11XrL2UdfHAjwkQNyC0u1YMqdecT9lgLidWTJOSBZ8ugwaevYdK/9p5JAQPGoGZFS1Bw==
X-Received: by 2002:a1c:998c:: with SMTP id b134mr8210036wme.59.1599236825261; 
 Fri, 04 Sep 2020 09:27:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v2sm13378741wrn.44.2020.09.04.09.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 09:27:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7E8D61FF7E;
 Fri,  4 Sep 2020 17:27:03 +0100 (BST)
References: <20200904134007.4175-1-alex.bennee@linaro.org>
 <20200904134007.4175-3-alex.bennee@linaro.org>
 <d497d2b9-3107-dae7-e6bd-21b9be580359@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 2/4] plugins: add API to return a name for a IO device
In-reply-to: <d497d2b9-3107-dae7-e6bd-21b9be580359@linaro.org>
Date: Fri, 04 Sep 2020 17:27:03 +0100
Message-ID: <875z8t4ieg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: robert.foley@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, Clement Deschamps <clement.deschamps@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 9/4/20 6:40 AM, Alex Benn=C3=A9e wrote:
>> +        return g_intern_string("RAM");
>> +    }
>> +#else
>> +    return g_intern_string("Invalid");
>
> g_intern_static_string.

doh - I'm sure I missed that from last time. Sorry.

>
>
> r~


--=20
Alex Benn=C3=A9e

