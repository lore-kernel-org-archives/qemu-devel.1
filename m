Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDE3C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87192067D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK3EnXWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87192067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXs3G-0007Sx-PU
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 14:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXs0K-0004bL-Mo
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:20:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXs0I-0004k0-DW
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:20:36 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43860)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iXs0H-0004ik-2c
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:20:33 -0500
Received: by mail-oi1-x241.google.com with SMTP id l20so4229619oie.10
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 11:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0EEGnDlzhsbheFPeAzao0w0UzUeYQock5nVdELCq/Qo=;
 b=iK3EnXWZsyka06UURmikVMwsI7FxYWCXSqdWDNLsFZXp84QAa2KjgG/OeoQLry++iC
 7K/T6Kml8XP2Q9sOi7eZGbMGH04lBuyElA6AMU3nvSTJoTZatGc51bhn2OflAPTfzASs
 IqN4xHFLI/+tS/WmjEutCjvpoQfwXc42X5uPrRfSPjBeOzyY4NrNUWUSizjX2VTEVC8k
 wZEkYXobEUBi+3zq3EA62LHvlsIDeH3KWyTNtE6ALuAEuQ2KtHyOUQaYoKkIvFqTz4T0
 Ko+y1iq5txOKsfqr25Id5YNRRNVuKW5uaCddd6LvNkuMgclZBgbQQqDw6nJE8Jadooup
 6W9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0EEGnDlzhsbheFPeAzao0w0UzUeYQock5nVdELCq/Qo=;
 b=bwMErCRMdrXFJTjLJcw6kyRcMQtXvI3WvV0KP/TM24KA1eUd8005P9fp99+3/HkDI+
 LJuhLxv02gXHwYxC88FuEvO4tZBN39TskySszEDkKoBgv5Y6hl8Py9dropXq/RONaAT1
 Fc1N5nXIdywFicgJ3QnAvUaNRuGGpaWGur51atihTh7j0BdYCtvi/lJ1hVAJQlaK4g1O
 dnK5X58ds/gynnzmFdLH4Gqeg9ca9FAV9d+Z2cABf2bpQ7gKIGCZ8Yeg/NI6vKFPmYKC
 tHXwKq4oFrUdC9gTc8hT5nA6kG7/3yODdNOqeN8qEphnSjukC9n3e//5swAWVICa8R4T
 0PmQ==
X-Gm-Message-State: APjAAAW4iTk7b/HBuImnkzc0LbWQQXUO35LvzqgG/91vpfJiO8JmWIXh
 XnSihe45RqbJwwKh84y18VWdeSt76Dn+PrePQB0=
X-Google-Smtp-Source: APXvYqyzc6jysiov1uMIQBdpBmhR8nHToPy3xoduVxRZMQ5jZ7597XWnGY9RMsh8D/LZQzNad7F2Ra/qoesT5rQD0I4=
X-Received: by 2002:aca:670b:: with SMTP id z11mr8627751oix.79.1574364032265; 
 Thu, 21 Nov 2019 11:20:32 -0800 (PST)
MIME-Version: 1.0
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
In-Reply-To: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 21 Nov 2019 20:20:20 +0100
Message-ID: <CAL1e-=gFBMPj938nrPYjvkOPuMQZTEP9OFiitwLLjekgCxRaKA@mail.gmail.com>
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
To: Taylor Simpson <tsimpson@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>  create mode 100644 target/hexagon/imported/global_types.h
>  create mode 100644 target/hexagon/imported/iss_ver_registers.h
>  create mode 100644 target/hexagon/imported/max.h
>  create mode 100644 target/hexagon/imported/regs.h

Taylor, if I understood you well, these files don't confirm to QEMU
coding standard, because they are imported. But, from where? And what
is the reason they need to be imported (and not created independently
by you or somebody else, but within QEMU code style guidelines) ?
Their content looks fairly simple to me.

Thanks,
Aleksandar

