Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CD7C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A212146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgWVLxOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A212146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iChH3-0003Dg-Sc
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 05:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iChFu-0002LQ-0u
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iChFs-0008AU-G9
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:37:09 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42347)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iChFs-0008AP-AS
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:37:08 -0400
Received: by mail-ot1-x344.google.com with SMTP id c10so875691otd.9
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 02:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j6ljvtPLA42uZWyboGvieEJKtnNxN6pEL4wxfndceg0=;
 b=PgWVLxOFLYWDsRXszkryibvAeeqRauEk3muaAW7wtfBI1l8QBv43d8Y3H7UoPjL5q/
 CjHz7hXj5eyxsoBCJXvZsMnrJzmHx4w4zYY/0cnwul673Gujt8K2pQV+GV4rPR8ejdrw
 BqCUt/7pWwliUrCQRJmOH7LTNPlZ1s4fOFegCpXLymXDMAtNhzQES1XA+Pj7FPOslDHG
 MwyqfAVAzf8QHtp1IWjL8RhEFo30zj5f5S6C7KVN7QdzP9kGEvx/fD+k3YvW8fD1jadf
 zmufVGyGOQVosOLO0SA90+jf+xwebj3iX1WTTzD316BWAlpKhvEux2Ab7vMwvy094GPR
 WrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j6ljvtPLA42uZWyboGvieEJKtnNxN6pEL4wxfndceg0=;
 b=L/DSF1EUetUO9GBL5qJvqV/Na2NUxD6B2eprPLcpA0jSkpB+0YdBM3h8gKOCygljph
 XUCBH+YQugGkCmDlQA847v497i+n7TnPzrbYVAHCh38O81jxtARlODCOIl9CcdiBJE8a
 VSIiEyXfYzb1OMrIxGxmralTzyhrPAoJFjtFbqaLk6yve7ZMognhGVR8VJ2gDKDhSGmi
 hOGOHinmptQpUtV0jn+NBlX/qG7CVOxa0tAjixs4hbwjIqcRK57iNLW1mwPLPb+PAD5D
 Hh1jUrmLN52p9aSdQrEA+hxbypwLu+PN9BA41s9gUGk1e3qddMQWERBuJdz5SYgKEwMV
 ZaXg==
X-Gm-Message-State: APjAAAXLhegOyx/xR0HZdrYIPF5BXkPIPvyEPHO9TO1Tq/HnAhBQYT+j
 AeknIZ3cxsxFXow4Jivz0ymTj1rLJnkYsvzA0t6K3Q==
X-Google-Smtp-Source: APXvYqxgXkKMo6R0Adi4XojUYmOBkBOfcwJpfSPK/ceS+50Gk75Db8A4a4rV7sMMssMZFaV+Z9AUaTMS32IGxqHGoCk=
X-Received: by 2002:a9d:562:: with SMTP id 89mr1118343otw.232.1569317827214;
 Tue, 24 Sep 2019 02:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_28AAA62B694825C348B1DF49@qq.com>
 <CAFEAcA8+bK0UyUWbXOiutyQZkCMSB_0Be7pJLKONSpA3CV9Pbw@mail.gmail.com>
 <tencent_0084E0586ADE9B2D30176A53@qq.com>
In-Reply-To: <tencent_0084E0586ADE9B2D30176A53@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Sep 2019 10:36:55 +0100
Message-ID: <CAFEAcA_Jadb7A1588uWwmURz1N2G5ycsLcA+3N2Rb+NqyynPRQ@mail.gmail.com>
Subject: Re: illegal hardware instruction during MIPS-I ELF linux useremulation
To: Libo Zhou <zhlb29@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Philippe Mathieu-Daud <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 at 02:10, Libo Zhou <zhlb29@foxmail.com> wrote:
>
> > Can you run QEMU with some debugging options:
>
> > qemu-mipsel -d in_asm,exec,cpu,unimp,guest_errors,nochain -D debug.log
> > -singlestep test
>
> > and then put the resulting debug.log somewhere we can get it?
> > (it'll probably be quite large)
>
> The logging only shows this little information. It seems like only -d cpu works for a short while.

> ----------------
> IN: main
> 0x00400094:  dmult.g    zero,sp,s8

I think "dmult.g" is an instruction specific to the Loongson CPU; it
is not in MIPS-I or even any of the other standard MIPS instruction
sets, which is why the default CPU for qemu-mipsel doesn't accept it
and is generating the SIGILL.

Something odd is going on here, because this doesn't seem to match
the disassembly of the test binary that you gave previously.

thanks
-- PMM

