Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47542C3B18F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13DD624649
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcjstx91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DD624649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ZW6-0006NS-BW
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 06:52:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1j2ZTx-0004a9-7n
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:50:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1j2ZTw-00051s-9I
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:50:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21759
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1j2ZTw-00051J-5e
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581681003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iTSDiFosNKc3TrM/zqpo0RpnDn4VdgDCtYGIvt/SkXc=;
 b=hcjstx919HQT+ctYLfNnMLZwAZD0gdUC8sRNfXp8c9cKSrt5NhV9qV/Lypny0TJUkkQjNQ
 HUBP18mjSqSgZ1a1UdpPCx+kbv5PkjRXCC18tw1PCB/xqPW4lLsas5YXsXkfoa5b8hIGYk
 SgGFoVjSfR7HRRgkctMnzc3bRfWM76k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-UubxwEJpPAaEku65n0DtFA-1; Fri, 14 Feb 2020 06:50:01 -0500
Received: by mail-wr1-f70.google.com with SMTP id u8so3891597wrp.10
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 03:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iTSDiFosNKc3TrM/zqpo0RpnDn4VdgDCtYGIvt/SkXc=;
 b=WyNfrs+GSJs//R24PVkDZRqoHN7NKP91w1PfVQPksJ5g54ExNTI+LHiOZObJDuuUI4
 eYgaKrXh/ZnBe1TAAojsliMbqYDbSwA9Damp9ax8eBRLwTCvraNgDUfpVBObi+Xn/m7P
 yKP7G/ojlWSd2sXGz58HA+oYo2RIb1Apa+o9pPXGcDlXBfWGuGs4wbBs8GDKr5wsKOCH
 1J89L6gV7euulhU9SPfnIIPfFoLo+QNY89uLxgA/CFY1251YQR5ocomKpceNcNcKg24n
 Ppc2IKcBNDc8q/8tX/IrnbFhOaJZjaB+aJrc94jQ5E7si1oX0RWFw0dtTfdZZnScnYa2
 OYfw==
X-Gm-Message-State: APjAAAUYwtaVOtMrF8HaibePFx9LamqO8H6NJjMpHaUGBILPTbrjXRTy
 7gly0QbmNOND1nnuWERxuDEckX8wAkTzgxD6owksAi0Kl0rntwOPMWI4482ua8+hdNub0ll27E9
 F7IjWGY3dVRzPSkvrDtRfVvNUxrWaYAo=
X-Received: by 2002:a7b:c459:: with SMTP id l25mr4219919wmi.17.1581681000962; 
 Fri, 14 Feb 2020 03:50:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqyh2hsXtkATST+u0hRluRhlb2NCJ5SvLC5ttby8DPg12nIpmlAs1+jbzUWFXpLgobqD8iUR4yCwG5BPgzcpzFg=
X-Received: by 2002:a7b:c459:: with SMTP id l25mr4219907wmi.17.1581681000737; 
 Fri, 14 Feb 2020 03:50:00 -0800 (PST)
MIME-Version: 1.0
References: <4949c3ecf1a32189b8a4b5eb4b0fd04c1122501d.1581674006.git.mprivozn@redhat.com>
In-Reply-To: <4949c3ecf1a32189b8a4b5eb4b0fd04c1122501d.1581674006.git.mprivozn@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 14 Feb 2020 12:49:49 +0100
Message-ID: <CAP+75-UqxEE_wDV=1+pNW9cbATry44D=1n-h2ZinUKJ7THYwMQ@mail.gmail.com>
Subject: Re: [PATCH v2] Report stringified errno in VFIO related errors
To: Michal Privoznik <mprivozn@redhat.com>
X-MC-Unique: UubxwEJpPAaEku65n0DtFA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 14, 2020 at 10:56 AM Michal Privoznik <mprivozn@redhat.com> wro=
te:
>
> In a few places we report errno formatted as a negative integer.
> This is not as user friendly as it can be. Use strerror() and/or
> error_setg_errno() instead.
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


