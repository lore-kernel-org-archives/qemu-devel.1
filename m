Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26207CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58FC20679
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiKh7KB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58FC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMY3v-0004ot-Jn
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMY1j-0002jn-Ow
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMY1i-000281-II
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:47:15 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMY1i-00027W-BX
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:47:14 -0400
Received: by mail-wm1-x344.google.com with SMTP id 14so6223187wmu.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 06:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Btc3sos3iY3Gks2aBAC+2g9Mg/KU69zi9wiSZYCLEwU=;
 b=aiKh7KB13kdPbxOWwA6ZPS9FwU316rJ6tEOD0xcC0j/GsDMExE77TkyHUoM/TOVL/h
 PYzYSIDmlJ8ot5McMrrpJcMHeK3foaWlECWH3rB1FPCqsU+n5JAGgkQIXf5i9EsG9GlC
 UP6Zt7PiKzmDsYFKprU2tlYAG6JR+Xz/ENHxKPNJuRB43ANzB8vP0fm0FJnGI/C246Qp
 mhq34ImCyH/Z0xJ5zAFNSSRJQKy1x5365JJJ1W8DMSy924Ss301f/E7lKZkZ0y1XkoC2
 3bdxx4ldSbdb404jVVgnRK1MtkeTjTkGCAVkwKfbGDG6eLBqtuZ83AbEtSczTdi6U8mc
 IHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Btc3sos3iY3Gks2aBAC+2g9Mg/KU69zi9wiSZYCLEwU=;
 b=bRC0rzNBvqF9Ki9HU1FbDoe917PZsj20bmxcSVWC8amtD2grVLinClcTBXqWetd4iE
 ZF/dhOK5VzBL4Z+e4LGeNOIimi6DDqkNnuc40FwEOO7jOLFY2/q3M/zm/Ltup6YrhF1Q
 XMWYzUV2xbXJJTavrzIcxypG1DnWWaMh1q9P4CySmi8w4f2xc0YLGo8kktFN6qFaspaI
 IW1FgSAjpE1loVMo47VxDO3mV/0WL3dqtaRHxnDx4AUCTiq538lFU6O+3b4HtCsyRwtE
 c0MnXHprGpUEa9FV+hYEdCFxV3skIUgmRsFTWRb/b5GHCF3XQs0pqf/JWqo5hDKZL1/8
 C5rQ==
X-Gm-Message-State: APjAAAUrmAK5LzNhDTMazyDqoTCcGLLBBh3GemqzmBhbg3PDHNeTwIoG
 7zNm9jfTwP+co8d1zW9DqOhKrw==
X-Google-Smtp-Source: APXvYqz+/mXRUpMaYU389E06LpVY7p5ifINs3N4pBcP3XaY5b2+YNrsp+zdadzOYLxvOPAfcEHGGCg==
X-Received: by 2002:a1c:4c02:: with SMTP id z2mr5583663wmf.78.1571665632773;
 Mon, 21 Oct 2019 06:47:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x2sm14385913wrn.81.2019.10.21.06.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 06:47:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9070D1FF87;
 Mon, 21 Oct 2019 14:47:11 +0100 (BST)
References: <20191018181705.17957-1-ehabkost@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v5 0/3] tests/vm: netbsd autoinstall, with IPv6 disabled
In-reply-to: <20191018181705.17957-1-ehabkost@redhat.com>
Date: Mon, 21 Oct 2019 14:47:11 +0100
Message-ID: <87r236w6qo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Eduardo Habkost <ehabkost@redhat.com> writes:

> I'm numbering this series v5 because it's a new version of the
> patch sent by Gerd, at:
>
>   Date: Mon, 17 Jun 2019 06:38:56 +0200
>   Message-Id: <20190617043858.8290-10-kraxel@redhat.com>
>   Subject: [PATCH v4 09/11] tests/vm: netbsd autoinstall, using serial
>   console

Queued to testing/next, thanks. I've made the changes Thomas suggested
in his review.

>
> Changes v4 -> v5:
> * Rebase to latest qemu.git master
> * Disable IPv6 by default (see
>   https://lore.kernel.org/qemu-devel/20191017225548.GL4084@habkost.net/ f=
or context)
>
> Eduardo Habkost (2):
>   tests/vm: Let subclasses disable IPv6
>   tests/vm/netbsd: Disable IPv6
>
> Gerd Hoffmann (1):
>   tests/vm: netbsd autoinstall, using serial console
>
>  tests/vm/basevm.py |   5 +-
>  tests/vm/netbsd    | 196 ++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 190 insertions(+), 11 deletions(-)


--
Alex Benn=C3=A9e

