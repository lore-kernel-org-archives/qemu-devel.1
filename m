Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF625C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:10:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E894207FC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E894207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7e2C-0005sQ-3F
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 07:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1i7e0D-0004IK-TL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1i7e0C-0006wV-OG
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:08:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42804)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1i7e0C-0006vn-GZ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:08:04 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7BFEA77342
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 11:08:03 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id m6so1195794wmf.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 04:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=WPEVwyFJvNnZAJR2fJDRxz4ot1Rl2gsEyZIU52iYYc0=;
 b=qD1qu++y86/Dp9y5Y71ttkQrcM3a1jX/DkUwKUMC8hztKmdbs/nfB0cmTIRdgPLFBM
 TvyrxCLcGeN4gR+6TMcthhwZByCTzRJv2F9nWImpnxsSTgfwIPIrzdl6hhzX9WzoF/Jl
 8nO/KUd27t0RhJEEfKu4DiFSEgjUWPLJdyZnYp5f9Zqs8VvPNj8M8GBYEsUCjh0dtEhj
 z7nlZt1ye9+dUcQw2rHrUsAMo4f3GyB2UAp8X/sr6oeaI418gRuOCHLlpK+JDM0DIMBP
 uBdmqdx4hGhLEPmiWshwkekhZzjlQG39HXXQaLooITt6Z08G6G4Mwz8cEoLUkOM2oF65
 fTXg==
X-Gm-Message-State: APjAAAX4S/wtEpgLhYoidq1/7xzSTnseXSn1OlOiuApuqHSQpdrfPT06
 u87aQ4suDa7/yo1b9DdblJ/01UBY81bmTsqdwiRfnXqnvWQ6sbvOHEPozG/sEYTh5aMGt13NRAC
 On4buHnalIg8/88Q=
X-Received: by 2002:adf:c613:: with SMTP id n19mr25911706wrg.109.1568113682244; 
 Tue, 10 Sep 2019 04:08:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwzeonZBL0HuJ3BOQvPUqdfC0kSKCOrTHvcvDFOgJa9/KPeHL2uNsbkjwZdyEAgdYiuTGFn4w==
X-Received: by 2002:adf:c613:: with SMTP id n19mr25911687wrg.109.1568113682040; 
 Tue, 10 Sep 2019 04:08:02 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it.
 [79.36.61.170])
 by smtp.gmail.com with ESMTPSA id h125sm3723128wmf.31.2019.09.10.04.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 04:08:01 -0700 (PDT)
Date: Tue, 10 Sep 2019 13:07:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <20190910110759.hbzjbhcpypkensmz@steredhat>
References: <20190910090821.28327-1-sgarzare@redhat.com>
 <87mufc1nvd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87mufc1nvd.fsf@linaro.org>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] elf-ops.h: fix int overflow in load_elf()
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 10:50:30AM +0100, Alex Benn=E9e wrote:
>=20
> Stefano Garzarella <sgarzare@redhat.com> writes:
>=20
> > This patch fixes a possible integer overflow when we calculate
> > the total size of ELF segments loaded.
> >
> > Reported-by: Coverity (CID 1405299)
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > Now we are limited to INT_MAX, should load_elf() returns ssize_t
> > to support bigger ELFs?
> > ---
> >  include/hw/elf_ops.h | 6 ++++++
> >  hw/core/loader.c     | 1 +
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> > index 1496d7e753..46dd3bf413 100644
> > --- a/include/hw/elf_ops.h
> > +++ b/include/hw/elf_ops.h
> > @@ -485,6 +485,12 @@ static int glue(load_elf, SZ)(const char *name, =
int fd,
> >                  }
> >              }
> >
> > +            if (mem_size > INT_MAX - total_size) {
> > +                error_report("ELF total segments size is too big to =
load "
> > +                             "max is %d)", INT_MAX);
> > +                goto fail;
> > +            }
> > +
>=20
> Seem sensible enough (although gah, I hate these glue bits). Would the
> large amount of goto fail logic be something that could be cleaned up
> with the automatic cleanup functions we recently mentioned in
> CODING_STYLE.rst?
>=20

As Peter pointed out, maybe we should keep the 'goto fail' and do a
better cleanup, but thanks to pointing that out to me.

> Anyway:
>=20
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>

Thanks for the review!

I'm sending a v2 following the Peter's suggestions,
removing the error_report and returing a new ELF_LOAD_TOO_BIG error
value.

Can I keep your R-b, or would you like to have a look at v2?

Thanks,
Stefano

