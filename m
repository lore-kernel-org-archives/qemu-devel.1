Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F68C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A787220707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQMpBdrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A787220707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAu4t-0005AH-0Z
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kAu4N-0004jg-21
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:58:23 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kAu4L-0001fa-Fy
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:58:22 -0400
Received: by mail-oi1-x243.google.com with SMTP id j18so1266018oig.5
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 04:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xsLInl26U8XbukwlcF8qNHkzvxdYHJzG5T8fGedKqi8=;
 b=TQMpBdrZ5TN1pMCE5gyk1VhUqmXCW4uEm8RzWW+alANPMiNTDPjeAuk+dLG8yVwizS
 xDH0TYDpCMulaeDBElph9/s5fNIqL4UIQyTySXKD3Ep+UDqd45ac+NtgRJg1pIxaBOEa
 n/cDhFyC6rjlqf9Ee2O2t7wd/Agfco/vMMSbq2UcGm8slDo3drxBjQ+9s6A+sBK+Q+Pl
 DVEaO3AnIZyr8EEeI53BnosxT4vRecWuWTVIr/TzvX6HxzSPiahF3sYSRIO1RdSBDjbV
 nDaXeuTXGCBjlET6FdKXGmsSTi3qp298JVCUeVtYuOMM8iyuN6adULAqHhWcnMsinr00
 Y2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xsLInl26U8XbukwlcF8qNHkzvxdYHJzG5T8fGedKqi8=;
 b=ZrDGR5ROGdNK0LCtv2CoWI3EJIPrtWnzgjrIuuErOnk69zpZDd31T3i2P+Wojqpk8O
 7ZwT092N3xHHbbgP22+mXEFPJ1gUdnUC+lyHl1LToWQF4aPj9e1H4+LPBoN31DpiyIAx
 /uyT5ACG8uPIO+ymRrJRowSSXNCGX43EMoYrnxbeKl35O/yBA4bo3jSR67LVgKOu3QCG
 i3Do7uZxlXJX7MhCJ3WhvKSI3NeOEqMLIKWDcKHmaQ8NZMzARuuJBPefc0wApKukvDXF
 YfZoNYnax2BeglbZFWaApp5DPkUK41x0Nkynkduxs8WN6ncg5MS9yXo3hnTeEa9SeyaF
 xkRA==
X-Gm-Message-State: AOAM532xlYo3UjmEPEHad0pA1jxCBGtgeWMEpNgOrSSq/Wd0Mrs3LyM/
 YYI/qIMTXRfmRv+Cu4c0HRfzzyoFupGBuUBIV2k=
X-Google-Smtp-Source: ABdhPJwGAMT1eVFNHtBaaxPWT/AahYfr0UsDAasPAdbJClFPUdxj25/TNLNxMueSa1z+CJa6KaseluIM3SI7SzVMOtI=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr3885813oif.56.1598443100306; 
 Wed, 26 Aug 2020 04:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-2-pannengyuan@huawei.com>
In-Reply-To: <20200814160241.7915-2-pannengyuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 26 Aug 2020 19:57:44 +0800
Message-ID: <CAKXe6S+Lvm+a7=HZJ9FWoXEnTYTzoJMP1qkJscvsN7dCDiV1FQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] qga/channel-posix: Plug memory leak in
 ga_channel_write_all()
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
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
Cc: Chen Qun <kuhn.chenqun@huawei.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Euler Robot <euler.robot@huawei.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:30=E5=86=99=E9=81=93=EF=BC=9A
>
> Missing g_error_free on error path in ga_channel_write_all(). Fix that.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  qga/channel-posix.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/qga/channel-posix.c b/qga/channel-posix.c
> index 8fc205ad21..0b151cb87b 100644
> --- a/qga/channel-posix.c
> +++ b/qga/channel-posix.c
> @@ -249,7 +249,7 @@ GIOStatus ga_channel_write_all(GAChannel *c, const gc=
har *buf, gsize size)
>              buf +=3D written;
>          } else if (status !=3D G_IO_STATUS_AGAIN) {
>              g_warning("error writing to channel: %s", err->message);
> -            return status;
> +            goto out;
>          }
>      }
>
> @@ -261,6 +261,10 @@ GIOStatus ga_channel_write_all(GAChannel *c, const g=
char *buf, gsize size)
>          g_warning("error flushing channel: %s", err->message);
>      }
>
> +out:
> +    if (err) {
> +        g_error_free(err);
> +    }
>      return status;
>  }
>
> --
> 2.18.2
>
>

