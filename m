Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF26C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06502208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A72nfI+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06502208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKoD-0002Sq-5b
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jmKbv-0004Rh-BR
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:15:27 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jmKbt-0005nw-Jy
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:15:26 -0400
Received: by mail-wm1-x343.google.com with SMTP id g21so5320219wmg.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=UCYsSYiOaxAeFCpERu0Ir3YfYcQVclNMhFRDXAVQ8WY=;
 b=A72nfI+zGkyNAiE7n/2X7pYE9JNGuGyglWaUjskhnDYjM9+UyoKot+pDcvjEMZ2njF
 qoml+xsSZi9ViZBgX4Qiywu9AZz+OzxNE8iv7AbDC6tC1bDYK1M4toyb0qvYnbSfLvBI
 iadzSNMkKuPRxN3phddJiJBAywHFHpuCuCNq2sfuTj+WSpnHwoxgYrqLqOcWWvPJc0e1
 gEXJVM/xASHurCOVWmzbv3vsX7L5B5RqipjQ7yjP8ZbjXKWbpOc0fPAfBbi88kZQTnE3
 Pi2Mf0vUVVEGgN4s5Am83ma6dVUN+/727pztALT6mEf9hSC4niQesbHECCF4FCLoirn7
 f6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=UCYsSYiOaxAeFCpERu0Ir3YfYcQVclNMhFRDXAVQ8WY=;
 b=N0lgW+hhiRl567mewu8fKe9yBRzZxQxnxzqrqAthgX4Zf4bcvLDrCIE7Ve3V32JvWt
 8Mf9DIo6cIjlfnTxYZnVoxwxQBoOUCocpNrMfG5nJxnZzUDUQGDUjIx1OoL9Xl6hE9HM
 4y49MgehJvdpthI03+Z64+xWSk8xA0+//xsCVv2RTQ3mFkZG4f7ZappR7gjq6mJwR9HG
 wsfjZnmvFIUzi2RaJyO2G2pqGM+1Bnnysgb6gQ7TdVWYV0H5qPw5OmPs31J1a+wDuUCr
 r5S2AOFZBEQr++Hfixv0G9ndinueiL2qv5MDNn5bjn+1VGpparQBNcpQ8OD5qGPyuneg
 Q6eA==
X-Gm-Message-State: AOAM531orjNVB5MydmEQoylf4nP0plJdPB8phOx+ydCIcJnNzR80YYi2
 Gk0zvBdsi4AmYbbd34tuC08tQA==
X-Google-Smtp-Source: ABdhPJxRC9O1Em8CL8tUObuVTcD4gnDAY429OyIp69EWHM+hKO9vVdCdoznq//P6jimvtxV4Db1haQ==
X-Received: by 2002:a05:600c:4146:: with SMTP id
 h6mr4933177wmm.170.1592586923902; 
 Fri, 19 Jun 2020 10:15:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o6sm7841658wrp.3.2020.06.19.10.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 10:15:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 30BE21FF7E;
 Fri, 19 Jun 2020 18:15:22 +0100 (BST)
References: <20200619170324.12093-1-peter.maydell@linaro.org>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] target/arm: Remove unnecessary gen_io_end() calls
In-reply-to: <20200619170324.12093-1-peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 18:15:22 +0100
Message-ID: <875zbnugd1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Since commit ba3e7926691ed3 it has been unnecessary for target code
> to call gen_io_end() after an IO instruction in icount mode; it is
> sufficient to call gen_io_start() before it and to force the end of
> the TB.
>
> Many now-unnecessary calls to gen_io_end() were removed in commit
> 9e9b10c6491153b, but some were missed or accidentally added later.
> Remove unneeded calls from the arm target:
>
>  * the call in the handling of exception-return-via-LDM is
>    unnecessary, and the code is already forcing end-of-TB
>  * the call in the VFP access check code is more complicated:
>    we weren't ending the TB, so we need to add the code to
>    force that by setting DISAS_UPDATE

That was the thing I was staring at trying to puzzle out.

I guess going forward we want to base the base DisasContext to
gen_io_start so we can flip a bit and then assert we don't start a new
instruction having already handled an IO instruction which should have
been the last one.

>  * the doc comment for ARM_CP_IO doesn't need to mention
>    gen_io_end() any more
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

