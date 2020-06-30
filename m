Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DBAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A3C2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja3Hoc6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A3C2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqI1k-0003fg-Rx
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jqI0c-0002ce-De
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:17:19 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jqI0Z-0007Vj-86
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:17:18 -0400
Received: by mail-wm1-x335.google.com with SMTP id o8so19184867wmh.4
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 08:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:thread-index
 :content-language;
 bh=U6gpWx6s17H1M9VJ6Oh9vPNBpxTYgr9zPk06ZNP9duI=;
 b=Ja3Hoc6gm808R+iiHXJ+YTAB271DNWOUMLTS3qsKPBA7ZFG3UVpjeCbmkTMVW/MmmS
 udqS+4mb3AruFaeVOe0C1raIYsMTMceHOAnlWJJuMLTmY87Z0vXABnTM335EqBF9tT1Q
 NzE0qFz2yvj+xh39kjoODv61pD10rsrqDAxgZABMBIwu8dBOabU7Gs4wxsWLNiIrUwhZ
 kzFSeIakj5PM4qlq4H8sdRLeOHdcQjgwUdBJ0b0eLdqn6EBP1UuqdP1aHYem9B7FtvCL
 XNln51//kteHAqh2OuA5CRnQH7n0GV2dcinLuyUabbNegMRIQ/MkZX7rb/m/r21kcm6I
 NDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :thread-index:content-language;
 bh=U6gpWx6s17H1M9VJ6Oh9vPNBpxTYgr9zPk06ZNP9duI=;
 b=Fcn7JcYkUfS2R1ORQhAIGDbDVj+jSKcb2kkcFYC2t4Z8I9hRxnx9XtaUcghI8WSC2k
 mNAJxv5frpcoXHI1eDjd/fBqkf4orBRM5WTHXEBF/+SwdpoBVbg+R7tredasJvcvNM9y
 iCxZU0AdUNQHhOBkOfsOEiXfNAGZ2snZRiOBcEnzUV94IlKVjXX64PVer/F3TPYUgvK2
 uRvTcPaNFvIpzonncAzezYOX9L/l6sJBXsv2yYPoe+XtY/0BGP/i21OYYu51TN/vaAZl
 Ge/rme8n7W/eGHpdffcaB5Krd5iPmnjp8OfSoPlltFtoMTA8AMmO2CrYMUeK8FMEqgF9
 GAkg==
X-Gm-Message-State: AOAM531TzF0u74CjcU5Ww7evoTPniWlQC8gH2PlXZZ7d0RKUqgTjXrCC
 H2vrkC5a8TBverfFVdwy6qw=
X-Google-Smtp-Source: ABdhPJz5rAGiFZIDrdJqvVJJ5HKWQXmPiwBmtxY124AwSoiwMS1+l2nVEKBvptNnZcYRRS1epYZK1A==
X-Received: by 2002:a7b:c348:: with SMTP id l8mr23780539wmj.54.1593530233192; 
 Tue, 30 Jun 2020 08:17:13 -0700 (PDT)
Received: from CBGR90WXYV0 (54-240-197-230.amazon.com. [54.240.197.230])
 by smtp.gmail.com with ESMTPSA id j41sm4207738wre.12.2020.06.30.08.17.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jun 2020 08:17:12 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: "'Anthony PERARD'" <anthony.perard@citrix.com>
References: <20200624121841.17971-1-paul@xen.org>
 <20200624121841.17971-3-paul@xen.org>
 <20200630150849.GA2110@perard.uk.xensource.com>
In-Reply-To: <20200630150849.GA2110@perard.uk.xensource.com>
Subject: RE: [PATCH 2/2] xen: cleanup unrealized flash devices
Date: Tue, 30 Jun 2020 16:17:11 +0100
Message-ID: <000401d64ef1$87c8d8a0$975a89e0$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJSqy6H9p+wwq7WTKLIQgTsJ4xkIwGyH0+lAR9Jc9Sn4gFdsA==
Content-Language: en-gb
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x335.google.com
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
Reply-To: paul@xen.org
Cc: 'Eduardo Habkost' <ehabkost@redhat.com>,
 "'Michael S. Tsirkin'" <mst@redhat.com>, 'Paul Durrant' <pdurrant@amazon.com>,
 'Jason Andryuk' <jandryuk@gmail.com>, qemu-devel@nongnu.org,
 'Paolo Bonzini' <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 'Richard Henderson' <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Anthony PERARD <anthony.perard@citrix.com>
> Sent: 30 June 2020 16:09
> To: Paul Durrant <paul@xen.org>
> Cc: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org; Eduardo Habkost <ehabkost@redhat.com>;
> Michael S. Tsirkin <mst@redhat.com>; Paul Durrant <pdurrant@amazon.com>; Jason Andryuk
> <jandryuk@gmail.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.net>
> Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
> 
> On Wed, Jun 24, 2020 at 01:18:41PM +0100, Paul Durrant wrote:
> > From: Paul Durrant <pdurrant@amazon.com>
> >
> > The generic pc_machine_initfn() calls pc_system_flash_create() which creates
> > 'system.flash0' and 'system.flash1' devices. These devices are then realized
> > by pc_system_flash_map() which is called from pc_system_firmware_init() which
> > itself is called via pc_memory_init(). The latter however is not called when
> > xen_enable() is true and hence the following assertion fails:
> >
> > qemu-system-i386: hw/core/qdev.c:439: qdev_assert_realized_properly:
> > Assertion `dev->realized' failed
> >
> > These flash devices are unneeded when using Xen so this patch avoids the
> > assertion by simply removing them using pc_system_flash_cleanup_unused().
> >
> > Reported-by: Jason Andryuk <jandryuk@gmail.com>
> > Fixes: ebc29e1beab0 ("pc: Support firmware configuration with -blockdev")
> > Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> > Tested-by: Jason Andryuk <jandryuk@gmail.com>
> 
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
> 
> I think I would add:
> 
> Fixes: dfe8c79c4468 ("qdev: Assert onboard devices all get realized properly")
> 
> as this is the first commit where the unrealized flash devices are an
> issue.

OK.

  Paul

> 
> --
> Anthony PERARD


