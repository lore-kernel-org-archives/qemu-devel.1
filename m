Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5A5C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F7C2177B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKRbK7QV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F7C2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k40Op-00075X-6f
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 07:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k40O8-0006FH-6r
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:18:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k40O6-0007Y7-D6
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:18:15 -0400
Received: by mail-wm1-x342.google.com with SMTP id k20so1477494wmi.5
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 04:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=KCvkuyKswt0l1geFJ6eG01qflfFwuIeDvyfMbDJiGXQ=;
 b=WKRbK7QVg8ObWu7+6vAjpFxs/4wV96yoZtfcU0TlzuNhJGIRYMNYugYLA/DGYeJ+Tv
 o00B4uHo0Jc8QLmmg3syOqARSPvol2KJlriRuhW4i4BVoR4lTCdaIq+OYBSYpfrrfNLg
 X7KpZiotmEBUPZESdBGBwL4DDI1dL47Jra6bB1Rjmvgwe+sfwknQzuRAP7/tP6IEAJzo
 FicMy/Od9vWz0o4MFstb64BwG63WCqW8naEei6uUuqfsKTMo/IVH6h/3hwCQiAr7lZ1z
 jOvQQmMsrgk/VZqdoaXpgHPH+RhwOrDUh5oyGN30osUq7bC0Yy2TMx7ZH+OS/hx1ul1y
 Yacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=KCvkuyKswt0l1geFJ6eG01qflfFwuIeDvyfMbDJiGXQ=;
 b=KSI1WLSEkmhJkoOkA0BZnZxdufaAOOWio6LJKfYdkqiF7CdDDdtJAWtCFQPf8mkvCy
 z34JFZF+vLeGNh9dtBqmFJn+PF/K1AdKctNDQP2NrTyi1hOXC3TLaulUDLlzhyb2APhW
 Qii9zIt7BqgfohaPWJPm4RBBKNbzn5ho4vLLviV7QdjVxCFm6cdi622K4JOQJTWR+AaT
 dKz+skYSZbXBb6a3jG6jObsfHUEPHpU7mlXpdetvBJHhcjcUZkM44BHS1tn74jXVUTmL
 KZIGc5BB0XZiN61c4FP5ZS9T3PJHSemQS6UOSnm0BPKklsMidz/IbSwfakT/sXhBV2j+
 ZnvQ==
X-Gm-Message-State: AOAM531g0Hr6mQ7wi2EL11ClegywwAsbkvpv+5sm36LBrID9d+NI1dVZ
 0ShnNO7MoE+8LiVnXHQU5wj79xSroXY=
X-Google-Smtp-Source: ABdhPJy0Aj/ZmvMiD0NKaC57sDrvnu5Oe0NJXkh2hXjRuqSONCuCkLSuvGve3BysxcK9jT9lz70Cnw==
X-Received: by 2002:a1c:cc0c:: with SMTP id h12mr11619818wmb.57.1596799091738; 
 Fri, 07 Aug 2020 04:18:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g16sm9743089wrs.88.2020.08.07.04.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 04:18:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 126361FF7E;
 Fri,  7 Aug 2020 12:18:10 +0100 (BST)
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-21-git-send-email-pbonzini@redhat.com>
 <87sgcyk9zv.fsf@linaro.org>
 <543f3674-b984-680e-4e85-0f507f6571ba@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 020/143] meson: add testsuite Makefile generator
In-reply-to: <543f3674-b984-680e-4e85-0f507f6571ba@redhat.com>
Date: Fri, 07 Aug 2020 12:18:10 +0100
Message-ID: <87k0yak8lp.fsf@linaro.org>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 07/08/20 12:48, Alex Benn=C3=A9e wrote:
>>> Rules to execute tests are generated by a simple Python program
>>> that integrates into the existing "make check" mechanism.  This
>>> provides familiarity for developers, and also allows piecewise
>>> conversion of the testsuite Makefiles to meson.
>> Hmm not sure why check-tcg has broken then:
>>=20
>>   11:44:37 [alex.bennee@hackbox2:~/l/q/b/all] review/meson-for-5.2|=E2=
=9C=94 + make check-tcg
>>   make[1]: Entering directory '/home/alex.bennee/lsrc/qemu.git/slirp'
>>   make[1]: Nothing to be done for 'all'.
>>   make[1]: Leaving directory '/home/alex.bennee/lsrc/qemu.git/slirp'
>>   make: *** No rule to make target 'run-tcg-tests-aarch64-softmmu', need=
ed by 'check-tcg'.  Stop.
>>=20
>>=20
>
> Probably unrelated unless you bisected it to this patch.  I'll check.

I tried bisecting but there was too much breakage at the other commits.

>
> Paolo


--=20
Alex Benn=C3=A9e

