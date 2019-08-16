Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B05FC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 17:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F562077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 17:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDCC04QY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F562077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyfdm-0002ND-Hm
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 13:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyfd3-0001u7-PU
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 13:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyfd2-0003c3-Fe
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 13:03:05 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:35248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyfd2-0003aO-9Q
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 13:03:04 -0400
Received: by mail-oi1-x232.google.com with SMTP id a127so5307897oii.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=EnDyMN+rhojozlNJEzGWU4Y/VDGr+vYeltjikuxAvzU=;
 b=VDCC04QYcsQ1Ywyu+8fcLArFUsjvVsjkH5xreLM7KEkKk0q1j+0ZT7L2divFZ6JJkQ
 NC81mQlssVDcdRV9O5e9p9DKSdYq3L+PFctg8omgKRoFzrt4weeB1PKqQkVYwDIPrsS3
 XOAXWhcOlLeAZIhRRF0blPKGuaprxVbOJib0eHzwem9FMqzXcp1KX492sWmKTHCll6CN
 I0ePwry90jTlDfHzSppZlfXBdnXvlhHo7dNJ/u69JBiZrzTEkE71CdI/mzqPATIG5aRE
 6cwkppUOBtkOMCnu8Ok43pGSnU19Xv7D5xXSJTy0mogPXW//Rofx9aOoASjMTtcRf0ZE
 N4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=EnDyMN+rhojozlNJEzGWU4Y/VDGr+vYeltjikuxAvzU=;
 b=aIU6gXYVatOmtzaQfOKDioc7DEAW75Mt3Vr97Xeh3jjr/V4kvq7Zve1RQz0yIxQjgE
 6p0bPxuZAsyglywBFV//QmuVO0mX63wdlUXffRzmjpUtJM5wMPgL1MPinm+8OgJugHpc
 weUrogxqHGkt6oqobdVQlBj6coNe4V7EwSSZarpthlNq54mDmSK3cppHlMlZ9LYWXAz2
 WNZnvAFYyTDHYaZGVE+x7GcSUYWip4n9vaa0r0WfH+X+/cW7mSyGnqslgC8rH4C5wsrj
 SEkQQ8TF9qabv6L4Vz5a8ECrSjA4oUnnCUrXfbJqueIWr2v/VLo5tIXJSMjuPRwKKOhL
 uCvw==
X-Gm-Message-State: APjAAAWLclB1IYouWxegHJV8VP9IPl/EzUArfE62jOj31wsPl7uPJsRB
 8NonZGQIHEHrq2ItFK+CTnhFqPQR30o+KCvxgmxMRvvU
X-Google-Smtp-Source: APXvYqwDDE0JGmE2/zYx+WaJsG0V4dloOEku16vZg+QPOu7nrLZ/s6Do7cSJ+NEffmY/5F8lfkJSTxC16VAUtAbDDBw=
X-Received: by 2002:aca:6185:: with SMTP id v127mr5754037oib.163.1565974982898; 
 Fri, 16 Aug 2019 10:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190816131719.28244-1-peter.maydell@linaro.org>
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Aug 2019 18:02:51 +0100
Message-ID: <CAFEAcA-cC_53OMJh_d_daTg6NBUVhGugvmbFqAJCdQhoY9DMRQ@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
Subject: Re: [Qemu-devel] [PULL 00/29] target-arm queue
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 16 Aug 2019 at 14:17, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> First arm pullreq of 4.2...
>
> thanks
> -- PMM
>
> The following changes since commit 27608c7c66bd923eb5e5faab80e795408cbe2b51:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20190814a' into staging (2019-08-16 12:00:18 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190816
>
> for you to fetch changes up to 664b7e3b97d6376f3329986c465b3782458b0f8b:
>
>   target/arm: Use tcg_gen_extrh_i64_i32 to extract the high word (2019-08-16 14:02:53 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * target/arm: generate a custom MIDR for -cpu max
>  * hw/misc/zynq_slcr: refactor to use standard register definition
>  * Set ENET_BD_BDU in I.MX FEC controller
>  * target/arm: Fix routing of singlestep exceptions
>  * refactor a32/t32 decoder handling of PC
>  * minor optimisations/cleanups of some a32/t32 codegen
>  * target/arm/cpu64: Ensure kvm really supports aarch64=off
>  * target/arm/cpu: Ensure we can use the pmu with kvm
>  * target/arm: Minor cleanups preparatory to KVM SVE support
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

