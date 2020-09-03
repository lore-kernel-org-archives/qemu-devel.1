Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23429C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD9320716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YacqIgbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD9320716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmYt-0008Ex-Q0
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kDmYN-0007md-2t
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:33:15 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kDmYL-0000rd-8h
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:33:14 -0400
Received: by mail-ot1-x341.google.com with SMTP id e23so2228728otk.7
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=V80vNAg/HOUUazKvW0DcPk5b7fBEIMqHUpgsEIVwMZA=;
 b=YacqIgbNe9WUOZhWa3ERcdZ1u51vTjW0YeX8pUWm367joc4rT+bxcJvZeKclFEHBy7
 mPWmb8pC3StqxcPehVEmkhY5Njj+vKdAgrt88TX6UhIZpQJGrrtOPbrgjxKIsaeyu14t
 kZXxmuyfGtggEmxF8mu0BG0JP6zWUrKL/UlKRAM7g1uqF1y7L339OUr7y51fVlnyiN9Q
 +vOraBheh7AzeHfIDISh88RPVjbxdYL7BgZLt1cQAUsNvcfOr6ZyM2xJhogLLC7Gkf1y
 YfC40kKDlUkLe5Iz8+Xs2aLZkV9z7AUlZLirHrB//SVYhrp6lzuR4KX82bBePFsURn+C
 1vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=V80vNAg/HOUUazKvW0DcPk5b7fBEIMqHUpgsEIVwMZA=;
 b=aIFxM95NG/b+mrROqneIze0bk+mHgOdHUmNetevCC0BiXtSOchbNL3apykxRJp2mV7
 ptXvLKNGY8HQnIrIJ538z7sdtygCEDff+DhnW+vU8hj3GvUg/djPyYFHKEGunTUZVVGz
 vxfcYzMJ4voK2/uJG0C1TXitLMoUFvX4EYgw9aiAt2Hhkr2qxxVBwbHtlVLUPYqL7JqZ
 YBhXRlBVtEw5RIrexE9jGNxzRJaz9ddXXMvWHFoA+8TsZ/iKmla6F8i22JgohGjWDHO0
 NB6pvV5yEE7WIis5lTWXe0wi7tuYTEqSh84Q4AwAssgh3imY7LB7wFvxIoTACOTWX5eX
 c+WA==
X-Gm-Message-State: AOAM532awyJn0N3lo/dYpQttDrHnQhrFitWgRJxEnsrotvUURSyHbE22
 ZrXgd8iDGT3ZtfIJvtqkV3T0Vds8DfdTB5F5T08=
X-Google-Smtp-Source: ABdhPJyAabJ/2hY2hmi8t9LrpdsPdV0wlKbvDJr5/KJ8ofss1vQgjXp5EqxaAvIFEYG6+JPKDsAs/ycpjP/JqXj2EOg=
X-Received: by 2002:a05:6830:610:: with SMTP id
 w16mr989235oti.353.1599129192067; 
 Thu, 03 Sep 2020 03:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200902162206.101872-1-liq3ea@163.com>
 <20200902162206.101872-4-liq3ea@163.com>
 <01e9f449-00c8-5a9d-b212-4df0147b6e5c@msgid.tls.msk.ru>
In-Reply-To: <01e9f449-00c8-5a9d-b212-4df0147b6e5c@msgid.tls.msk.ru>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 3 Sep 2020 18:32:36 +0800
Message-ID: <CAKXe6SKcoqAGP0TwbSwqe4=QC6b-841Nj4YY6c4WhPX2ZXVM9Q@mail.gmail.com>
Subject: Re: [RFC 3/3] virtio-gpu: make the IO handler reentrant
To: Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michael Tokarev <mjt@tls.msk.ru> =E4=BA=8E2020=E5=B9=B49=E6=9C=883=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=881:12=E5=86=99=E9=81=93=EF=BC=9A
>
> 02.09.2020 19:22, Li Qiang wrote:
> ..
> > @@ -809,6 +809,10 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
> >  {
> >      struct virtio_gpu_ctrl_command *cmd;
> >
> > +    if (atomic_read(&g->in_io)) {
> > +        return;
> > +    }
> > +    atomic_set(&g->in_io, 1);
>
> Can't we race in these two instructions? Both
> threads atomic_reads at the same time, both see zero,
> and both are trying to set it to 1, no?
>
> Just asking really, b/c despite of the atomic_ prefix,
> to me this look a bit unsafe..

Yes you're right. My patch is wrong. Here I try to address race
condition and DMA to MMIO issue at the same time.

I will first focus the DMA to MMIO issue in the revision patch.

Thanks,
Li Qiang

>
> Thanks,
>
> /mjt

