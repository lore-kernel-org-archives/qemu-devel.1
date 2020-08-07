Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BB0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:45:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212B9221E5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEp/MUIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212B9221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ywi-0002pl-6y
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k3yvY-0001W2-K7
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:44:40 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:40360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k3yvW-0004SN-Qs
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:44:40 -0400
Received: by mail-pl1-x634.google.com with SMTP id u10so803089plr.7
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 02:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4eNxeNGVOOjRBT7qXtqucCH5bejXzed9utfrJkA/b+E=;
 b=OEp/MUIoPLFyqFW2BIlv19WxMI1IGwd6wL1PX/cz8vRe44ZE9oNgyPTJvpka6jgOS4
 ddJZDz3nXwBcD1sFlPB2KNuMYZKiZPiGs97tlL8XBybkBrATL949ho14ZeVOepTsENEn
 4b5QyEQqI5d+h+UYMmc9p/UaT/5vv6HTQZE1G/SSe7uihQH5pAgljwzaZkd5Kl55BquV
 wGV0AAG8TQB1l/4ND2tmpFfCiIUAHbbGmqCXjZ/VSyx+hTSLFR1yVhhPgkGae5kel1U+
 EBJG1D9C+shYwAI4Z1p/jh7aAIwWpx9Y2Go/WLI9StPajXtQ/4WJKzs0tUznVfJJ+/n8
 cABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4eNxeNGVOOjRBT7qXtqucCH5bejXzed9utfrJkA/b+E=;
 b=lXqS3y4D4Xty1qEPp3I6kdvxFfFpgd8yJnT1qVONfg69l3AVKem2eaL88eT/0tAWOm
 wNhvLD0eQuY/QEpyf7MxWOo5lX33K0sBN8xGpQP6LaG7UbaonLsQmbE82BV9kNOw65Bf
 OFke8GNpdD/CkFgW+4TiB0eRZNHmUClJgwsh7K2v24D/q21hWfOukuHRwvHl1qEYSG9A
 nHCEZDhMS/o2JBzr/t3nb3guBOi8hMk21ZBHfk7it6jq5ZlgRpEfba2kFitvHzl6a3vK
 cEMwPqURMtLhVMQEGk12NRq6WWkuxilYzq9jLV34XS3/4YSS1lmhCbLidItMzRHB4pyB
 vp4g==
X-Gm-Message-State: AOAM531qlSApxeISbgUYozNsSX4KQFcrUlI9U9JbZkqdUMN5NmLGfbhJ
 Xa/w/1/g/7c2NMOdrYA+DwyuTELE8+B9OgmEAfc=
X-Google-Smtp-Source: ABdhPJy5j11xgkZWwmoSZ0dN41WCfNHbCe/fhFXlTLCjykLVyMNnaN6rWBIIvpO3WA0nHUaKl+uX16krlfuJlC1Dg0I=
X-Received: by 2002:a17:90b:1103:: with SMTP id
 gi3mr11649499pjb.132.1596793477233; 
 Fri, 07 Aug 2020 02:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QWF8g7r5VqU_PRbskWZU3ahCq+eobR8GexUcPrAiYoCPQ@mail.gmail.com>
 <20200806110826.GH4159383@redhat.com>
In-Reply-To: <20200806110826.GH4159383@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 7 Aug 2020 10:44:25 +0100
Message-ID: <CAJSP0QUfET+KjAaUS6ped=OWh0ZFN1Kup1jAvGw4Cr3M2eDa8w@mail.gmail.com>
Subject: Re: Why QEMU should move from C to Rust (clickbait alert ;))
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=stefanha@gmail.com; helo=mail-pl1-x634.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Oleinik, Alexander" <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Dave Gilbert <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 6, 2020 at 12:08 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> Yes, but I think we'll need put in significant effort to guide / assist
> people in taking this direction, and think about what it means for the
> future of QEMU as a brand and GIT repo.
>
> In many ways it is a good thing if the Rust vhost-user impls are
> all in their own standalone git repos. They're likely to be independent
> codebases, so there's little compelling reason to force them into the
> QEMU git, where they'll have to use QEMU workflow, and QEMU release
> cycle. They're better off free from QEMU where they can choose to adopt
> modern development practices like GitLab merge requests if they
> desire and release on a more frequent cycle than QEMU's 3-times a
> year, etc. Would also make them more appealing for use by alternative
> non-QEMU userspaces for KVM.
>
> The downside is that QEMU git would only contain the "legacy" builtin
> C impls of the devices, and all the "recommended" modern Rust impls
> would be elsewhere. Essentially QEMU would no longer be a self-contained
> provider of the complete solution. Many parts would be disaggregated,
> and users now have the burden of finding all the right pieces to build
> the best solution. We've already seen this to some extent with existing
> vhost-user impls, but it feels like we'd be pushing towards that as a
> more general model for the future which would amplify problems we've
> largely been able to ignore upto now.
>
> I'm not sure what a good answer here is. Perhaps QEMU could try to
> become more of brand for an umbrella project that covers multiple
> independant repos ? eg create new repos under gitlab.com/qemu-project/
> but allow them to work fairly independantly from the main qemu.git ?
> That way we can more easily promote a collection of QEMU repos as
> showing the recommended architecture, without forcing everything
> into qemu.git. We can leverage the QEMU website, wiki and documentation
> in general to showcase the overall solution, while still letting the
> pieces develop independently.

I agree.

Working independently and following Rust conventions ought to work
well for external programs like vhost-user device backends.

It's important that the QEMU source tree builds a complete system. Git
submodules can help with that and are already widely used today.

Stefan

