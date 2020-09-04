Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C44AC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C7C72074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c3k68mKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7C72074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDlC-0001va-8n
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kEDkb-0001CI-9D
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:35:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:37105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kEDkZ-0005hL-3P
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:35:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id a9so6491896wmm.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=user-agent:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vXZqs0dWis6vPj7FMh65e0uFmrw9hMa9w4IIMsG9Gdk=;
 b=c3k68mKnpxsjDDZnTjO9YfFnM6y0gL1RlN/9Y8udwd+eGCwltoXzfQ88CtnEhjN9CS
 ViNsuhERsBwRRAe6Lsqd0AtepWpyYU5zAgvgOJXq8Ersmn3jXKaf4FT+DaPPf/VbAslx
 Iw+ESIqpQ3jJu3vmgDHmfCKHPJnEVduwcB/M5UT1M/q/lp0p/wAZ/R8++PTAnW7Mw1P/
 Ybd2k/gpglUvYosGCocy9tW4FjiF+7izJeyHjjLUNJt21SsTev4zL6CYdRehdf5WkamF
 cahYXzXsTfFohpa70YPjI2lRj/LuFZfqw6ChkWP0iqwqeOBf7OvFtYagkl2Mluv87gwt
 CpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:user-agent:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=vXZqs0dWis6vPj7FMh65e0uFmrw9hMa9w4IIMsG9Gdk=;
 b=JvvXtK3v7faepakD3v6qruJZ0yWdHKCDl0XlhR/jhQaFHLVBbAolwrTLKMJZiy1snf
 +SJEXHcPIAV7hMZ9s8BQ9vGb9QqDlUUBa8Qp+m5UBHqYIdp6uE1GCoyCcp/dNrLmNqZQ
 sbrIe6LIvJiinMZfzABcqpipHFaAONTBjud7IyJd9r/cja85qvqDYhrVf+y9Ej8eYGWL
 qBEDzTAwAedgru3Yg4gz6xUeTGMo6bUinshoqj/sv0huwL591/g/yFCIq8tI9n/UmOau
 97SOb4lvTur2ICgzXo1JlTqowy9DHaaFuSRXS+v41Di0Beft78JF0RerGj6isz6OwPry
 CCfw==
X-Gm-Message-State: AOAM530T0fWn+HQvIMyV09wl5fvegC08wK0FoJq8pVTcM8TnGfIv77n1
 gfDX7JofWRb4+/IIiOofPzYgTBtrvdIHYQ==
X-Google-Smtp-Source: ABdhPJyxQjwN1T/fwGQNrXtg4qef7zkSxKTt+mWZuD0nwS6lpyYFd3r6nlTda70aLMycF42TkNSvHg==
X-Received: by 2002:a1c:7504:: with SMTP id o4mr8121584wmc.70.1599233735931;
 Fri, 04 Sep 2020 08:35:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y1sm12306406wmi.36.2020.09.04.08.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:35:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5C4FE1FF7E;
 Fri,  4 Sep 2020 16:35:34 +0100 (BST)
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: Should we apply for GitLab's open source program?
Date: Fri, 04 Sep 2020 16:35:34 +0100
Message-ID: <878sdp4ks9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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
Cc: "qemu@sfconservancy.org" <qemu@sfconservancy.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi,

Given our growing reliance on GitLab and the recent announcement about
free tier minutes:

  https://about.gitlab.com/pricing/faq-consumption-cicd/

is it time we officially apply for GitLab's Open Source Program:

  https://about.gitlab.com/solutions/open-source/program/

?

From what I can see the QEMU project will easily qualify - the only
minor inconvenience is needing to reapply every year. So far it seems as
a public project their are no usage limits anyway. We are currently
listed as 0 of 50,000 minutes:

  https://gitlab.com/groups/qemu-project/-/usage_quotas#pipelines-quota-tab

So we are in no pressing hurry to do this for the minutes but I suspect
there may be other things that are made easier by having access to all
the toys GitLab provides. Daniel has already posted to the forum
requesting details about how this might affect our workflow so maybe we
should just wait for feedback until pressing on?

  https://forum.gitlab.com/t/ci-cd-minutes-for-free-tier/40241/33

--=20
Alex Benn=C3=A9e

