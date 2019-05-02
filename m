Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF663C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 13:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741522063F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 13:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qhq3fOT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741522063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50927 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMBPq-0003PI-NQ
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 09:06:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMBP2-00035I-0c
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMBP0-0003f5-Pk
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:05:31 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:41016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMBOz-0003e9-Kx
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:05:30 -0400
Received: by mail-oi1-x22b.google.com with SMTP id v23so1589066oif.8
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 06:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=jTFJ/10xMgAL63mEBts4vZdhtfDSS3KLX5fx1o2OGmw=;
	b=qhq3fOT+PZbgPSD0NZEs+It4oSOGp6+7YywtvvUsIEi0YsfF3XwP4kgtzYzxLN0Ykt
	doyahFCt4pcMuSpEJx/mZgmJ01iupUxMjSFlmmMNj6Y6rxDp00j3XuSyn0XTMEkAscod
	lGehfQURbNnPfsf04TYpcMqgC9VwJ8cskIsQ4UArIwgw2XWFPW0AvkmvBLywz5Xa7E9z
	UvSRMaEscOHXkPlhC9AeR5UElYOPQzHHHd/zShIV28VlBHcOzm8AGgGuHf5NSgoNOHJH
	C08a9FoX8iwqgKxn2cRqFr19Z16Wf5GD6XKmeENjS/IsLHPadgIQr0rhmbL5G3Sm6Ghg
	AX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=jTFJ/10xMgAL63mEBts4vZdhtfDSS3KLX5fx1o2OGmw=;
	b=aF9IdtDMdVXRzSrnqblTVFO/BdNrLr07osbRTb3GfiSd1xRfDsfReieLrdPhZzHFqa
	TtVxZOy9lmT813bK2SDAVEDOreZA8Fp/5h7V0btbHv7PoRZ9Wb2sI4w4lyBPmWK6U9FT
	qjR8FnZNfxczrHOWytarnsl8UfSfl5Dtvbqe5Tnh7KHXUt5A/85uQzakejUG6ZnW/RYg
	mdWLT7uRiYlmbhYy61O5SL9uD5p4A9/Sr+jVfgEdqYftXLjtNiuLTZz0F6Ur4f+jAiBs
	EXLnSBaUbfybyE4VcwcKjnNvhlKhb0UHtcurcTakRnko60VzDk/B1s8Z1z7+ulV35BED
	chlg==
X-Gm-Message-State: APjAAAWTdgwPs2kOMhLw8EcyQ6V4BTg+nw2WNALecT86UJSlMwHfX0mU
	zznFQL94HAkSo6+C4V+ej3DyYf3ZxzWy19itZadDDZyaP0Y=
X-Google-Smtp-Source: APXvYqxa9I4vCrz8JXFtdwsRmaKCjFN5Kmu4XI5aSTmzEEURfo7kF+DwR1VjNuiHUAL5OizET4dXni+pkWHcS3jMxXo=
X-Received: by 2002:aca:4b04:: with SMTP id y4mr2333191oia.170.1556802327185; 
	Thu, 02 May 2019 06:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190502073543.4391-1-kraxel@redhat.com>
In-Reply-To: <20190502073543.4391-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2019 14:05:16 +0100
Message-ID:
 <CAFEAcA-OyrwAqp1Kwt-sFJY3xj=0mUszGtF3RewwLs25vOhNLg@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22b
Subject: Re: [Qemu-devel] [PULL 0/7] Usb 20190502 patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502130516.TiGBMiBgDn_HuYmP21znSLsXpKiwmkYFk7MhnuFr_KI@z>

On Thu, 2 May 2019 at 08:54, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit f75d15231e56cb0f2bafe19faf1229c459a607=
31:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-04-30 17:06:57 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20190502-pull-request
>
> for you to fetch changes up to f3ea801df82991e852862bcaede23a4607859dd8:
>
>   hw/usb: avoid format truncation warning when formatting port name (2019=
-05-02 09:34:13 +0200)
>
> ----------------------------------------------------------------
> usb: bugfixes for mtp and xhci, split ohci-pci.
>
> ----------------------------------------------------------------


Hi -- I'm afraid this failed to compile on one of my systems:

  CC      hw/usb/hcd-xhci.o
/home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c: In function
=E2=80=98usb_xhci_realize=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c:3340:66:
error: =E2=80=98%d=E2=80=99 directive output may be truncated writing betwe=
en 1 and 11
bytes into a region of size 5 [-Werror=3Dformat-truncation=3D]
             snprintf(port->name, sizeof(port->name), "usb2 port #%d", i+1)=
;
                                                                  ^~
/home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c:3340:54: note:
directive argument in the range [-2147483647, 30]
             snprintf(port->name, sizeof(port->name), "usb2 port #%d", i+1)=
;
                                                      ^~~~~~~~~~~~~~~
In file included from /usr/include/stdio.h:862:0,
                 from
/home/petmay01/linaro/qemu-for-merges/include/qemu/osdep.h:99,
                 from
/home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c:21:
/usr/include/x86_64-linux-gnu/bits/stdio2.h:64:10: note:
=E2=80=98__builtin___snprintf_chk=E2=80=99 output between 13 and 23 bytes i=
nto a
destination of size 16
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __bos (__s), __fmt, __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c:3354:66:
error: =E2=80=98%d=E2=80=99 directive output may be truncated writing betwe=
en 1 and 11
bytes into a region of size 5 [-Werror=3Dformat-truncation=3D]
             snprintf(port->name, sizeof(port->name), "usb3 port #%d", i+1)=
;
                                                                  ^~
/home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c:3354:54: note:
directive argument in the range [-2147483647, 30]
             snprintf(port->name, sizeof(port->name), "usb3 port #%d", i+1)=
;
                                                      ^~~~~~~~~~~~~~~
In file included from /usr/include/stdio.h:862:0,
                 from
/home/petmay01/linaro/qemu-for-merges/include/qemu/osdep.h:99,
                 from
/home/petmay01/linaro/qemu-for-merges/hw/usb/hcd-xhci.c:21:
/usr/include/x86_64-linux-gnu/bits/stdio2.h:64:10: note:
=E2=80=98__builtin___snprintf_chk=E2=80=99 output between 13 and 23 bytes i=
nto a
destination of size 16
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __bos (__s), __fmt, __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

It looks like this compiler isn't able to decide that i is definitely not
negative, so it thinks the resulting string might not fit.

thanks
-- PMM

