Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4E8C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 12:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BE922CEC
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 12:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BE922CEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5qkL-0006tu-1y
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 08:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i5qj7-0006S2-SV
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i5qj6-0002Up-Nw
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:19:01 -0400
Received: from 1.mo4.mail-out.ovh.net ([178.33.248.196]:36955)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i5qj6-0002TP-IE
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:19:00 -0400
Received: from player755.ha.ovh.net (unknown [10.108.35.27])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id CBC7E2057D9
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 14:18:57 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player755.ha.ovh.net (Postfix) with ESMTPSA id E7EE2991E2F4;
 Thu,  5 Sep 2019 12:18:51 +0000 (UTC)
Date: Thu, 5 Sep 2019 14:18:48 +0200
From: Greg Kurz <groug@kaod.org>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190905141848.331aba6c@bahia.lan>
In-Reply-To: <20190905140701.6cc679ee@bahia.lan>
References: <20190905113346.2473-1-thuth@redhat.com>
 <20190905140701.6cc679ee@bahia.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18244363565973870898
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejjedggeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.248.196
Subject: Re: [Qemu-devel] [PATCH] travis.yml: Install libcap-dev for testing
 virito-9p
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Sep 2019 14:07:01 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Thu,  5 Sep 2019 13:33:46 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
> > So far we were not testing virtio-9p in Travis yet, since we forgot to
> > install libcap-devel. Do it now to get some more test coverage.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> 
> Acked-by: Greg Kurz <groug@kaod.org>
> 

Hmm... shouldn't libcap-dev be added in the "Acceptance (Functional) tests"
section as well, near line 260 ?

> and
> 
> Tested-by: Greg Kurz <groug@kaod.org>
> 
> Whose tree is this going through BTW ?
> 
> >  .travis.yml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/.travis.yml b/.travis.yml
> > index 92b00927d4..1d46442020 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -15,6 +15,7 @@ addons:
> >        - libaio-dev
> >        - libattr1-dev
> >        - libbrlapi-dev
> > +      - libcap-dev
> >        - libcap-ng-dev
> >        - libgcc-4.8-dev
> >        - libgnutls-dev
> 


