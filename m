Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A569C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E10A20708
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvVweg/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E10A20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTnMM-0006Ci-7f
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qkrwngud825@gmail.com>)
 id 1kTnD7-0003eb-Tn
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:29:30 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a]:46422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <qkrwngud825@gmail.com>)
 id 1kTnD6-0006mZ-AN
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:29:29 -0400
Received: by mail-ua1-x92a.google.com with SMTP id y1so1520352uac.13
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P+gIv2Lcj4WNQ6W5r97xFTj/z+w+Zw6Am1AGbMCfPgE=;
 b=AvVweg/pSu+cvJE0S0zZqtqcLAoadXExFz3xAe9zG7vo50YMTLwHQ1i8ftED2DTCXA
 uDyLEeGC6cYYaKOaXhAhMiSavtK6o+K0Bf0j3CS6CK6OzuSRfmaff3DhIkmIeSRj1QmC
 iOisXBQpzXX94cVxrWjw059s2E/Sj+SZ8+0L6jcZKRmU2wzQSoBODay/ZjP4eDDE4KHD
 rIXoGB1a4ZvI8eIsepfck2FIUOVafAAvByyjbLIaaBkDw2ok0thiS0I16UshtZz++jVD
 JAra2+ekaIrQbnMF4Bc81YjliIwbhBI8tg+Dy3t7U9FlTbPsxakUCdFDzj6/YRsRUX3Z
 TwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P+gIv2Lcj4WNQ6W5r97xFTj/z+w+Zw6Am1AGbMCfPgE=;
 b=c2oUKxXsdGRKhwfBg1+OSZqkFypQBGcIgKpG0KmAYlWTdJYdnFSOf0it7vM7QuuYBR
 n2jdQ4/QuCWb1UacfbOoGYrWsho4GwKuy5S0l3adfFEhtmoV9j6rAQ3Mz2J6WSynN1K/
 tJLNbeJ87ukrkbmFymoiOlEb7kvuqU+Pl0/wTjWYGLYWMzoZXQk3lnw71sfT3mvACy8D
 BiXqdsYxZQ6Vz6T0DgGZ4BkE7WZ8fGZSiIef2dHArasiNJ2t8Wemf/Sn8C+4JXFhffJZ
 ZaTmKbhOyJxCsAi1p1ZUTyVBJlWKPv4jrh4DbAHtPAbxXQBP4hq2JqM4PL4VBN8uBp0D
 xUSA==
X-Gm-Message-State: AOAM531kJPXougBkYGL6l26KD0IM/rpm7k4n6yZ4F2XNT3+CocCAJP/J
 nzRq4S7d9chdEyQVMW7LZ/MDjhbW9RQUSFez2/U=
X-Google-Smtp-Source: ABdhPJzden7sO+y2LzeOJWCADNP5kK3JioLv+GRKwCvaAYdK5okKzL5TOLlsjB6Kg7jXp74ndZ1SqzW+p2DQEwMjyA0=
X-Received: by 2002:ab0:6f81:: with SMTP id f1mr4272724uav.31.1602944967083;
 Sat, 17 Oct 2020 07:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAD14+f3G2f4QEK+AQaEjAG4syUOK-9bDagXa8D=RxdFWdoi5fQ@mail.gmail.com>
 <20201001085900.ms5ix2zyoid7v3ra@steredhat>
 <CAD14+f1m8Xk-VC1nyMh-X4BfWJgObb74_nExhO0VO3ezh_G2jA@mail.gmail.com>
 <20201002073457.jzkmefo5c65zlka7@steredhat>
 <CAD14+f0h4Vp=bsgpByTmaOU-Vbz6nnShDHg=0MSg4WO5ZyO=vA@mail.gmail.com>
 <05afcc49-5076-1368-3cc7-99abcf44847a@kernel.dk>
In-Reply-To: <05afcc49-5076-1368-3cc7-99abcf44847a@kernel.dk>
From: Ju Hyung Park <qkrwngud825@gmail.com>
Date: Sat, 17 Oct 2020 23:29:16 +0900
Message-ID: <CAD14+f0h-r7o=m0NvHxjCgKaQe24_MDupcDdSOu05PhXp8B1-w@mail.gmail.com>
Subject: Re: io_uring possibly the culprit for qemu hang (linux-5.4.y)
To: Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=qkrwngud825@gmail.com; helo=mail-ua1-x92a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, io-uring@vger.kernel.org,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jens.

On Sat, Oct 17, 2020 at 3:07 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Would be great if you could try 5.4.71 and see if that helps for your
> issue.
>

Oh wow, yeah it did fix the issue.

I'm able to reliably turn off and start the VM multiple times in a row.
Double checked by confirming QEMU is dynamically linked to liburing.so.1.

Looks like those 4 io_uring fixes helped.

Thanks!

