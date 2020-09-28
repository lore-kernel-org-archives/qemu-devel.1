Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3550C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63EDF207D8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CqLu9BcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63EDF207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtaX-0002Qp-Hw
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMsqw-00089W-EZ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:06:02 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMsqu-00014T-9W
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:06:02 -0400
Received: by mail-ed1-x542.google.com with SMTP id n13so1211696edo.10
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6ZfFrJJxeX4KzCfpX1TEiuYfvDOPxHkGBnf252tKC48=;
 b=CqLu9BcXoixyNmDodIRHyKK0cHkKBeGBGWkecVX5liPWerSeP0NMt8fFt+rTuz0aOL
 UXMiAiFPRWCjV0UiIU2iWF6eV8Fy0pfDQYhbn1rjCtNha7Eg1nDwvjf3+7hJFFemElSR
 mb/PHgTO0wWwMuS9EJM9ghnF4X0RFo4fp1hwOkGjV5pgkZtmS0YfybkM4pGsM6Nh3DOl
 hISgodF0YHWlDuqqU/4sZvT0w6qn7miMRUZag3QgranG7shbm/++5aGxzw9pzflvNNOk
 12dR44NBNbEmsys7Ub8RDvZ4DtrjdQlKxJBNILLSnBy/PqqTk8EWZpGBkOTe3TJV1Xcu
 R8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6ZfFrJJxeX4KzCfpX1TEiuYfvDOPxHkGBnf252tKC48=;
 b=YAr8fe4x8LnR+pezmjUOV2w3SNzDuIvnUzl1j2T/Vf0ovpUhQ/5sT+MLRHOvSShfcy
 hWYM2yDNGBb0svm+ZhYTZncdda8voQpbNHCsy1tozJR6vY7XjMv/08/9gO8UZOoowPU3
 sBJB1fxe1DPOasFKl626TLmsrGM/GtV0YSsCkvJbjpnX4MILuj+aUbf5WF1r8MyKah1g
 1TuU3nu7OLFTiex50fh/xW5SJtk3wXownWRTz566XAbfccWJrQ4k9KWMWM8EfK7KkStC
 7GQIHYVuzRQUHnKRu5PsBO+alMVGTCBYFxdnfIzjWPXzHrvWXrkGArl6Y/cdU3YdNF7D
 dWtg==
X-Gm-Message-State: AOAM532tXeO/4fuorSdAZOcN80490sVN3xYUuxfvPfgsocMt1n85n9dl
 jVA4+rs3ca2/jE9lT+wPrzjnUgyZ7aM3CvmTNnxRvg==
X-Google-Smtp-Source: ABdhPJzbwLRyoNoHkqeeLCZCbPopnA67pxhtd0QLbuNS+KK0MOBrpDPgrjUV4rJouiB0K1LZh2ZZ8YlHD7lDFpx92wU=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr1574937edw.251.1601298357617; 
 Mon, 28 Sep 2020 06:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <160106193961.10465.12078546060105198824@66eaa9a8a123>
 <CAFEAcA8uWY+MCDToz9an+zsrMVrctkBmgpMV82iUR2ZZOgA3Vg@mail.gmail.com>
 <87h7rif3x3.fsf@dusky.pond.sub.org>
In-Reply-To: <87h7rif3x3.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2020 14:05:46 +0100
Message-ID: <CAFEAcA9TdEPAHECmLAA3nOzUBEzcpis=OL7MFmMv-76e4yS6+g@mail.gmail.com>
Subject: Re: [PATCH v6 00/21] Convert QAPI doc comments to generate rST
 instead of texinfo
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Sep 2020 at 14:04, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Fri, 25 Sep 2020 at 20:25, <no-reply@patchew.org> wrote:
> >
> >> In file included from ../src/qapi/qapi-schema.json:78:
> >> ../src/qapi/migration.json:1747:1: unexpected de-indent (expected at least 13 spaces)
> >
> > This is yet another mis-indented line in a change to the QAPI
> > doc-comments (commit 4c437254b807). It hit master in the
> > latest migration pull after I'd sent out this patchseries
> > but before patchew got round to testing..
>
> Obvious fixup for your PATCH 01:
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7d9342c064..7f5e6fd681 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1744,9 +1744,9 @@
>  # Information about current dirty page rate of vm.
>  #
>  # @dirty-rate: @dirtyrate describing the dirty page rate of vm
> -#          in units of MB/s.
> -#          If this field returns '-1', it means querying has not
> -#          yet started or completed.
> +#              in units of MB/s.
> +#              If this field returns '-1', it means querying has not
> +#              yet started or completed.
>  #
>  # @status: status containing dirtyrate query status includes
>  #          'unstarted' or 'measuring' or 'measured'
>
> Happy to fix it up in my tree.

Yes, please.

thanks
-- PMM

