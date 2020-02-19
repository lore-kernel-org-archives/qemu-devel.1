Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C02BC3405F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E96924656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/j7tVq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E96924656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Tbu-00051e-BM
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 12:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4TbF-0004S3-D4
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:57:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4TbE-0000f0-Bx
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:57:29 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4TbE-0000dP-7O
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:57:28 -0500
Received: by mail-oi1-x244.google.com with SMTP id i1so24642440oie.8
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 09:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=179mJDX+ROuLeeYryL3XXiDQwgJ/Ycc+79IUaFBk2Rw=;
 b=F/j7tVq1O9/NkUp8WcbX5WzZ4poGZowMCJp6Jzmh9PkyYNRqMQjvHmWNI3XPbL2alq
 vp3Fbk3/gzovOQmTui60ypKTj+VOuczL/M9lp5YK+zNYQEe3DPTpgv4llshdfvtr8WB6
 qcsan2YFHMVowLh6i9nJCEhjDSPbxPyt8o/ng3rYATqopdnpbxiyzYFKA7FgKbud0pSn
 pR2b4xZSvWNiLk2Y9fzE9QGoeSYYaCGi6vPrsCuMcg2IKOwXceJ5DzDEcdGagOcyCUS9
 aBuJfzLt33fcu0hDeu27BxvBNHWwUbMDa1nLrNHBj65y4EnkQLAH/pdtCmM3IpEk9RGi
 jXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=179mJDX+ROuLeeYryL3XXiDQwgJ/Ycc+79IUaFBk2Rw=;
 b=MTDce2H2vLv2Jq9puy/mzRZUVdGhdPI9j6dM4LqJFB/e/1N2alnyAODMAFcL9q0gcF
 tIWIvpKGP2eX/11rZVXPupKulXZvaJYr1bXxJnE4sL55v7WFCfeFOcbs0l7KbrvlU3BO
 wQJZy6W0BvU0ycE5ES5D7sOvzYk28nPBAnpEXZtnihd0QupKYLDQSe4M/Q+56B5aePxF
 QzncxKxXv/tTbOXZBwZPoQIF0DhP8chTXtwxI2fOuc8F2nfMfd55cEaf5dGkLSqy+wzl
 Tgw2opTD38Rd/ASkHzvWm5jwHqNelm4q8QNzKcGppI+WnVPMt2POx58L+xJi9rcPBJOn
 K99A==
X-Gm-Message-State: APjAAAVkC7XySctV3iVARzckCmEW92j25Dyw4IsQc4s878FtKjp8/dEV
 5eS7qer4jmjBxG7OBbxEhWmKFfhQRQZTZIvaaOZsKQ==
X-Google-Smtp-Source: APXvYqyWV+rthEPbCbfkLE7vANntea/xfS9xcbm6NNnJEdv3xYoTZjdWMewbtJXhtiphAJS1YpjJoLDjzHVIh2P00Do=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr5478143oif.163.1582135047182; 
 Wed, 19 Feb 2020 09:57:27 -0800 (PST)
MIME-Version: 1.0
References: <20200219114607.1855-1-kchamart@redhat.com>
 <20200219114607.1855-2-kchamart@redhat.com>
 <CAFEAcA94A3doGQthOTrPuMadOfqrSLBadUbi+3BpHr1MGp_w1A@mail.gmail.com>
 <20200219164007.GC24572@paraplu>
In-Reply-To: <20200219164007.GC24572@paraplu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Feb 2020 17:57:16 +0000
Message-ID: <CAFEAcA_M3s7U_Brx4iZcWKbrNesn5z33C2Cz+jr1PxCNGTvaXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs: Convert qemu-cpu-models.texi to rST
To: Kashyap Chamarthy <kchamart@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Feb 2020 at 16:40, Kashyap Chamarthy <kchamart@redhat.com> wrote:
> Peter, how are you able to generate those *.7 `nroff` man pages?  When I
> do 'make sphinxbuild' from my build dir ($HOME/buld/qemu), I only see:

Just run 'make'. As with the existing texinfo manpages, there
is no specific makefile target for "build the manpages and
nothing else".

thanks
-- PMM

