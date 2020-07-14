Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A600CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8E6207CD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVREvkRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8E6207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvIjJ-0007wW-Q1
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 07:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvIiQ-0007Vt-39
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 07:03:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56421
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvIiN-0005Gq-HK
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 07:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594724587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sk6wGfMUobfu/xWX4jTK8eHp+LSxrOxz59O7riEM4Mk=;
 b=CVREvkRAdsmUMcrPpWlz/mJZ7k2FFQXIuvhxt2oGWLdwRhqhDW+vUmTKpGHJUkxbJpx4So
 4jhAknbZTxyLtJcI9JTFBQi5tUhnXsI1HEL0lsUbxPqigpHffMIqOGDV8dX0WDfVE9eNsx
 A8/I0WdLcQc1UIv6PtRIV1coRvnM5SM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-dLEeZgNjO1y1Fwn2F4QB-A-1; Tue, 14 Jul 2020 07:03:05 -0400
X-MC-Unique: dLEeZgNjO1y1Fwn2F4QB-A-1
Received: by mail-wm1-f71.google.com with SMTP id g138so3378302wme.7
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 04:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Sk6wGfMUobfu/xWX4jTK8eHp+LSxrOxz59O7riEM4Mk=;
 b=LV6/GI5iYhqYkuDD/GWRdFKUCts8JUA6kj1fiVW5DegmAZUjO5qnNz9CNuAbEAGXpZ
 EXJFcbidzr5lJIB5qcB+JrDg2pX59e79tQzkZkcPeAvzqAJUw4lKApIkwBm4U9mfC5b1
 gyqat04b1zzdIwzoLFEiA0er+uqhQ10T2L7QRAE27AXUtOytsn/bzppHx/cyGhNOq1nc
 Wfdz9M5iRvAFtfj6Ab0GfKhn9qPr4+egl8mO6+Xb7xPQ9Bs4JKxCN5mvMJ1ErEompSMc
 dOE5g2pjbLiFM7EgyDHuV5Hn6I4WlX6zKVba7oet9oSRQOqMZD7wwYNOMqnHY3X3plce
 LfmQ==
X-Gm-Message-State: AOAM53347ldXCKUWNxt6JYuveDyK2jfm7zRGjTpglLHB6aBGHAGHAAR/
 CKWieY78HB8z8Zcpd/cMbahbwGAJd9VJAjU3On1HneWM1fLBg4IpGM6EpF0+BLbRtfdpCLAyvCe
 ld8PEWnpTbdTgDGk=
X-Received: by 2002:adf:82a1:: with SMTP id 30mr4857620wrc.210.1594724584318; 
 Tue, 14 Jul 2020 04:03:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrnjmaI7/5s73YJjnpwhxl6LnSwi9UDAj7K6xDh/U5qYUITKSVQFCqiMw55Zri+EbnS0PNGg==
X-Received: by 2002:adf:82a1:: with SMTP id 30mr4857574wrc.210.1594724584074; 
 Tue, 14 Jul 2020 04:03:04 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id e17sm27277234wrr.88.2020.07.14.04.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 04:03:03 -0700 (PDT)
Date: Tue, 14 Jul 2020 07:02:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
Message-ID: <20200714064921-mutt-send-email-mst@kernel.org>
References: <20200714083631.888605-1-ppandit@redhat.com>
 <20200714083631.888605-2-ppandit@redhat.com>
 <CAFEAcA9QWLmi1fGuPW93GXFKV2KCwNs6Xp3U9MU2r4wtendzhg@mail.gmail.com>
 <20200714095233.GC25187@redhat.com>
 <20200714060916-mutt-send-email-mst@kernel.org>
 <CAFEAcA_ca4JN655GW=eGyjrjDmiv0EktaZZ7RMghO5rBwm9tGQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ca4JN655GW=eGyjrjDmiv0EktaZZ7RMghO5rBwm9tGQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:44:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, P J P <ppandit@redhat.com>,
 Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 11:22:28AM +0100, Peter Maydell wrote:
> On Tue, 14 Jul 2020 at 11:12, Michael S. Tsirkin <mst@redhat.com> wrote:
> > And for people who want to build QEMU with lots of functionality (like
> > Fedora does), I think a -security flag would be a useful addition.
> > We can then tell security researchers "only a high security issue
> > if it reproduces with -security=high, only a security issue
> > if it reproduces with -security=low".
> 
> I think a -security option would also be useful to users -- it
> makes it easier for them to check "is this configuration using
> something that I didn't realize was not intended to be secure".
> For me, something useful for our users is much more compelling
> than "this might make security researchers' lives a bit easier".
> 
> thanks
> -- PMM

True. And I guess downstreams can also force the option to high or set the
default to high rather easily if they want to.

So the option would be:

-security level
	Set minimal required security level of QEMU.

	high: block use of QEMU functionality which is intended to be secure against
		malicious guests.
	low: allow use of all QEMU functionality, best effort security
		against malicious guests.

Default would be -security low.

Does this look reasonable?

Just a correction to what I wrote: I no longer think it's reasonable to
classify the severity of a security issue automatically. E.g. a qemu
crash in virtio code is a high severity security issue if it triggers
with platform_iommu=on since it is then driver from guest userspace, and
low severity one without since then it's driven from a guest driver.

So I think we can add something like this to security.rst and to
the wiki:

	only a security issue if it
	reproduces with -security high, a regular bug if it only reproduces with
	-security low

Prasad?

-- 
MST


