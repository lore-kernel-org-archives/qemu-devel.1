Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE73C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4335F2068D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdRrEGUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4335F2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jilC4-0007wC-If
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>)
 id 1jilBT-0007WU-Bv; Tue, 09 Jun 2020 16:49:23 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>)
 id 1jilBR-0004sf-Ut; Tue, 09 Jun 2020 16:49:22 -0400
Received: by mail-pg1-x542.google.com with SMTP id e9so10793908pgo.9;
 Tue, 09 Jun 2020 13:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=FcCCIxPi0rfzfio0dJA3RiNtAB5zNv6sBUrp5/zVaYU=;
 b=PdRrEGUgWQABSmOvqQGwAWmWAJdEs9xYZhF1Ogdr1yZxitAJbK7Ai+1L6xLF5YWp+m
 /Eh31ELcdxpaDf2REsRd+wjeZku2F6TemlJzcaWJnAk2YdmsqYQK3awrUOs4lQheXVi+
 ncMuJUojxoGDosB+BwS/eNX9w24zCuJP/1fI3XZjRIKEf9hAnnMtGyU+TEkx3OGU9zlW
 LzoskgFL76zdfXvVRD22d55L8NoVVqsOdoHsR8+Bnu5d8JMWKhBG18FQTYqVmEQHxbUj
 mD5lcy7/WWFVkjGFWGT5Pdf3Ewl0PCt30iKadrbLwqG1GRTQxQKdqBs9hvVBZ6WIzrmc
 3yhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=FcCCIxPi0rfzfio0dJA3RiNtAB5zNv6sBUrp5/zVaYU=;
 b=WXjZ5tZITruDFpVZTbRTtUlYIQ50KvnhfS+c/soqwtde7A/JmnGAprtoktXdfJiQ+g
 GsJfyt1FYeXyypFvnH4wqDIEq2yeWq9JvvM7NnhlBE/N3Gw78WHmOKxMNu8PvTUm+cRl
 WIBIjukTK/Nnx4bw0BghBd3f7p/i3wMMaon89Saifs/SkHbP/8mZD9J2iwwjYYAOeF18
 Y4yWGWuzdjE0H7kxoxKkHfRzVgiYeIqrqqO2I/Q3JA+xo7vzW09y9Nc9UJH4O77ZJGdv
 Y93JlWIhSU7lQDN9dSMO84zY4qUaCOb+ktFWJlbVsLNNECEb8mbS2HCxn4cRGUUowPkE
 BkYA==
X-Gm-Message-State: AOAM531ZoeTCdl66bB4IQX2arlX5nAN3SorFUYulNSXJv5s2OgGahrvP
 O/P9GspX4x+lGt9ELn8aV3c=
X-Google-Smtp-Source: ABdhPJwmP28tOIkgVPHVncMBE7E4T0r0pVW4wK38Qsn4juaIAzIh//E09lvfb+ca3EsMNWPL7uggLg==
X-Received: by 2002:aa7:8b56:: with SMTP id i22mr26825292pfd.63.1591735760064; 
 Tue, 09 Jun 2020 13:49:20 -0700 (PDT)
Received: from localhost (g228.115-65-196.ppp.wakwak.ne.jp. [115.65.196.228])
 by smtp.gmail.com with ESMTPSA id
 l23sm9096977pgc.55.2020.06.09.13.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 13:49:19 -0700 (PDT)
Date: Wed, 10 Jun 2020 05:49:17 +0900
From: Stafford Horne <shorne@gmail.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] hw/openrisc/openrisc_sim: Add assertion to silent GCC
 warning
Message-ID: <20200609204917.GJ75760@lianli.shorne-pla.net>
References: <20200608071409.17024-1-philmd@redhat.com>
 <95f1d638-3921-ffdf-8f07-2f077d1d0cc9@redhat.com>
 <20200609204227.GI75760@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200609204227.GI75760@lianli.shorne-pla.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=shorne@gmail.com; helo=mail-pg1-x542.google.com
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

On Wed, Jun 10, 2020 at 05:42:27AM +0900, Stafford Horne wrote:
> On Mon, Jun 08, 2020 at 10:33:24AM -0500, Eric Blake wrote:
> > On 6/8/20 2:14 AM, Philippe Mathieu-Daudé wrote:
> > > When compiling with GCC 10 (Fedora 32) using CFLAGS=-O2 we get:
> > 
> > In the subject: s/silent/silence/
> > 
> > > 
> > >      CC      or1k-softmmu/hw/openrisc/openrisc_sim.o
> > >    hw/openrisc/openrisc_sim.c: In function ‘openrisc_sim_init’:
> > >    hw/openrisc/openrisc_sim.c:87:42: error: ‘cpu_irqs[0]’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
> > >       87 |         sysbus_connect_irq(s, i, cpu_irqs[i][irq_pin]);
> > >          |                                  ~~~~~~~~^~~
> > > 
> > > While humans can tell smp_cpus will always be in the [1, 2] range,
> > > (openrisc_sim_machine_init sets mc->max_cpus = 2), the compiler
> > > can't.
> > > 
> > > Add an assertion to give the compiler a hint there's no use of
> > > uninitialized data.
> > > 
> > > Buglink: https://bugs.launchpad.net/qemu/+bug/1874073
> > > Reported-by: Martin Liška <mliska@suse.cz>
> > > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > > ---
> > >   hw/openrisc/openrisc_sim.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > 
> > Tested-by: Eric Blake <eblake@redhat.com>
> > 
> > With the typo fixed,
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Acked-by: Stafford Horne <shorne@gmail.com>
> 
> I see there are now two patches for this, I kind of like this assert fix.
> 
> Shall I queue it for OpenRISC pulling?  Or can someone else pick this up?

Hello,
Sorry, I see v2 of this patch has already been picked up.

-Stafford

