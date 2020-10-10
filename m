Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B19C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 15:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671CD223AB
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 15:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYmtMSUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671CD223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRHEC-0001x1-I9
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 11:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kRHBl-000086-Vz; Sat, 10 Oct 2020 11:53:42 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:37725)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kRHBi-0001yL-KC; Sat, 10 Oct 2020 11:53:41 -0400
Received: by mail-lf1-x143.google.com with SMTP id j30so11520993lfp.4;
 Sat, 10 Oct 2020 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=uL2hp2LUdE/j/mRHzKildq+S5sAxX8bJDXiT5xZLryQ=;
 b=pYmtMSUiPmSdbZ2oSvlSGEmusMYSpdoOLYv3O85/8TYu85BlEn1luz1aHUALuj9aBV
 PaNnOcStr3N9Cs3ehsV7rpizJur+tpoh5xLxCcgH6ZJMGpYfbBNX7ARGamLQ0xDX6qq9
 Isel9GbOn6mxnzKD4XchA3Hat6VkS3wb8IcmmcC1FOSE+9fyjzo1WV4Kvwvfe4qze0TD
 4c/WhlrJ8GnGJOro/7CgqVTLHlKfcXJoNdAG7MRr3vDTB+BBPdvoJRzZWJodZy/42THE
 LZwFixPwCh5380xcOR2hpY8vyf4k+VLMcxoNyygbTkZIncS9NcnyP3W8nENOIVgx54Pu
 A3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=uL2hp2LUdE/j/mRHzKildq+S5sAxX8bJDXiT5xZLryQ=;
 b=nRPEx4qVhcmchIyXLFmAFC9ImWCt6xvD99raB6Sn05+P2Y6DV9n1RuJZu50HqsYHVI
 Da4XPEh7IX4D1TyLvX+Mnx+2n6Qb7/behjiu01vHBJMiE6xWYxXatlnn7yn8S/rOtZvV
 sODvqm4jFabG/ZKInsXUDp7qyQ8upQp7Uht2MmGME0t6BewvaRwKADp6RFdDY4pEx1HE
 +b2XdtO9AAhio+DSBE7xpDEtxyZqYeJAooyOJB0wI02n6rVgMn740X4ZWBLpLKpKBdOg
 dqgYAP9G3ZG5aQvLTRME8dAR1Hl0MeK4dXqpUQ5tSFbe69fGac7mEqeg9aU6gt2tTNMN
 x4AA==
X-Gm-Message-State: AOAM532E6OXtra5jNeMPYB5JdwIBfD2VQWmemY4/vjRa5h1i5LlQ5vI4
 Q5gmyDAMG8f/njmvJ9Yt/gM=
X-Google-Smtp-Source: ABdhPJwdpbhogcd2+ztjqN2oDsjsRpZuq4wXTV1HS6M0QDhC2CpsZkvX8LKXAPJ5ArEGxC2VqCFltw==
X-Received: by 2002:ac2:5c5d:: with SMTP id s29mr3002471lfp.584.1602345215685; 
 Sat, 10 Oct 2020 08:53:35 -0700 (PDT)
Received: from [192.168.167.128] (37-145-186-126.broadband.corbina.ru.
 [37.145.186.126])
 by smtp.gmail.com with ESMTPSA id x4sm2407822ljj.62.2020.10.10.08.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 08:53:34 -0700 (PDT)
Message-ID: <f505c80b88ee665a62883a69bed9d614f6ba2a66.camel@gmail.com>
Subject: Re: [PATCH] hw/net: move allocation to the heap due to very large
 stack frame
From: Elena Afanasova <eafanasova@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Sat, 10 Oct 2020 08:53:00 -0700
In-Reply-To: <20201010060745.GK1025389@yekko.fritz.box>
References: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
 <20201010060745.GK1025389@yekko.fritz.box>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=eafanasova@gmail.com; helo=mail-lf1-x143.google.com
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
Cc: qemu-trivial@nongnu.org, jasowang@redhat.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 2020-10-10 at 17:07 +1100, David Gibson wrote:
> On Fri, Oct 09, 2020 at 07:02:56AM -0700, Elena Afanasova wrote:
> > > From 09905773a00e417d3a37c12350d9e55466fdce8a Mon Sep 17 00:00:00
> > > 2001
> > From: Elena Afanasova <eafanasova@gmail.com>
> > Date: Fri, 9 Oct 2020 06:41:36 -0700
> > Subject: [PATCH] hw/net: move allocation to the heap due to very
> > large stack
> >  frame
> 
> Patch looks fine, but some more details of the motivation would be
> nice.  I wouldn't have thought that the size of a network packet
> counted as a "very large" stack frame by userspace standards.
> 

gcc with wstack-usage warns that stack frame size may be ~65Kbytes

> > Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
> > ---
> >  hw/net/spapr_llan.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> > index 2093f1bad0..581320a0e7 100644
> > --- a/hw/net/spapr_llan.c
> > +++ b/hw/net/spapr_llan.c
> > @@ -688,7 +688,8 @@ static target_ulong
> > h_send_logical_lan(PowerPCCPU *cpu,
> >      SpaprVioDevice *sdev = spapr_vio_find_by_reg(spapr->vio_bus,
> > reg);
> >      SpaprVioVlan *dev = VIO_SPAPR_VLAN_DEVICE(sdev);
> >      unsigned total_len;
> > -    uint8_t *lbuf, *p;
> > +    uint8_t *p;
> > +    g_autofree uint8_t *lbuf = NULL;
> >      int i, nbufs;
> >      int ret;
> >  
> > @@ -729,7 +730,7 @@ static target_ulong
> > h_send_logical_lan(PowerPCCPU *cpu,
> >          return H_RESOURCE;
> >      }
> >  
> > -    lbuf = alloca(total_len);
> > +    lbuf = g_malloc(total_len);
> >      p = lbuf;
> >      for (i = 0; i < nbufs; i++) {
> >          ret = spapr_vio_dma_read(sdev, VLAN_BD_ADDR(bufs[i]),


