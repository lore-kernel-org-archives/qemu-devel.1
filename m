Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A0DC06517
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFF6218A6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlsg7fjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFF6218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hizEA-00085b-NH
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 06:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50383)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hizCm-0006ij-QY
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hizCk-0004AB-RW
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:43:08 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39774)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hizCk-000494-LF
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:43:06 -0400
Received: by mail-oi1-x244.google.com with SMTP id m202so4601764oig.6
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 03:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aTD4kYXTKhIbspsnLWc3FKHoQnDn0j8oDEKhaY7HNSM=;
 b=vlsg7fjRufkcg2NVfOZYzIXcVgcvSUtOwFwBI1Ju/H8FhJVYmEfsM0wYr+9+aV/AML
 yxVJVBDO3tjsRRcDeG9YWc2j+xs7Sb0zmCXJFqixu0rfRp2j2i/sNIu3hOt/m5DdB802
 JnZqYB6Ei2AryM2kce6mvavaz9DiX2+gpkQ8sviQWRDn6wK5K8zYieFG01VGtozr2ec3
 BmCd0CbPrxe0u358x4bYiFY/p5Jh3OBVP7fJpENwsGvb/c+CRofnVgM/uxhCsA5lwa3n
 vhMHTzX0uqDNsKO+9JizIDxK3Q7bOnd5nH8HbknMFmZgNll2URPyxH713uXbfML5ibkI
 P06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aTD4kYXTKhIbspsnLWc3FKHoQnDn0j8oDEKhaY7HNSM=;
 b=mJEkp9Yg6EL8wqTgmYsLHubCWkaBjQUmTeuWM8J2tAd7PIFr8U0QM2mO23ZcOtSnRH
 Y9vlE5f9nyExjf+jMQyBmzSp3bFG4vXSu2p6anH+JGIczeKpOXWHzdUmlCqOg3N3pj0C
 rnAusJqWbeUhfRSRE9fb34WMYWEqMM9As1lwWnf2cBDyAtgKvL/mjtNVDxmENvndEGXC
 g8191/oFpATHTRBoCnk5mGxmUCsbI3XLkN6Cn/xly9V+HWcDNCxXRLQ45RBmWJeDorqk
 t10587e28qtuyTYsFg8E3lcY2P83RMbT2NgIBDXkxsUbzcuyZSYUghfulS9YS+jF0DXJ
 Yd8A==
X-Gm-Message-State: APjAAAVk/seAvjnN0Yg1aHh90n6t9xPunPDhhqZYTPlZMOEtZurTEYX2
 +5OIdE9iHRT6GSUYB/Ol09H7PR8KgDS6fgefPMeuhg==
X-Google-Smtp-Source: APXvYqxMQ8FvAe82OAJ75fKemYmYYbsiO0WGZyA7jJx1d7c7zFM5NdE3v3Ukx4t2pfwMtkNZuTCqxEKdbHXSIRhkL1c=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr1402704oie.48.1562236985537; 
 Thu, 04 Jul 2019 03:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190703190615.31436-1-ppandit@redhat.com>
 <59f87427-3d1d-928b-ac87-0a0a4049c4f5@redhat.com>
In-Reply-To: <59f87427-3d1d-928b-ac87-0a0a4049c4f5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2019 11:42:54 +0100
Message-ID: <CAFEAcA86=RDpZEzWF_5QL_ix8Bghqxvn7ykXUBkAzTWp7KUVcw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH] hw/ssi/xilinx_spips: add lqspi_write
 routine
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Qemu Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Sai Pavan Boddu <saipava@xilinx.com>, Lei Sun <slei.casper@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jul 2019 at 11:11, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> However, looking at the datasheet 'UG1085 (v1.0) November 24, 2015',
> Chapter 22: Quad-SPI Controller, I understand this region is only
> accessible by the CPU in READ mode, as an AXI slave.
>
> So, if we model this, even logging LOG_GUEST_ERROR is incorrect, we
> should trap some AXI bus access error.

Well, that depends on what the decode and the device really do --
often datasheets are pretty sloppy and just describe what
software "should" do, not what the h/w does if software does
odd things...

thanks
-- PMM

