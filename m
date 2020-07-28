Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396E8C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0560C20714
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0fbrVc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0560C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Md3-0007UO-9g
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0McJ-00072j-Uo
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:13:51 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0McI-0007iS-6x
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:13:51 -0400
Received: by mail-oi1-x241.google.com with SMTP id u24so7100422oiv.7
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 03:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dIGitEZzrPfalnnDRusGe28l2o0rf72O/DvG7N9N97E=;
 b=b0fbrVc8hmErEmlFhfL5lTeN9t7A3Y/NNz9ll10zrA+Rqr6Rm33Pceg/B5+x4mmt+Y
 EHGT2F4txMqMn5Sf4UTpq5A8nt+UJzjmVOCu/z27+epYaa4ProLwm0ttSKIaoJs+DyFT
 kbBZaFP9pyzsVLI3NPiAiLTCcqYJLlo/x+kQN/FH3/+MecdNkLz/QaRHqm59CAmkkUw7
 Fo047mxpm3vj+qaoPjxhWJAImYZE7NgWvBMvxu9MGwD4gzoA4He7ZYSPm00pw72HgX4j
 S/IxVEn9Fb+dRcB5NKxPulhl/XnafW/kclyefM+2AjouvvckBIyGc1R5Ns8RovWh6du0
 hyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dIGitEZzrPfalnnDRusGe28l2o0rf72O/DvG7N9N97E=;
 b=TaMvz0hY7dMRbQxXB3LikB9OTH82UFNgSFaIan3G0jh4B23qQOEKhkyclSnQeTddxk
 JZ9IMcIhydzRRtQcTqyTcvftdh1qm6kGhNmZlNWOV9DcB2d4i7Dd2ilmCURjjzJ3gp0f
 dKCcdXP7XnWoajgVpQBMgdxFb1S2ra+LXqFimd/4JGlgHEqNHpHnsOkorDbwqtZdBZJ+
 Pko3WMhA6u+6e/4O1RUEcZcfS8UAzil7oIouAR77/QiEwAxpaLzuYQvnbB+4I2g2XKZv
 6dVl75iV/tKsHnS/qTaO4xEgx+WnEEJbItXik+h8zY4cWuUwey7wPQxiyDgbk3uui2Ty
 VR+w==
X-Gm-Message-State: AOAM533XtSZS5AbsFERP8zPHD42zNnGxyLMRpFPGsu4kKz61Y9rICcpU
 HLvVxoo61lvZdzwgQu7teGSnuC1NfHouaXmSUfJPjg==
X-Google-Smtp-Source: ABdhPJzFJC22rWeZ4x/tjI2G7ahXjg4PWDt64qOjlCb0r7cf4shJQj8p9wDx5Yd4f0r/+JUpZ9r5PzneOkT/HQbrL8w=
X-Received: by 2002:aca:4a96:: with SMTP id x144mr2814958oia.163.1595931229010; 
 Tue, 28 Jul 2020 03:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200728091828.21702-1-paul@xen.org>
 <CAFEAcA_wKTFWk9Uk5HMabqfa6QkkTAdzBotmnrA_EH1BR4XjYg@mail.gmail.com>
 <32ad0742-bff2-1fbc-2f7a-d078980eb171@redhat.com>
 <CAFEAcA84fH3aGpbrJoA6S3qJ-FjD3NZMoj0G7jqvRneH_pS6=A@mail.gmail.com>
 <a09853d3-5c27-893f-54ed-63dc461bfacb@redhat.com>
 <ee8374bd-1257-1d29-6800-3902426b1a0b@redhat.com>
In-Reply-To: <ee8374bd-1257-1d29-6800-3902426b1a0b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 11:13:38 +0100
Message-ID: <CAFEAcA9zp48p64mPxR4_NyLDdYxjtEkKE_xQz_4D+Uau7HTE3A@mail.gmail.com>
Subject: Re: [PATCH] configure: define CONFIG_XEN when Xen is enabled
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Paul Durrant <pdurrant@amazon.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 at 11:00, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> Apparently kvm_enabled() checks CONFIG_KVM_IS_POSSIBLE instead
> of CONFIG_KVM, I suppose to bypass this limitation (from osdep.h):
>
>  21 #ifdef NEED_CPU_H
>  22 # ifdef CONFIG_KVM
>  24 #  define CONFIG_KVM_IS_POSSIBLE
>  25 # endif
>  26 #else
>  27 # define CONFIG_KVM_IS_POSSIBLE
>  28 #endif
>  29
>  30 #ifdef CONFIG_KVM_IS_POSSIBLE
>     ...

Interesting. We don't have CONFIG_WHPX_IS_POSSIBLE,
CONFIG_HVF_IS_POSSIBLE, etc -- also bugs, or do we avoid
them by happening not to check whpx_enabled(), hvf_enabled(),
etc in obj-common-compiled source files?

thanks
-- PMM

