Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E231FC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6000B2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQxdX7/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6000B2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52128 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbnJC-0006lB-Tn
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34083)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbnEO-0004Vz-8x
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbnEM-00021Q-8t
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:31:04 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37095)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbnEL-0001sA-TP
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:31:02 -0400
Received: by mail-ot1-x343.google.com with SMTP id s20so2835037otp.4
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jzi1WzBywV7Ksk/jL1LGuopLvP6VTSwpRc+Q7NFGC+I=;
 b=jQxdX7/aYvpuPIyOXjdDnu8zlv0ph0PZeWI1v/V4r98IsApEA1IRvaVWrf5GZeYsac
 6bUJzBAGRvIwv4h42eybLdmaoOCHAU3LTzUBU1GqzY9gl5FMx3efk5W9dfjup2YMn957
 8Lo5K4yS1VVx0xN3wA0R8eFozG1yLDoGSjxztJD0ET6AZdfgMNlg69BtyhLzFMsD1f++
 OqzIQ/O2EmDm6Q2ITyWRqxYXtES7Nm5UXHRIK/WOZinH/m2nhVJiaoFUjg8VIhA6ATiZ
 +EePnQh9ziEXAyI9ZzuqHBYOPj5BvPSizPislP2FdAhjqf3GKIfWpbGWdeKjy3EPU/i9
 ZgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jzi1WzBywV7Ksk/jL1LGuopLvP6VTSwpRc+Q7NFGC+I=;
 b=tKMxYY4JGyCbMrCk0hJDzSh2nc0Myn/D06+BRC+oq0YIH07/XCjJeAqctnHlNkc/QN
 Y4Ks5CDA8qcyDfIpHhOd6KoBZo1aVuxvtOwclR52Vq4IBWo2NLFG65PdyQQ2zknj117e
 jJCtSJkXVe62eTuAPg+4eLPdC5f7wO4OK+KTF+hp71X8z7LfHvMslPZ8xo6szsobypQM
 Bq8YW20ywxGcQewZQjPpckesEiwDiwe6XU1WTMK3yWOT2Z2WI3ILpHFl3wtY8hHiLkFZ
 1eMm5Mmsd2k0QsBP55vN7ROD0EAa1kGHRw7X/mDJ1FRwL0TRZvnMQx7IoaqGDpQ1Jj3d
 t0/A==
X-Gm-Message-State: APjAAAUFpnL4MAXwFwfC+Muxkk8bVkf7Bd4B/t/hoNABfYJar18O2gmr
 QjTXs/maspTWhOshSUKYFKgJDyyaqazFmWkim2XSBg==
X-Google-Smtp-Source: APXvYqzbae1ON33fVGKRoyvh1f4krjDKHYVu44oK6GDktHYfWWnkZIRRm97hyGDM0suFEu5wwE69VgYUPyg51hKdVLc=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr6359254otn.135.1560522647592; 
 Fri, 14 Jun 2019 07:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190614072432.820-1-philmd@redhat.com>
 <CAFEAcA9zEKePcOHK6WMqAitf282EWh5LUYRqZ3oAJ_W1wPsohw@mail.gmail.com>
 <8736kce0b2.fsf@zen.linaroharston>
In-Reply-To: <8736kce0b2.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jun 2019 15:30:36 +0100
Message-ID: <CAFEAcA8Uw8QNMa8EFzsjNzADdUAmkiYtXi04GN7+M-9w+eLSkA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 0/6] configure: Try to fix --static linking
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 integration@gluster.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?B?TG/Dr2MgTWluaWVy?= <loic.minier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Bharata B Rao <bharata@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Jun 2019 at 14:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:

> It would be nice to have a --static-user config flag and deprecate the
> --static flag. I don't think there is a decent use case for system
> emulation targets.

It would be really tricky to build half with static and half
without: our configure and build system really assumes that
fundamental stuff like "what libraries" and "what compiler flags"
are the same across the whole of the build.

Is --static-user really much better than:
 * allow --static --disable-system --disable-tools
 * forbid --static without --disable-system --disable-tools
 * require users to build the static usermode binaries separately
   from the system/tools build

(which is in practice what we have now) ?

Debian wants both static usermode and non-static usermode
binaries, so they'd still need to build multiple times anyway.

thanks
-- PMM

