Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80182C3F2CE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B36A20738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ynLohNLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B36A20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEDTK-0002hm-Fv
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEDSX-0002DR-Sz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEDSW-0001Mb-CM
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:44:45 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:40120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEDSW-00015Y-2X
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:44:44 -0400
Received: by mail-oi1-x235.google.com with SMTP id y71so21958712oia.7
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PSN+0SfFb8GYH8B8kGxk/LZsYeQek/byfvHO1qknS8Y=;
 b=ynLohNLzzXkgaI7j2JKqhAdMcQuQc93L1+qQkT6jJ15utvMbKmwNH/1aJ+A9IosKik
 ur2BmtVDTDmA89LU2suas6z4TrKlHtyczUilEi1KiIdSqH5dwtUpepd6rbc/nKor0Fef
 i323UrfPwZ+ff6/eguRSKxFpagySgo74ZomMgIu2PdQGDn43o8Q8BlNpoN4zQ6NsPiCZ
 evOvI3Ot+kySj34FJoWAt5lwE/kqAek0q/82xYEEabjrQaU0kOWBHNjnAIyJ2jZHpwj7
 2enlDk/tNdhaxJ8jVxFx4CzP8AJT7igD/+pWTFKf7hNJLxiUx3ytBFKva4MUSMksFuKo
 h/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PSN+0SfFb8GYH8B8kGxk/LZsYeQek/byfvHO1qknS8Y=;
 b=ue6+4gB4dxClsB/ZEpYANxmAnh+XB/bL0Q/e0vy6CsbIwJ6y1lld6Pjo9fi3RMcd4A
 6+aaOuO1NtWxGj+m5y0DZVucKaFBwSGMMNklmNa8rkeVgItRtlN2L4vrvVebrOrNXhI7
 GphaSZgmC5sYvVcF2hXIBpDQwYJ4+tekm4FYgAuDx+LYgFrlwQEbFcERO2pnnN/ONBVD
 MYWaeShi3yqRDh9GuHghgPHW72ZWV0ZnTF+FH7tjTcROGTdKo3ZtGaXHQoRoF5rIrJmi
 FCcCtDaHmJ0QF/5gjWa8719KNWLmVGoddOUeMN91kWBs5ZMPO5YTKUqQE0OgGKjpnNfF
 qZsQ==
X-Gm-Message-State: ANhLgQ2kRRbJJVb74uolGvEHYsqw0g9IoXxggvVWk/X63MOsnzRsbzxI
 bv/n5wZPo6J7zlyNR1MpfmyHjDXzQkEt++SLOyWvnA==
X-Google-Smtp-Source: ADFU+vvfQY4Ngg89WIGF06NmoKKdy2fyi3xRnu5RaspBuj71MA/oDWV9nEx6UUH01vDjfk8OHmvyqbpn+/Od1cHGKc0=
X-Received: by 2002:aca:c695:: with SMTP id w143mr3864890oif.98.1584456282115; 
 Tue, 17 Mar 2020 07:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200317095049.28486-1-kraxel@redhat.com>
In-Reply-To: <20200317095049.28486-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2020 14:44:30 +0000
Message-ID: <CAFEAcA8gQy_sDbFmLZv+aBi4zFugj6Z13UkJKa0wSvXWDjRiEg@mail.gmail.com>
Subject: Re: [PULL 0/4] Usb 20200317 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 at 09:52, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 61c265f0660ee476985808c8aa7915617c44fd53:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20200313a' into staging (2020-03-13 10:33:04 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20200317-pull-request
>
> for you to fetch changes up to 647ee9877272d4359659e2595262db0e062c8ffc:
>
>   usb-serial: Fix timeout closing the device (2020-03-17 09:05:34 +0100)
>
> ----------------------------------------------------------------
> usb: bugfixes for usb-serial @ xhci.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

