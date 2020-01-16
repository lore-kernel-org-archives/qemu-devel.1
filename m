Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58628C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B9420730
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOFMI+Ev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B9420730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is6qV-0006cw-3U
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 10:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1is6pd-0005kR-UY
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:13:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1is6pc-0001Gq-Gy
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:13:13 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45475)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1is6pc-0001GD-AQ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:13:12 -0500
Received: by mail-ot1-x341.google.com with SMTP id 59so19629739otp.12
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 07:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/DpJ4FKbGtggHiJHPngPxi5MdCn/ZA9Xxtwy+B9yUQ4=;
 b=cOFMI+EvaZTSNvFLKyKRm+qeUnMpRqAWXs36xOp9BDwswoR040C0xzyFsdixIwbSj6
 p6CHUOEpE8RJxTw3OreGhTGCwFnV3O67vu3PHhZxwXR/XQHf3sWUDQsb247AVm9RamBx
 YL0Q0LoPvyRRFxR7QiTOgg4EYHszqlb9W6batm3DvPvl8ugkrAuTOb9k72GPv5GObBMl
 IaHuJddQ9JzJtXtW/OpL/CHp2njqDgMY+KBh3J9czBwEnY5oytQhghnwN+XVASRzEfRb
 jiSpQv2Xa4ws7unwH0ZheWedvHQcaddp0zmQgrtOOflXdVTEqViRWhHzu1jBL28z93Qg
 m/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/DpJ4FKbGtggHiJHPngPxi5MdCn/ZA9Xxtwy+B9yUQ4=;
 b=IvnJWfvRXwGbQYJSuslRPfClDvMFDtyQ/Ixjq9sqXoea0N422IsqLQlU0YM9PYn0bL
 ttvkr3eWQzgqqkysJ1qW8xSkQjU6KYT1/rv1thUMEzQH4R1hzDq/KosXG6cqmUeRUUQ3
 rxF7yTFaYNbfi84P6U6rEbgi7ykWAP9A1zHF9v/wb12ZjqvHWL/R+xULgPXEUJkdC742
 jMK5lhgM1is39JU8VHoUpqyceaKHqtsTUUw6SBidRBANi+pX2G9YNnXbo3cLpKKsSyR9
 cmejUqfZbGaaqA5u/h4moP2TaVA2Iz7JIqfFmEhLgwV/1ikLNAmCdShNf1fCTn8ZoaK2
 gJLA==
X-Gm-Message-State: APjAAAV3/bVxoWQkbs3DGw1ZbD2vy7pwdMYuHSL/NrHDA7lqfuziiCyC
 9G3Wdu4ET9ddMhr7XzjbhReMcrc2HhwYuwRwvGTW9Q==
X-Google-Smtp-Source: APXvYqyEACsG+Vvc02yQU/Gzj6iLrtRGAfVijZLjTED7f8+fs+XNgVnsgtwxEwXvvyTpUbPMTpZJLeCTYt5cr5pMMW4=
X-Received: by 2002:a05:6830:1586:: with SMTP id
 i6mr2228566otr.221.1579187591251; 
 Thu, 16 Jan 2020 07:13:11 -0800 (PST)
MIME-Version: 1.0
References: <20200116115413.31650-1-philmd@redhat.com>
In-Reply-To: <20200116115413.31650-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2020 15:13:00 +0000
Message-ID: <CAFEAcA8urpGfs5=wqTHgjNc7BjKWf+FyWH3i72SO7x4s8twh0g@mail.gmail.com>
Subject: Re: [PATCH v2] ui/gtk: Get display refresh rate with GDK version 3.22
 or later
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Nikola Pavlica <pavlica.nikola@gmail.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 at 11:54, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Commit c4c00922cc introduced the use of the GdkMonitor API, which
> was introduced in GTK+ 3.22:
> https://developer.gnome.org/gdk3/stable/api-index-3-22.html#api-index-3.2=
2
>
> Unfortunately this break building with older versions, as on Ubuntu
> Xenial which provides GTK+ 3.18:

Thanks; applied to master as a travis buildfix.

-- PMM

