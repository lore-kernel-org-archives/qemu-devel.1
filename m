Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DCEC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EAF022B4E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkwsSM9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAF022B4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxVji-0005RY-FV
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 09:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jxVj1-000502-SF
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 09:20:59 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:37904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jxVj0-0002Yp-61
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 09:20:59 -0400
Received: by mail-ot1-x334.google.com with SMTP id t18so12127309otq.5
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6cvrcLMPloJI7battwfXerfrUbUDXKtE35mRQSAjw/4=;
 b=XkwsSM9xkbn+axwQOuhDptNLdZ8M0rLhx0aFUOIlr30dT9Jzv3KPMtegrJqh+C0Qpd
 w/OdivFaZEUCFE9J3URmsNpX/xEzPpfr7sCGCt+BB7nnKDTrb6U2Lj+0KQJECQ9Mwc1R
 a4kCts08ENG7gA2mE1tlt70BwtehH/IBhZIjvO0ltr3tRyUKJk1oMQNE4WEDIYcZOKwa
 WVUWXzKeuJ40H9rhNCgi+nCmdh+SE7bwthLOy6U/T98abebClA4T4L55Xpg1+iYtfMBK
 XF69ts2VLK8qpOc7SSypMMndLDgMSIV/JQn5bpempLacj9bVJ4lLIw3oLmBC6cObufKA
 Mv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6cvrcLMPloJI7battwfXerfrUbUDXKtE35mRQSAjw/4=;
 b=Of0tUmCfYuBuJQ+/St7nGt2boKk67TN+tHwnzBkcxBhTCh20x7lvL77yj3EyX9qWYl
 z8wVFL7eVCyAZAgytud3mXtEbZczudJ4iGuDQG4gomjtb5yBGbFNr8GyuS+QAoc7v9eh
 NCyYN/uRSASqfC63yoISwQlyGmDqJFnpnlT1cWG7epJ8tbwPtFzCuMnV82msNzPznTeP
 NJbjRSmkDqzrjQe1Dwomi1yduvzmO6vQjvKo1/2KMkMJOLiAsN4IN04EPXZSjJ4DjPdk
 nMRD8c8rjw25j57FJwhJplLWVVFbr8OPcg7xwhqixnCrAnFR1SaipuIb65dj0oqRyazx
 Ox5w==
X-Gm-Message-State: AOAM532iMpbwZGK4+lGGINCzxvzqeOLlXMgxSjypxFBmBwtkkvUKHr+9
 J4BeP1keErtOLuUP14hR2RfNXlqJ7azV0sbdVvs=
X-Google-Smtp-Source: ABdhPJzVQ8JJjmOqTdkkJjRDxQfHIJ99B8RrCRbDdNnjzcLWbPbzudhp1Z/Re1oda8/d6M8+VEQ4qbQE0chgvYsjRYg=
X-Received: by 2002:a9d:787:: with SMTP id 7mr19468874oto.333.1595251256961;
 Mon, 20 Jul 2020 06:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200716192335.1212638-1-ppandit@redhat.com>
 <CAKXe6SKL3aNiOKKLEMof6GGNjYLcX9fvfSf-0PBSX48rh4--FQ@mail.gmail.com>
 <20200717012151.tlfmc6hsfia22f4e@mozz.bu.edu>
 <4e4909ae-db2f-4a32-ae5c-d52149e80a8c@redhat.com>
 <nycvar.YSQ.7.78.906.2007171016480.950384@xnncv>
 <3620abab-a464-8e3c-d5b9-0bd80b35e2f1@redhat.com>
 <nycvar.YSQ.7.78.906.2007171326100.4380@xnncv>
 <CAKXe6SJbJaEepRVFtNy=5fhJrw8+Gax=mcwFuhfXrHTgo+wmog@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2007200752230.4380@xnncv>
 <20200720033304.sttpqr337xsf4rna@mozz.bu.edu>
 <CAKXe6SKV8=B2rb6EY72W17r6-oz5nx9VQndH9gSyafubOU4rJg@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2007201822290.4380@xnncv>
In-Reply-To: <nycvar.YSQ.7.78.906.2007201822290.4380@xnncv>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 20 Jul 2020 21:20:17 +0800
Message-ID: <CAKXe6SLxxvCkwekVqZSQP68bAME3=wu0wxzzn1JCmb2UaR0OZA@mail.gmail.com>
Subject: Re: [PATCH] net: check payload length limit for all frames
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x334.google.com
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8820=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:57=E5=86=99=E9=81=93=EF=BC=9A
>
> +-- On Mon, 20 Jul 2020, Li Qiang wrote --+
> | This seems is the same issue as LP#1886362 . Look at the free path. Her=
e the
> | 'e1000e_write_to_rx_buffers' trigger DMA and then go to address space
> | dispatch. So the DMA is not RAM but a MMIO range. Then we go to another=
 send
> | path, and in that we frees the 'iov'.
>
>   Cool. Thanks so much for the confirmation Li.
>
> | Alex do you tried my patch to solve LP#1886362 ? I have tried it and it
> | seems no this UAF triggered.
>
> He mentioned that your patch fixes both issues:
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg05367.html

Ok, then let's focus that patch.

Thanks,
Li Qiang

>     ...
>     > On the other hand, I cannot reproduce either issue with Li's patch:
>     > Message-Id: <20200716161453.61295-1-liq3ea@163.com>
>
>
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
>

