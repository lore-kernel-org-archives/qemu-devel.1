Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297F9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DAA20760
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dsOtWhqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DAA20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLfj-0005uF-56
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLf3-00055g-7W
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:23:25 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLf1-00019O-1R
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:23:24 -0400
Received: by mail-ot1-x341.google.com with SMTP id h1so4494166otq.12
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=trPggD/qDTRvmUcKIiOePZptue9Ia1D5+lE2V2+b2X8=;
 b=dsOtWhqklzMhWw7NvzEb9qY+QuGXLA/y58PIrGUB1iURCrAN1z0eD+EX9bK8o3/ncH
 veSaOzKwizcyXf4FbAsHLz3+QY8QzG8yRpS5xCeuMv/Nseg4eM0TDaqCTwYOsOSmFGcT
 rQZDHH3gwvDnjtUJ27u6NozYK6uD6xhTUzuOxHIPHraJVW/So244VkFG/BmkCK4KWn7/
 mdIpf6Su+abziLDbSjqHndiczsJYqLCG+FKnuEJWH8gZcknSnwmdmMTBnViRpwNelnE4
 qlExrvn3j7O2szoZMqsblUbe+2NhPNWtXtGZrTQckUILzHzFE375OGo2X90jsRzz3KJN
 YUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=trPggD/qDTRvmUcKIiOePZptue9Ia1D5+lE2V2+b2X8=;
 b=JkMZNqPPcry558Yc+h6EvcMJuRvWVl2vuTqWpZeQQfl7J3CQC1YHsRbVgbZ9L1qXwC
 HBKV/idC9s6VFoWhvVras5EwV2gd2jf0/pOMTFeQchyVrvm4kTg06emYvr0lwvhThaQY
 JvJmQEoafokddvzl24P4ARJhJEl2ifHWNZGEb0ikNZtJy61WipqxxbsWU5eQMiVGW8hv
 roaZgKgtHhzjrP9QIbS3SWaUkK6d0BH8KxxXPcNqn7gW45nV/IU7gLiS/lJM91KL9EDp
 p+XllXqY3Q62MwBmaHXuldtvhmcxyTnWw0PplswWhs/qFl4ICzFR4Kp5sGHmeCIBW2l+
 oDlw==
X-Gm-Message-State: AOAM530K9AQtwHx2b6iu2wdIBRqvKfkCe7kpQTYeSOx7XNMl59WN9R05
 LaCwx8sAN4VXJcIzSVxWjHCdgGB10Dyst92N2aT2sw==
X-Google-Smtp-Source: ABdhPJyjXUYvYXpPNHxNUpWWPWcJyu2oj+R7s2flZqwFCSl8BygcV7huVhvqzqixsRHnHNdmKp45/HODxRj0JZEb7Fk=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr24467661otk.221.1593782601209; 
 Fri, 03 Jul 2020 06:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-10-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-10-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:23:10 +0100
Message-ID: <CAFEAcA_dhbr6cjK40H0=e39sD2r8ERTZYrY5nhJtx81Rk+RmUg@mail.gmail.com>
Subject: Re: [PATCH v7 09/17] hw/sd/sdcard: Special case the -ENOMEDIUM error
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 14:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> As we have no interest in the underlying block geometry,
> directly call blk_getlength(). We have to care about machines
> creating SD card with not drive attached (probably incorrect
> API use). Simply emit a warning when such Frankenstein cards
> of zero size are reset.

Which machines create SD cards without a backing block device?

I have a feeling that also the monitor "change" and "eject"
commands can remove the backing block device from the SD card
object.

thanks
-- PMM

