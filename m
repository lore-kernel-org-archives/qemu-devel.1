Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC07C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE9725586
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bpd4r5BX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE9725586
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwLh-0002DY-W2
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jpwGf-0005DM-FK
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:04:25 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jpwGd-0000g9-QN
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:04:25 -0400
Received: by mail-wm1-x343.google.com with SMTP id f139so16620691wmf.5
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 09:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dYD3gpAibggWvJCfgwDYZvObI0QEt3hiu4x31wxnKjk=;
 b=Bpd4r5BXtRqY3V2nz2+yFgHpy5aU/zV7RGVDG1RMGLoCdeGi8qdmQcWuNfPpboeg7z
 19pzqkry+q71Vc5zTTGgC9FjOKZrqcSIif8llympo0k4icCkXO+7KIDckd5XazRg/5rR
 YiR7mHp5AtqJ2/WW/VQh5suI6gG9S06f9tPfcl1iVR8JHWdqZdUDCxmZKlr+mOhm5iux
 wswqjoZ5AvATWaCQRaPzTNrdT/eY8RMj7jHkSqLqKF5X6Ka1HLPlG3h8UeTz48UGpGjh
 lTxR48xzlNEsfQTPwKakpuoKJRAplLAnL3WGCpe5Qb25ZqK2Dxqi3pvNIqNjR+ff/qvy
 FjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dYD3gpAibggWvJCfgwDYZvObI0QEt3hiu4x31wxnKjk=;
 b=i6t+2DmslGPPm+Z2y3ENJGHgx7+WoYGWxrDKLBiqZtBG8PyGbde+JOp3FmgO+sxpUT
 xQzQnZ7QAkIJY3+/WsG8Lt6T02RzkF38HsYS9Y2+fNLZ8WTj3BULacRyi6JpQcnc7UD6
 L8t92HKXu2IFanY3AFoo5dhCyuCsYBfWV8RAWj7SJVp/agB8sj5zUBTeSvCJklbSt4Nj
 KbJ0UtLX32x+bpRkVEsFvyLD7HusoiBJag/7MFAmaurHQ7U4I5kisHuDnAmyC6iHNz12
 KPRtA/d5fyzBWy7Sa8V+sJ7hOhqvu9/pbw7qnoh81N8Z9A38yhIcM3CbjT168DpDfyUf
 zTAw==
X-Gm-Message-State: AOAM532Ywa8z1Y/XFQe1z7SjXE/hrWHP9GMqGL9aSM6PHnX2D+V03Y8s
 n+sPzTf7/lsaSLruHYMrNC4CAg==
X-Google-Smtp-Source: ABdhPJzMIp6uRQ0i3UK5e4nEkt4aRvpT/vTds/fl6hpMUCc/YBCXAgQEN7/BeEGjL901L6D9auUH5w==
X-Received: by 2002:a7b:c5d5:: with SMTP id n21mr17246683wmk.106.1593446661035; 
 Mon, 29 Jun 2020 09:04:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a126sm264983wme.28.2020.06.29.09.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 09:04:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1862B1FF7E;
 Mon, 29 Jun 2020 17:04:19 +0100 (BST)
References: <20200626170001.27017-1-robert.foley@linaro.org>
 <20200629132640.GN31392@stefanha-x1.localdomain>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] util/coroutine: Cleanup start_switch_fiber_ for TSAN.
In-reply-to: <20200629132640.GN31392@stefanha-x1.localdomain>
Date: Mon, 29 Jun 2020 17:04:19 +0100
Message-ID: <875zb9svss.fsf@linaro.org>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Robert Foley <robert.foley@linaro.org>,
 qemu-devel@nongnu.org, cota@braap.org, Stefan Hajnoczi <stefanha@redhat.com>,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Fri, Jun 26, 2020 at 01:00:01PM -0400, Robert Foley wrote:
>> This is a cleanup patch to follow-up the patch which introduced TSAN.
>> This patch makes separate start_switch_fiber_ functions for TSAN and ASA=
N.
>>=20
>> This does two things:
>> 1. Unrelated ASAN and TSAN code is separate and each function only
>>    has arguments that are actually needed.
>> 2. The co->tsan_caller_fiber and co->tsan_co_fiber fields are only
>>    access from within #ifdef CONFIG_TSAN.
>>=20
>> Signed-off-by: Robert Foley <robert.foley@linaro.org>
>> ---
>>  util/coroutine-ucontext.c | 52 +++++++++++++++++++++++++--------------
>>  1 file changed, 34 insertions(+), 18 deletions(-)
>
> Thank you for revisiting this patch after it was applied!
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Who takes care of coroutine patches or should this go via a different
tree?

--=20
Alex Benn=C3=A9e

