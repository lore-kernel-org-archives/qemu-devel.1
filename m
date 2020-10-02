Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C7AC46466
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 21:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E64B206C9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 21:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd+J8Gxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E64B206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOSYK-0001qL-F2
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 17:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ngompa13@gmail.com>)
 id 1kOSX7-0001KH-UK; Fri, 02 Oct 2020 17:24:05 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:41148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ngompa13@gmail.com>)
 id 1kOSX6-0003cK-7z; Fri, 02 Oct 2020 17:24:05 -0400
Received: by mail-io1-xd43.google.com with SMTP id z13so3064941iom.8;
 Fri, 02 Oct 2020 14:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gIiuo1pLBf4Jq9PO9PeIFSLtbYPidteAHp7odCDknds=;
 b=Jd+J8GxgJZUThnHAgST3fnRycbdw9XMRWhqWoU14XoRXQE87YxhZwhUlvJgJnjRkah
 6ZEILp9Joo393xI0uYSxN2ev/W353ltYXallFc8SrZNx+jJId4n8fi44bKfpQU77W8IB
 XzeYeNyjevXjimHuFq0YGDdhnmzthBdhB/JUslVsAT3DuxFs2YnlSToOaSE1hH6v9Zwb
 GaOBS92GeQTFUSBN3BNyOcLTiCUBp29TpR8y3SkLfZu4DRX8ljzF9EJrLA4mE7jjcXes
 o8IHfPTW13V4rTh3X1VSHcwqRAzmSHE6GD+PXflE6JOHpC1Zuq/wToLPX588OQHBtQP2
 ErFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gIiuo1pLBf4Jq9PO9PeIFSLtbYPidteAHp7odCDknds=;
 b=neu34VDwUGPdjWixob3CkYARDKs8Qt7Haz7kV2VhiwEactixcfh2DCFKX4jl4xvRqa
 ua2y18bVUBFoQ2hIQM3Rq+xjo350U5oUyxJ7A8WebNoeAINbphEzgDbfJrRi3gf9xLjA
 TZGX6F0mx/CEp71RonPjXqdWM8goTrpTG0QzMb6cKKfhoNsRzu6SV7EkMwsVRxwkrvEH
 i7QIufAISjlDCzV9uD9ju2gBQyg0hndi4RPBxF9K56Jcmq+yKaXDB8dJNNkH0HU7iIMl
 M2kAXaRqC1zu5apxIm7HDyu1mnWoWAnFmcc+87l5Y2oOxRQz9+C3UBnz+6vcTosurwF5
 i6hg==
X-Gm-Message-State: AOAM533wz7hRTa33k7baetk9xeGVptUrYZUPxdlwh60kmohlsyZ/68Fd
 7KmCMvSHT6esPQNCczE6C8lcFoqv2vWa+A7Z8f0=
X-Google-Smtp-Source: ABdhPJwrujnKCrlMnryaPWmQUyTGpFItQFJKxFxHZutwrIVEt+yhSwzWjzbfzpnt4hp5UVJ2DqpHDtBqY3pyFd7P4tI=
X-Received: by 2002:a02:8529:: with SMTP id g38mr3980202jai.47.1601673842294; 
 Fri, 02 Oct 2020 14:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201002113243.2347710-1-berrange@redhat.com>
In-Reply-To: <20201002113243.2347710-1-berrange@redhat.com>
From: Neal Gompa <ngompa13@gmail.com>
Date: Fri, 2 Oct 2020 17:23:25 -0400
Message-ID: <CAEg-Je_s8p6RSbpsxazV3vwM47JaJXwJBuHJjaFP6+_56p1uSw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] block: deprecate the sheepdog driver
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=ngompa13@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 sheepdog@lists.wpkg.org, qemu-block@nongnu.org,
 libvir-list <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Liu Yuan <namei.unix@gmail.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 2, 2020 at 7:34 AM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> 2 years back I proposed dropping the sheepdog mailing list from the
> MAINTAINERS file, but somehow the patch never got picked up:
>
>   https://lists.gnu.org/archive/html/qemu-block/2018-03/msg01048.html
>
> So here I am with the same patch again.
>
> This time I go further and deprecate the sheepdog driver entirely.
> See the rationale in the second patch commit message.
>
> Changes in v3:
>
>  - A few minor text changes
>  - Don't initialize static variable to false
>
> Daniel P. Berrang=C3=A9 (2):
>   block: drop moderated sheepdog mailing list from MAINTAINERS file
>   block: deprecate the sheepdog block driver
>
>  MAINTAINERS                |  1 -
>  block/sheepdog.c           | 14 ++++++++++++++
>  configure                  |  5 +++--
>  docs/system/deprecated.rst |  9 +++++++++
>  4 files changed, 26 insertions(+), 3 deletions(-)
>
> --
> 2.26.2
>

Series looks good to me.

Reviewed-by: Neal Gompa <ngompa13@gmail.com>


--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

