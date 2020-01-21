Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EBBC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:00:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D02124653
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqRr+tCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D02124653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwtd-00011r-JY
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 12:00:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pdurrant@gmail.com>) id 1itwsB-0008Gw-2V
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pdurrant@gmail.com>) id 1itwsA-0005iC-1u
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:59:26 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pdurrant@gmail.com>)
 id 1itws9-0005h2-T0; Tue, 21 Jan 2020 11:59:26 -0500
Received: by mail-pl1-x642.google.com with SMTP id a6so1592673plm.3;
 Tue, 21 Jan 2020 08:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DKEZ+rFgh1FXDkP8cH00GpTaydprdQJ7DPFD5gprERY=;
 b=RqRr+tCbOQ8WPX3stp52RVDkId//sCDJf9CO5sfgfRdLJabtk/wtA/I+5CohyNqFCM
 sESVIsO45yJDbUfUzJwGvO4soEqXyDNQvmKYv2KekJjMT+sJA8ZGb1/zDJxW0jHAcphZ
 elfg2ABbGho/RZGdVKbC7gc4XUqgj4TycaibpIGYNMR6khmF3N72ElZIP5P7bDMCP0qR
 Dh8saLSxKjQe04U8ywMDMegf+0nJqzajqP8ReOcFEy5vBdeCgWzSS3oil58GO9Rw46td
 uYGHfsd0DPW4RrpiXkaMOyxLBIOW+aEseGbj6invbd7DnvPALN459pFGPtao15wzENxm
 D2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DKEZ+rFgh1FXDkP8cH00GpTaydprdQJ7DPFD5gprERY=;
 b=OnU/8o8Ino+sb9NWTm/nI9zPUud0R55uTPGVNnaYe9+vvb4FJnqpM1bVcsAhSA/HX5
 qw3JXUY3+279pRCKcBy5ERfeSAWMf+2axS9HDr6mmSd/RSDwGowZwQgFdMJ11d9GJ0mB
 M9j2isfrgsiX1DQDU/23/mu/jSj+RIF+6nOAZ7WEi/7Mv09cXmXDGc5d1wYjUswuxioL
 ruD9DaDJRPM1RnJ9/90OzswvlB0gdSeKP1SNepteGmFsKlrNg0W7OYSRQFpJZ8p26ExN
 hb5N/nSDfchWjk0Z4o81efydKhj4pCQZDi3+iG6ZHuKjh7wZuwTUDleuEo5HzhwmA8xi
 X9pw==
X-Gm-Message-State: APjAAAXe3Sln4BzL1dlWtSgE00KuqbAB/FxokiD8PdKMzq1CjrWRpd7y
 hWz5jaGnV0cereBUjLlA8TgGtevNRmzyPA120BQ=
X-Google-Smtp-Source: APXvYqzQ7V/yjk2IB3+IOt/dUJUCw7xy1gibPalzPgdG/hOiHo5q/OkxOXQelyvuJRpYuQHd5F8vi13aOFCNWWBUicc=
X-Received: by 2002:a17:902:7291:: with SMTP id
 d17mr6233137pll.227.1579625963940; 
 Tue, 21 Jan 2020 08:59:23 -0800 (PST)
MIME-Version: 1.0
References: <20200121161747.10569-1-thuth@redhat.com>
In-Reply-To: <20200121161747.10569-1-thuth@redhat.com>
From: Paul Durrant <pdurrant@gmail.com>
Date: Tue, 21 Jan 2020 16:59:12 +0000
Message-ID: <CACCGGhCZeb1-OQ0XJsRYiYC2EUSZxoeH=Q8FFortE7UnXXJuwg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] trivial: Remove xenfb_enabled from sysemu.h
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Anthony Perard <anthony.perard@citrix.com>, qemu-trivial@nongnu.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 xen-devel <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jan 2020 at 16:18, Thomas Huth <thuth@redhat.com> wrote:
>
> The define is only used in one other place. Move the code there
> instead of keeping this xen-specific define in sysemu.h.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Paul Durrant <paul@xen.org>

