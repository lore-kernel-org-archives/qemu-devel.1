Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693F0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ACE322D0B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7PaQlgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACE322D0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3c2v-0007jB-2e
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 05:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3c2F-00074S-Cf
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:18:03 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3c2C-0005Hi-H3
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:18:03 -0400
Received: by mail-oi1-x241.google.com with SMTP id l204so13496087oib.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 02:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DxTvDL4aYr6D+jUsHru3iFLI0rDaYdAdjro4hzMumMI=;
 b=B7PaQlgEmTjVw+R+tSAGSQA6WSKPWuIZVdeSqrTTuZRTszE1qHwwJZEzosW1Wo2qtn
 PQLBO/PMSRQ7nJosivTrxuJkiULmwTmImV/CDQ2ag7cSLhYE/UC8uUw+hfyw0KF7Va5q
 pIn1gt5pHu7vdhlvtZFnHkX3Y4eaLMIRtLKqDhzTdSjNdiWCq/PJw3R8JxcxILA8U2gy
 SHWbBPOZvndMbQURuWp6l/twtf1LLJAsf0arBrOhmf0+DLgNoXvxF1lEMnOxBhqboTHh
 JECWv6RGCBgGgZFzaE9LapH1O+yDL7YWWhs38dcnrvgqfuc3OWUD8hy7M6aDE32gJCKo
 Homw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DxTvDL4aYr6D+jUsHru3iFLI0rDaYdAdjro4hzMumMI=;
 b=MBsEwY1e0KQZpu6mWdJnS2QlsYaufVim+ZDM2bInWt08gs+xZUguZ9uJcMKbWBFqW3
 VfZfttEyTSIn4PSwYkYOSVpGg7xCscZDWIGm/xehGL3NNipIiOG9dUl4HrkGYa17YWhZ
 wEyjt8aXcyld7dSnlH0Eogk4T8U4UjzEwBQOTBo0b2K4Ja1IsisEoqHp4OULJ9JYoL3t
 d/nvCjVEjTXx0/GOkAgMU35JORI5q0CWJqfvr9roF00TmLRywc3TyvxxWStayRtHhT4I
 faPB+DR9iE5iPAkQXjywsIhOiO1ji6SZte69DO02VCsxxKVammTWoN70E+o/uYM2RPjG
 dT5g==
X-Gm-Message-State: AOAM531cSG885On8XhkZMMPoDWGs27JrD9R2eEkLL1PUTEEzeBwWprnC
 VfAF39QdNOhlVAuUDznvyjzqCL3G/miZ3vxyroMAsg==
X-Google-Smtp-Source: ABdhPJx3/CYlFos9/ffQERP9btXsVMCOg5fTXXiGoBYsL3C6dTwJfVh+tIDbfmAu7bnf3XixUiYO9xEiBDPw2m0tbl0=
X-Received: by 2002:aca:50c4:: with SMTP id e187mr5875121oib.146.1596705478947; 
 Thu, 06 Aug 2020 02:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <878sf3uojf.fsf@morokweng.localdomain>
 <20200730005947.GO84173@umbus.fritz.box>
 <CAAdtpL5Mtaf7Xwu74U33eGTCAiFZNNXeCST8COwQeW8S9j8ZVQ@mail.gmail.com>
 <87a6zh3uyv.fsf@morokweng.localdomain> <874kph58o5.fsf@morokweng.localdomain>
 <CAFEAcA-Yi754zyxHd+bggjny5vXw=rrs5fm6SZCcxwVUeoTtOg@mail.gmail.com>
 <20200806051355.GA157233@yekko.fritz.box>
In-Reply-To: <20200806051355.GA157233@yekko.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Aug 2020 10:17:47 +0100
Message-ID: <CAFEAcA8fg8b-Z_fd9mK6QPurNhQYNGMhRc_r9RizYndrFC2DMA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Generalize start-powered-off property from ARM
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 06:53, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> On Wed, Aug 05, 2020 at 08:04:11PM +0100, Peter Maydell wrote:
> > On Wed, 5 Aug 2020 at 18:01, Thiago Jung Bauermann
> > <bauerman@linux.ibm.com> wrote:
> > > Any news on this? Is there something I should be doing? I saw -rc3 today
> > > but not these patches.
> >
> > Sorry, you've missed the bus for 5.1 at this point. I'd assumed
> > that the relevant bits of the patchset would go into a PPC pullreq
> > if it was important for 5.1.
>
> Ah, bother.  Meanwhile I assumed that since it was cross-target it was
> going in separately, so I didn't take it through my tree.

This kind of confusion is why it's a good idea to list "this ought
to be fixed for the release" issues on the Planning wiki page. That
way I will see them when I'm looking for patches that might have
been forgotten or that I need to wait for a pullreq for before tagging...

-- PMM

