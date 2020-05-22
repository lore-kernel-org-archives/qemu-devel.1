Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEAFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE452247F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b06hdovs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE452247F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc8ZW-0003cR-Bs
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 10:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jc8Yu-0003C0-8I
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:22:12 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:38230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jc8Ys-0008IG-IB
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:22:11 -0400
Received: by mail-ej1-x644.google.com with SMTP id h21so13251772ejq.5
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 07:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BVOe622+MsqkkcP9KF2Lt+UVv98asm7jGeUCQr5iFVg=;
 b=b06hdovsodOLICnCLWPDB+5myyqywZINTL/eCvR8hYPP4GZdNqGrokvWuopGMFIy1P
 urEPOuZiHmmG9glxlIJKaa5LktZlxMM/MATAPsx3+fhNjXN/R+76qzo7l16aXjY2sWEd
 G1/brehVYU69j+LhIzkH8LnYh/henAdIJF3Ehpps/ApDbHIkwrOLMJlLoMVS/9ScpkI+
 +xuD7Ekq+UtVqvTmMqZOPXJBsWsRkBj7uLlEQSFab7MDwSJv2UM2wdlSc47eIB3cn6wH
 EFn9JDvseEWkeJGpwg7jWazCW8IlWa5+oEwroafX6k2y5Hy6E3o6a28p/ZfyBXDkUcss
 A3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BVOe622+MsqkkcP9KF2Lt+UVv98asm7jGeUCQr5iFVg=;
 b=R7f9ix/p8tIZyn/7TN8NojXCwI2ifjv7wvxPGiTmNoI/vp5tlUv5SJD6AGNilxuIcG
 EVYRdqmgrqJy4PaoGVd/BWQAawmg9XgWk1kkIPTZ5bkhbyiH6YoRFE779DgUBRb3K2Wt
 NC+32zgz3zpEFNUf4NDwTGS5U/CgosBdIivI6onovUlWDYFgzreDsarSMFJ7RNcI4lZ/
 SXQf1Ru2vIcWldHqcKI/NT6zqCoda0Pyv8gu9iREwABBM1B8UL45RoVffAIJilPcZ7KZ
 fhv+sgNL1AUx3HnCfKVhorxXf49E5/seD43znRDTHUmK9Vaa+xYNOyyhnFgOoZdg/hCk
 mkqQ==
X-Gm-Message-State: AOAM530xHCICZZe9Q3svMVnyNC8rTA1dIlN4IOL7LwZ36zYOJeiIzb99
 THV+9IeohgMMx4bAgEWqY7VVzw==
X-Google-Smtp-Source: ABdhPJxpsXa9RJcEgrpMxWqm7v1pdKYYrAn1LTHE2UAPnccPNcbROYqJ1rKqbttFqkFIZhfEV9lBVg==
X-Received: by 2002:a17:906:e090:: with SMTP id
 gh16mr8714956ejb.41.1590157328607; 
 Fri, 22 May 2020 07:22:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w12sm7193130eds.4.2020.05.22.07.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 07:22:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 631401FF7E;
 Fri, 22 May 2020 15:22:06 +0100 (BST)
References: <20200519132259.405-1-robert.foley@linaro.org>
 <20200519132259.405-5-robert.foley@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v7 04/12] tests/vm: Add configuration to basevm.py
In-reply-to: <20200519132259.405-5-robert.foley@linaro.org>
Date: Fri, 22 May 2020 15:22:06 +0100
Message-ID: <87k114dp81.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: peter.puhov@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Added use of a configuration to tests/vm/basevm.py.
> The configuration provides parameters used to configure a VM.
> This allows for providing alternate configurations to the VM being
> created/launched. cpu, machine, memory, and NUMA configuration are all
> examples of configuration which we might want to vary on the VM being cre=
ated
> or launched.
> This will for example allow for creating an aarch64 vm.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

