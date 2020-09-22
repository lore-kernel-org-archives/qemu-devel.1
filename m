Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4915FC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 641662388B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJCAf9Cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641662388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKexv-0007Re-P8
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKewa-0006nZ-Mn
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:50:40 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKewY-000195-HJ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:50:40 -0400
Received: by mail-wr1-x443.google.com with SMTP id s12so16317389wrw.11
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 02:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=sQPhss5DWjtqofnkMpdYG5L2+8qhzRQPv6JYWrgqoeo=;
 b=mJCAf9CvFXonSS2gyuInGdKmLrjz3yeI5c8KygioUpRJRhtjL8O4wgZlRqXLvGhiSG
 DqoWeNCZMUup2j7Mxvs/OZzdGfi6TqWCN18N8WJIXXWSGgiHj5NtTi6oSfEbMOnt01EV
 uhPK9DRMWBg8XqnumJn+IxYDtQbORN4QX0WlDYSkqZq3ynEJGK8e7lGoysmD4iqu6W+r
 oU8ZVB9JxIWC6Bq2eaVQwA71sDUBR3zsQksw5XxZMyNSRUE7LCF0BbCO0ClR/rW5BkML
 Nio72NCgPxhf4xjaKj00ah0h96Nzx+nbzeLIllclGyHp3O6IRVZ1NVPeNc0RlBwHKse0
 225A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=sQPhss5DWjtqofnkMpdYG5L2+8qhzRQPv6JYWrgqoeo=;
 b=ZAcDCDXQg4t9zYtN4/O0zBam6zISza8kl4VxbVr6dxrdGbugHIq4z7c/NiTE6oIngp
 zcuQlljKaMm5KcKKEiq/COZJAdGhIyXg1MBdgWvUjfakbOhAejdXBuyOz+PO+8wJLa6S
 iZVcwlvutPu3cZF8i95XWLDEYPAj/Op4VH9J3uIjxe0NTZfLpxCp+1n7WM3SMkP5GgzT
 UQJxng0ECY8HEsv2jZg6xMm0+fr+LVDz8ts5P6EFyTmVlN4+WMCXBYDS5sGKSphQGBir
 olsY/fXNKeYP1rXine6Kx6t4E52NV8aGXGk37EryX2ON5ceJfNhV+7CMHMwWG15DEbIE
 ZCBw==
X-Gm-Message-State: AOAM531szVp6yJYx9Ipfo6ZDzd2hrj8lTxp0AybVFyqWzruLqPkm97wB
 aDR5+nVQlxddbItEJx46N3s1TQ==
X-Google-Smtp-Source: ABdhPJwm2Xzmgd3cUxp91oqin7Q7/9hHvoaEoFsltGvUp56TShtd7qaVf3KImcWbdFhbxXll7oFncA==
X-Received: by 2002:a05:6000:12cf:: with SMTP id
 l15mr4284392wrx.312.1600768236688; 
 Tue, 22 Sep 2020 02:50:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x10sm3846499wmi.37.2020.09.22.02.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 02:50:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9458F1FF7E;
 Tue, 22 Sep 2020 10:50:34 +0100 (BST)
References: <20200921174118.39352-1-richard.henderson@linaro.org>
 <20200921174118.39352-5-richard.henderson@linaro.org>
 <87d02fnd1y.fsf@linaro.org>
 <8e1ac018-dac8-b049-aae3-059f86698f3a@linaro.org>
 <d3a5ec4f-259e-2f5a-2ae9-9bbc46d24298@amsat.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v4 04/11] disas: Move host asm annotations to tb_gen_code
In-reply-to: <d3a5ec4f-259e-2f5a-2ae9-9bbc46d24298@amsat.org>
Date: Tue, 22 Sep 2020 10:50:34 +0100
Message-ID: <871riunnrp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 9/21/20 9:53 PM, Richard Henderson wrote:
>> On 9/21/20 12:29 PM, Alex Benn=C3=A9e wrote:
>>>
>>> Richard Henderson <richard.henderson@linaro.org> writes:
>>>
>>>> Instead of creating GStrings and passing them into log_disas,
>>>> just print the annotations directly in tb_gen_code.
>>>>
>>>> Fix the annotations for the slow paths of the TB, after the
>>>> part implementing the final guest instruction.
>>>>
>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>
>>> I guess what we loose in the inline annotation we gain in simpler code.
>>> We can always grep stuff out of the logs if we need to:
>>=20
>> What information do you think we're losing?
>
> This in tb_gen_code()?
>
>   note =3D g_string_new("[tb header & initial instruction]");
>
>   g_string_printf(note, "[guest addr: " TARGET_FMT_lx "]",
>                   tcg_ctx->gen_insn_data[insn][0]);

We are not loosing information - just it's placement is slightly
different. It's nothing you can't work around.

--=20
Alex Benn=C3=A9e

