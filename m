Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D104AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B0C24916
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B0C24916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSM6X-0001QL-CF
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 11:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kSM31-0006Vw-0G
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:17:07 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kSM2x-0000Gn-2C
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:17:06 -0400
Received: by mail-io1-f65.google.com with SMTP id u19so23067574ion.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 08:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fmDBCM1OoR+mrJ9JQqKPucQwXjtVkZzj7bN2Bz1rfJ4=;
 b=ZuTq8KQaRbAXq2jeZp2c9ekSAXVWb3yPuUYxhAu51d8gguHKd7NwOyHui/R2Vnbp33
 YwAP/yoAF8529y8E1Wrsh4oh7d0oii3lSpD5fBTDvkHcOLc7xuI6X33zg3xJP175/O8I
 XW9javl7IJibdvRyxu8OtdTJlM93DtefrJkQNCq3ZJjye8nvszITwVO8lQTEuhBjRDBY
 m1KmoaIr5b2Ei4EtU9/ucsBwS+fpHs9sSPJQyPIFXOq0CmwJD5T1zrhgEtiIRPSurSYg
 vSL2yp2gKuERiU5uyEg2UAqDDZBIKJaFhvCmmnyFnuPnIeXTsAH2CTA5aILg73exq3tW
 CEBg==
X-Gm-Message-State: AOAM5321iSfnUoLsBhG/jPoLNelXDQvezOfoMVB2qNkoemod+nS0SbRA
 EKYlncWrAqWbgZTpX3eTW4Nvv8NVBGw=
X-Google-Smtp-Source: ABdhPJyTTcmundLbngmS/9cLhGNY/12Bq1oBPPv0OtrUZEIUNEHfiGKN9nYuzgMk/pgGtWUmUj5RHQ==
X-Received: by 2002:a6b:7f43:: with SMTP id m3mr20171972ioq.114.1602602217739; 
 Tue, 13 Oct 2020 08:16:57 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com.
 [209.85.166.173])
 by smtp.gmail.com with ESMTPSA id q16sm51582ilj.71.2020.10.13.08.16.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 08:16:57 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id r10so121056ilm.11
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 08:16:57 -0700 (PDT)
X-Received: by 2002:a92:de07:: with SMTP id x7mr327282ilm.33.1602602217198;
 Tue, 13 Oct 2020 08:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-5-j@getutm.app>
 <20201013075104.GA70612@redhat.com>
 <e27acf2-4dbe-4674-78cc-67aa7b505c54@eik.bme.hu>
 <20201013144625.GP70612@redhat.com>
In-Reply-To: <20201013144625.GP70612@redhat.com>
From: Joelle van Dyne <j@getutm.app>
Date: Tue, 13 Oct 2020 08:16:46 -0700
X-Gmail-Original-Message-ID: <CA+E+eSBu_LOnQ=B+N7vm3H2zkBxey8z_T1V0JpSU8rZND6GRYQ@mail.gmail.com>
Message-ID: <CA+E+eSBu_LOnQ=B+N7vm3H2zkBxey8z_T1V0JpSU8rZND6GRYQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] meson: option to build as shared library
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.166.65; envelope-from=osy86dev@gmail.com;
 helo=mail-io1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 11:16:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: qemu-devel@nongnu.org, Joelle van Dyne <j@getutm.app>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I will start a separate conversation of UTM's license compatibility.

Regarding the patch, would some sort of warning message in configure
(if building as a shared library) regarding the license be wise? Or
would it pollute the output logs?

-j

On Tue, Oct 13, 2020 at 7:46 AM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Tue, Oct 13, 2020 at 04:41:06PM +0200, BALATON Zoltan wrote:
> > On Tue, 13 Oct 2020, Daniel P. Berrang=C3=A9 wrote:
> > > On Mon, Oct 12, 2020 at 04:29:33PM -0700, Joelle van Dyne wrote:
> > > > From: osy <osy86@users.noreply.github.com>
> > > >
> > > > On iOS, we cannot fork() new processes, so the best way to load QEM=
U into an
> > > > app is through a shared library. We add a new configure option
> > > > `--enable-shared-lib` that will build the bulk of QEMU into a share=
d lib.
> > > > The usual executables will then link to the library.
> > >
> > > Note that QEMU as a combined work is licensed GPLv2-only, so if an ap=
p is
> > > linking to it as a shared library, the application's license has to b=
e
> > > GPLv2 compatible. I fear that shipping as a shared library is an easy=
 way
> > > for apps to get into a license violating situation without realizing.
> >
> > Please don't let that be an obstacle in merging this series. They'll do=
 it
> > anyway as seen here so having it upstream is probably better than havin=
g a
> > lot of different/divergent forks.
>
> "They'll violate the license anyway" is not a compelling argument.
>
> > In case of UTM it seems to be licensed under Apache License 2.0:
> >
> > https://github.com/utmapp/UTM/blob/master/LICENSE
> >
> > which FSF says not compatible with GPLv2 but it is with GPLv3:
> >
> > http://www.gnu.org/licenses/license-list.html#apache2
> >
> > Not sure however if that's for using Apache licenced part in GPLv2 code=
 or
> > the other way around like in UTM in which case I think the whole work w=
ill
> > effectively become GPLv3 as most parts of QEMU is probably GPLv2+ alrea=
dy or
> > BSD like free that should be possible to combine with only files explic=
itely
> > GPLv2 in QEMU remaining at that license and UTM parts are Apache 2.0 wh=
en
> > separated from QEMU. I have no idea about legal stuff whatsoever but
> > combining two free software components should be legal some way (otherw=
ise
> > it's not possible to combine GPLv2 with GPLv3 either).
>
> You need to distinguish between GPLv2-only and GPLv2-or-later.
>
> GPLv2-or-later is fine as that upgrades to GPLv3 when used in a
> combined work with Apache License or GPLv3 software.
>
> GPLv2-only will, by design, *not* upgrade to newer GPL versions
> when combined - it is simply license incompatible.
>
> QEMU unfortunately has a bunch a GPLv2-only code present that we
> cannot eliminate.
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

