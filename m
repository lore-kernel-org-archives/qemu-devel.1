Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E444C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFDB20720
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJOq0nSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFDB20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9BYc-0006j8-Ca
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 14:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k9BXj-0005vq-17
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 14:13:35 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:32957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k9BXh-0007JL-Ed
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 14:13:34 -0400
Received: by mail-il1-x142.google.com with SMTP id r13so2188710iln.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=btY2JI8o2pfdV8o8ETokBB0wymY/gZ0SoZL41ZRpJpY=;
 b=TJOq0nSBx7N1Fq/khXhNcrtD73yVNM7ZKUdseuUARadoL5lEAPWu4ayLalP4b9aGib
 JfzX1MuOEqB/gI5jZwpEmdIFH8usPmg/cBFswecUJ0sevZaUOdxTBaCDArn3eRuMx+er
 oLv+3gxNxegEymH7o/A2EIyqA42PgdunMc6kRHkUhEeLzWIVAHk3EaNnmcuKIKH6RGLT
 hyrAmNWjJIHa6I9KspPmXXQLHRVHDWGER/8zvj7Nbhq/tvP4sRissWvnwtMnzJW8CAl8
 EcH5OheKXW5NGOa9Ai2suPrMJRYdhC6PfHHCC9RxlK9nkrJJHChV3FntfypqiT3eSr24
 VLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=btY2JI8o2pfdV8o8ETokBB0wymY/gZ0SoZL41ZRpJpY=;
 b=fZimZQ0f1pyV7N7wk3pXxaMkfOg3jprnrZrn5E+cqMrc1waRMZUlWtgmiMoBnKQC8M
 aKmuqXE8ABw1L0RfquURCwi+xfqAVpfdHO6T+gu98RbqnB6NgjaavZ1f6e17LNgKVsru
 GIFsjkY0SL9XWNNHOokeRKPzKw+l2ovY2aoszfFLSG/UKVQaU9SMz8AQDghjfASSOuHT
 znBHxFSxdJiccds4NnMvGcxR55q/exdOq9T6c2PifTSXTTrq15udOueBGWBM4KpKVf3r
 jiVcF7XhS8q9R++2qyXUHcOwH7mNu5Bx7WL0+2Wxcw4vHduZV5qW22F0Rr/GoEb7TEkJ
 5nsg==
X-Gm-Message-State: AOAM532+pKJEuAYFNPtlcbRTVWRy3R4D92qBh8Sdqqs8MLM1znCVvVtd
 FDUM9qx92D5s9a4/ItW4vEYCc/6lvKPd/wc/PBQ=
X-Google-Smtp-Source: ABdhPJyuPnTsryFbReJjIVl8FY9MLrDd4nd1slawQdf+IRPxaCVPoa9GQVJYflbLV2TfzkySyAtDbjzOx/kEQTEnr+Q=
X-Received: by 2002:a92:9117:: with SMTP id t23mr3660449ild.177.1598033612228; 
 Fri, 21 Aug 2020 11:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200821174604.1264321-1-f4bug@amsat.org>
In-Reply-To: <20200821174604.1264321-1-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Aug 2020 11:02:54 -0700
Message-ID: <CAKmqyKMZs=AWWfDXQQ6qD20=uTGo7NsNOXLGqfFn2wUztyBK5w@mail.gmail.com>
Subject: Re: [PATCH] hw/ssi/ssi: Set abstract TYPE_SSI_SLAVE instance size
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 10:46 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Set the abstract TYPE_SSI_SLAVE instance size in case an
> implementation forgot to set it.
>
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> See:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg731954.html
> ---
>  hw/ssi/ssi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
> index a35d7ebb266..b3e82470381 100644
> --- a/hw/ssi/ssi.c
> +++ b/hw/ssi/ssi.c
> @@ -85,6 +85,7 @@ static void ssi_slave_class_init(ObjectClass *klass, vo=
id *data)
>  static const TypeInfo ssi_slave_info =3D {
>      .name =3D TYPE_SSI_SLAVE,
>      .parent =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(SSISlave),
>      .class_init =3D ssi_slave_class_init,
>      .class_size =3D sizeof(SSISlaveClass),
>      .abstract =3D true,
> --
> 2.26.2
>
>

