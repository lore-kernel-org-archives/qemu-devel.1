Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC10CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CCF20679
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJXlBiYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CCF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO393-000852-0P
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 13:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO2zO-0001IS-6n
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 13:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO2zM-00052B-Qq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 13:03:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO2zM-00050Q-HM
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 13:03:00 -0400
Received: by mail-wr1-x443.google.com with SMTP id l10so3164955wrb.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IKHCNkmDLor/el2ZoF3niIQQV4ChYKgrLQG6D8fRyEc=;
 b=pJXlBiYpY+XMvh7LlaiqIA6TaCDZOEenSlf+iIWD/5VJExsCFS//BjDzwPnbEa+OOV
 J38amOeY1DL6vMWZZYyKAFqhBf5GOCp3n4MiqJFBjpdyyKIQ1n07yOcaUHt+ACHw033N
 +iUb9tug2559YklUxP12gfaeS+J3eNmXfx0zDSPNq7zVKjN82zCB1txZG8w/j79eHLYL
 Fa/0THSA93cH3yGovOva9cTFSwf2tNkj6iMmaD+rxCcH0wzFn7ZjC/ZCcryTcGh086cZ
 nFtg8uhC1dz/q1lfacjKm89t/cPn5iQVAYgGp7qGwekq/mh0Dy6wUnZRNsKGYi5yopf4
 HNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IKHCNkmDLor/el2ZoF3niIQQV4ChYKgrLQG6D8fRyEc=;
 b=C5acCQReESZv4MpVyK+sltRZlL48fEbWXPuaVPHk1G5mE1K5fJdWvRQfs6SeLFkXfj
 ZRlU5Zo75KWZ38lKa39ivsmlbVvs5EKHni8NOnREN1C45RV4g+AMxAjBlpGCe4+lE3rM
 O+UMa3OiZNA7ejxFOfKJmh2D5glIFmYrCb0MYTwsp5KQDv2rAnePD5R7oEdYclrxUq1A
 t16lofhogdVLQDv3lryCL7qTstqGPkkNm/LTOyf7ffqxJYBeYZZREvBFyYbgQL7gtdtl
 PPKJVDJ/rR4gvUB7+A4r/6IA2O5jDX0YSg4Bk1qn8sEgaA+6UM9aYDHJfIN+8ff7gona
 PJFQ==
X-Gm-Message-State: APjAAAUL3kH/8KbWMXzz0fTsNw9I/qfXIHZF3HeqYzmOIFNA/jFWbyKo
 tevT3IiqKp7lXqX4g2NuJOHorFxhwpw=
X-Google-Smtp-Source: APXvYqynjAl53iqCp3mT0w2MscjoUI5NbND3SzWIGqcBZBguT2ymrAMFhj+etiQKuOJmGyzAHLeodQ==
X-Received: by 2002:a5d:4f91:: with SMTP id d17mr4087801wru.184.1572022978968; 
 Fri, 25 Oct 2019 10:02:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s10sm3770146wrr.5.2019.10.25.10.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 10:02:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9C0D01FF87;
 Fri, 25 Oct 2019 18:02:57 +0100 (BST)
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Keith Packard <keithp@keithp.com>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
In-reply-to: <87pnik4w9n.fsf@keithp.com>
Date: Fri, 25 Oct 2019 18:02:57 +0100
Message-ID: <87ftjglpvi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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


Keith Packard <keithp@keithp.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
<snip>
>> Please keep version history bellow --- so they get dropped when the
>> patch is applied.
>
> Sure, I'll edit the mail before sending. In my repo, I'm leaving the
> version history in git so I can keep track of it.

It's OK to keep the history in git, I do it all the time. But by using a
--- divider in your commit message the git-am tool will trim it off when
it gets applied from a mailing list. There is no need to manually edit
your patches as that would be error prone.

To pick a random example of what I mean from my tree:

  https://github.com/stsquad/qemu/commit/1b648ac695d45a4e4d72cf64a97346d969=
5b863b

--
Alex Benn=C3=A9e

