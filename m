Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637BCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C517207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oL5DnZYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C517207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jil5c-0004Gc-7U
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>)
 id 1jil4t-0003kx-0Q; Tue, 09 Jun 2020 16:42:35 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>)
 id 1jil4r-0003Ov-T0; Tue, 09 Jun 2020 16:42:34 -0400
Received: by mail-pg1-x543.google.com with SMTP id e9so10786803pgo.9;
 Tue, 09 Jun 2020 13:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=qfV30FoU58k2ttUY1GTYXDCX1rA6FSBjaL/WxZ3FFEQ=;
 b=oL5DnZYqLr3yT60S2mJ1i9sHg5ZOr8B8ZCQGMnWzG349skxnnk9xmq3rQRdN8qVmN8
 BFkPIcUh3U8sz/5aedU0a7Nit/vd3QVKXJE++LEyORDeQdyP/RfBqCgUwpaFtX1hLgT7
 Nq5eq1eHOCNO+Xinqu9pbz36Qb7/1mN2crBA3CyPs6BP/artR9og0O8JSJ9xw0M30QsS
 kCidHmhCmGa6pwA6n+7AvNwqW/4i+EWesyd8ocUU0zO7cdMzqX/5pOnbPwt8IuZoMv8G
 lZ2l8qsoPY4uXj7wCrofEc1U23ddVIhZLhjUMThqxxxd4LzxRIg0gjYHm5sMS9xoZIR5
 BjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=qfV30FoU58k2ttUY1GTYXDCX1rA6FSBjaL/WxZ3FFEQ=;
 b=Q8tz2AHb1F7v4t3MDpIP02+bS6X5SttXOd4AcnNcXEfdUnFU+VTj7n8z0lRCVvLL6X
 rkmHYthipnRuyOkmEIY1OjQYyhTMng4aMKuZm62A/8KaOzduLEMiWHv5ZER4pWeUqLoh
 gQtaVoktGMQjtCgDlcI+UtJ4Ru1aTtVsiYyKkbXBGNc2g1ifxVmDuMGmQ44F3jPJAzwJ
 m8j9jnwljNag3hlnvZdDFabwukfSvcxqQUdPai5Flx/GX11K4n7dI5z4UERkKI1Jadhk
 Kk/Lp9FwZkI9YzU7RljORt8V8BtX7bCqe1UCbhTVbUCUozl/06LamxQKqnIvXk85NMFN
 iCLQ==
X-Gm-Message-State: AOAM532oREHRtU2t50zswhOzwgBjgnIEbMBej22SJVu0jLJ48A9KDosM
 i/znlB8XJdpHBFjFLHsMFUs=
X-Google-Smtp-Source: ABdhPJxUHNuNwn9kWW8Zj2xH6GoUpFQokoiMmziPQrQ2nw1nXKQ/HbFMnhdDNJsFlhofETfRmoXf7A==
X-Received: by 2002:a63:4b0a:: with SMTP id y10mr25993855pga.57.1591735351296; 
 Tue, 09 Jun 2020 13:42:31 -0700 (PDT)
Received: from localhost (g228.115-65-196.ppp.wakwak.ne.jp. [115.65.196.228])
 by smtp.gmail.com with ESMTPSA id
 i19sm3378843pjz.4.2020.06.09.13.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 13:42:30 -0700 (PDT)
Date: Wed, 10 Jun 2020 05:42:27 +0900
From: Stafford Horne <shorne@gmail.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] hw/openrisc/openrisc_sim: Add assertion to silent GCC
 warning
Message-ID: <20200609204227.GI75760@lianli.shorne-pla.net>
References: <20200608071409.17024-1-philmd@redhat.com>
 <95f1d638-3921-ffdf-8f07-2f077d1d0cc9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95f1d638-3921-ffdf-8f07-2f077d1d0cc9@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=shorne@gmail.com; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Jia Liu <proljc@gmail.com>, qemu-trivial@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 1874073@bugs.launchpad.net, Christophe de Dinechin <dinechin@redhat.com>,
 Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 08, 2020 at 10:33:24AM -0500, Eric Blake wrote:
> On 6/8/20 2:14 AM, Philippe Mathieu-Daudé wrote:
> > When compiling with GCC 10 (Fedora 32) using CFLAGS=-O2 we get:
> 
> In the subject: s/silent/silence/
> 
> > 
> >      CC      or1k-softmmu/hw/openrisc/openrisc_sim.o
> >    hw/openrisc/openrisc_sim.c: In function ‘openrisc_sim_init’:
> >    hw/openrisc/openrisc_sim.c:87:42: error: ‘cpu_irqs[0]’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >       87 |         sysbus_connect_irq(s, i, cpu_irqs[i][irq_pin]);
> >          |                                  ~~~~~~~~^~~
> > 
> > While humans can tell smp_cpus will always be in the [1, 2] range,
> > (openrisc_sim_machine_init sets mc->max_cpus = 2), the compiler
> > can't.
> > 
> > Add an assertion to give the compiler a hint there's no use of
> > uninitialized data.
> > 
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1874073
> > Reported-by: Martin Liška <mliska@suse.cz>
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > ---
> >   hw/openrisc/openrisc_sim.c | 1 +
> >   1 file changed, 1 insertion(+)
> 
> Tested-by: Eric Blake <eblake@redhat.com>
> 
> With the typo fixed,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Acked-by: Stafford Horne <shorne@gmail.com>

I see there are now two patches for this, I kind of like this assert fix.

Shall I queue it for OpenRISC pulling?  Or can someone else pick this up?

-Stafford

