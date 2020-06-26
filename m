Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE34C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D24F2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKjgINhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D24F2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jopUX-0003rN-IO
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jopTh-0002eJ-4h; Fri, 26 Jun 2020 10:37:17 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:43657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jopTe-0006lS-Sq; Fri, 26 Jun 2020 10:37:16 -0400
Received: by mail-ej1-x642.google.com with SMTP id l12so9577401ejn.10;
 Fri, 26 Jun 2020 07:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=llQy5Q8/tEfF9bB8Y4Y1fpAyk/sk8BOml2tnJpCRedI=;
 b=XKjgINhdrDGMDOIzRHh/TbtjpWuky+5BmBvMYV9GrTN6E0xfukgmncGByqzueXidFs
 K26IS3Ba423oFZNUG43bvAzQFE9xmmJzR8c/0u9St7afuqTZ1ZmGDdC0TGxJAwyvUQ2l
 wNClbJ2JOAFZb5mjkKgLhD8LXvv3hm9Ibqj4bmTDnxWFzkqPSDvJ3ykU9DsTgOTFiUka
 1Dw+qUxjR4A/NLUWAqHn03XhU1SgTlws1fzHNoUoK10xPv0z2huQkUEKW0azshUin9dW
 g46o55hLreNCod4trcTaaDmgFelBUCmfp8+zCKh1/WemlhQU6hmFlLMlwRanFBGkqSi7
 j4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=llQy5Q8/tEfF9bB8Y4Y1fpAyk/sk8BOml2tnJpCRedI=;
 b=YLBskXvAzrmmY9vhA3lrmOht3R1IlMsndUPX156IZ2Fhv2s+f0AqQI6Ul6lAYorifO
 UEEq+NI6z4JgWAXRVEpvdWnHBBES9Zy/aCTYo8QdxRnJ3EQefVkOemXXQc9MRq4wOx0W
 d81Dhu5OwUXwQtG/VJm/U4Y5cx1eT6IQRvHnTyw8VUDRNIBlN2n+NM7tpr4euKVrVkj0
 XAGsz1otPcvEaHeIlNIq80BxhCfPzknstp0bwiPN/cN2AiukBk1/OIZrI9LYxc3oijud
 S1Qy8goh4WArgWfujhcfHoQFyxHO5GerD/wU+keJsnpKPQCkf+c4ernGPBcIMy9KV+7L
 JbRQ==
X-Gm-Message-State: AOAM533sNDi7HlNvR3rf2bXbujXvPN9tvb63NLP19cP2CP3Rovr3wgyU
 DIjivMRdP85q+HOZ/L0qTMJJxz1DptwazJ0bCMY=
X-Google-Smtp-Source: ABdhPJwmSJJ8yqCAkt2B2rNEY5W9JR45DfQFt0hW/uw9w1Hc6kvbnT2Xar/Ax7Dn22Dg8rEnpDP+nNvX6qP7G7/wXBI=
X-Received: by 2002:a17:907:100a:: with SMTP id
 ox10mr2730214ejb.351.1593182230548; 
 Fri, 26 Jun 2020 07:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqwDLw2BJ9Cf0kEyUW+J+rTPOOvebRPPkBSiWdD50wct5Q@mail.gmail.com>
 <CAFEAcA8mpiPcwgz9-7c0GgSWz2hujzegOBvHn5qasCBtuyG8ww@mail.gmail.com>
 <CA+XhMqwyRmQ7Dtawm4tMEMRJ9EEfxep8WC6qSRCEC_WyUptG-g@mail.gmail.com>
 <CAFEAcA-fj++yDKCbvfXWduVxTPsAhSkFKpEHcvcCvpdO8H0Cdg@mail.gmail.com>
In-Reply-To: <CAFEAcA-fj++yDKCbvfXWduVxTPsAhSkFKpEHcvcCvpdO8H0Cdg@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 15:36:59 +0100
Message-ID: <CA+XhMqyecFYzy3zBHHk9Aazx5_e3w5xbwX+jmgnTCT0-VAdMLQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] haiku build fix second batch
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No idea if I ll have energy to redo all over again I lost previous
patches. Fine no problems...

On Fri, 26 Jun 2020 at 15:33, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 26 Jun 2020 at 15:10, David CARLIER <devnexen@gmail.com> wrote:
> >
> > I sent again minux the ones already approved.
>
> Sorry, I intended that you should send the whole
> series, including the ones which I've reviewed.
> (Where I gave a reviewed-by tag, include that
> tag in the commit message when you resend the patch.)
>
> thanks
> -- PMM

