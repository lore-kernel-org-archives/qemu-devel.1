Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE394C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA28205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THS0LGq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA28205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvi32-0000l9-Tw
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 10:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jvi10-00066C-P0
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:04:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50024
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jvi0y-0007Ao-Hv
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594821843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LUdBEm3DX478dtRefPYNBoOIo+XYGvWzcSLoyAymS9I=;
 b=THS0LGq9015Cp6yqnTFFIuU77OuaZKEV83creKc/0pS2A7btFLq8BXhQ2C9ulfziEbBq/D
 ymugki/K0jbLPbBfdqQCZTHq6ivHMjT4R5Y0gMHHrAcfFQnZARwZ56UEAxn/zLn1foBVnR
 HZcROiJVBvcSYq3P++81rKNBkEFsUCY=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-eW7vmluJO5qKFMqPBeL-Zg-1; Wed, 15 Jul 2020 10:04:00 -0400
X-MC-Unique: eW7vmluJO5qKFMqPBeL-Zg-1
Received: by mail-ot1-f69.google.com with SMTP id g18so1039918otj.12
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 07:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LUdBEm3DX478dtRefPYNBoOIo+XYGvWzcSLoyAymS9I=;
 b=dkTxnyarmnKyZR0kCc6jqfkYsmtN8PF1OUXZwXFQtcgmyeRPQKacaHQCXm0sl3sG5T
 6ITPGE9RyEadOXFr8+8AXaZMW7nMcMJyex+9NnRpK6jHuwyMaVoulfVZMLi8kDPMXS3/
 kpsoyJ9uRt/mKz3zUSSLeGkbmvnp0KIhpGRg6YewCX+kckTEfiRGfUp9p6HDFquLPdEL
 Pmyzwi9d8Nbhkg19MYKrAS/ZYsx9jTqWuqAZKCfT3JUtoc6ZE8MCIgujQvFPu5yIMLeQ
 tyMDgqhgEHn8SSALTvbQ0wo6CixY5U13eYJ9yZkx+VH96vfXaAXoof+8ewmBFThoIRdF
 WNSg==
X-Gm-Message-State: AOAM532gqMyagrL/Q5KbtK34UKsmdNQrblPV+PMk6Iuyis2JVvv+D8yX
 ueWUl549p7VQ52XAGjnBotz6mIX2hDs0ycqBL3liHIYTmUWCiCitnESam6PWI4QPjUtMtsgedDw
 J859QfCxzPMlW1w7M8G8802Bg+6jwN1g=
X-Received: by 2002:a05:6830:309b:: with SMTP id
 f27mr9276722ots.315.1594821839922; 
 Wed, 15 Jul 2020 07:03:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnvS+jkoqVDZ00eut04A4TpreVEl0/pYkfKRcYukwGivF7r2SQmWIXvuZ6239t/SY8V4v0ELRSgjSh0BsQQ9E=
X-Received: by 2002:a05:6830:309b:: with SMTP id
 f27mr9276688ots.315.1594821839577; 
 Wed, 15 Jul 2020 07:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200710142149.40962-1-kwolf@redhat.com>
 <20200710142149.40962-2-kwolf@redhat.com>
 <CAMRbyyux0eQo8vmz4JB8pT_1i4PJviQJPKiaJC6ehwjLhc649A@mail.gmail.com>
 <20200713165637.GH10318@linux.fritz.box>
 <CAMRbyysaB5MDWGz7upg-O=N2vhQn4OUdZVsqeBothYBtZyy6ZA@mail.gmail.com>
 <20200715134229.GB8833@linux.fritz.box>
In-Reply-To: <20200715134229.GB8833@linux.fritz.box>
From: Nir Soffer <nsoffer@redhat.com>
Date: Wed, 15 Jul 2020 17:03:43 +0300
Message-ID: <CAMRbyytmc-6t4RJizfcgwFVVaoVeiFtCBmMoUs3HZOjt+pLCYQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1 1/2] block: Require aligned image size to avoid
 assertion failure
To: Kevin Wolf <kwolf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 4:42 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 15.07.2020 um 15:22 hat Nir Soffer geschrieben:
> > On Mon, Jul 13, 2020 at 7:56 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > >
> > > Am 13.07.2020 um 18:33 hat Nir Soffer geschrieben:
> > > > On Fri, Jul 10, 2020 at 5:22 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > > > >
> > > > > Unaligned requests will automatically be aligned to bl.request_alignment
> > > > > and we don't want to extend requests to access space beyond the end of
> > > > > the image, so it's required that the image size is aligned.
> > > > >
> > > > > With write requests, this could cause assertion failures like this if
> > > > > RESIZE permissions weren't requested:
> > > > >
> > > > > qemu-img: block/io.c:1910: bdrv_co_write_req_prepare: Assertion `end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.
> > > > >
> > > > > This was e.g. triggered by qemu-img converting to a target image with 4k
> > > > > request alignment when the image was only aligned to 512 bytes, but not
> > > > > to 4k.
> > > >
> > > > Was it on NFS? Shouldn't this be fix by the next patch then?
> > >
> > > Patch 2 makes the problem go away for NFS because NFS doesn't even
> > > require the 4k alignment. But on storage that legitimately needs 4k
> > > alignment (or possibly other filesystems that are misdetected), you
> > > would still hit the same problem.
> >
> > I want to add oVirt point of view on this. We enforce raw image
> > alignment of 4k on file based storage, and 128m on block storage, so
> > our raw images cannot have this issue.
>
> Yes, then you won't hit the problem.
>
> > We have an issue with empty qcow2 images which are unaligned size, but
> > we don't create such images in normal flows.
>
> Can you give a reproducer where qcow2 images would be affected?
> Generally speaking, the qcow2 driver either takes both WRITE and RESIZE
> permissions or neither. So it should just automatically resize the image
> as needed instead of crashing.

I think this is a theoretical issue in other programs trying to access
the unaligned
images using direct I/O.


