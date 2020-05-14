Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE59C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6E52065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eodUBwEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6E52065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDE3-0004uB-Rk
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 08:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZDCh-00036U-Fp
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:43:11 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZDCg-0007mv-DH
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:43:11 -0400
Received: by mail-oi1-x243.google.com with SMTP id v128so7566631oia.7
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 05:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yhcEEKeDt1+Oysa6f9yYfKb0i5g/9aIadZPVlgSEpSU=;
 b=eodUBwEazMuofMRe5flRoAT4WkYF7OhAegpbA78ad3rv3DTU5e8e3RbWSQ1iTS6d5H
 bpWR1CoI+yLV1yzxvsPpBucjbrCR4iwQYnvRmebPTE5Qf9nYyTX/1aosHPaP0tmaZB/K
 UCawyh1OqRzzEhdFrFIGZosk6xt/uunQZZjAbZCd94ouC5QyBTT6IxMfpvort8vVQ8PN
 JNzVIFNTl8PkSTl4myt5/EMe6r2LGWefN8/RcmDjHO9uz5YnN8jyaDVbL2G0XgAqggSF
 MWDXkseD3hcTvQ4LB1xz9Me5qyWFR3FZo5E3kLSXyvA4xPWoom9VtKFxqsQAy7cxlz4m
 fL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yhcEEKeDt1+Oysa6f9yYfKb0i5g/9aIadZPVlgSEpSU=;
 b=fdtDVcgU5Nq2DPgtxIcqTm5NT9MOY4j3qdIn2HDtqHeSZg1tpp8vSXU3eAHZ8Z7O8a
 pi8X+BzT4dFHuyJhJ2AcTZVD2Xb7F/5ftaLMOBqxanF6giOyghL6///eJYOBdTq5zlq2
 ThLzgyG3A7o8+PTmg7gBFAd2K99LHZm2nSt0WsSvjLBNtWAT+CITsyVUQSvaprk1PUoP
 5jAi8YIutmhQnVeWfaR2DzZIgxkjl/MolJ6UzIJ9JyWUp9M/vOSRD2MiFAwt1EqzBXS4
 F3EF3Ri2hmP51+EQdrwYCyKMgd+mgu6Vz9Axptq/NEDBFUrAw3uB+fn/LGR/wpSPNJyd
 dhIA==
X-Gm-Message-State: AGi0PuY4k3WF7qqgewLxJZ+pymp/7kADTWmt5x4L87mymsvBh+SRdBV/
 0TZ+57CYWB0VoAc1TcAoyWWikZKLLy9VMlQuFEPeCg==
X-Google-Smtp-Source: APiQypLlviM2O0oU64Vw1pLseUYfMvYpMDS2+1g+kRZlrlw5H1kbOE6cQmwHMaP4de2Hroj2S7AR3gm26CpQ4yDOxP4=
X-Received: by 2002:aca:895:: with SMTP id 143mr30523705oii.163.1589460188702; 
 Thu, 14 May 2020 05:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200512064900.28554-1-pauldzim@gmail.com>
 <20200514122223.hyffhhvjkearqgao@sirius.home.kraxel.org>
In-Reply-To: <20200514122223.hyffhhvjkearqgao@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2020 13:42:57 +0100
Message-ID: <CAFEAcA-kKtQdt3TvSFaxxO=c1kTihmxEJj49U=REWmBxNtHamw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] dwc-hsotg (aka dwc2) USB host controller emulation
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020 at 13:22, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Mon, May 11, 2020 at 11:48:53PM -0700, Paul Zimmerman wrote:
> > Gerd, Peter, what do you think about accepting this patch series? The
> > only possibly disruptive patch is #5, which modifies the dev-storage.c
> > code a bit, the rest is all new code which shouldn't affect anything
> > else. Felippe Mathieu-Daud=C3=A9 has done quite a bit of review of the
> > patches, and has said he thinks it could be accepted now.
>
> Looks all sane and passes basic tests, good.
>
> Will send pull req with this series (no other usb bits pending atm)
> in a moment.

Most of the patches haven't got a reviewed-by tag yet...

thanks
-- PMM

