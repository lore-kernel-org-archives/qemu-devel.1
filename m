Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668E9C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A302173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUELP4dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A302173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55183 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT6DK-0002FN-F4
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 10:58:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT6CC-0001fA-Ik
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT6CB-0003DO-4D
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:56:52 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT6CA-0003Cw-Va
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:56:51 -0400
Received: by mail-ot1-x344.google.com with SMTP id n14so16621922otk.2
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 07:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Kle1G+IhkMcIxmQmaSHBb8I19c07Nb4mlkvkHrJKkDc=;
	b=iUELP4dyULPE0BUF4xPpa0wHFa/U5CEjEGXQuddnMhWPgIYsw75Yyq5Ezaj6kd31Aw
	fOhCbnmsnYAN+3PDXzb109hNXN+mtOeoz7OSASB/5YtCjvjZA8hwFHwLqbx9gMM4u/GW
	dyUVIh8wgXSEncc+7SBfQazHLcpuyixYv83K1Wijq8dYeAxlrk2lyjLclZtFvSVGALDp
	folQmMr7ix/X59UyElveP64T3HoORHkmi45p29wpm++/FdcVMjz1T4ij4HI9EUkf7Qjq
	AQBw5Yjkiqu4IQDyVVMN23OtXpZTRZ1Bb6xK07tfoN8kJWwT58ponOXMgzKLv3CNHkeO
	9ZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Kle1G+IhkMcIxmQmaSHBb8I19c07Nb4mlkvkHrJKkDc=;
	b=OiIlSAt3ouN/wsMs1UP6PpaSITrFFzL6x437NmE4LgJETUQUurbSiZu1yIz5xhJycX
	ZdjrggIp2LrucU4PRxyKunX3bHkeJ9ZSoqkTffGio3NVDyf3yAXADWuOAE393lPwfZcj
	fI98EVsewrIPDHUev7f4rb4gB7/89qjYp8+RqNW8c59sb6ffwCYyEuz0Ajq2NODXDCi/
	2jh3vKIuLnBJlKKtL6QyDed8mgOusRSw+mZXLP97N0KFiqheyna7/BPOhwyqM3NUsyoH
	GHmeDO2LaCp+rx09FnsDeltSCtPb07koyXaLrIhtVzy3pkLj6yvO451pQ8HMtPTWKm/+
	baqQ==
X-Gm-Message-State: APjAAAXX4X+FmjrH5NZQt29I4uIa0/C3fHBktqoyE5vKV0YiBIS09Ww2
	TSukvGWa/1DRf/j96Sz5fbEqFp2eO5C1EUulIiTRTBRxnQQ=
X-Google-Smtp-Source: APXvYqyW8djSxAX+dLAVdmasyASetLrVwGV1Ah8YZ06dQAnCR/mgdEE0cjUgiW7k4IChIecdRJyuqasca72tHsMiiBs=
X-Received: by 2002:a05:6830:209a:: with SMTP id
	y26mr19824889otq.232.1558450610404; 
	Tue, 21 May 2019 07:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190520231008.20140-1-mst@redhat.com>
	<CAFEAcA80Q8zWxM4TBVMZHLuOzo0HSpT=4C76uAwdMjLn2Xye=w@mail.gmail.com>
	<20190521094218-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190521094218-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2019 15:56:39 +0100
Message-ID: <CAFEAcA-1Y050aYg+TBv-ALCaSAFJdv_YP_eQFZt+2KrkTLDviw@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL v2 00/36] pci, pc, virtio: features, fixes
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 at 14:42, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, May 21, 2019 at 12:49:48PM +0100, Peter Maydell wrote:
> > On Tue, 21 May 2019 at 00:10, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > The following changes since commit 2259637b95bef3116cc262459271de08e038cc66:
> > >
> > >   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-05-20 17:22:05 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > >
> > > for you to fetch changes up to 0c05ec64c388aea59facbef740651afa78e04f50:
> > >
> > >   tests: acpi: print error unable to dump ACPI table during rebuild (2019-05-20 18:40:02 -0400)
> > >
> > > ----------------------------------------------------------------
> > > pci, pc, virtio: features, fixes
> > >
> > > reconnect for vhost blk
> > > tests for UEFI
> > > misc other stuff
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> > > ----------------------------------------------------------------
> >
> > Hi -- this failed 'make check' for 32-bit Arm hosts:
> >
> > ERROR:/home/peter.maydell/qemu/tests/acpi-utils.c:145:acpi_find_rsdp_address_uefi:
> > code should not be reached
> > Aborted
> > ERROR - too few tests run (expected 1, got 0)
> > /home/peter.maydell/qemu/tests/Makefile.include:885: recipe for target
> > 'check-qtest-aarch64' failed
> >
> > thanks
> > -- PMM
>
> Dropped ARM and re-pushed.

Fixed up version applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

