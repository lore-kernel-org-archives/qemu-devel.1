Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F339C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2691820672
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXy/3F+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2691820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKlof-0006HA-1J
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ngompa13@gmail.com>)
 id 1kKlnX-0005IJ-8C; Tue, 22 Sep 2020 13:09:47 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:41106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ngompa13@gmail.com>)
 id 1kKlnU-0007oo-RC; Tue, 22 Sep 2020 13:09:46 -0400
Received: by mail-il1-x142.google.com with SMTP id f82so17999691ilh.8;
 Tue, 22 Sep 2020 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HkH9Hdmp6ffRYOnf4zfREuzkQ265J69hGhZYTcSzlvw=;
 b=eXy/3F+DKFVPkPsVr1HqHKvTaDT1s3xKLiPpeqEsUyHt/RAZ1mk8PmXjMcWdvpHNjh
 ioFaGZtL1bz4anZvW1r9vPSy5ES3WPCsvXEkuFRmWrUPjB77ba3ezaverphupsXr/p3E
 X54y9QFCrCyw3Egvj/fN9fmbWqUHSNcddAMl8WlspF0BEk6nNlBDOs3OtxLGAiGV99QN
 h7qK74nznr5w1CV/4PPTKZBrQG+Tjeb2d/LsKE+1yH8HxN6qZw+bVJ1IxZDU5lKk5c3u
 6RfXmUpg9lzj/Vg38mshTVXF+Qh27mllrsrNUZ8ztpIb+wmgEzC+jtTF3n72LbBv5PVh
 FYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HkH9Hdmp6ffRYOnf4zfREuzkQ265J69hGhZYTcSzlvw=;
 b=KkWlj+mDWkJt6znDNVXqvObMZNa5hMXUwt+4ZVvf+mgIaPGA+U/zVl8+o4T6rgbYIJ
 anCuzTn58CEOpVDZAL1HOxxLCjWTpNgcuf6txh2cRYog1fX6HoQeYs8PhuCaupD0TFcz
 9GVQlkUDxdkCYklMUq3rXXbAwWGritZaDJoEqeY6mstfZW5Dw4D9dMAy5YkKret/AL2r
 lDAMJlB6Zcte6axgCFXl1ucyDq7HUEz5tduBok3NqY6+CO2CUmJ1FMIdB8FY+78R//ZW
 ZDoDb5LjlnfJ8M7ddMXJK8NLcHDlT8wG2Ac3QtP8Wtz/VSCGaQt80hVuIVREgSP81P7Y
 jTqw==
X-Gm-Message-State: AOAM532LjcBQ6kYfPd+Kx2kNlplSJbu9z9Wm8TgBl2Mf00zg/MWJWeQ+
 JXVtp/rv+RLVm0Ng0Mw+m7Vhn3Hno7kbuN+TX0U=
X-Google-Smtp-Source: ABdhPJwR33G/0sBPMZ3ZCUkdzvzaKcVW8/dJd58ats7jTGORfF7g4fu4Z/q8MGS2MlEtdU3gfRglaaTJhMZ7bXvRzQY=
X-Received: by 2002:a92:2901:: with SMTP id l1mr5132993ilg.10.1600794582613;
 Tue, 22 Sep 2020 10:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200922161611.2049616-1-berrange@redhat.com>
In-Reply-To: <20200922161611.2049616-1-berrange@redhat.com>
From: Neal Gompa <ngompa13@gmail.com>
Date: Tue, 22 Sep 2020 13:09:06 -0400
Message-ID: <CAEg-Je-td5R-pqbzUgpNYo856QnyfVafSh7QNNaWv8qvcRaJ9A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] block: deprecate the sheepdog driver
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=ngompa13@gmail.com; helo=mail-il1-x142.google.com
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
 Max Reitz <mreitz@redhat.com>, Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 12:16 PM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
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
> Daniel P. Berrang=C3=A9 (2):
>   block: drop moderated sheepdog mailing list from MAINTAINERS file
>   block: deprecate the sheepdog block driver
>
>  MAINTAINERS                |  1 -
>  block/sheepdog.c           | 15 +++++++++++++++
>  configure                  |  5 +++--
>  docs/system/deprecated.rst |  9 +++++++++
>  4 files changed, 27 insertions(+), 3 deletions(-)
>
> --
> 2.26.2
>
>

I don't know of anyone shipping this other than Fedora, and I
certainly don't use it there.

Upstream looks like it's unmaintained now, with no commits in over two
years: https://github.com/sheepdog/sheepdog/commits/master

Can we also get a corresponding change to eliminate this from libvirt?

Reviewed-by: Neal Gompa <ngompa13@gmail.com>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

