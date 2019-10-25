Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939BBCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 21:04:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52BB921D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 21:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwAEImm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BB921D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO6ky-0007fq-VO
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 17:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iO6eL-0007YG-BV
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iO6eH-0003AV-Nr
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:57:32 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:46964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iO6eE-00037p-1s
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:57:27 -0400
Received: by mail-oi1-x22a.google.com with SMTP id c2so2466338oic.13
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gf/ivBmWo0KcWm5DRXGU2CbPoXQT2DBnasijPNq+w88=;
 b=gwAEImm7KdSnvxFhLCAUsbH/QvRWM4me6h2hqIBpscTZphQn0FAS/aS7EUwMRo8Qid
 EEwzEFc5/jSas4oftXpT36iHCOZTU/FL9WjuTGqrMKMsCJZwgGoTBeKl1cgah9C/CgqW
 6Oh7JrEG0y51fQrE2VEXhq7lgwoGn0hxOlzgPiZ9/Gdi40uOOKn+TYNDcntBYSzB2YXp
 5uVeKGwWGyvIpoyc/Aes7hch4e27HJTy4DXkgiZpLDGYjSXLAv132+CADM3pAHflqCM/
 FLERRo3gRnWwpPYyxWMqxfRvPoHX/YjZyrfdpAInd8Wv5z6Cv/C64eIx1GpVqgBtvxNC
 T7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gf/ivBmWo0KcWm5DRXGU2CbPoXQT2DBnasijPNq+w88=;
 b=o4dTEnnMEyFCOXBAaDXj7sYvktTrRCbyGhTXdaBkUzJariEkDckFsDCuRDcj+nksv8
 CnrE5YcMVtqaaXiTiyqmpO2meVjSitC172h8iuPDRlmFF7fprVVH3ghSSwfBsnRW3frV
 TvDhyhy2RKaF4azktZw6mkYPBN2pNm3ZISR1XHTDuumq3YoqAsKE3nz284wZq8IgzQ52
 VEBZe0eZ59Tvx71fsq0jUpaYtzT221rkg8/sF9+aLdfM9MQCUPOaBBQ1gDxnykg3l2Ow
 mCtTqUxhT0tJnNk6sJG3i9hE+rfMKVwSEOpTWggOF+/bEj7EoWOIOFmWuF849YBJt9Qm
 2nNg==
X-Gm-Message-State: APjAAAV0mbdCRp/QJpuTFojKttly206N3nI2IlIJ21O4QTFJQOv6E52W
 6PTJclscx3oPnBSqkvpeeUEfNyV12UwxgkxES4BXdA==
X-Google-Smtp-Source: APXvYqwcG9E+72UEouAH/tcu9+svTxjniND7tO93FMJGEiQB31DcuHvdrU4pFSh6CEQCdqbetI+DEZTwtqNUZ+eGIes=
X-Received: by 2002:aca:2312:: with SMTP id e18mr3660860oie.98.1572037044942; 
 Fri, 25 Oct 2019 13:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <1572021862-28273-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1572021862-28273-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 21:57:13 +0100
Message-ID: <CAFEAcA_+beScuNNgvuo+y2LnzS3g4LX8P79id+_fYYz9LKXJ=A@mail.gmail.com>
Subject: Re: [PULL 00/20] MIPS queue for October 24th, 2019 - v2
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Oct 2019 at 17:44, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 03bf012e523ecdf047ac56b2057950247256064d:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-10-25 14:59:53 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-oct-24-2019-v2
>
> for you to fetch changes up to 220ad858d3baf8b772cfddb8b657f9c799e98ddd:
>
>   tests/ssh_linux_malta: Fix 64-bit target tests (2019-10-25 18:37:01 +0200)
>
> ----------------------------------------------------------------
>
> MIPS queue for October 24th, 2019 - v2
>
>   - update of MIPS-specific acceptance tests
>   - other mostly cosmetic changes
>   - in v2, an offending patch (causing clang build error) is removed
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

