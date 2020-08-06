Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E98CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05F55206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H3cvbpMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F55206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3eNl-0007XM-E2
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3eNA-0006wp-BO
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:47:48 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3eN7-00074q-LS
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:47:48 -0400
Received: by mail-wm1-x342.google.com with SMTP id 9so8547826wmj.5
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 04:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lbxK9wDOnHcpcBrmM4d/xz/MJQNaZ5Ih3TwoD+zvXP8=;
 b=H3cvbpMZeDBechE6aPHpYu9vZDb4ghY/d9cT4fZu94TXrorsWwFJ1jqXHm2/mLt7Ft
 oEDgbmyvDSYUjRFemvZ875c9zGfpt35MHL5sF2V5TTYlutwCZJT0+f5xHtOVifS2F8D+
 yWurG5K5UumPhS0iXRg4/GzW79i0K7PU/AfhtVDI1LAVGlWvKOG7SWw8IiutSZfGmNvR
 uZV4ArVyfS2PN+4ZrqdlbV8THjVMQSMxmlwE7dxadleIvwGt4ZnXo7lF8YGjbMjcRsFC
 UnY795tOmRlf4S0DdNjiuNuMuaY9LYI+2cPEpc/foEsf3d9WAHq3ocAyP8x4cUfG1bFX
 4Y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lbxK9wDOnHcpcBrmM4d/xz/MJQNaZ5Ih3TwoD+zvXP8=;
 b=sdiO+Ng5kbVN7nwduFdn+V3npF+Mr9yfsguJlPFByYb/6gl2w/XNqTzyWT42hO4BJO
 iq5GdKKXfZUhzRXpnU1yaG3e3jjFLwlT4TVCrdLWu9GWy7pUk1JFf0jQtdgO1AP+loC2
 azygOPLV+axiZUXex7cVBd9qPZ1KpjXJYXEK3AngnxsMyMZwL/EJ6VkwG+Z39WT1Ih1B
 hipPDfp0Cuz3SBRV4lcl7WR+WtAS9CJfWdzozUmY6Z8bcEhHVDK2CHLnrQqLl/9Y9C6I
 xj4y8Cy4hwK90CUwl8a+5E1x8pTC8Z1XBgUPqNM0galybXGXvd12mG+tlMi1LwITN/sG
 pHOg==
X-Gm-Message-State: AOAM530vpeDu84ACYXtZvfrw4AY/o1lAk6NuJJ5c7dhndFx5so+ZyrUV
 NSM0rDtVREXJNuw90TwZEDO+fzA1qrI=
X-Google-Smtp-Source: ABdhPJzG8zWi9L+NsHl1rT41h0O6D+GxIhQNFVhZrlLezRaAybGq7vqw9pe16vCFJ6aHWvW+s0VjNw==
X-Received: by 2002:a1c:19c2:: with SMTP id 185mr7561862wmz.8.1596714463035;
 Thu, 06 Aug 2020 04:47:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o30sm6317412wra.67.2020.08.06.04.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 04:47:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ED7811FF7E;
 Thu,  6 Aug 2020 12:47:40 +0100 (BST)
References: <20200806104453.30393-1-peter.maydell@linaro.org>
 <20200806104453.30393-4-peter.maydell@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/4] target/arm: Implement FPST_STD_F16 fpstatus
In-reply-to: <20200806104453.30393-4-peter.maydell@linaro.org>
Date: Thu, 06 Aug 2020 12:47:40 +0100
Message-ID: <87ft90knc3.fsf@linaro.org>
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Architecturally, Neon FP16 operations use the "standard FPSCR" like
> all other Neon operations.  However, this is defined in the Arm ARM
> pseudocode as "a fixed value, except that FZ16 (and AHP) follow the
> FPSCR bits". In QEMU, the softfloat float_status doesn't include
> separate flush-to-zero for FP16 operations, so we must keep separate
> fp_status for "Neon non-FP16" and "Neon fp16" operations, in the
> same way we do already for the non-Neon "fp_status" vs "fp_status_f16".
>
> Add the extra float_status field to the CPU state structure,
> ensure it is correctly initialized and updated on FPSCR writes,
> and make fpstatus_ptr(FPST_STD_F16) return a pointer to it.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

