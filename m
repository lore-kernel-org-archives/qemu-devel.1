Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F98C48BD6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 852B720883
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxCRXwTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852B720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34436 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfpp9-0005Yd-EY
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 14:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44079)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hfplL-0003Jj-2N
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hfplJ-0002AY-UR
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:01:47 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hfplJ-00026y-MS
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:01:45 -0400
Received: by mail-ot1-x344.google.com with SMTP id x21so18141880otq.12
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 11:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=ZCzgZuXiuagsQx3N9QOBXANRGGUc5NWcmOB3kdIWjcU=;
 b=JxCRXwTHL8RMvN0wUpFB13aagxJmMTmRgmT1tvt5JOlyBkfxAYSkwMd0jbTlosweoJ
 LOQnE0bA89ApYz9rbD7DMV8XFMAfnWFxmEQlbgOJSeDtfebjq6UBfASCR68n8Fn8IKBC
 cEwCyZ5+qeF5hJE3468UHSFbDgE8xv25R0KHhGKeJP6b3ajV5LOXg+ioKGKHKj1tACBA
 oXSBGsUB1G/R/TekglZm/8QdKRf8yrxbWTGx7xfQ0O4G7Nc6ojHEHfJFZbsmkMetv+Qo
 BNlogLd4MU9nIJBJTyx87zdFFj4uCJbV+wPPxpsCAIdMTCqmVtqZ+7YhIEoJxy+A9ErA
 mW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=ZCzgZuXiuagsQx3N9QOBXANRGGUc5NWcmOB3kdIWjcU=;
 b=LShiKuNnCQUnZQio08R5OiDe6Bc+zYZmYt5KYmfDeWv2QfwABLFvqSPoZPLJSNn3z6
 ZV67xavjQh89eJBZb/lvcy/oOXI/04/lYm8mLEsowInS72KHg6JPFXZPb40uvdHBMkR2
 VD4QinWEVykq6BJ6M6GTisawb8xmGYs2eTF/YQ7RX1g7XnynR5lcRE4E4mEq8g+7+Anm
 JOXbJvpHMDkJTCTO4/e3GQn+ICWDWEwIu9149+odmlyTKzhQ17xAGX2HwJeUOH3+bXuZ
 ZIYcTsVFSeA9KrIkfPsfwHspdIQWGcZYsDOvtVtQECsuUMwOYYxB+unvLLJhSMWL1cre
 Et0g==
X-Gm-Message-State: APjAAAV2NRtxEkJjwfnxzWsCDhC8mYyFYP5EoRtNazS8ph8IAFuiWjhn
 /WnU2Pv2TdnwBZfLjAKVeVc5LeZYPpm1n4RcBUA=
X-Google-Smtp-Source: APXvYqx+yGtZXYyfk+NgLJGqX9pYmJbKQ7gESIgXAKitQcUwfmlCnnGMf6iuo3j+ceHnjnBjBtNfcoF8BoK3EzBDawI=
X-Received: by 2002:a05:6830:11d4:: with SMTP id
 v20mr20174969otq.121.1561485700297; 
 Tue, 25 Jun 2019 11:01:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Tue, 25 Jun 2019 11:01:39
 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Tue, 25 Jun 2019 11:01:39
 -0700 (PDT)
In-Reply-To: <b8aab3f4-e3eb-a137-62b4-ba5ac1a2ad8f@ilande.co.uk>
References: <20190519041522.12327-1-richard.henderson@linaro.org>
 <8f28d008-2608-a579-7505-4546b08deb41@linaro.org>
 <085d6881-f518-9888-a13e-081cdc09de46@ilande.co.uk>
 <0b9f4772-37f6-1453-e4ea-5ad9d0f52a5b@ilande.co.uk>
 <acc57487-c8a0-9380-bc2a-4de22541eabf@ilande.co.uk>
 <CAL1e-=iavFqEeFuNm2efVM7mu5OaABBVo90wqJEhmoWa4DQv=Q@mail.gmail.com>
 <ffae3651-5daf-e008-6562-2de09d82ace9@linaro.org>
 <b8aab3f4-e3eb-a137-62b4-ba5ac1a2ad8f@ilande.co.uk>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 25 Jun 2019 20:01:39 +0200
Message-ID: <CAL1e-=gupur20rK79TSqAZ1NwavDSvL+QcwzF4idg=+of_b0Hg@mail.gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v4 0/7] tcg/ppc: Add vector opcodes
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 25, 2019 5:42 PM, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>
wrote:

>
> The problem is that in tcg/tcg-op.h we define "DEF(dup2_vec, 1, 2, 0,
IMPLVEC |
> IMPL(TCG_TARGET_REG_BITS =3D=3D 32))" and in the last patchset dup2_vec i=
sn't
introduced
> until towards the end. Unfortunately it's not a simple as bringing the
patch forward
> within the series to maintain bisectability because the current
implementation
> depends on VMRG which only appears in the patch just before it...
>

My strong impression is that VMRG,  VSPLT, VSLDOI, ... opcodes and basic
logic could have been defined very early in the series. (They all just
support other TCG vector operations. Their functionalty just helps achieve
other, exposed, backend functionalities.) That would reduce patch
dependencies and  allow =E2=80=9Cpatch mobility=E2=80=9D within the rest of=
 the series.

However, I am not positive at all that would solve the problem at hand.

Aleksandar
