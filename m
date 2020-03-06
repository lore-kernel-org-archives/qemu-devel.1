Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7449C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 00:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F9F2073D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 00:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIbfWnBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F9F2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA16M-000285-Lt
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 19:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jA15P-0001ih-Ud
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 19:43:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jA15O-0001TM-7I
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 19:43:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30880
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jA15O-0001Qa-1n
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 19:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583455409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+T3ReBb/QUjDJJXxYT4VhhQ87fGOPU8FfSvZkc7SLYs=;
 b=CIbfWnBqIO6bNCgT6loq3Y/EQ7x0IHtS12bs5sTsOca9ErJ1Fh8HEAwguW5QcDepGsFQlP
 FWcZ/MD2G0ArjxBa3XFSutk/exi5MenGhH9EdV7L8p9MAT24lB4NgETZQU7Qp6Hy1darqR
 DvDdQqCRKH/vqEu9zSY1gGkmIE3nfKg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-ny3y9soBN-af0yntzWq7zA-1; Thu, 05 Mar 2020 19:43:27 -0500
X-MC-Unique: ny3y9soBN-af0yntzWq7zA-1
Received: by mail-qv1-f72.google.com with SMTP id v2so177394qvi.6
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 16:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AhrPsoeAltRIanOLZZ5t+xZQRpTWInVfuZh6XXQDRO0=;
 b=QqewRZrrGyqUbEFyp3055AqPjI2mLw0GS4M7ImUc5anj7Ro4aYOVsqxNYnGd1HKiFY
 E0SqKgkNlRYXbyutSFCJ7j4eW7MVYry2RvQMqjssFZKrQ7T7NyPyvpMBFqmivKOPQHsA
 oTs1CbzZJIVb6OrLLpBTsPExMWAijgCT/aNHJvUlMv1Nbu4Bp3lbmzBaqQg+bXRuxUmr
 pQL+lgwhyM5xT6tc5T4oyB120yd+8y4jhNJUoozRbbzpdDgOevDMigFwP4N8dEvQGfOi
 7iC7iT9Ig9gnySgwdcxJkogCP34OAU5537IK5JxAEtMqJFVMi31MkP+mVdn1ALJBTJWI
 WVEA==
X-Gm-Message-State: ANhLgQ0arFiEt2ClQ6qj26FwG3N6fYdlEgk2Cm1Nn4PzK8tMfBjRxFNq
 TM6UQ2D4AVuUVYt4LqbpVhIJz3qamW3gvCc/7Wn399K1uMo+3TXnDIHcMygHYyTEZUlXY+vF5ze
 vhMOLnnjeeWamVHY=
X-Received: by 2002:a05:6214:20c:: with SMTP id
 i12mr899251qvt.48.1583455407282; 
 Thu, 05 Mar 2020 16:43:27 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtOtz4TyqMwccCRc2lkj7fAsJ/jpRLQ8FlALkGr2jnVJeLj+8sT3lPxH6sepWULsLGqzfTMzw==
X-Received: by 2002:a05:6214:20c:: with SMTP id
 i12mr899240qvt.48.1583455406893; 
 Thu, 05 Mar 2020 16:43:26 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id h9sm16754459qtq.61.2020.03.05.16.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 16:43:25 -0800 (PST)
Date: Thu, 5 Mar 2020 19:43:24 -0500
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 4/5] KVM: Kick resamplefd for split kernel irqchip
Message-ID: <20200306004324.GG7146@xz-x1>
References: <20200228161503.382656-1-peterx@redhat.com>
 <20200228161503.382656-5-peterx@redhat.com>
 <20200305165857.6a3ec29f@w520.home>
MIME-Version: 1.0
In-Reply-To: <20200305165857.6a3ec29f@w520.home>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 05, 2020 at 04:58:57PM -0700, Alex Williamson wrote:

Hi, Alex,

[...]

> > +bool kvm_resample_fd_notify(int gsi)
> > +{
> > +    KVMResampleFd *rfd;
> > +
> > +    if (!kvm_irqchip_is_split()) {
> > +        return false;
> > +    }
>=20
> Nit, checking split irqchip here seems unnecessary.  We're only adding
> and removing list entries based on split irqchip below, so the list
> would be empty anyway, unless another user comes along that might have
> a reason for this functionality that isn't as tied to split irqchip.

Right, now it's more or less a hint to readers, and we can remove it.
I'll see whether I'll repost a new version, and I'll drop it if so.

>=20
> Overall the series looks like a big improvement versus falling back to
> our crappy generic EOI hackery with split irqchip.  Thanks,

Yes I was pretty happy to see the numbers too when I first tested the
series, after all I was still uncertain about how much overhead the
userspace EOI would take on the irq return path.  It turns out that
the injection seems to be more important.

In all cases, major credits go to Paolo for the idea. :)

Thanks,

--=20
Peter Xu


