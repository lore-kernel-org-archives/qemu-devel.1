Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA95C31E44
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 06:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A7C4218B0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 06:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtQ9ZJox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7C4218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44436 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcklZ-0003je-IS
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 02:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43201)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hckki-0003HO-16
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 02:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hckkg-0006i5-Pp
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 02:04:23 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:36147)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hckkg-0006hk-I2
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 02:04:22 -0400
Received: by mail-qt1-x844.google.com with SMTP id p15so9400444qtl.3
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 23:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0ZwWT79xovLicytd99A6TaPhtIDP9OH+aW0ONXbCoCo=;
 b=FtQ9ZJoxFfeqEj+eZdP9rDbgDBV8Dd6kARGwbbrBiC93/G+OQmU+m6f+pOGe/Jy3er
 7UcjJJf9qUMmimld/NLPAfzB78aZIazFnmKfcRfXsY0AnGrPzqTmC4krmbV818Qb5+iu
 +sSBLDT8/0634rHzcBU/dZJuIxGZDCVS73IoZ4U7cOz5oPNWS4O5gdaI7VwVPtE+w2u0
 G20POKM1lFI6me7yHzRJvIn9787T1ww70aoMIbBlYKtXMWWznc6QqVXDeefrrF6Lg8JJ
 aNvtPRMhLfkaCr5ny+gYbnz43CeBMplIWYqggKtvvRanywudAe2ribNuS2O2T4DyonUc
 P4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0ZwWT79xovLicytd99A6TaPhtIDP9OH+aW0ONXbCoCo=;
 b=gRLkpwRbvnpLZQWYg6vzNTbUfff3XpKmOtfwie3KQ/878VzQshsVyl1RyPy1042YMF
 JPV0dAiufFDokA5KfImjzh7RsTPyr16SMi0h2xnha1eeFJv5Rjwt0FNR6edBvkoOM8uo
 oBhcW3/I+K+RQ5VctcOEaRCNA+G4R+qAfwfPloySV6xG8gxqJUiUU5yb9qRXL3KFse4B
 qLXN6l9ZWQBhpyqVdArHvcDX3JXqWq8aOx4tlDgzD1DE3r1HfPGycDYWvpKx0tlW1pts
 N688Ypaf10B3abv0S5GYhZWTP7ZduUWd6rru+6aaBUzrNT82rcuRZckCfrpMzQOnEGTs
 wrvg==
X-Gm-Message-State: APjAAAVWsNZryqCrulzqArQ4pE4e2ukUh+kNe8RsaInIx6H6AC1LYhpF
 Uw8vVGPSEb9nCdqRh39FTO9fH1PpnIzwOelN2s0=
X-Google-Smtp-Source: APXvYqy1YmRsMgUszII2U0VAsWUmc8g012EBL0n53cMaZgjuIijoO5F6wtG2OeZQhSHc5oMDgk2SmPjfTftIxbIoT9c=
X-Received: by 2002:ac8:3811:: with SMTP id q17mr62897201qtb.315.1560751462106; 
 Sun, 16 Jun 2019 23:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190614093121.5580-1-xieyongji@baidu.com>
 <20190614093121.5580-2-xieyongji@baidu.com>
 <20190614134452.7924f135@bahia.lan>
 <CAONzpcYMmw+4q-VmBOnrBBNbfrG4XeSggk3R2tAKmF5u6b1VcA@mail.gmail.com>
 <20190617072044.3e95124f@bahia.lan>
In-Reply-To: <20190617072044.3e95124f@bahia.lan>
From: Yongji Xie <elohimes@gmail.com>
Date: Mon, 17 Jun 2019 14:04:10 +0800
Message-ID: <CAONzpcaPxf2aBrBhNYyFg11TFNLzjEE0qf1Hc_6ePPjb0CVYrA@mail.gmail.com>
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: Re: [Qemu-devel] [PATCH v3 1/5] virtio: add "use-started" property
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, pbonzini@redhat.com,
 Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Jun 2019 at 13:24, Greg Kurz <groug@kaod.org> wrote:
>
> On Mon, 17 Jun 2019 10:14:30 +0800
> Yongji Xie <elohimes@gmail.com> wrote:
>
> > On Fri, 14 Jun 2019 at 19:45, Greg Kurz <groug@kaod.org> wrote:
> > >
> > > On Fri, 14 Jun 2019 17:31:17 +0800
> > > elohimes@gmail.com wrote:
> > >
> > > > From: Xie Yongji <xieyongji@baidu.com>
> > > >
> > > > In order to avoid migration issues, we introduce a "use-started"
> > > > property to the base virtio device to indicate whether use
> > > > "started" flag or not. This property will be true by default and
> > > > set to false when machine type <= 4.0.1.
> > > >
> > > > Suggested-by: Greg Kurz <groug@kaod.org>
> > > > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > > > ---
> > > >  hw/block/vhost-user-blk.c  |  4 ++--
> > > >  hw/core/machine.c          |  8 ++++++--
> > >
> > > This patch conflicts with latest upstream changes to hw_compat_4_0_1[].
> > >
> > > It seems you need to rebase. Also, I'm still not sure how we're supposed
> > > to handle hw_compat_4_0_1[] versus hw_compat_4_0[]... nobody commented
> > > on:
> > >
> > > https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg00637.html
> > > https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg00641.html
> > >
> > > Maybe worth to sort that out before re-posting.
> > >
> >
> > If hw_compat_4_0_1[] is introduced only for q35, I think this patch
> > should be OK. If not, maybe we should handle hw_compat_4_0_1[] in
> > other machine types (i440fx, arm, ppc, s390)?
> >
>
> It turns out that hw_compat_4_0_1[] isn't needed at all. Please see:
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg03054.html
>

Oh, great! I will rebase my patch after this commit is merged.

Thanks,
Yongji

