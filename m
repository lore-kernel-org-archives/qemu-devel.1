Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1884C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 11:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1EE20729
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 11:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tGwve06e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1EE20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k55eY-0002Fb-20
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 07:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k55do-0001Qh-Vl
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 07:06:56 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:34953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k55dn-0007O9-3Y
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 07:06:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id 184so7927135wmb.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 04:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EPKKjub5xIEylUzklvuWM4byRfcXO9pjxDmZYKE7eo4=;
 b=tGwve06efCFFQudbwpqV7RZ+ZV5e5z0tY2OJDMm6GTxfzjCuFQZocqR4OSXbBB1cfp
 asjZNk+AwICiH5ezuS+4ht/En9nK53WG90Qy2aGNk3wyRtdJrLnWmW8NOqztpyIAWqT/
 CqA9UNTTHid9NlojIzSIo6xdr8m5MHLHWGLZ+CuWm+s1yU5VRV0aK60Opry/jNsVrEcs
 cbOL4FG+CVodhMtOBfPE5tDGMk+eNrdkxEzRhAdFRBH2Y9lnL/AKz+iYLG+gDpNBAIaf
 GHkHLLhwn0Jdk3OxGn/CAAb32MWdhokuZxZ7ph3Emj8/Hq04uU90+dlXEJTnBj8eWbRp
 jMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EPKKjub5xIEylUzklvuWM4byRfcXO9pjxDmZYKE7eo4=;
 b=T8r/6YnfVgJGJkWW8KQNs+WWiRwAiETKC1K5Y9iJKpSMypwFdysyC6aCzoObnoAe3N
 RbLFkMQUSGR0pWxgrvuaYqD7wvdW5LUyi2ddQaToJsz422efDnVOX62MxI2moPbU36ZJ
 vG8oTHxPBwKsObt9koPHljWANtpkkkKwMdBNV3NmYNIXi6Cttlmow2EKU7qcuTLub0lx
 eTdQO3gcd1SlplOqdsc/R2D5sHgVjceDDIUa+60vREjqwtl3NkKwXbamNpy+2DJ9Oh9L
 Cuh6D+yrkXACGxwtGdbCKEoi1oAS2x/6tid+DNLxOoP/I3vqIzyZ1C1Hx3sZIDSyYEKr
 JHiA==
X-Gm-Message-State: AOAM530mbNAymxD81GIcENCJDFd8op7H3fo9Vo6OVUgzrB+YrWx1cD32
 vD/EkdEmolu/W4hXhX0Htp9UogEPMOk=
X-Google-Smtp-Source: ABdhPJyrheF2mMTOP+Nlit2MMuO9ZoPZrY/9B2RJm8/GRP2if2mFgn61DiycOBWN258zU9W6LNg47Q==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr24305384wmc.162.1597057612938; 
 Mon, 10 Aug 2020 04:06:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z8sm20530667wmf.10.2020.08.10.04.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 04:06:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EAA6E1FF7E;
 Mon, 10 Aug 2020 12:06:50 +0100 (BST)
References: <159670025270.3099.13280483088179052036.malonedeb@gac.canonical.com>
 <159705580515.5476.18189254156927143329.malone@soybean.canonical.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bug 1890545 <1890545@bugs.launchpad.net>
Subject: Re: [Bug 1890545] Re: (ARM64) qemu-x86_64+schroot(Debian bullseye)
 can't run chrome and can't load HTML
In-reply-to: <159705580515.5476.18189254156927143329.malone@soybean.canonical.com>
Date: Mon, 10 Aug 2020 12:06:50 +0100
Message-ID: <87ft8u3gl1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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


Tony.LI <1890545@bugs.launchpad.net> writes:

> It's fine on x86 that I use qemu-x86_64-static.But it's bad on arm.So
> what is the problem?

Could be a number of things - is Chrome using threading alongside it's
multiple processes?

--=20
Alex Benn=C3=A9e

