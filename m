Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF05C4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D5A23A5B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwC38GN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D5A23A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDfd-0006VQ-L1
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNDZz-0000fj-TW
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNDZy-0004Ji-5O
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:13:55 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601378033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v3CbcWt6VrrefnqFfH2cnDr2js7uKVn/Ji4CIA8AoOc=;
 b=EwC38GN20OYhYrhzMDNGWhBRyzOy4RuPLbppYRJG7QiEUv/lQgBryum+4MH8nFl6fuDQqN
 sC8A2zA9Wnc/68+JpR00oYShklPv7LAuEcX1gJ+tqDbmKLhtrdWt1kbu5GXaqcYUdFpE3K
 aRMoS18fzrZfWgHruchA1nYBlWGZtVM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-L7gBtIE0Mh65kRfaRVPX4w-1; Tue, 29 Sep 2020 07:13:51 -0400
X-MC-Unique: L7gBtIE0Mh65kRfaRVPX4w-1
Received: by mail-wm1-f72.google.com with SMTP id t8so1573759wmj.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=v3CbcWt6VrrefnqFfH2cnDr2js7uKVn/Ji4CIA8AoOc=;
 b=owK+7vtzqPs8T0XpldqCtOKGzKFpVsKcsJLtOMr5sYe3tPdzcx5+jhZibXjPKLysBl
 obvloEXILV4nZVjxKDZ/ZBmbuJHqxkqtA5X7wkP3/pLz74yCWreHnGXqvfk/jjE/eGK7
 krY6lQp0vnR37Vs8hNnUSlvygYdmx4qGC+oUoKgwBPtbRNTOjcp1EOQKIY82hnNDfN+X
 pWf2xlK6C/Sz01FfMuK770UrGiS3i4Hyn3Cdz82kkHFNA5Q9lsLb+cDD2wA/4mSK2Tag
 3OFM7rendBvaEK5bwA5sEnnoEGql1kuDaS3GKp6p6ENIkBpbsS6XqFT3w+v1rd7ZRZ3L
 uKkA==
X-Gm-Message-State: AOAM5337uQbj/HJeUOVg3QdnC66TWNiNToYdLa4j7Fi/XGKF9c2T5eKi
 WmHA0toA25r8LHim8G8nQNbc7YZihq29UMyIMxQAXSzLOIayjDfECmamWrl8gHA7f9rKVKQygbn
 Dur/1bwfOequ66OQ=
X-Received: by 2002:adf:df05:: with SMTP id y5mr4004956wrl.39.1601378029564;
 Tue, 29 Sep 2020 04:13:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyG8ZRrQjdQ9KEx8Vmt3sejqJnj9vhQm/3GvuVnrj2hb08GMvRfEw+0gpvJlLjKRiLmWkQapA==
X-Received: by 2002:adf:df05:: with SMTP id y5mr4004927wrl.39.1601378029297;
 Tue, 29 Sep 2020 04:13:49 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id s11sm5490966wrt.43.2020.09.29.04.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 04:13:48 -0700 (PDT)
Date: Tue, 29 Sep 2020 07:13:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v4 00/48] virtio,pc,acpi: fixes, tests
Message-ID: <20200929071323-mutt-send-email-mst@kernel.org>
References: <20200929071948.281157-1-mst@redhat.com>
 <20200929070322-mutt-send-email-mst@kernel.org>
 <CAFEAcA_D+qM6jW9LeB4gpU-A9skUv8mpWWQJ1uu9xMjw7nwxOA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_D+qM6jW9LeB4gpU-A9skUv8mpWWQJ1uu9xMjw7nwxOA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 12:07:01PM +0100, Peter Maydell wrote:
> On Tue, 29 Sep 2020 at 12:04, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Sep 29, 2020 at 03:20:52AM -0400, Michael S. Tsirkin wrote:
> > > Changes from v3:
> > > - dropped reconnect tests
> > > - added more fixes, an smbios feature
> > >
> > > The following changes since commit 74504514b154ebebdff577d88e4bf5c13074e9ed:
> > >
> > >   Merge remote-tracking branch 'remotes/alistair/tags/pull-register-20200927' into staging (2020-09-28 16:49:10 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > >
> > > for you to fetch changes up to 8138405528c29af2a850cd672a8f8a0b33b7ab40:
> >
> > Ani Sinha pointed out that this included unnecessary files, I pushed out
> > a new commit 192d48b4ae4216f0dc40fba35e8edf3b92713aa7 which should be
> > ok.
> 
> Oops, I just merged 8138405528c before reading this mail. Could
> you send another pullreq which makes the fixes as changes to master,
> please?
> 
> thanks
> -- PMM

Done. Sorry about making this mess.

-- 
MST


