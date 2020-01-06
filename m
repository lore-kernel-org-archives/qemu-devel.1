Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B311AC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E91C2075A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fqmO9WFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E91C2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUQO-0001wf-Gg
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioUKU-0002I7-D3
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioUKS-0002VZ-VK
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:30:05 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:43137)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioUKS-0002Ui-Nw
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:30:04 -0500
Received: by mail-ot1-x32e.google.com with SMTP id p8so35721032oth.10
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 07:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=eJzpmfiDU8qbCGTrOBnyWh03X2qcKiBYVulVqk2pa68=;
 b=fqmO9WFZaSU7RLctGJwTZvgq6sWwC55o7O1h9/pJ2xbxqNZQP1V13+zzHTCqS3m+GK
 F+QeRqBRsaaugH/BQWxsWJWg6bRRK5bn9hUedPrUGO9ZV/iImBjc0CjWq83Dr0mQ+3bK
 EaiY4SygrLk8//bAM28VzCtOefWau4DHUWpe6URAiP8RwNIikqYiS7T+o/JvFVlYGk5b
 Bi4WllwzKsKryFd3dhO5o9H7d2pFH/HpoLeeJOYMaE/MZMcxtG6sxnpm8LqfPhf6Anas
 IguzD4VsCACtj/JmTeo2k/QNK604/gUZKzHGNjtU2O22cfYn4B41LJwpeoDcFhpQONGK
 Gqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=eJzpmfiDU8qbCGTrOBnyWh03X2qcKiBYVulVqk2pa68=;
 b=ULTvMKiIufi2Qer38ItDmoGim61APnUj4jzJq4QuOtomWfdQ/PvdGnHhNYhk4qX9vZ
 1OUjhFfvx706OGDjQUqS6wxojlpOeT3+B13UX2UCH6eIPWtdDN1CnAQYqDausVRNijiE
 pHI4HjFKHdjX2kUfNe2JtO8IV7Y4HmdcXYXUVKMvNicW/qlYtJmgbg2UK0QzVd3LGbLQ
 3xQfm+JDZLLvpOSsSWjS0zZvhw9osbG0GEAbogmKVKWFt/4DOHmPGbsb9/dRoH0+fYLC
 5pRaiCRyvlcZCoXBO5+4kcU5yhNgK6iSIt7nnozHlONFvuskTWOsolqyq/9YULh/42uz
 LtqA==
X-Gm-Message-State: APjAAAVx+SaPo2267sqnF5+kp5tdMSaw80IB81rfRsD1x0mVKv13yARl
 EN1uakX7GPEy4D4Yk1dG+GV9Q85hga2L/a/7EaCdFFjT4EQ=
X-Google-Smtp-Source: APXvYqyRfiCtpf+SwFs4wjNwOI03xO2bqCppflH3Jir7AlgSGGbYM1tjxvtV8JdifGs8S8dcCD7h8ks2pl3ONLYBhg4=
X-Received: by 2002:a9d:8cb:: with SMTP id 69mr96821143otf.221.1578324603311; 
 Mon, 06 Jan 2020 07:30:03 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 15:29:52 +0000
Message-ID: <CAFEAcA-HPAXpeWcJOvyJM3hdFR86u4HyovAAB8qmoZaye-P3Vg@mail.gmail.com>
Subject: 5.0 release schedule proposal
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here's a suggested set of dates for the 5.0 release:

2020-03-17 softfreeze
2020-03-24 hardfreeze/rc0
2020-03-31 rc1
2020-04-07 rc2
2020-04-14 rc3
2020-04-21 release, or rc4
2020-04-28 release if we needed rc4

(I'm at a conference week of 23-27 March, so possibly rc0
might get a little delayed if I'm not able to handle
pullreqs while away, but usually the big rush is for
softfreeze so I think this should be OK.)

NB: Easter is 10th-13th April, so between rc2 and rc3.

Any opinions/suggested tweaks/etc?

Of course if somebody else wants to do this release cycle
they can set the dates :-)

thanks
-- PMM

