Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255C4C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE4A2075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5Bd/s3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE4A2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRf99-0008NE-Vh
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 12:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRf7x-0006IM-61
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRf6q-0004ya-FI
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:54:00 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jRf6p-0004y2-U2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:53:56 -0400
Received: by mail-ot1-x342.google.com with SMTP id g19so7241012otk.5
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 09:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dtBSQxjwFqFI0MaxLVnMkfDcettJ4P4UbXRA41Rtpmo=;
 b=Q5Bd/s3GWvHzMlBhFaC6nOvg+QTy4zkvnD9zKGxdSQLQ5c2mDV0lWs/byVbr8wiyA5
 o1q/qIM7IZDbwiRjRBb4voyTXFpHg+QL6foVI0ASN41f17c3X5fGKE+QI9rblJnaunrf
 FJnPEm7UAxk9fumSGf97D1TaN1Zn1rHispFdzaPEPL4KJ+F0jNDkuPEm8uGIZPmu+tbF
 jfD/sZ5RYXVEANXUUaYJdQkIaRtNEZTNgmHWhtbqEuPm1SsjlIGlIyfE00GQ6CLpD8np
 wibCH/pguEmFF2nob+3F1yxUo31xhBKH1DK7sJUnrA39aJ3d/UNtf75p0DvkD9DZpa/0
 Y1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dtBSQxjwFqFI0MaxLVnMkfDcettJ4P4UbXRA41Rtpmo=;
 b=WRdvpMDh5XLMMCtNBVcSNiPla+IW1iZBYXSrDCQ6pCcIGl47+BLEx/RMIFkF+uWLBX
 cmYP2XH20BYpcvvYbr2jFDbvad7ypt7uXKdr75aeU+VgGkWYBoN/9xR6/jXjXNuWmpEz
 aTXIKI6UucTEjfmhlBO0WqKxJ60zAQCXa6YHkn9ygpdXx4dtt/f60X4+2BvWGPlA1moN
 EHPLAXjS3kWDtpCKLROxplt0OCpHSNJNW7emy4t4tlmWGZvbsoWe8QVHdq7nocQDMo50
 fcTeF0AVzov2Irzjy4jp/m0y92oPLLmwS4NPgOHa2Txr+hfL04uuVmYW0SxKF93IEgnZ
 ppdQ==
X-Gm-Message-State: AGi0PuaIjMwaEWl/TtH3cpNZNTg0t/oG/ReUYrtjKgRXtfEqEKVs1z+w
 xzwhKTjDq/3E7qEXA7fJl4yJ9M4a4fUKC4RiJ1ezmw==
X-Google-Smtp-Source: APiQypIli4NGUgQsOT+6g73kT2MpSOlIQdY+L58A+VienvTIV77PiG6H8yqV38Unecq8xNGHfLog+gYGcyVFB3zFjyE=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr4143012otj.91.1587660834548; 
 Thu, 23 Apr 2020 09:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJhHMCAcA2CMEbV+DcOjM_LhJ4KSob=F2=hrDT0zwrMZ7Wj=oA@mail.gmail.com>
In-Reply-To: <CAJhHMCAcA2CMEbV+DcOjM_LhJ4KSob=F2=hrDT0zwrMZ7Wj=oA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Apr 2020 17:53:43 +0100
Message-ID: <CAFEAcA-3iBYNxC=ZqsAG6je90w=pcCa8=HjBxM+rVSjsMwEpJw@mail.gmail.com>
Subject: Re: Warnings with GCC 9.3
To: Pranith Kumar <bobby.prani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Apr 2020 at 17:19, Pranith Kumar <bobby.prani@gmail.com> wrote:
>
> Hello,
>
> I keep seeing these warnings on the latest master with GCC 9.3:
>
> /home/pranith/qemu/hw/block/pflash_cfi01.c: In function =E2=80=98pflash_m=
em_read_with_attrs=E2=80=99:
> /home/pranith/qemu/hw/block/pflash_cfi01.c:667:20: note: parameter passin=
g for argument of type =E2=80=98MemTxAttrs=E2=80=99 {aka =E2=80=98struct Me=
mTxAttrs=E2=80=99} changed in GCC 9.1
>   667 | static MemTxResult pflash_mem_read_with_attrs(void *opaque, hwadd=
r addr, uint64_t *value,
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Are there any patches in queue to fix this before the release?

No. This bug report is at least a week too late for a fix to
get into the 5.0 release... (but it's not too critical,
because releases always disable the -Werror flag, so they
don't make the build fail).

thanks
-- PMM

