Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE37C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 11:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3831121BF6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 11:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="Vji1oZHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3831121BF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvKOC-0006V8-Dx
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 07:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57466)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jusual@mail.ru>) id 1hvKNV-0005vy-8b
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 07:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jusual@mail.ru>) id 1hvKNU-0000cU-B1
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 07:45:13 -0400
Received: from smtp51.i.mail.ru ([94.100.177.111]:49676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jusual@mail.ru>) id 1hvKNT-0000Xn-OY
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 07:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version;
 bh=kX8C3GH1PdhT2nVPrFliyqVkR1ASHQIYry2PLXgg3ug=; 
 b=Vji1oZHUWYxQEV1SSddBbVYzjoAu/pmYrffQqNHLT0NLNXAXek2/SyoqhozrApuT7JoaHYJs5Tq7MRfLyFHtWkk8Gy5B19xO9WuUZA4Tc0mjH4rkuV2YS7I868mj+PhIYFDWrqZLM0PodRbhJ1uDFU2gK2FJvfVTbDmHBtwvGCo=;
Received: by smtp51.i.mail.ru with esmtpa (envelope-from <jusual@mail.ru>)
 id 1hvKNQ-0007kL-Tx
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:45:09 +0300
Received: by mail-lf1-f42.google.com with SMTP id z15so59520474lfh.13
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 04:45:08 -0700 (PDT)
X-Gm-Message-State: APjAAAWLQUMcefmenWTTFC0AyR7n8f5CajG1vyyM8/KuE3M4DJxIsxf6
 ue+KbZrtvcojUznp6JIqjVcgWO+YhCXnFQeCswtlTQ==
X-Google-Smtp-Source: APXvYqwnyj8jQvs/XVxRq5fw5VqFaZcKuksbPXCu2+8ECTM59nUdOeYgkLGIyA5YxKg5Hw08vvM1L7IynF4PEdavtwI=
X-Received: by 2002:ac2:5976:: with SMTP id h22mr5598158lfp.79.1565178308390; 
 Wed, 07 Aug 2019 04:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
 <20190801234031.29561-8-mehta.aaru20@gmail.com>
In-Reply-To: <20190801234031.29561-8-mehta.aaru20@gmail.com>
Date: Wed, 7 Aug 2019 13:44:57 +0200
X-Gmail-Original-Message-ID: <CAMDeoFUMSupka-F+TCHSq+1UMd_UbNXFyPwzdC738BSmNWXi2w@mail.gmail.com>
Message-ID: <CAMDeoFUMSupka-F+TCHSq+1UMd_UbNXFyPwzdC738BSmNWXi2w@mail.gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: smtp51.i.mail.ru; auth=pass smtp.auth=jusual@mail.ru
 smtp.mailfrom=jusual@mail.ru
X-77F55803: 2D1AD755E866B1545A78504BD2AC29411A843C288C57C502945223B1EF45B75B2D2FACE3D783569086D590F1EF289684
X-7FA49CB5: 0D63561A33F958A553EDCB14759842D563BAE15F96CE8CAB7DBDD558EBD32B618941B15DA834481FA18204E546F3947C1D471462564A2E19F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B2EE5AD8F952D28FBA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C22494A2C4B6BA9DFC5103AA81AA40904B5D9CF19DD082D7633A093541453170D46FCD81D268191BDAD3D78DA827A17800CE76937630EBE596648EC76A7562686271EF5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE792A88657AE5FD006FDEC9B8CFE8D2E8875ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57DE7CCDD3542A186E00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 4C235FE2E5D2D8903B37EB98D235FFC4EBE13A2A73873263C1977FD234168AD92269EB2C477A7CFBBCD5BA2C93075E1EC77752E0C033A69E882C431543FD75E20226C39053983FF03453F38A29522196
X-Mras: OK
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 94.100.177.111
Subject: Re: [Qemu-devel] [PATCH v9 07/17] blockdev: adds bdrv_parse_aio to
 use io_uring
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
From: Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Julia Suvorova <jusual@mail.ru>
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 2, 2019 at 1:41 AM Aarushi Mehta <mehta.aaru20@gmail.com> wrote:
> +int bdrv_parse_aio(const char *mode, int *flags)
> +{
> +    if (!strcmp(mode, "threads")) {
> +        /* do nothing, default */
> +    } else if (!strcmp(mode, "native")) {
> +        *flags |= BDRV_O_NATIVE_AIO;

This 'if' should be covered with CONFIG_LINUX_AIO.

Best regards, Julia Suvorova.

> +#ifdef CONFIG_LINUX_IO_URING
> +    } else if (!strcmp(mode, "io_uring")) {
> +        *flags |= BDRV_O_IO_URING;
> +#endif
> +    } else {
> +        return -1;
> +    }
> +
> +    return 0;
> +}

