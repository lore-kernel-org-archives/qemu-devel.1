Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73CAC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 22:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9569320776
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 22:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpMUl330"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9569320776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netbsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC8uZ-0001fj-Fj
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 18:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <macallan1888@gmail.com>)
 id 1kC82B-0004IF-S7
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 17:05:12 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:39794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <macallan1888@gmail.com>)
 id 1kC829-00041n-Kn
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 17:05:11 -0400
Received: by mail-qv1-xf42.google.com with SMTP id o2so1254300qvk.6
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
 :organization:mime-version:content-transfer-encoding;
 bh=npVwvafmTAsaCBHMuLNMBhhNNm97V+LaFIHQwkYdIrM=;
 b=DpMUl330HpGpuvdnIljbik+4sl9gD5wAnUSXpRwilrgTRsaJ09Wu+0EhG8DlVF6UEH
 hic11tiWVMJX4ZrEBANVB5+HnMfwimy4YICyqNqkL8HT5QY1zAUgBEe/n3mgfEm/dlRb
 v2d93Q1euvcZzM8dRk1NVo6YtVPaRri0xEQhRJ4qkg70XGjW+sNDlbWxYxRcNY+A86aD
 BRGwr006JDgUoU21GcH0LQxKgWf+mhiI0sxdHWDuIE3SpA3ckFEqveMkawkBJHOLJU1+
 8e6Dw+fnaqkLh5mermq8uet6sg1WKsrosnKpHdfkhaTt5T70RDbEZIB69EOoO9HMJSvt
 0LBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :in-reply-to:references:organization:mime-version
 :content-transfer-encoding;
 bh=npVwvafmTAsaCBHMuLNMBhhNNm97V+LaFIHQwkYdIrM=;
 b=EsgTkK0UajpZ+gyAPd92EBC93QzZAu9VVH7qH6haAZB09YchG4pGDML/0wkcdwFDmD
 rfdksFqtygkxGTdOLzZD1JytnYO35B4nvWvoORnusyZlQGdM+FD+ZIyyH1bUw8YPU0Eu
 +sJsxZa8cTX6EoCP8XYT/B3F9OXs2MlhzlP+ixuf9z7x1Qv9epG8gHuIHfh24u/qZM1d
 f+A10boXeQkLP8c16CelNbPNY5V5daYBXbjNaNxN8tW2BqOuP1qZXcN1nca3l/8kUvF8
 U9bp5rHNBnwGrPu7PNGHG8Vb1sGLqA7gYRt1Q1Q8XSX5g3ygIvc23036OfWQqqOWaYxC
 TOPw==
X-Gm-Message-State: AOAM533uLRfJhFnehrr3YCpm163SphkWpo71+OjjOI7abJ8YKlqoWoUr
 4wb1YeZbhqe5+Kxssakciak=
X-Google-Smtp-Source: ABdhPJxvIi9fLbMlw6vFUacrtdwFj9FknAB2jhdQg7iimrr6km9xsYhdEhLMX+6YS0BSgq+BWpccSQ==
X-Received: by 2002:ad4:486f:: with SMTP id u15mr4297248qvy.126.1598735105296; 
 Sat, 29 Aug 2020 14:05:05 -0700 (PDT)
Received: from linkwood (c-73-121-86-106.hsd1.tn.comcast.net. [73.121.86.106])
 by smtp.gmail.com with ESMTPSA id
 25sm3194227qks.41.2020.08.29.14.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2020 14:05:04 -0700 (PDT)
Date: Sat, 29 Aug 2020 17:04:45 -0400
From: Michael <macallan@netbsd.org>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH v2] hw/display/tcx: Allow 64-bit accesses to
 framebuffer stippler and blitter
Message-ID: <20200829170445.3153c4a5@linkwood>
In-Reply-To: <CAAdtpL4Pi3w+5awNrohmSpySsZhmmPFQeby+a1-=TT8mJ7ZQVw@mail.gmail.com>
References: <20200822142127.1316231-1-f4bug@amsat.org>
 <7300edf2-ab44-3676-6948-adf2c5af6c02@linaro.org>
 <20200829121341.59d8277b@glenfarclas>
 <CAAdtpL4Pi3w+5awNrohmSpySsZhmmPFQeby+a1-=TT8mJ7ZQVw@mail.gmail.com>
Organization: The NetBSD Foundation
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; powerpc--netbsd)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=macallan1888@gmail.com; helo=mail-qv1-xf42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 29 Aug 2020 17:58:09 -0400
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
Cc: Michael Lorenz <macallan@netbsd.org>, Andreas Gustafsson <gson@gson.org>,
 Richard Henderson <richard.henderson@linaro.org>, 1892540@bugs.launchpad.net,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "qemu-devel@nongnu.org
 Developers" <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On Sat, 29 Aug 2020 18:45:06 +0200
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> > > > However the NetBSD revision 1.32 of the driver introduced
> > > > 64-bit accesses to the stippler and blitter [2]. It is safe
> > > > to assume these memory regions are 64-bit accessible.
> > > > QEMU implementation is 32-bit, so fill the 'impl' fields. =20
> >
> > IIRC the real hardware *requires* 64bit accesses for stipple and
> > blitter operations to work. For stipples you write a 64bit word into
> > STIP space, the address defines where in the framebuffer you want to
> > draw, the data contain a 32bit bitmask, foreground colour and a ROP.
> > BLIT space works similarly, the 64bit word contains an offset were to
> > read pixels from, and how many you want to copy.
> > =20
>=20
> Thanks Michael for this information!
> If you don't mind I'll amend it to the commit description so there is a
> reference for posterity.

One more thing since there seems to be some confusion - 64bit accesses
on the framebuffer are fine as well. TCX/S24 is *not* an SBus device,
even though its node says it is.
S24 is a card that plugs into a special slot on the SS5 mainboard,
which is shared with an SBus slot and looks a lot like a horizontal UPA
slot. Both S24 and TCX are accessed through the Micro/TurboSPARC's AFX
bus which is 64bit wide and intended for graphics.
Early FFB docs even mentioned connecting to both AFX and UPA, no idea
if that was ever realized in hardware though.

have fun
Michael

