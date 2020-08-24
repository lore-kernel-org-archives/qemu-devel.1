Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349A1C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 21:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB22204EA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 21:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQ0+Fotk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB22204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAKRf-0003ad-64
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 17:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1kAKQA-0002xy-N8
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 17:54:31 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1kAKQ7-0007fL-SB
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 17:54:29 -0400
Received: by mail-pg1-x543.google.com with SMTP id g33so5320832pgb.4
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 14:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DbD1Z7uTPMI5FnmXOrmqtfJxcQFtBq6rPcoTFLfxrP4=;
 b=cQ0+Fotk22qORmYLdgdHpywFBcg+Dm8pf1HG1ocHXb4NuagDNkf0LPfj/mG0alpirT
 5I8H0xfvdwcSicEMLJFuep17BpFLyxf35OFQypmzRbfb9MZ2o7AshIMcgi1dEEYNI03w
 WAs4H5BlOh+tIWG53wFRk3SGtpkA4lqQWKIOh4oqh8EvRCCQKjyguP6YT1ITUMK/1/Av
 2wvf7h+JqN0s6OF6E5SMFvpQEQe8VXx6aPF3iQO1QcolUX0zSO55Wv2zsBG91VfwKTir
 QiZp2byjGQrMQ2POjTT7n41Vif0Z3rdgEaTro4TxHMMMSYh3xhebogORqplM6DVCsp7V
 hs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DbD1Z7uTPMI5FnmXOrmqtfJxcQFtBq6rPcoTFLfxrP4=;
 b=bH877SM8rsjA+1czeJ2gRkOzY6HYZ2aXkGn6MvVi501GnR9DdPoWsyb4pEIT186un8
 3O9L8QYyMgobC1gIfzNYLTKDC+32TZrf+eIcoE183FNASdrDkyNTQZEdXX7nTTtKHXD1
 +EAe1R4WxvHjna1UqFdgWN7r7/ftdInFpBcadeiSQ7T+Iim6HXYIOiWUKgc7XRpQP/jf
 4rBTtL6NFu0N+ZydyIiuyH6eIine+CCX5n64N8dRoW9xMWjy3vCiEp72FTTZ0NMlRsU6
 nmZnxGgw02dsnmBTkZo6PDvQK4HfWqj7y7xNYmaKX4TQXzwzIYolPwgQ/Wink6DdcYki
 NCGA==
X-Gm-Message-State: AOAM533CZQ3rWjjwV2GHE2xcZqgOIImbuph4t8SKHQnjG/NkCQg0iKvl
 CqzeGCy+WHyUV/l3X28CS917B3EVfG03Ohh3AYQ=
X-Google-Smtp-Source: ABdhPJw/GNnBdatiQIZDU4G8FLZQutJvJT2QyMQ3jQQBQ2Nvnrsy1i77yIwRv9YYDagfXvQFb1XCK4hxqptwHZcKsRw=
X-Received: by 2002:a17:902:e906:: with SMTP id
 k6mr5295991pld.333.1598306065708; 
 Mon, 24 Aug 2020 14:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200821205050.29066-1-jcmvbkbc@gmail.com>
 <8b20adcd-97e9-0f8f-1854-b9809060d6cd@amsat.org>
 <CAMo8BfKnW7oEe76akdszPh46R1GVU2kuGfTg3T7ypVHQnzDzTQ@mail.gmail.com>
 <CAFEAcA8sY720+g9ms4EyrGEfHnZaDK-W81Jb=RS0J+V9kCc68g@mail.gmail.com>
In-Reply-To: <CAFEAcA8sY720+g9ms4EyrGEfHnZaDK-W81Jb=RS0J+V9kCc68g@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 24 Aug 2020 14:54:14 -0700
Message-ID: <CAMo8BfK+LOyc+HSeBWWyJPEJKGzjJSVqAZ9ZE_XmC3bCfN60fA@mail.gmail.com>
Subject: Re: [PULL v2 00/24] target/xtensa updates for 5.2
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 24, 2020 at 2:33 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> On Sat, 22 Aug 2020 at 20:48, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > On Sat, Aug 22, 2020 at 3:20 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> > >
> > > Where does that come from?
> >
> > Generated by xtensa processor generator, as one of many output artifact=
s.
>
> Is there anything different with the source for these cores
> compared to the ones we already have in the tree, or are
> these just "more cores, generated the same way as the old ones" ?

They are generated the same way as the old ones, but they have different
configurations: they support FPU2000 and DFPU opcodes implemented
earlier in this series. I've added them to enable testing of these opcodes.
de233_fpu is supposed to be a platform for further xtensa gcc development.

--=20
Thanks.
-- Max

