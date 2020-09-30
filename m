Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_HEX
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02753C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133452067D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="CJhSyskb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133452067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYU0-0003Ox-U8
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 05:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNYS9-0002Fq-Qz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:31:13 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNYS6-0002lO-7z
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:31:13 -0400
Received: by mail-wm1-x343.google.com with SMTP id e17so933381wme.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 02:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Bh6DnJ5o/XQF5NpOFv9pVytGVLoo7o9HmSKupwBJDSk=;
 b=CJhSyskbirqZZkQjYBh4uQdtp4FBzuF9sMlYDDz3nMK031zkPXw9A6hmXzeCrolNAM
 nYaG7I79diZd/UEETWKSBhTiQ0Owpf/a0ksfx34GmpAY1+0HnORRFn1Bo0zK0jtHrRFl
 ldCa4Z2V9mvk7NicFEP/19xvMc+c3t8VUp0DctIyFLVTu1HK8vLF/iuF5rBTkcB6zWdx
 kbtyn1SVwLNBnoNhdy+N9y1b2t1XvfxmdNUXhUFBd7T/dDoisrsjiw9llhyzSAiFekx8
 0Lb5JufJtm6mQjxOmZz7N2yO2xFA4wfEigY10YiY0fTLPeHSULPWf75u7UkO3bmvTAd+
 ImNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Bh6DnJ5o/XQF5NpOFv9pVytGVLoo7o9HmSKupwBJDSk=;
 b=HKO/foQ4bHtdQyJehfbvLsY5+um+bP+RH2bypoa5KESJOI8rzR0Ks6d9Enu5IOxwri
 YP3PvKSUpHIz6nFnjIpH9u0wFkTQDizBvsOMPS+LmxosqIsK6J6rq42yaE2W9z8bsJkt
 9L3sbEitVUC7ta3/3M5vJH5Uczddl6vU6rfBVFZOfwr6zPQftkRAqGJpLXLDkX+0FNEO
 UHjyIFn/4dVM0txjI6b9vo+6antFOrQxiDB6Ntp6MWZIpnqrH1q1RkQ3EMZk6XOxe8bM
 I3ebZuQUcvSk4ZJMvAYhkPQsAKlEfssFmQUxM/YKWN5gBC93BunGJ2X8ouBOeoGaHFvZ
 3HiQ==
X-Gm-Message-State: AOAM532wQKrDrTMVYj+IRKD14uY6JOjZGKxzfqHjKxanqJoNNx4TNeve
 QGJaNaZKRWgtb9E8eY14KvFvybpqVUX47JYFpDZrxw==
X-Google-Smtp-Source: ABdhPJyItlh8XLAojij5XOsXcBQn9KQjfaXSR7jb7of4EO1nR/s5D+UsNT/6oltG5LqJyl/UaI/ZE9LJelEdfkcDajY=
X-Received: by 2002:a1c:c207:: with SMTP id s7mr2040004wmf.102.1601458268358; 
 Wed, 30 Sep 2020 02:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200929064858-mutt-send-email-mst@kernel.org>
 <CAARzgwwFeSPd=JGjdk-uj=uuLb+HcfMfGTe1_GmbFRTkP-jZdQ@mail.gmail.com>
 <20200929071412-mutt-send-email-mst@kernel.org>
 <CAARzgwzdYfVn6Kdic+rj7xSxdvP6RAM48wr8Pt_MpDwuYvDSiw@mail.gmail.com>
 <20200929073523-mutt-send-email-mst@kernel.org>
 <CAARzgwyNHnG_dzhD9mZbico2V3-c=XL-fNo7xO=rP2jfVMqtdw@mail.gmail.com>
 <20200930033540-mutt-send-email-mst@kernel.org>
 <CAARzgwyAE1bL5VnkH7dKBeMEtwcsZBhuhtRxx+BUxYsd8ZRi_A@mail.gmail.com>
 <20200930034220-mutt-send-email-mst@kernel.org>
 <CAARzgwy_+kVWQs5sQo4qAYC3Gi5LhdLoMQDPzKadwRPZ1D8Brw@mail.gmail.com>
 <20200930040207-mutt-send-email-mst@kernel.org>
 <CAARzgwz1TJpyVZfxJF=yCoj4pBMsUxOvaVmZCCn0Dfni-dB5kw@mail.gmail.com>
In-Reply-To: <CAARzgwz1TJpyVZfxJF=yCoj4pBMsUxOvaVmZCCn0Dfni-dB5kw@mail.gmail.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Wed, 30 Sep 2020 15:00:56 +0530
Message-ID: <CAARzgwzDdYnkKGBUdjr367qqZ3As4bqEhhWiaLqRzwXN2VKhHA@mail.gmail.com>
Subject: Re: [PATCH v10 13/13] tests/acpi: add DSDT.hpbrroot DSDT table blob
 to test global i440fx hotplug
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000355f0905b0848fc1"
Received-SPF: none client-ip=2a00:1450:4864:20::343;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URI_HEX=0.1 autolearn=no autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000355f0905b0848fc1
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 30, 2020 at 1:37 PM Ani Sinha <ani@anisinha.ca> wrote:

> On Wed, Sep 30, 2020 at 1:34 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> >
>
> > On Wed, Sep 30, 2020 at 01:17:53PM +0530, Ani Sinha wrote:
>
> > >
>
> > >
>
> > > On Wed, Sep 30, 2020 at 1:14 PM Michael S. Tsirkin <mst@redhat.com>
> wrote:
>
> > >
>
> > >     On Wed, Sep 30, 2020 at 01:09:09PM +0530, Ani Sinha wrote:
>
> > >
>
> > >     >
>
> > >
>
> > >     >
>
> > >
>
> > >     > On Wed, Sep 30, 2020 at 1:06 PM Michael S. Tsirkin <
> mst@redhat.com>
>
> > >     wrote:
>
> > >
>
> > >     >
>
> > >
>
> > >     >     On Tue, Sep 29, 2020 at 06:03:00PM +0530, Ani Sinha wrote:
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > On Tue, Sep 29, 2020 at 5:05 PM Michael S. Tsirkin <
> mst@redhat.com>
>
> > >
>
> > >     >     wrote:
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > On Tue, Sep 29, 2020 at 04:58:03PM +0530, Ani Sinha
> wrote:
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > On Tue, Sep 29, 2020 at 4:45 PM Michael S. Tsirkin <
>
> > >     mst@redhat.com>
>
> > >
>
> > >     >     wrote:
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > On Tue, Sep 29, 2020 at 04:35:50PM +0530, Ani Sinha
> wrote:
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > On Tue, Sep 29, 2020 at 4:25 PM Michael S. Tsirkin
> <
>
> > >
>
> > >     >     mst@redhat.com> wrote:
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > On Tue, Sep 29, 2020 at 04:11:45PM +0530, Ani
> Sinha
>
> > >     wrote:
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > On Tue, Sep 29, 2020 at 4:07 PM Michael S.
> Tsirkin <
>
> > >
>
> > >     >     mst@redhat.com> wrote:
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > On Tue, Sep 29, 2020 at 04:02:07PM +0530,
> Ani Sinha
>
> > >     wrote:
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > > On Tue, Sep 29, 2020 at 4:00 PM Ani Sinha <
>
> > >
>
> > >     >     ani@anisinha.ca> wrote:
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > > > In your pull request the following patch
> is
>
> > >     completely
>
> > >
>
> > >     >     screwed up:
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > > > commit
> cda2006eded0ed91974e1d9e7f9f288e65812a3e
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > > > Author: Ani Sinha <ani@anisinha.ca>
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > > > Date:   Tue Sep 29 03:22:52 2020 -0400
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > > >     tests/acpi: update golden master
> DSDT binary
>
> > >     table
>
> > >
>
> > >     >     blobs for q35
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > > > This is not my patch. It has all sorts
> of changes
>
> > >     which
>
> > >
>
> > >     >     does not
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > > > belong there. Can you please check?
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > > See https://patchew.org/QEMU/
>
> > >
>
> > >     >     20200929071948.281157-1-mst@redhat.com/
>
> > >
>
> > >     >     20200929071948.281157-46-mst@redhat.com/
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > I had to regenerate the binary, yes. That's
> par for
>
> > >     the
>
> > >
>
> > >     >     course.
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > But it looks like I added disasssembled
> files. Will
>
> > >     fix up
>
> > >
>
> > >     >     and drop,
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > > thanks for noticing this.
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > OK I pushed out a fixed variant. Pls take a look.
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > OK I am not used to this workflow. How am I
> supposed to get
>
> > >     it?
>
> > >
>
> > >     >     Which tag?
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > New for_upstream tag - I just sent in a pull request.
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > Can you please point me to your tree?
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git
> tags/
>
> > >     for_upstream
>
> > >
>
> > >     >
>
> > >
>
> > >     >     >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > I have sent the updated patches based on your pull request
> tag. I
>
> > >     just
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > had to regenrated the blob for
> tests/data/acpi/pc/DSDT.hpbrroot.
>
> > >
>
> > >     >
>
> > >
>
> > >     >     >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > make && make check-qtest-x86_64 V=1 passes.
>
> > >
>
> > >     >
>
> > >
>
> > >     >     >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > The diff looks good.
>
> > >
>
> > >     >
>
> > >
>
> > >     >     >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > Can you please send a pull request with these two patches
> ASAP?
>
> > >
>
> > >     >
>
> > >
>
> > >     >
>
> > >
>
> > >     >
>
> > >
>
> > >     >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     Thanks, I will queue them and merge in the next pull request.
>
> > >
>
> > >     >
>
> > >
>
> > >     >
>
> > >
>
> > >     > I'm willing to get down on my knees begging you to just do one
> another
>
> > >     pull
>
> > >
>
> > >     > request for these two patches. Were so close with my entire work
> merged.
>
> > >
>
> > >     >
>
> > >
>
> > >     > Please let's not wait another week or so.
>
> > >
>
> > >
>
> > >
>
> > >
>
> > >
>
> > >     OK it's not too much work but ... could you please add
> justification
>
> > >
>
> > >     about why adding this one unit test is needed so urgently?
>
> > >
>
> > >     That motivation would be quite helpful for the pull request.
>
> > >
>
> > >
>
> > > A patch without unit test doesn't complete the patch work. A unit test
> makes
>
> > > sure that the change would not get broken by other changes that come
> in later.
>
> > > Typically all code changes are accompanied by unit test in the same
> patch.
>
> > > Hence since the main work has already been merged, the unit test
> should merge
>
> > > ASAP so that no breakage can happen in between.
>
> > >
>
> > > Plus this completes an entire series of work which I've been working
> for a
>
> > > while. I really would love to see it all merged cleanly and fully
> completed.
>
> > >
>
> >
>
> > Absolutely, thanks for the great work!
>
> > I am not sure that's a good justification to rushing a pull request
>
> > though ... are you waiting to get paid and it hinges on the test, or are
>
> > under a deadline, or something like this? It's okay to say so if so.
>
>
>
> Yes I am under a deadline too. Unfortunately can't disclose more details.


Thanks Michael. Very much appreciate your help here.


>
>
>
> >
>
> > >
>
> > >
>
> > >
>
> > >
>
> > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >
>
> > >
>
> > >     >
>
> > >
>
> > >     >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > I think DSDT.hbridge is wrong. The checksum
> looks
>
> > >     weird:
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > + *     Length           0x00000B89 (2953)
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > >   *     Revision         0x01 **** 32-bit
> table (V1),
>
> > >     no
>
> > >
>
> > >     >     64-bit math support
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > - *     Checksum         0x05
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > What is weird about it?
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > > This file should be introduced just by one
> patch. my
>
> > >     patch.
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > I just re-run rebuild-expected-aml, no changes.
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > I have this:
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > commit 5e3a486211f02d9ecb18939ca21087515ec81883
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > Author: Ani Sinha <ani@anisinha.ca>
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > Date:   Fri Sep 18 14:11:05 2020 +0530
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >     tests/acpi: unit test for
>
> > >
>
> > >     >     'acpi-pci-hotplug-with-bridge-support' bridge flag
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >     This change adds a new unit test for the
> global flag
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >     'acpi-pci-hotplug-with-bridge-support' which
> is
>
> > >     available
>
> > >
>
> > >     >     for cold plugged pci
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >     bridges in i440fx. The flag can be used to
> turn off
>
> > >     ACPI
>
> > >
>
> > >     >     based hotplug support
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >     on all pci bridges.
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > Here is the full DSDT header, attached:
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > /*
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  * Intel ACPI Component Architecture
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  * AML/ASL+ Disassembler version 20190509 (64-bit
>
> > >     version)
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  * Copyright (c) 2000 - 2019 Intel Corporation
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  *
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  * Disassembling to symbolic ASL+ operators
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  *
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  * Disassembly of
> tests/data/acpi/pc/DSDT.hpbridge, Tue
>
> > >     Sep 29
>
> > >
>
> > >     >     06:51:03 2020
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  *
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  * Original Table Header:
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  *     Signature        "DSDT"
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  *     Length           0x0000139D (5021)
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  *     Revision         0x01 **** 32-bit table
> (V1), no
>
> > >     64-bit
>
> > >
>
> > >     >     math support
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  *     Checksum         0x05
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  *     OEM ID           "BOCHS "
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  *     OEM Table ID     "BXPCDSDT"
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  *     OEM Revision     0x00000001 (1)
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  *     Compiler ID      "BXPC"
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  *     Compiler Version 0x00000001 (1)
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >  */
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > DefinitionBlock ("", "DSDT", 1, "BOCHS ",
> "BXPCDSDT",
>
> > >
>
> > >     >     0x00000001)
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > --
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > > MST
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > > > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >     > >
>
> > >
>
> > >     >
>
> > >
>
> > >     >
>
> > >
>
> > >     >
>
> > >
>
> > >     >
>
> > >
>
> > >
>
> > >
>
> > >
>
> >
>
>

--000000000000355f0905b0848fc1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Sep 30, 2020 at 1:37 PM Ani Sinha &lt;<a href=3D"ma=
ilto:ani@anisinha.ca">ani@anisinha.ca</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1p=
x;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,20=
4)">On Wed, Sep 30, 2020 at 1:34 PM Michael S. Tsirkin &lt;<a href=3D"mailt=
o:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br><br>&g=
t;<br><br>&gt; On Wed, Sep 30, 2020 at 01:17:53PM +0530, Ani Sinha wrote:<b=
r><br>&gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt; On Wed, Sep 30, 2020 at 1=
:14 PM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_=
blank">mst@redhat.com</a>&gt; wrote:<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=
=A0 =C2=A0 =C2=A0On Wed, Sep 30, 2020 at 01:09:09PM +0530, Ani Sinha wrote:=
<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;=
<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=
=C2=A0 =C2=A0 =C2=A0&gt; On Wed, Sep 30, 2020 at 1:06 PM Michael S. Tsirkin=
 &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>=
&gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0wrote:<br><br>&gt; &gt;<br><br>&gt=
; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=
=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0On Tue, Sep 29, 2020 at 06:03:00PM +0530,=
 Ani Sinha wrote:<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=
<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=
=A0&gt; On Tue, Sep 29, 2020 at 5:05 PM Michael S. Tsirkin &lt;<a href=3D"m=
ailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt;<br><br>&gt; =
&gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0wrote:<br>=
<br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br>=
<br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br><br>&=
gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&=
gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; On Tue, Sep 2=
9, 2020 at 04:58:03PM +0530, Ani Sinha wrote:<br><br>&gt; &gt;<br><br>&gt; =
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0=
 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; On Tue, Sep 29, 2020 at 4:45 =
PM Michael S. Tsirkin &lt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"m=
ailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt;<br><br>&gt; =
&gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0wrote:<br>=
<br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br>=
<br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt=
;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt=
;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; &gt; On Tue, Sep 29, 2020 at 04:35:50PM +0530, Ani Sinha wrote:<br><br>&g=
t; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&g=
t; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=
 On Tue, Sep 29, 2020 at 4:25 PM Michael S. Tsirkin &lt;<br><br>&gt; &gt;<b=
r><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br><br>&g=
t; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&g=
t; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=
 &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt;=
 &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=
 &gt; &gt; &gt; &gt; On Tue, Sep 29, 2020 at 04:11:45PM +0530, Ani Sinha<br=
><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0wrote:<br><br>&gt; &gt;<br><br>&gt; &gt;=
=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt; On Tue, Sep 2=
9, 2020 at 4:07 PM Michael S. Tsirkin &lt;<br><br>&gt; &gt;<br><br>&gt; &gt=
;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:mst@redhat.c=
om" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br><br>&gt; &gt;<br><br=
>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =
=C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt=
;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt=
;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; &gt; &gt; &gt; &gt; &gt; On Tue, Sep 29, 2020 at 04:02:07PM +0530, Ani Si=
nha<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0wrote:<br><br>&gt; &gt;<br><br>&gt;=
 &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=
=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt; On Tue, Sep 29, 2020 at 4:00 PM Ani Sinha &lt;<br><br>&gt; &gt;<br><br>=
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:ani@=
anisinha.ca" target=3D"_blank">ani@anisinha.ca</a>&gt; wrote:<br><br>&gt; &=
gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &=
gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt=
; &gt; &gt; &gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0=
&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0=
 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; In your pull reque=
st the following patch is<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0completely<br=
><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=
screwed up:<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><b=
r>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt=
; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt;<br><br>&gt;=
 &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=
=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &=
gt; &gt; commit cda2006eded0ed91974e1d9e7f9f288e65812a3e<br><br>&gt; &gt;<b=
r><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=
=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &=
gt; &gt; &gt; &gt; Author: Ani Sinha &lt;<a href=3D"mailto:ani@anisinha.ca"=
 target=3D"_blank">ani@anisinha.ca</a>&gt;<br><br>&gt; &gt;<br><br>&gt; &gt=
;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =
=C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; =
&gt; Date:=C2=A0 =C2=A0Tue Sep 29 03:22:52 2020 -0400<br><br>&gt; &gt;<br><=
br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=
=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt;=
 &gt; &gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<b=
r><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=
=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0tes=
ts/acpi: update golden master DSDT binary<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0table<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =
=C2=A0 =C2=A0blobs for q35<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =
=C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =
=C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; =
&gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; =
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &g=
t; &gt; &gt; &gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=
=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; This is not my =
patch. It has all sorts of changes<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0whic=
h<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =
=C2=A0does not<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br=
><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; belong there. Can you ple=
ase check?<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br=
>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=
 &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=
=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; See=
 <a href=3D"https://patchew.org/QEMU/" rel=3D"noreferrer" target=3D"_blank"=
>https://patchew.org/QEMU/</a><br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=
=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://20200929071948.281157-1=
-mst@redhat.com/" rel=3D"noreferrer" target=3D"_blank">20200929071948.28115=
7-1-mst@redhat.com/</a><br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://20200929071948.281157-46-mst@r=
edhat.com/" rel=3D"noreferrer" target=3D"_blank">20200929071948.281157-46-m=
st@redhat.com/</a><br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt=
;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =
=C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt;<br><br>&gt; =
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0=
 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br><=
br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><=
br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt;=
 &gt; &gt; &gt; &gt; I had to regenerate the binary, yes. That&#39;s par fo=
r<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0the<br><br>&gt; &gt;<br><br>&gt; &gt;=
=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0course.<br><br>&gt; &gt;<br><br=
>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =
=C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt=
; But it looks like I added disasssembled files. Will<br><br>&gt; &gt;=C2=
=A0 =C2=A0 =C2=A0fix up<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0&gt;=C2=A0 =C2=A0 =C2=A0and drop,<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=
=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0=
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; thanks for =
noticing this.<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br=
><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=
&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=
=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; OK I pushed out a fixed vari=
ant. Pls take a look.<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0=
&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0=
 =C2=A0&gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=
=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; OK I am not used to this workflow=
. How am I supposed to get<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0it?<br><br>&=
gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Which =
tag?<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; =
&gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; =
&gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>=
&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; =
&gt; &gt; &gt; New for_upstream tag - I just sent in a pull request.<br><br=
>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br=
>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt;<br><br=
>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br=
>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; Can yo=
u please point me to your tree?<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=
=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =
=C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =
=C2=A0 =C2=A0&gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=
=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0git://<a href=3D"http://git.kernel.org/pub/=
scm/virt/kvm/mst/qemu.git" rel=3D"noreferrer" target=3D"_blank">git.kernel.=
org/pub/scm/virt/kvm/mst/qemu.git</a> tags/<br><br>&gt; &gt;=C2=A0 =C2=A0 =
=C2=A0for_upstream<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt=
;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =
=C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br=
>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=
 I have sent the updated patches based on your pull request tag. I<br><br>&=
gt; &gt;=C2=A0 =C2=A0 =C2=A0just<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =
=C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=
=C2=A0 =C2=A0 =C2=A0&gt; had to regenrated the blob for tests/data/acpi/pc/=
DSDT.hpbrroot.<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br=
><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=
&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; =
&gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; make =
&amp;&amp; make check-qtest-x86_64 V=3D1 passes.<br><br>&gt; &gt;<br><br>&g=
t; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=
=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=
=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0=
&gt;=C2=A0 =C2=A0 =C2=A0&gt; The diff looks good.<br><br>&gt; &gt;<br><br>&=
gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =
=C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=
=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; Can you please send a pull request with the=
se two patches ASAP?<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&=
gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &=
gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &=
gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =
=C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =
=C2=A0 =C2=A0Thanks, I will queue them and merge in the next pull request.<=
br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<=
br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=
=C2=A0 =C2=A0 =C2=A0&gt; I&#39;m willing to get down on my knees begging yo=
u to just do one another<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0pull<br><br>&g=
t; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; request for these two patc=
hes. Were so close with my entire work merged.<br><br>&gt; &gt;<br><br>&gt;=
 &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=
=A0 =C2=A0&gt; Please let&#39;s not wait another week or so.<br><br>&gt; &g=
t;<br><br>&gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;<br><=
br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0OK it&#39;s not too much work but ... could=
 you please add justification<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=
=A0 =C2=A0about why adding this one unit test is needed so urgently?<br><br=
>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0That motivation would be qui=
te helpful for the pull request.<br><br>&gt; &gt;<br><br>&gt; &gt;<br><br>&=
gt; &gt; A patch without unit test doesn&#39;t complete the patch work. A u=
nit test makes<br><br>&gt; &gt; sure that the change would not get broken b=
y other changes that come in later.<br><br>&gt; &gt; Typically all code cha=
nges are accompanied by unit test in the same patch.<br><br>&gt; &gt; Hence=
 since the main work has already been merged, the unit test should merge<br=
><br>&gt; &gt; ASAP so that no breakage can happen in between.<br><br>&gt; =
&gt;<br><br>&gt; &gt; Plus this completes an entire series of work which I&=
#39;ve been working for a<br><br>&gt; &gt; while. I really would love to se=
e it all merged cleanly and fully completed.<br><br>&gt; &gt;<br><br>&gt;<b=
r><br>&gt; Absolutely, thanks for the great work!<br><br>&gt; I am not sure=
 that&#39;s a good justification to rushing a pull request<br><br>&gt; thou=
gh ... are you waiting to get paid and it hinges on the test, or are<br><br=
>&gt; under a deadline, or something like this? It&#39;s okay to say so if =
so.<br><br><br><br>Yes I am under a deadline too. Unfortunately can&#39;t d=
isclose more details.</blockquote><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Thanks Michael. Very much appreciate your help here.</div><div dir=3D"=
auto"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1ex;bor=
der-left-color:rgb(204,204,204)" dir=3D"auto"><br><br><br><br>&gt;<br><br>&=
gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt=
;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt=
;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt=
;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =
=C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br=
>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=
 &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt;=
 &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=
<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;=
<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br><=
br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><=
br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt;=
<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;=
<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt;=
 &gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br=
>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=
 &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =
=C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =
=C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt; I think DSDT.hbridge is wro=
ng. The checksum looks<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0weird:<br><br>&g=
t; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&g=
t; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt;=
 &gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br=
>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=
 &gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=
=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt; + *=C2=A0 =C2=A0 =C2=A0=
Length=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00000B89 (2953)<br><br>&gt=
; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt=
; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; =
&gt; &gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0Revision=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x01 **** 32-bit table (V1),<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0=
no<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =
=C2=A064-bit math support<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =
=C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =
=C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt; - *=C2=A0 =C2=A0 =C2=A0Chec=
ksum=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x05<br><br>&gt; &gt;<br><br>&gt; &gt=
;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =
=C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt=
;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt=
;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; =
What is weird about it?<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=
=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=
=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &=
gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &=
gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt=
; &gt; This file should be introduced just by one patch. my<br><br>&gt; &gt=
;=C2=A0 =C2=A0 =C2=A0patch.<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =
=C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =
=C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt=
;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =
=C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; I just re-run r=
ebuild-expected-aml, no changes.<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =
=C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=
=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt;<br><br>&=
gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =
=C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; I have t=
his:<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; =
&gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; =
&gt; &gt; &gt; &gt; commit 5e3a486211f02d9ecb18939ca21087515ec81883<br><br>=
&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>=
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &g=
t; &gt; Author: Ani Sinha &lt;<a href=3D"mailto:ani@anisinha.ca" target=3D"=
_blank">ani@anisinha.ca</a>&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=
=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; Date:=C2=A0 =C2=A0Fri Sep 18=
 14:11:05 2020 +0530<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&=
gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =
=C2=A0&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0=
 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt=
;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0tests=
/acpi: unit test for<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&=
gt;=C2=A0 =C2=A0 =C2=A0&#39;acpi-pci-hotplug-with-bridge-support&#39; bridg=
e flag<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt=
; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt=
; &gt; &gt; &gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0=
&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0=
 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0This change adds a =
new unit test for the global flag<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =
=C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=
=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&#39;a=
cpi-pci-hotplug-with-bridge-support&#39; which is<br><br>&gt; &gt;=C2=A0 =
=C2=A0 =C2=A0available<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0&gt;=C2=A0 =C2=A0 =C2=A0for cold plugged pci<br><br>&gt; &gt;<br><br>&gt=
; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=
=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=
=A0 =C2=A0bridges in i440fx. The flag can be used to turn off<br><br>&gt; &=
gt;=C2=A0 =C2=A0 =C2=A0ACPI<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =
=C2=A0&gt;=C2=A0 =C2=A0 =C2=A0based hotplug support<br><br>&gt; &gt;<br><br=
>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =
=C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =
=C2=A0 =C2=A0on all pci bridges.<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =
=C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=
=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt; &gt;<br><br>&=
gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =
=C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&=
gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&=
gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt=
; &gt; Here is the full DSDT header, attached:<br><br>&gt; &gt;<br><br>&gt;=
 &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=
=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&gt;=
 &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt;=
 &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &=
gt; /*<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt=
; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt=
; &gt; &gt; &gt; &gt;=C2=A0 * Intel ACPI Component Architecture<br><br>&gt;=
 &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt;=
 &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &=
gt;=C2=A0 * AML/ASL+ Disassembler version 20190509 (64-bit<br><br>&gt; &gt;=
=C2=A0 =C2=A0 =C2=A0version)<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0=
 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 * Copyright (c) 2000 - 20=
19 Intel Corporation<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&=
gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =
=C2=A0&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 *<br><br>&gt; &gt;<br><br>&gt; &g=
t;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =
=C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 * Disasse=
mbling to symbolic ASL+ operators<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =
=C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=
=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 *<br><br>&gt; &gt;<=
br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=
=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;=
=C2=A0 * Disassembly of tests/data/acpi/pc/DSDT.hpbridge, Tue<br><br>&gt; &=
gt;=C2=A0 =C2=A0 =C2=A0Sep 29<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=
=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A006:51:03 2020<br><br>&gt; &gt;<br><br>&gt=
; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=
=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 *<br>=
<br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br>=
<br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt=
; &gt; &gt;=C2=A0 * Original Table Header:<br><br>&gt; &gt;<br><br>&gt; &gt=
;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =
=C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 *=C2=A0 =
=C2=A0 =C2=A0Signature=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;DSDT&quot;<br><br>&=
gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&=
gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt=
; &gt;=C2=A0 *=C2=A0 =C2=A0 =C2=A0Length=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x0000139D (5021)<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=
=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 *=C2=A0 =C2=A0 =C2=A0Revision=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x01 **** 32-bit table (V1), no<br><br>&g=
t; &gt;=C2=A0 =C2=A0 =C2=A064-bit<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =
=C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0math support<br><br>&gt; &gt;<br><br>&=
gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =
=C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 *=
=C2=A0 =C2=A0 =C2=A0Checksum=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x05<br><br>&=
gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&=
gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt=
; &gt;=C2=A0 *=C2=A0 =C2=A0 =C2=A0OEM ID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;BOCHS &quot;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=
=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 *=C2=A0 =C2=A0 =C2=A0OEM Tabl=
e ID=C2=A0 =C2=A0 =C2=A0&quot;BXPCDSDT&quot;<br><br>&gt; &gt;<br><br>&gt; &=
gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =
=C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 *=C2=A0 =
=C2=A0 =C2=A0OEM Revision=C2=A0 =C2=A0 =C2=A00x00000001 (1)<br><br>&gt; &gt=
;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt=
;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;=
=C2=A0 *=C2=A0 =C2=A0 =C2=A0Compiler ID=C2=A0 =C2=A0 =C2=A0 &quot;BXPC&quot=
;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt=
;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt=
; &gt; &gt; &gt;=C2=A0 *=C2=A0 =C2=A0 =C2=A0Compiler Version 0x00000001 (1)=
<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;=
<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt;=
 &gt; &gt; &gt;=C2=A0 */<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=
=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; DefinitionBlock (&quot;&quot;, &quo=
t;DSDT&quot;, 1, &quot;BOCHS &quot;, &quot;BXPCDSDT&quot;,<br><br>&gt; &gt;=
<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A00x00000001)<br=
><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br=
><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &g=
t; &gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><=
br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&g=
t; &gt; &gt; &gt; &gt; &gt; --<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=
=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=
=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt; MST<br><br>&gt; &gt;<br><br>=
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =
=C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt; &gt; &gt;<br><br>&=
gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&=
gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &gt; &gt;<br>=
<br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br>=
<br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br><br>&=
gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&=
gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =
=C2=A0 =C2=A0&gt;<br><br>&gt; &gt;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=
<br><br>&gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;<br><br>&gt; &gt;<br><br=
>&gt;<br><br></blockquote></div></div>

--000000000000355f0905b0848fc1--

