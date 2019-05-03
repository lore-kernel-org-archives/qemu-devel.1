Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DE6C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 21:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F052075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 21:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRJ4sTE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F052075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47490 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMfnc-0005Ig-Ih
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 17:32:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1hMfmh-0004x3-3i
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1hMfmf-0007jS-Oo
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:31:59 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b]:35772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nirsof@gmail.com>)
	id 1hMfmc-0007gE-BD; Fri, 03 May 2019 17:31:54 -0400
Received: by mail-io1-xd2b.google.com with SMTP id r18so6427843ioh.2;
	Fri, 03 May 2019 14:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Y1feQyjbF6q0PvWmothWPG3aN5M9Ex4xX7B4acd/kNg=;
	b=JRJ4sTE2mLlnEOw8KPPa6f848xBjuaWXyhhSvoscOCAQwPwNnNzRBfk0BmJ8WayLRQ
	hNExR/8IR9CgfG2ivF1PiqAteVf99KRvhqDZRROLBUp+OGKGNKXLEG/Fu8yMetr/6Nqt
	MRMBSIPH67LNOHA5N/KfNB+uuXujY8Dz+zkq6z+gRjo/+gUhicKc6cT1cNCL9TLCwIN9
	4phq/gBplbU9fmziqvsSchyXoGc5MC+ZKaNhS0TAljELs1rl083MbE6g8gh/QFc8NmxR
	AVJhtyiHK6xhwyE/+wuF15nDlhf2SI/AsxzzGELwrRvYQz4Zmo4y1iB9WcBD4x1+reNP
	AePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Y1feQyjbF6q0PvWmothWPG3aN5M9Ex4xX7B4acd/kNg=;
	b=iVFmTTZ3SACqUXGHHfLjmhmytJnc67vM82Pu7go4vsSCo0TDjtmpIcbm4EKpVxMqc3
	PkiPjx/IQWH1Lfn1HDDUCB+RLdNqhzoi4knRAgnINbceRSxx13i4GJ//Tw59Oeta+RM8
	H+kStUsTqUr/ZH7SCSLYTcdhXXS4nWsV1NbT2P1urnP2mB0Nqq0xa4+p2voKqZ515Ws5
	9qTGgEIc72EJdt8eBcSt2Z6qis0+wQgYORz5tvtub4udcbH04ET6hcccLiScbfWz+nwi
	tAojL+nb2BOsO2ut614lABF+cul4dwwe8vKAkX4W5UCyamEN5vK2eMx55hpydfhcGaf8
	iyew==
X-Gm-Message-State: APjAAAVfgHNlE8/PU7nxAPIwkG/4ObkmK2sCO19GVuFvO37aQVt8ZBEh
	KtNq4x+l0Lg+0DxODip/6b0xLNYC+hSlm8NSSco=
X-Google-Smtp-Source: APXvYqwqO6YVfFywFqPd8HpJ4KnQufA5Oshg5M9mCzzjJafEu3F4PHVLZEvMudtGeakOxdPTgQRHJW7C/o63tgR+XB8=
X-Received: by 2002:a5d:9b96:: with SMTP id r22mr8845995iom.74.1556919111777; 
	Fri, 03 May 2019 14:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
	<f1dfe2c3-2d61-e477-ac3d-37ad26d9236d@redhat.com>
	<61685a48-b84e-c379-7193-f456e82635ba@redhat.com>
	<67a38513-89af-7f54-2fc8-05b5777983ca@redhat.com>
In-Reply-To: <67a38513-89af-7f54-2fc8-05b5777983ca@redhat.com>
From: Nir Soffer <nirsof@gmail.com>
Date: Sat, 4 May 2019 00:31:38 +0300
Message-ID:
 <CAMr-obv28mp9bABmm906tnwfkBp93ATeEsuaUt-o=Ti75N_1DQ@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d2b
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Failing QEMU iotest 175
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503213138.rbWNF0itUcdmfnpBSTZVGoZcmxZl0dKDyODL193s-AI@z>

On Fri, May 3, 2019, 23:21 Eric Blake <eblake@redhat.com> wrote:

> On 5/2/19 11:37 PM, Thomas Huth wrote:
> > On 02/05/2019 23.56, Eric Blake wrote:
> >> On 4/28/19 10:18 AM, Thomas Huth wrote:
> >>> QEMU iotest 175 is failing for me when I run it with -raw:
> >>>
> >>
> >>>  == creating image with default preallocation ==
> >>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
> >>> -size=1048576, blocks=0
> >>> +size=1048576, blocks=2
> >>
> >> What filesystem?
> >
> > ext4
> >
>
> Hmm, it's passing for me on ext4, but that probably means we have
> different configuration parameters. I'm not sure how to easily show what
> parameters a particular ext4 partition uses to compare the differences
> between your setup and mine (mine is tuned to whatever defaults Fedora's
> installer chose on my behalf), so maybe someone else can chime in.
>
> >> It should be fairly obvious that 'stat -c blocks=%b' is
> >> file-system dependent (some allocate slightly more or less space, based
> >> on granularities and on predictions of future use), so we may need to
> >> update the test to apply a filter or otherwise allow a bit of fuzz in
> >> the answer. But 0/2 is definitely different than...
> >>>
> >>>  == creating image with preallocation off ==
> >>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
> preallocation=off
> >>> -size=1048576, blocks=0
> >>> +size=1048576, blocks=2
> >>>
> >>>  == creating image with preallocation full ==
> >>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
> preallocation=full
> >>> -size=1048576, blocks=2048
> >>> +size=1048576, blocks=2050
> >>
> >> 2048/2050, so we DO have some indication of whether the file is sparse
> >> or fully allocated.
> >
> > Maybe we could check that the value after "blocks=" is a single digit in
> > the first case, and matches "blocks=20.." in the second case?
>
> I wonder if 'qemu-img map --output=json $TEST_IMG' might be any more
> reliable (at least for ignoring any extra block allocations associated
> with the file, if it is some journaling option or xattr or other reason
> why your files seem to occupy more disk sectors than just the size of
> the file would imply).
>

I think it should work better and is more correct, testing actual sparsness
instead of underlying file system implementation.

I can send a fix next week.

Nir


> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>
