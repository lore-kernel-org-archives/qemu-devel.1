Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C512C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CCFF20663
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIV8lF/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCFF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je03v-0002P3-FW
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 13:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1je02L-0001P9-6p
 for qemu-devel@nongnu.org; Wed, 27 May 2020 13:40:17 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdzvd-0007Og-5n
 for qemu-devel@nongnu.org; Wed, 27 May 2020 13:33:23 -0400
Received: by mail-wm1-x344.google.com with SMTP id v19so276723wmj.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=82O/Oc1WEFJvJ1ySWmqxfSNPVaPNadwd/cFEQ5+0XAo=;
 b=UIV8lF/0m/Xc0fMJFAXL+wjKtr54U2q772PqcLt5tK4312ECxsiHrKN8d8O2xLqTn5
 h9CDPZqZ7I6OM0xlmyA+Z9H4Wq22mFcOKVi6mRF+nh7HKA9VbXIQ0lzw2k19JkRnuUhX
 xraS8cWnYI/fIbq4r0qOctvPweyKr4GTlSaHMKdKYvm0N4KAdoHJe6EmvtnnG1LtPSkX
 QO0fvGz5xSPK54RE6lUtvcl3tMTJGzidRq8s0KPY70oq8r51f+1KscsoZNxoGcBquwuE
 b+LBOgI0hhISsTgKgV0u1Q2S15shQVo/WnaG0TGQNcdfTPkBAsC4lHguT/UoRgN7CmG3
 uJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=82O/Oc1WEFJvJ1ySWmqxfSNPVaPNadwd/cFEQ5+0XAo=;
 b=lR/Bv+Nu0YogRpY31ZQWRhRq9jmWVHOx43cO5S0UnOpypMytjN3VOyo6KrwclaFv1l
 wWhh28TZ8yXBCTbbtoxSwsMwMg1SE8+zAnz69ljVHtHFGvHo3iy54jAc0wUXdGgSxRUF
 fpgRXRDTsD0iLftz267HoWTWQSs4ESQna1KQrdJLkqoAj0PpQCiRNYn/o+H+mh98WhUz
 OToVZfowH8Ug979e9hbEU1+OdsZZroSc5OPdDH+nN3IoQ8cj02FHcEivDtMDf4VyBeGo
 wQNLrKa5qDjZ8pqtQ1xORFiUZ//FeHA06hoe49gGS1YgQBLSut9Axee1O6iqucaJxOVr
 vPsA==
X-Gm-Message-State: AOAM5339aVKc0c51mGEDPzgXzy0KToK7sv8oPc3DQUZ1J3oKAeNEDzty
 bZADjFPJtVP9JqwFyiTO9zgE0MHg5O4=
X-Google-Smtp-Source: ABdhPJy66ykqHer5acATABEpTbhr0ttjdZg793NmSaULmoqiA3YM6Hi/WkbaldSuA4cegQ0X+AEfHw==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr5209046wmc.123.1590600798692; 
 Wed, 27 May 2020 10:33:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d17sm2526839wrg.75.2020.05.27.10.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 10:33:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 594CC1FF7E;
 Wed, 27 May 2020 18:33:16 +0100 (BST)
References: <20200525131823.715-1-thuth@redhat.com>
 <20200525131823.715-4-thuth@redhat.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/7] GitLab CI: avoid calling before_scripts on
 unintended jobs
In-reply-to: <20200525131823.715-4-thuth@redhat.com>
Date: Wed, 27 May 2020 18:33:16 +0100
Message-ID: <87a71t5llv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> From: Cleber Rosa <crosa@redhat.com>
>
> At this point it seems that all jobs depend on those steps, with
> maybe the EDK2 jobs as exceptions.
>
> The jobs that will be added later will not want those scripts to be
> run, so let's move these steps to the appropriate jobs, while
> still trying to avoid repetition.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> [thuth: Rebased to current master branch, use separate template]
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

