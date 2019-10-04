Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31254C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 14:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09AE20873
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 14:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BzeksFJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09AE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGODz-0001Bk-EG
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 10:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iGOCz-0000Z5-Sd
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 10:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iGOCy-0006MS-3g
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 10:05:25 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iGOCx-0006D4-SU
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 10:05:24 -0400
Received: by mail-ot1-x343.google.com with SMTP id z6so5397234otb.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 07:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=v+zudTp73d8qRm0omNGNW6D27zZVxitCjBRiTm8dgco=;
 b=BzeksFJx9csOLM5mrTDu7018RvChY+hJBFtkUBZXBjfwhSSeZOX0d2eYbYJ7k+oJX6
 6jN6I+2mtDtK6RZCosCyBSFhHleE/3uZ+M8aj4Oqyj5fUf/HYwSQ/nVXRsswAQ2TqUjh
 Hy8lJmd/1DWTZ4lU8gwjNZgCvG6mf0JIQ5647S5Fz6yuRvj8K79FJvlUS79m1DKr1cu/
 3XiVFSxr3FRRHrZNZC9LdfW2FvQ5G93dStqTR0O4Ghh/AL4HH9GCKK4Du8Va4KmkPmdO
 97Qx33QUXu4CupXYXywTitunjImtK9/UICorlMFrNnDkO0+BYS9EZ3Z3itPwLQmFTiKb
 CdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=v+zudTp73d8qRm0omNGNW6D27zZVxitCjBRiTm8dgco=;
 b=RokB8xW4QGok9da3nJMqhzQ/qr2ifUasYdZ2Gbxo58wxI79HuipNduEwtH9pxsrfk2
 V+7IcuZh9l5wFaKLOv8xcg/8R1UyrsUK3HT4ODlPCcVjP5YvAHlwoPMUhV3sE9bEG+it
 jHgswYpCpCJqe9c45KH7NFNbkqyQmyBnHuoMVO/RqAWB55m+6N2bKv7dJdmqWA8xNiiU
 TqLRzyZi0EComes/5e39O+cb3aIO3ZlbFobD5LbAe3h8iXI24jLuJHecQE/cU65gXrQo
 Z/nK0eEriN/OC8N7bTkn5I5lo4aRc08uT/wvm2Mg2aukAfDWVG64dsvWgsW3yFnzsbJT
 I5EQ==
X-Gm-Message-State: APjAAAUs6QS487UEAt81hjYM3+h+i2FBA9iQh3c79UzZYkmAfgD+0Xqy
 L+EnJZsEesMPtq4e5YZIFI2hSC+cGlbxpMCI6hOuTA==
X-Google-Smtp-Source: APXvYqxF9RYvg6LxSL2SZpgH2AGlhujrWgpSOMGANLenZ0XkI4PRd69m9ovs8vmkfk7L1vM25GpDprzCS0Kn6PguklI=
X-Received: by 2002:a05:6830:1357:: with SMTP id
 r23mr10953083otq.91.1570197911752; 
 Fri, 04 Oct 2019 07:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-2-jsnow@redhat.com>
 <a252472e-842a-8401-2743-e4ed948b066b@redhat.com>
 <450a1f52-9589-cb98-88cb-1d3fcd5f506a@redhat.com>
 <778487c5-566e-d133-6395-d3908db66adc@redhat.com>
 <62cf912a-8ee9-d023-84c2-1ad6ea94e3b8@redhat.com>
 <16eef993-c16e-3fd7-c60d-6d3c7bfb5148@redhat.com>
 <20191002164438.GD5819@localhost.localdomain>
 <a7f532cc-68cb-175e-6c8f-930401221ef9@redhat.com>
 <20191004101952.GC5491@linux.fritz.box>
 <d194e22c-7125-e558-0a80-131a28a87419@redhat.com>
 <CAFEAcA-4-ttpQ5S-HuEtv86TeNjBnFzp77D5ML1D9CZMYGR5Ow@mail.gmail.com>
 <2873f340-cac2-c168-d46a-e22c0571e83d@redhat.com>
In-Reply-To: <2873f340-cac2-c168-d46a-e22c0571e83d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2019 15:05:00 +0100
Message-ID: <CAFEAcA99ezCejkZi9+yVYK-SRpNOvPng9vrkF+kcuS12LQBmuQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] iotests: remove 'linux' from default supported
 platforms
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Oct 2019 at 14:50, Max Reitz <mreitz@redhat.com> wrote:
> On 04.10.19 15:16, Peter Maydell wrote:
> > 'make check' does have the restriction
> > that we don't want the tests to take too long to run, but in
> > general the block layer should be running some reasonable subset
> > of tests in the project's standard "run the tests please" command.
> > (I have no opinion on exactly what that subset ought to be, beyond
> > that it would be good if that subset doesn't have known intermittent
> > failures in it.)
>
> Deciding the subset is difficult.  My stance was that it=E2=80=99s better=
 to not
> choose an arbitrary subset here but ensure that really everything gets
> run as part of CI, that is asynchronously so it doesn=E2=80=99t block any=
one and
> can take as long as it wants.

I wonder if we have a terminology difference confusion here.
To me "CI" means "we have tests which we automatically run
before pushing commits to master, and if they fail then we
don't push". So (a) they have to run synchronously and (b) there
is a need for them to run in a reasonable period of time because
otherwise it takes too long to run the tests before pushing
to master and we get a backlog of unprocessed pullrequests
and annoying delays.

> If we decide to get pull requests based on that, then that=E2=80=99d brin=
g even
> more pain, but at least it=E2=80=99d be honest.  But just running half of=
 the
> qcow2 tests to me seems only like we want to pretend we ran the iotests.
>  So for me, iotests still break, and we need to deal with make check
> failures on top.  I=E2=80=99d at least prefer one or the other.

I think the ideal we're aiming for here is:
 (1) people doing active work in the block subsystem are probably
often going to want to run all the iotests, and certainly the
subsystem maintainers will want to do that as they put together
pull requests.
 (2) but people who *don't* do active work in the block subsystem
still sometimes touch it in passing as part of things like global
refactorings or other changes that touch big parts of the tree,
or accidentally break it with a change to some other bit of QEMU
entirely. These people won't run the full iotests, but it is
reasonable to expect them to run 'make check', and it would be good
if that caught "whoops you broke the block subsystem".

Similarly, "make check" has incredibly spotty coverage of
various arm boards and devices, but it does do some basic
checks which do catch accidental breakage.

thanks
-- PMM

