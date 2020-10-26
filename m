Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A21C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C4A22281
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NiMLNPJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C4A22281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2YC-0004AW-Su
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kX2XU-0003bV-PP
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:27:56 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kX2XR-0006Z4-TP
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:27:56 -0400
Received: by mail-wm1-x342.google.com with SMTP id c16so12468252wmd.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 06:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=QIREdB84fznPFQlTmUHl67FrzO+f0E8x071A861HCLQ=;
 b=NiMLNPJ7G8Vof8UY4u9IRPZ716dLKoFQicGHS16WEFpYebRYEc4cql/I9mg7oaFdZ1
 13pB2pzirGOUXAJ5lpGt80vz4dWPuFHWPxFWW/6oLafIqh9COqA4etGbsekNBA9wdL9c
 SCXvOf2dySVQ9dGHMJcssmM5QlDbbkGrxxOW5kiZwuMhntwRA2EpCdK0tlZbp1A6/dRE
 Zm4VkFGtFYL4yTUNX7g+samunRY7lT6NWF9hfW2cw95TBnU0TuU6N29t2IFn3nWwAfD7
 MsduIG8W3Hbt9Bp8gn1pL7u38F8VLR+BE1tHenCVaB2kcZWPI92Y+UNiwAoo/AoePZ5t
 H2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=QIREdB84fznPFQlTmUHl67FrzO+f0E8x071A861HCLQ=;
 b=uWxfPxy561zLIj5oWWSA/NIUnh2/go4sEdp+L5uAGj9xgS4FSTie36tsYjzZzRyZKL
 AE2wN/hKHbQjffRucCkjYSRdTToz04bYX4VjvztKrkxxYwxw7KdcKZzPPDwao8Va5O7c
 bbFwoLirmnw9zAoy2GksiCRGViOzAdbZ8QMgvz+6gISADThefUN+DxKa0YwbLClgZEtz
 NuAAjktiTVETAkuotouWB/kZ2o6AO4g06a1eT7nfeWd5+MziNSxXN+0Gli0acvCd8k14
 9buRG624asVoQCGCKZJoZy2y96rEcIdAmp+Jge+mll0svPm9l4znBSwotxOcCnjAQCHU
 4JlQ==
X-Gm-Message-State: AOAM532l73ZImMM93chz7c++qoCdHoCEEmONBBjn4vPsjdC4Zy7HrYE6
 5ruA3SYXvafu+m0wxzomEZlusb9ob2DoUg==
X-Google-Smtp-Source: ABdhPJzrOtQ7QZBUsR4pV8DgLBhjxfBkPtQmRdzFQThurgfmrE5YOkEKyidjFuV3A16pFdwLWN66ww==
X-Received: by 2002:a1c:96ca:: with SMTP id y193mr11042997wmd.22.1603718871591; 
 Mon, 26 Oct 2020 06:27:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e13sm22554582wrt.57.2020.10.26.06.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 06:27:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9BEFC1FF7E;
 Mon, 26 Oct 2020 13:27:49 +0000 (GMT)
References: <20201023073351.251332-1-thuth@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 0/4] Test more "check-acceptance" tests in the gitlab-CI
In-reply-to: <20201023073351.251332-1-thuth@redhat.com>
Date: Mon, 26 Oct 2020 13:27:49 +0000
Message-ID: <87mu09glre.fsf@linaro.org>
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
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-ppc@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> These patches enable more "check-acceptance" tests in the gitlab-CI,
> fixing a broken URL, setting AVOCADO_ALLOW_UNTRUSTED_CODE and adding
> some missing packages to the containers.

Queued to pr/261020-testing-and-misc-1, thanks.

--=20
Alex Benn=C3=A9e

