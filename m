Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6DCC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F20020B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F20020B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjhn-0000xK-HF
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kSjLO-0007uU-Of
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 12:09:38 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:39571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kSjLM-00029p-Pk
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 12:09:38 -0400
Received: by mail-vk1-f195.google.com with SMTP id h74so879069vkh.6
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 09:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tvO/bRJU34F8838Y84be4alnvYrXLXFq5GLFL+7eK+w=;
 b=pvrhxRXafxF9jmQC22KKpQ5ZQ6KrfGHwpRTletlt5LQ3FzJSo3OoZLADfOzDEHwAmI
 1TY/sbwD1EX8TbI5zXuyiWNju4Z0mzhDb88jh5/+/bAvc8vQMsFNSN9FL2KChX9TSt6Q
 6Z+v5Ng61dWdD4m/0YdIrwed5nJW3XCZAf7AJeGQlRomjhHVr1VGW1B8kGJGJIXQBzPA
 xazCEupgKAInwkvjes1nh+E8C99c2WV612/QeDskKT2IKlBOQxqNdJGdxikfG9tSs+Tj
 02ibpC74UOEVmszTJ85b/QKtXkXpFTc64HbUMuoKC8vFq4rqb3X64oZzz7C4t7bdVtx9
 0cNw==
X-Gm-Message-State: AOAM530VmiplmTsQ4G2BRjhmL6kCSzE6VqDeVZcF6GtQLhYOkjrmdWQ1
 f2njTdkMRoK5XevJjQxsiBAIpmAZRrs=
X-Google-Smtp-Source: ABdhPJy0OU6uKaXy7zoaFGTVQl2BrhRIqe837eABgJr6fR6QMk4SdlnWpssfnqqCndeo1nXr0e1qyw==
X-Received: by 2002:a1f:bdcb:: with SMTP id n194mr165581vkf.18.1602691775475; 
 Wed, 14 Oct 2020 09:09:35 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com.
 [209.85.217.41])
 by smtp.gmail.com with ESMTPSA id 31sm12884uac.10.2020.10.14.09.09.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 09:09:35 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id f8so2407925vsl.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 09:09:34 -0700 (PDT)
X-Received: by 2002:a67:d00e:: with SMTP id r14mr3778494vsi.56.1602691774661; 
 Wed, 14 Oct 2020 09:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-5-j@getutm.app>
 <20201013075104.GA70612@redhat.com>
 <e27acf2-4dbe-4674-78cc-67aa7b505c54@eik.bme.hu>
 <20201013144625.GP70612@redhat.com>
 <CA+E+eSBu_LOnQ=B+N7vm3H2zkBxey8z_T1V0JpSU8rZND6GRYQ@mail.gmail.com>
 <20201013155757.GR70612@redhat.com>
 <9d737fc-809-b1b3-f42e-45d8cfbfbd6e@eik.bme.hu>
In-Reply-To: <9d737fc-809-b1b3-f42e-45d8cfbfbd6e@eik.bme.hu>
From: Joelle van Dyne <j@getutm.app>
Date: Wed, 14 Oct 2020 09:09:23 -0700
X-Gmail-Original-Message-ID: <CADmqK1sUah1yTdRuP7Sq=pe1k+g1x+6-HnBxzCYAWMm8nLNLbg@mail.gmail.com>
Message-ID: <CADmqK1sUah1yTdRuP7Sq=pe1k+g1x+6-HnBxzCYAWMm8nLNLbg@mail.gmail.com>
Subject: Re: [PATCH 04/10] meson: option to build as shared library
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.221.195;
 envelope-from=osy86github@gmail.com; helo=mail-vk1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 12:09:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since there seems to be some more push back on this one, I will remove
this patch from the v2 submission and submit it as a separate patch

-j

On Tue, Oct 13, 2020 at 9:40 AM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Tue, 13 Oct 2020, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Oct 13, 2020 at 08:16:46AM -0700, Joelle van Dyne wrote:
> >> I will start a separate conversation of UTM's license compatibility.
> >>
> >> Regarding the patch, would some sort of warning message in configure
> >> (if building as a shared library) regarding the license be wise? Or
> >> would it pollute the output logs?
> >
> > I think there's also a more fundamental question of whether this is
> > a concept we actually want to support at all.
>
> Discussing other compelling reasons for doubt is OK, just wanted to avoid
> having this dismissed on possible licensing problems only. I still think
> it would be a good idea to support QEMU on iOS but due to the (mostly
> security related) limitations of that platform some compromises my be
> needed. Please consider it instead of being quick to decide to avoid thes=
e
> problems by not taking the patches upstream which is a convenient solutio=
n
> from QEMU viewpoint but not helping other projects. (Other platforms may
> come up in the future with similar limitations that iOS has as more
> desktop OSes also move in the same direction to increase security so thes=
e
> may need to be handled anyway at one point, iOS is a good test case for
> that.)
>
> > IIUC, this shared library just exposes a "qemu_main" method which
> > the external app has to jump into. IOW, the "char **argv" parameter
> > to qemu_main becomes the ELF library ABI.  Declaring this a shared
> > library interface is a non-negligible commitment for QEMU maintainers,
> > especially given that there is alot about QMEU's command line parsing
> > that maintainers do not like and wish to change.
>
> Given that libvirt uses the command line instead of a proper API
> currently, this is not worse than that. If there was a better API or ther=
e
> will be one in the future, the shared lib API can be changed the same way
> as libvirt will need to be adapted for that but it's not reasonable to
> demand these patches to come up with that API now. So for now this seems
> to be acceptable and does not prevent cleaning it up later together with
> the planned changes you mentioned. Compatibility for the command line wil=
l
> have to be maintained until a better API is devised for use by other
> software like libvirt and anyone intending to use it as dll so this does
> not seem like added commitment.
>
> > There is a further question about whether we want to commit to an
> > architectural model where  fork() is not something we can use. A
>
> Does Windows support fork()? I think we're already committed to support
> Windows so any solution you'll come up with will have the same problem
> anyway. So I think this does not add additional restriction that we don't
> already have either.
>
> Regards,
> BALATON Zoltan

