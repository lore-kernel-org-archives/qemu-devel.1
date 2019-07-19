Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18670C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 00:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BB72077C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 00:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYrdg1Y9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BB72077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoGkv-00044e-VP
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 20:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35891)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <carenas@gmail.com>) id 1hoGki-0003Vf-UV
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 20:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <carenas@gmail.com>) id 1hoGkh-0006Dq-Rm
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 20:28:00 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:40972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <carenas@gmail.com>) id 1hoGkf-00068w-RE
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 20:27:57 -0400
Received: by mail-io1-xd44.google.com with SMTP id j5so50669291ioj.8
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 17:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6h0wHwYgZl0yNuY1eNzuEm+Dlh785XmnCTrl4ipFwYA=;
 b=SYrdg1Y96WWDmvMcSBojdwRRnJir3GpboIVfXPty4pER8+wtGilSCZQpP4NxMk3PWO
 Y2eS1o7gHGYa0Xlna6YUuovIj1wMdlxhGhZnTe7Biy6AlmVDkPQoBlSWkbl6M8KbrybK
 e/pj78RNht6JVaNHKBD6O3OMgYfzfn6xL03FS+TeOHxWPbq+1FxeZyAqa0fi7Ur5kWCW
 tfjryapit6GEZh/BWadnFg+yrdqM3qDjDhykwro9HMZl/Zo7sH2aMoAxxGhjWWN4HsJy
 zKMXJzWtVsEcztmPYhLBLiynqL+aBX5rejRrm1mDnHMrXAyV4Il7xFI01jlAIXHm0aCg
 NbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6h0wHwYgZl0yNuY1eNzuEm+Dlh785XmnCTrl4ipFwYA=;
 b=BhAeGMUlqp1kQbVYJq1LaYvS620skQsKeOyU9ZR5rr2E+R7334g2syrH+B/myfgq48
 /h5UUpT4o/7EgxlZA7b/tHa5pCgVD7pvTE9rfrA+0tKJ+PcBo7Jsn6G5XsxN0H2X1dYy
 FKCkr5LQRYdmTIwQwMg4fvXZCXLEvbo8aRyoRwQIYNcuTF8jNEYgvHDqbLCb00tVBFdO
 cS0unBY0MlWe17n6QQPeoZbiiUEcrP7fd34nsg2ChgmkNlHw01j6RFws7npPrl2w6gxe
 L+7MOVz6ch5NGYImfnpzetQ6pjtYOGo7inPwxqcNYTVWSgwp0kaw9IOn6XKJAEXkv4Bc
 zqDw==
X-Gm-Message-State: APjAAAXwGhoe9uMjWYupOApJ1LbiHiGetEzkv7HXb7PFs4vssPPLfIk6
 iF6j4WTNqQncZn5/JV4Tttb3lUJfDrizjigcfIM=
X-Google-Smtp-Source: APXvYqwBZl4dQBzKJwrJR4fY5ASK8wd4NZObsN20g/alGExNMcClqxZhaK/KyByoQb/tig6stQUbFvpv+Y3/DawxG6Y=
X-Received: by 2002:a5d:890d:: with SMTP id b13mr43873110ion.124.1563496072787; 
 Thu, 18 Jul 2019 17:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190718195123.13064-1-sw@weilnetz.de>
In-Reply-To: <20190718195123.13064-1-sw@weilnetz.de>
From: Carlo Arenas <carenas@gmail.com>
Date: Thu, 18 Jul 2019 17:27:41 -0700
Message-ID: <CAPUEspjjpVg4C13XGJfmK1NUbPWkST8L4M3+-fei2NzH_eCGKQ@mail.gmail.com>
To: Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: Re: [Qemu-devel] [PATCH-for-4.1] crypto: Fix data type for len
 parameter in two typedefs
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

this series seems to provide a more complete fix

https://patchwork.ozlabs.org/cover/1131259/

