Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBAFCA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A527206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+NTNrAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A527206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYZXL-0004So-Hl
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYZVW-0003JV-7h
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:19:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52133
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYZVR-0003k3-5t
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589307590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0lqs+neV0GOf9SwpBPCkfjro3/1blwfBwfl02q4MqgM=;
 b=W+NTNrAoK0bMFuQ4StmNz3NqvX4RlQmDeFqLmRldD+YDrJRZIaeByiMn6bXmM/vDBeKytg
 T/OmXLHA6+f/NaOnlxMfofTEY7JauuugMwEgELHOlJVNKhkxCcziW0b0ft8xxiWPH2oeH6
 3jIqNujPixyRYdVOZu77dlXxN+p0qM8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-iUg2mzN8MG-69SNPt_wtbw-1; Tue, 12 May 2020 14:19:45 -0400
X-MC-Unique: iUg2mzN8MG-69SNPt_wtbw-1
Received: by mail-wr1-f69.google.com with SMTP id q13so7326688wrn.14
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 11:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0lqs+neV0GOf9SwpBPCkfjro3/1blwfBwfl02q4MqgM=;
 b=g/e22QrgQ5DTHDpPP7wzYWlABn4RscVuCxFj2cy3aELoa9wUlOsKGUxyR9Rc95FW0Q
 4xeBfpMmEn5MC2e8lXAO7MUQqvKcKv+GVmjOauCtZNAWr3qhndD4Usu5bx6U5ZUKpgvl
 DLW89oM4HgOzhwSNghm7vOwLnNg3lYx8f3DZNfH4ZK2eVNyUvs194dCFKHRMEOuNNLrw
 NCsvnhROW4p/IRvQIFEvFOnr/ImVqty9BgTpaxvxtwLlUyAo4Mk4Hgm4VKRZdUKWyiTH
 z9MWbd6zOFycj6cIhGePsWp39aAc1Y+yhreQRZ23If3M7fMpaozo1mI62UJUWxuSjrm7
 nTdQ==
X-Gm-Message-State: AGi0PuZG37guOH9cZ3AKVsuyuXlk+ydbguLYYf72m7jGjMW8InTX5Qno
 1kj7Mrb3m4fMmf1oRdZ4kN5e8pY18/O2abCBf6S9vW6SjbEXVx5hQS9X10APitGuJCG7Swskfp9
 fkd7Wjh/q1Ylb87Z7P9/pz5JUHMYwcs4=
X-Received: by 2002:adf:e511:: with SMTP id j17mr28538493wrm.204.1589307584626; 
 Tue, 12 May 2020 11:19:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypIbVUQaoTxQKWJft3Eg6WKgg1e7vyzm/KQfO744LtHaVUc9M5vJrapBnpjwi1zxXf6JavxfbMJUfGB+X4vV/QA=
X-Received: by 2002:adf:e511:: with SMTP id j17mr28538392wrm.204.1589307583347; 
 Tue, 12 May 2020 11:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200512170704.9290-1-rad@semihalf.com>
 <16d128a6-c07e-d2d1-129d-c4047d0da3ea@redhat.com>
In-Reply-To: <16d128a6-c07e-d2d1-129d-c4047d0da3ea@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 12 May 2020 20:19:32 +0200
Message-ID: <CAP+75-Wq3imeKOLd8qY+8OQ0Bjq_X8Z+n1Z=KqogKX=Qn2c0fw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update Radoslaw Biernacki email address
To: Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Leif Lindholm <leif@nuviainc.com>, qemu-arm <qemu-arm@nongnu.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 12, 2020 at 8:18 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 5/12/20 7:07 PM, Radoslaw Biernacki wrote:
> > My Linaro account is no longer active and stop forwarding emails to me.
> > Changing it to my current employer domain.
> >
> > Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>
> > ---
> >   .mailmap    | 1 +
> >   MAINTAINERS | 2 +-
> >   2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/.mailmap b/.mailmap
> > index 6412067bde..668da447e3 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -46,6 +46,7 @@ Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arik=
alo@wavecomp.com>
> >   Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.=
ibm.com>
> >   James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
> >   Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
> > +Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
> >   Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
> >   Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
> >   Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1f84e3ae2c..a9d6893036 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -799,7 +799,7 @@ F: include/hw/misc/imx6_*.h
> >   F: include/hw/ssi/imx_spi.h
> >
> >   SBSA-REF
> > -M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
> > +M: Radoslaw Biernacki <rad@semihalf.com>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

And now:
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

=3D)

>
> >   M: Peter Maydell <peter.maydell@linaro.org>
> >   R: Leif Lindholm <leif@nuviainc.com>
> >   L: qemu-arm@nongnu.org
> >


