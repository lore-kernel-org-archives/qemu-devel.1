Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361B0C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062242082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YBJOkFya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062242082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6B6D-0004sD-6x
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 06:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i6B5I-0004Ql-PV
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i6B5H-0000LZ-9I
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:03:16 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45605)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i6B5H-0000LN-1h
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:03:15 -0400
Received: by mail-ot1-x342.google.com with SMTP id 41so1402104oti.12
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 03:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2YapL5VDuz7Vd3BxxuvOuiZc+9cI0DhXmCDbtX68ZI4=;
 b=YBJOkFyavVGOHTG/8kVAAX6fWtghUWYj8uvncL97prhyF4BBxq3QTHqmwseOetkuul
 z3SiiRnNRMQbDMHhJNX1gyeak76vIrfv0Ap+AeXt+/LjRGaVY/ybHMyKrQbDcamdTss0
 dp0GhqG1oIW0pEN6Fx9GiM8BOdAaVsGX/jNGe06cW7vIU8G4+7Wf6eHTCNGHTGHWgok6
 gFEuJwkbvffsJFl1OVWLKXsSDSdQqPsrpbj2zHk/x1GQ3YKhyLjKgbZjdHZ//mX4HXIb
 b8jC0PtalnLUf6RGcB+hB74uqWTGfI4FDJOSQoYvnMPRarGkzEcY+vT2JckB/PsS/PTr
 O95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2YapL5VDuz7Vd3BxxuvOuiZc+9cI0DhXmCDbtX68ZI4=;
 b=awG+QSYoA4cD98E+TEiXvpXTENNaoqVS480NHkIS4PSh1xQFIR+MZb4wmxr5hzFx7Y
 1k+1WrMSbQTqsJ2c4rY1Hil9ZOaxlSHOPKxRomaskiV/+WWSrPLTYTnX/YWelaz7QXVf
 xMSHLgKJoYx5KzGt2Qk+m+3OL2zpdwOad5euAUaNy1s5chq1wF4bd3rzBn+YT/7Frfvp
 e4Isb3MP0XyAf5fc9yomGDxDxV+BIgOPvMv2xK5cIzLsI60ZenH7n5kevS8DXDIUl6uD
 t6oYn2qf/Z+s/VGU6hOiuGDMRviFyuwe6qNk2kBiT2cJ4c47ejuYJ6850zXyFFP75I1F
 y6jw==
X-Gm-Message-State: APjAAAWHr9K0IeEAbebrbHeHZUl3YXRa67R2HS6svl13bxOCx3waPODT
 pDRoK0K9xSWrmsgJvZNwXvGbk10LqHsphxrx3Dh53g==
X-Google-Smtp-Source: APXvYqzWS7dZEbiONKVTQqkysoyUUcNeduzUCFrhtjU6z8tLgIUjMzTL57xoRiAz8cD4+YpFlb/GFlsdBDfeJqSZIII=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr6654196oti.91.1567764193761; 
 Fri, 06 Sep 2019 03:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190904112108.2341-1-alex.bennee@linaro.org>
In-Reply-To: <20190904112108.2341-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2019 11:03:02 +0100
Message-ID: <CAFEAcA9gr-vf4VP0oBnHjBwRb1vbD=hE-K7kuzQZjOLH_=TECQ@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 0/5] fixed up semihosting fixups
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Sep 2019 at 12:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Hi Peter,
>
> Here is version 2 of the ARM semi-hosting cleanup patches. The re-base
> had failed due to a change in the gen_exception_internal_insn API
> which now takes the PC instead of offset from pc_next. There is also
> the a minor indentation fix.

Hi -- I'm afraid you'll need to rebase this again, as Richard's
decodetree refactoring has now landed.

thanks
-- PMM

