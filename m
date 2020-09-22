Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB622C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 18:13:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 513C8238A1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 18:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPOI54qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513C8238A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmnJ-0003vY-Cx
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 14:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ngompa13@gmail.com>)
 id 1kKmlZ-00034h-HK; Tue, 22 Sep 2020 14:11:49 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:41118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ngompa13@gmail.com>)
 id 1kKmlX-0007aa-TB; Tue, 22 Sep 2020 14:11:49 -0400
Received: by mail-il1-x143.google.com with SMTP id f82so18194178ilh.8;
 Tue, 22 Sep 2020 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Op5r7EOdBV4BbGLAIvUJLLDg7hQO+sSgowMYpfbKfg8=;
 b=nPOI54qA5Xc2J6K9+FLnzExqoCC6JadYIx9n2bMhrt5HZ5a5VDofDH+60II1imwHad
 +vssaMWR3XLlpzDnycdpRL/kyPerOxPQ4WodLLYttG7Od1/5m9oCkat5W8L5rnzzSVb1
 BNCZkZzIm4pmnFTH90Dbxfl96XeEecar80yWn4i7zXPXY8MsxIv9NK0QnzoKVWRIGIkI
 Pns8kIEnPMw1tDPyBABprMkSrDLGih2HRvpqINJE1LSIXS5j1XDfNKql0jEqFs9Zobmz
 hL8S+xJ7VH3ulOi6z6UdAc+rUX6qN8MUkZRAknI/Mgi2jNUdqneS1k6yYlkN+ox2b0IS
 HWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Op5r7EOdBV4BbGLAIvUJLLDg7hQO+sSgowMYpfbKfg8=;
 b=OY7WsdOFGHJmojR78UuKphLeEB5sGAEeKex5QEL79EmupD1THlFyD9jsOuvlmGgOkK
 fTTSRU9mQrsrw8ZFbPEOzNmVXhGY6JkzyWgO3HRR6g/unTdpj2IV4uXR/TCFvPL6kN3J
 CUeTafq3OzRu1wuK3PUwHAnPEM6vt1225a5GFBnS3djD3bRFtGJ6SAjp+uaNy+hLPpH9
 QeM/VbzHoVgy0Uwo728JRxbJcCsSNtmC0ZAq8dSrMsGmPtQFwjvv1Aj5OLzq4vAE+Hyh
 PZJfhnQQGI1oxv8Q4idUhLWx8K8w2t+bCANKubkG9OE3A9yzjLO6RK+taOeWKG7Bp0Fc
 GhYw==
X-Gm-Message-State: AOAM531mLNPtE1PL8SCQZoc7/dqhW6bxu3zGwh0HqhVFJsPe3b82+RKT
 b43GC13kXxGVIII72mLjctweX34je4Ls0nsPehM=
X-Google-Smtp-Source: ABdhPJyzEimWnzXyKiBpj9KBN02KCZuQ9SM1Z+dkOkshnyBl6+0HIUN6koKO4+3cGQFOWakNPgxwioWaufRwHsUvm5M=
X-Received: by 2002:a92:2e0b:: with SMTP id v11mr5666027ile.112.1600798305611; 
 Tue, 22 Sep 2020 11:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200922161611.2049616-1-berrange@redhat.com>
 <CAEg-Je-td5R-pqbzUgpNYo856QnyfVafSh7QNNaWv8qvcRaJ9A@mail.gmail.com>
 <20200922174252.GU1989025@redhat.com>
In-Reply-To: <20200922174252.GU1989025@redhat.com>
From: Neal Gompa <ngompa13@gmail.com>
Date: Tue, 22 Sep 2020 14:11:09 -0400
Message-ID: <CAEg-Je_psR2xZ41dUNRzUP0J8herCBeBChyFXa5vn8+rsqbtrA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] block: deprecate the sheepdog driver
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=ngompa13@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 sheepdog@lists.wpkg.org, qemu-block@nongnu.org,
 libvir-list <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 1:43 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Tue, Sep 22, 2020 at 01:09:06PM -0400, Neal Gompa wrote:
> > On Tue, Sep 22, 2020 at 12:16 PM Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:
> > >
> > > 2 years back I proposed dropping the sheepdog mailing list from the
> > > MAINTAINERS file, but somehow the patch never got picked up:
> > >
> > >   https://lists.gnu.org/archive/html/qemu-block/2018-03/msg01048.html
> > >
> > > So here I am with the same patch again.
> > >
> > > This time I go further and deprecate the sheepdog driver entirely.
> > > See the rationale in the second patch commit message.
> > >
> > > Daniel P. Berrang=C3=A9 (2):
> > >   block: drop moderated sheepdog mailing list from MAINTAINERS file
> > >   block: deprecate the sheepdog block driver
> > >
> > >  MAINTAINERS                |  1 -
> > >  block/sheepdog.c           | 15 +++++++++++++++
> > >  configure                  |  5 +++--
> > >  docs/system/deprecated.rst |  9 +++++++++
> > >  4 files changed, 27 insertions(+), 3 deletions(-)
> > >
> > > --
> > > 2.26.2
> > >
> > >
> >
> > I don't know of anyone shipping this other than Fedora, and I
> > certainly don't use it there.
> >
> > Upstream looks like it's unmaintained now, with no commits in over two
> > years: https://github.com/sheepdog/sheepdog/commits/master
> >
> > Can we also get a corresponding change to eliminate this from libvirt?
>
> This is only deprecation in QEMU, the feature still exists and is
> intended to be as fully functional as in previous releases.
>
> Assuming QEMU actually deletes the feature at end of the deprecation
> cycle, then libvirt would look at removing its own support.
>

Does that stop us from deprecating it in libvirt though?

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

