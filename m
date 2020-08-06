Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4475C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5CC922D0A
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tcNccYcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CC922D0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3hu4-0005fh-N6
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 11:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3htN-0005CZ-4b
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:33:17 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:39093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3htL-0003pb-B8
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:33:16 -0400
Received: by mail-ot1-x335.google.com with SMTP id z18so16002242otk.6
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 08:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bTHLTKHXe5989VjuocNixbX+xfVXIB2VWuX25G7obsI=;
 b=tcNccYcpheTkFIT3qTJsugBNSrBTjLlWSi8x63ZHlasasqC2h7k2XWGntDTsMPpsVm
 qAMcCcpWSamNf0x9smNRxWRFznx0T9REslXWQ6ESXZ3bgK3hemZluBLlSSIdU4cIJOfV
 mPf/st03soIOA1OLX90EL1N5FaDPZTKhYjDrlMEXBfOZiWMl9VgKjQ6Ga1m1S9TWx8MJ
 J62H8qiKLL270nefLdI35Ivw2WkwMSzSpmn7w0PTMZLZaNGoixdfhzhSD34F5znLccJh
 aI04hPYu3K2PV7CS8iz70WiRbVpuHoet/XgGmt7OU4Pta0MuGIZp97Hde1xtsCSbRB0p
 PWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bTHLTKHXe5989VjuocNixbX+xfVXIB2VWuX25G7obsI=;
 b=S/PQF+3tOYQYBKpiZv6EppNKtN9/5NZzMDMzeOj6spqNfjqamB0JBXmehCL9ANPqaK
 Ebn6qPGyeCaD0dBEMHvlAwA/m6G0yVEkg1LV5fdsvQSqOjoadiLVeasSMjCfB7Ua3wP5
 2JzPxdDRY8C6CN4iNXRs0m2wXEtVGlMgZzCJRrFwIYv0h48Q1enKPKmodNSVrHCiMMkQ
 vKU54C9kZpNdFxYHp8CRIWsg+6m4MxOX2tZSie1WXEJ7K7GGXKQaAIzrNaMt2b600bpB
 x739Hy+2Qv7r6YqNSjR6zkoaaUdy68QMtznFoasgryJKICzuv9rSLDTzck7afwSyfpH7
 pEpw==
X-Gm-Message-State: AOAM532RxSknWIHkl0MhZGDyaOt9ifwZAb8WjN3W9oKBci6Nz+VP8C82
 2GYMtDW15CxgcrEWXGrJqdMV/VlKNTMH1QNQbwhdQw==
X-Google-Smtp-Source: ABdhPJwKwu4B3Lw+fa24Vsity/LKjMH4ZEBMvtarcL2FZpRjhqWYhVzvSVHwo2XP6DDMVdATFbmS+jRpHX1NAD+I6zM=
X-Received: by 2002:a9d:3b61:: with SMTP id z88mr7945994otb.135.1596727993399; 
 Thu, 06 Aug 2020 08:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-5-peter.maydell@linaro.org>
 <87eeolnt25.fsf@dusky.pond.sub.org>
 <CAFEAcA-nk3+W-on=tsW_8OY==MriMyeJFQ=_tFjHkaoj5mUA_A@mail.gmail.com>
 <87364z6de4.fsf@dusky.pond.sub.org>
In-Reply-To: <87364z6de4.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Aug 2020 16:33:01 +0100
Message-ID: <CAFEAcA-NX7mDthCwNKE+zQxfrmJ6D61jknMMubWf6Ym7HEncDA@mail.gmail.com>
Subject: Re: [PATCH v4 04/18] tests/qapi/doc-good.json: Clean up markup
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x335.google.com
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 15:46, Markus Armbruster <armbru@redhat.com> wrote:
> Remind me, how is messed up doc comment indentation reported in the
> brave new Sphinx world?

For insufficient indentatation, like this:

  GEN     qapi-gen
In file included from
/home/petmay01/linaro/qemu-from-laptop/qemu/qapi/qapi-schema.json:91:
/home/petmay01/linaro/qemu-from-laptop/qemu/qapi/machine.json:194:1:
unexpected de-indent

(where the quoted line number in the .json file is the line
that was insufficiently indented).

If you over-indent, then the QAPI parser assumes you intended
to use some rST syntax which needed the extra indent, and passes
it to Sphinx, which will either interpret it as per the rST
spec or complain.

thanks
-- PMM

