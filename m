Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7E2C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A802087C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rk3LHmBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A802087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtFC-0003rC-TQ
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kAt46-0007rE-Kl
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:54:02 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kAt43-0001hZ-7Y
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:54:02 -0400
Received: by mail-oi1-x244.google.com with SMTP id z195so1122321oia.6
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 03:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/6Qb9HUZPr1M4+WsnWJ+hiTdF/J1R2bDjrjIOxqgiKc=;
 b=Rk3LHmBNJWcomUxrAOhxZFQpnJLZpaayXncBOPfkiCADthn9N/dkccO/XWzkzF+Pb+
 mUy//U/O5eyaNXhguedLW8hHEzdfnexF4xj2vedegVpEbYgo3x91wQ5c2qltM7rntzL/
 rqF3PsMDbeB8wImoCskTJWFsFtoRW4WBQNfXSeGHLffsfjr8/spvG3ZzKDZWX/r1RMxx
 6AgHMprlDMNp1OkCodixpDhliroIa2GBQ3Mr2HdM7mYduvX7tEatzeCuUU4ueBilAN7g
 E4YT0MWPYez/NiOlvzYANhXJYFyt0kEfI3/Xxv13txAKUqOvqfPyMAqyMVxe080CSZUf
 SpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/6Qb9HUZPr1M4+WsnWJ+hiTdF/J1R2bDjrjIOxqgiKc=;
 b=bpYHmSGBLJrUbRMB+OpraxlkSU4BrLr5q1OZgGyNUDm/qzIXjDFvIDrCIJ2MUcPG4/
 ttIVUt/IVthvVP37aOjWdggVECPUpw9k3pxMy/PJ8hh8Qa8DymF58FEFfOLCQtKF8tPC
 HCwtxz1wN3FevZEBE3fFxu0NqwgIe971Yy38LXrCNCpchhog6x3x/s2ydLHdnbvpCDmS
 1aoIfJUcN4VeB2edTLN7361izpgplQeIeZzW3u14Qpt1SmN6maaNcz/thjaY2CGsQjzA
 mDyCh3+S83qc6fL2uP4f1wVKy1x7oPCVlQfTKuBQwL2XoN92XxQHGDGnk9hx6Vme2CAb
 i25g==
X-Gm-Message-State: AOAM533aeV1UFXIpAdj+e55utfU4WMkGXDwr1AeiYzxsmhAHI8r7iZue
 Ysuntk9t2vn3vjjpop9mzspUPkYf/1+Ogrfiu7k=
X-Google-Smtp-Source: ABdhPJwLgrRx52tcVuzcB6jxum2vTS6Bw15/eftSdlgnweBj9NuG1icyslPMhjGyl7n+E1SQIGOKydjcfD7Z6l3Vt4E=
X-Received: by 2002:a05:6808:4d3:: with SMTP id
 a19mr3420750oie.150.1598439237914; 
 Wed, 26 Aug 2020 03:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-6-pannengyuan@huawei.com>
In-Reply-To: <20200814160241.7915-6-pannengyuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 26 Aug 2020 18:53:22 +0800
Message-ID: <CAKXe6S+jWLnMo8+zQ6OFjZoWVLifQPn64JBwJz5A_zPkP0tEkA@mail.gmail.com>
Subject: Re: [PATCH 05/12] target/i386/sev: Plug memleak in
 sev_read_file_base64
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Euler Robot <euler.robot@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:37=E5=86=99=E9=81=93=EF=BC=9A
>
> Missing g_error_free() in sev_read_file_base64() error path.
> Fix that.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/i386/sev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index c3ecf86704..de4818da6d 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -500,6 +500,7 @@ sev_read_file_base64(const char *filename, guchar **d=
ata, gsize *len)
>
>      if (!g_file_get_contents(filename, &base64, &sz, &error)) {
>          error_report("failed to read '%s' (%s)", filename, error->messag=
e);
> +        g_error_free(error);
>          return -1;
>      }
>
> --
> 2.18.2
>
>

