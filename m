Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD503C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 19:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FB1206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 19:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AwaL/+Ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FB1206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isXPM-0003ES-Au
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 14:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jkz@google.com>) id 1isXIU-0004yX-99
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:28:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jkz@google.com>) id 1isXIT-0004JK-BP
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:28:46 -0500
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:34541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jkz@google.com>) id 1isXIT-0004J1-7i
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:28:45 -0500
Received: by mail-ua1-x944.google.com with SMTP id 1so9363417uao.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 11:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pK6gxRpl/HqPSdY382icMzd48ZBL1D4kZT4Z3oBE0NE=;
 b=AwaL/+Ss7CuWr2yZBpeTdq6wVDmGXxwB9K/rwO8MQYF6XbjbI+bpsD0mSCdpqquw5c
 Eto2nif/ubhzQHbHYx8FPTQI8Fz6F9bxVP8/zga72feZxVg3M9E5orhxBAzWYbrpnmg0
 jUm3mhd474s9vl/bHZPNXA48TdgiwKxlwFbG8e3cYdwDVEE5H8ukkpFY8ZjTER3EurO7
 e/CssmekyI5chtud7/ln9l0Uuotk5dO10C9rJMGjjkT1Fya9LD5i9S2alZjnEnEbCR8g
 zUfcDiJTDk+UIbz3b+SFVGFN4MnOlQGJRoSUhUtpRIFw20WTgLfdhK0eCsdcfcSucKBu
 INdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pK6gxRpl/HqPSdY382icMzd48ZBL1D4kZT4Z3oBE0NE=;
 b=Db545xs8hGSjcpNntS3oIuBVbBwebAptvs+FFFRGWTTHoB4rysj8GDKxB36KLgkc1K
 RFpgmyoS2LIAJVrLm0PlmZFqFnoHgIyd9WfGF2R4YyQNQVJiPsA0oIcisW24Cb6bmwQk
 B7tBS2T+4I/Qyiy9PgyoNweUAtKtcTBBuSKxnf64NRZ//1kTDI+RF1382UmyOrWPatsS
 NzEAZ5XjD+WHiaJUnxw5erhX1czSxN/VemHNy3cw/QIYlqu0mJxVHr8cZGaB+cONt3GC
 PMtaXwa5IkWShRqAnYd8Yr1+koIMsqS37I4shsamnN+VeoHPYCZMwU0pe7C9BJICR2+5
 enYA==
X-Gm-Message-State: APjAAAXFhf0+4jyaAH40t+HHCqPE8S87hYsVHpalEDqPNBoG7AHTNfCH
 XnZIPjhfhdZ9fneP0fAodtM9hUknTZKn6PIPel9hbA==
X-Google-Smtp-Source: APXvYqxxSI7PqdFLAmR1LZ+lJOkBJvOkgYR2/9niG/RX47WExMvqVv+m1kslGy1s1NCpcr8RkPu5aV3/jZYQtXNyuhs=
X-Received: by 2002:ab0:3085:: with SMTP id h5mr21660741ual.110.1579289324349; 
 Fri, 17 Jan 2020 11:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20200114030138.260347-1-jkz@google.com>
 <20200114030138.260347-3-jkz@google.com>
 <87muaqmhmq.fsf@linaro.org>
In-Reply-To: <87muaqmhmq.fsf@linaro.org>
From: Josh Kunz <jkz@google.com>
Date: Fri, 17 Jan 2020 11:28:33 -0800
Message-ID: <CADgy-2vbY9UPfZ4V474J1g4LtwxrjfQ1JQ17rpJ97puC-kyHsw@mail.gmail.com>
Subject: Re: [PATCH 2/4] linux-user: Use `qemu_log' for strace
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, 
 Laurent Vivier <laurent@vivier.eu>, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::944
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 2:56 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> Could we cut out the middle-man and just qemu_add_log(LOG_STRACE) here
> and drop the enable_strace variable.

This code has been re-factored based on Laurent's comments. In v2
`enable_strace` is still needed to avoid QEMU_LOG/-d overwriting the
mask set by -strace.

> Please don't drop the brace - c.f. CODING_STYLE.rst

Thanks for the catch!

> Side note, print_taken_signal might want to consider using the
> qemu_log_lock() functionality to keep sequential qemu_log's together. I
> suspect you might want to do the same for syscalls.

This is likely true, but outside the scope of this patch (this patch
preserves the current bad behavior). When I get some spare time I'll
try and address this in a follow up patch series.

