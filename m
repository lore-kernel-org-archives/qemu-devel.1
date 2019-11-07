Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B004EC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3D22187F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yptuVbBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3D22187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSfor-0007Zw-M4
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 06:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iSfny-00071O-Gv
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:18:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iSfnw-0002NM-0B
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:18:22 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:43264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iSfnu-0002Kv-7Q
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:18:18 -0500
Received: by mail-wr1-x42e.google.com with SMTP id n1so2525990wra.10
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 03:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=K7gjfPMjYg9jEet+wQlkfS4ORUZSEUVQA+OIQlXC0t8=;
 b=yptuVbBcc9g4SmTPSyiPTQ2+WOtE6DTNl3wx9prDHtpZPZikYq1sqSjlQE90QbN/d/
 82BGsSC/UKYpij+MpQYKx5dg96wb0b+SXG9oVH2d73o7PT9zc8kwZWpMUL/imQSNvtZo
 jLfDqMyROXpllmzcH0Jzc1g1WzQosg6U7gZJ3B2R3cAFI+YVXF3bSXjK4iWGsq6NUDlr
 YsXBig3xlNin8gEsIgL8fBShcE9OEPw5XKF5SOwPu5onYP7bF0+byXevJY+U9hrYB/Mc
 Qg1U2lXKqfn5wNgDHGYVNssLTb7s3/BifmBhpo/aJvFfTdWXMfpAIBet5d4NJtveEbCR
 uF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=K7gjfPMjYg9jEet+wQlkfS4ORUZSEUVQA+OIQlXC0t8=;
 b=bX5M7d0Rb6b1x7a1dfyiYDx6+zcHOTUx000dM2NU0B2cnzeSfnwjWTOS7gRKAFhzu3
 VNdR5uaji4wbKARiuneCWKKRFZyraxT8JJ5Fp57kPI49zEvJi9BniIu4abBdF0/UCQ7a
 XCKhWT4GKjpdkIqgS/E4/hGtE9oMwNDLzUJrJ46cj3Hv8Qq8YWKLZH1EEhHBvy563qWj
 Rqpyzqzixz9EfbVlOUlMWUihSdGIuvU5msC4aX77auL+BKKoHCsTp/53+hH99F4Ig6P/
 CECUAtNtnd+MeeAuHz8G78Rdnu92Zh8kw+mkM9Ci9p7MVNIkLIPJcOEya2i2+CYqccul
 /6Vw==
X-Gm-Message-State: APjAAAU9GdDDrK3wyMtbJrEq7hzmjyJC31KVFtVV/WZIknU6iulXYYtB
 1xCDsxMkfmRpWDGTFemjlkJQbBq+NzM=
X-Google-Smtp-Source: APXvYqyN0AiJ2tt7Xyt4zbFUsCZd4i9mrFsURZFns3WiqhxsTRdK/UOanHijFCBNornECJB5XmGEIA==
X-Received: by 2002:a5d:414a:: with SMTP id c10mr2498088wrq.100.1573125494634; 
 Thu, 07 Nov 2019 03:18:14 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j22sm2711638wrd.41.2019.11.07.03.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 03:18:13 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 60A391FF87;
 Thu,  7 Nov 2019 11:18:12 +0000 (GMT)
References: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: Looking for issues/features for my first contribution
In-reply-to: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
Date: Thu, 07 Nov 2019 11:18:12 +0000
Message-ID: <878soshr4b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Rajath Shashidhara <rajaths@cs.utexas.edu> writes:

> Hi all,
>
> I am a Computer Science graduate student at The University of Texas at
> Austin (UT, Austin). I am looking forward to contributing to qemu !
>
> This semester, I am taking a class in Virtualization
> (https://github.com/vijay03/cs378-f19) and contributing to a
> virtualization related open-source project is a significant part of
> the course.
> I would be interested in contributing a patchset to qemu - possibly a
> self-contained feature or a reasonably complex bug fix that can be
> completed in under a month's time. I did look at both the bugtracker
> and the QEMU Google Summer of Code 2019 page
> [https://wiki.qemu.org/Google_Summer_of_Code_2019] for ideas. However,
> I would be interested in hearing from the community and I would be
> delighted if somebody can be suggest a suitable project !

Ahh someone else looking at QEMU \o/

You might find some suggestions in the thread:

  Date: Sun, 3 Nov 2019 04:59:31 -0600
  Message-ID: <CAOyzTAivEpv1VXzPXVH3Za9Zcz1URFjnpFCZQrRB4K=3DZ-oy1Dw@mail.g=
mail.com>
  Subject: Feature Recommendations?

> I am an advanced C programmer with both professional and academic
> background in systems design & implementation - especially OS &
> Networks. Given my background, I feel fairly confident that I can
> pickup the QEMU codebase quickly.
>
> Eagerly looking forward to hearing from the community !

Expanding a device emulation could be doable. I'm not sure what the
current state of the Raspberry Pi emulations are but I don't think they
are complete as we keep having to fix bits as kernel drivers are
enabled. Phillipe (cc'd) might be able to give some pointers.

--
Alex Benn=C3=A9e

