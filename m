Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D7BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 12:51:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CFD520787
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 12:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g17cus4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFD520787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZ3S-000778-LM
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 08:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jdZ2k-0006gu-N1
 for qemu-devel@nongnu.org; Tue, 26 May 2020 08:50:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50211
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jdZ2i-0006Ol-3M
 for qemu-devel@nongnu.org; Tue, 26 May 2020 08:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590497449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZfZye6NAVyGrLaGZWXlV+l4uEKE1lrQFQxI4Cmf7FDc=;
 b=g17cus4hz55IQ1nGtvggnHlH83Ou92LhgEZ33QMpatV3dCbBWk6cp2pDif847BlGNy6b7e
 9bHrdGCEMJ1CA5GvNwFpPQQFR6o12aePCwY8WVvt0u5tf7a6A3JT16K7Bb9J0/x/l9yvjk
 H2HmxNrVjpl6YyFKZfhmJCzvT4GBNDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-wMWer3p3OPuBfsyiCdfz4g-1; Tue, 26 May 2020 08:50:46 -0400
X-MC-Unique: wMWer3p3OPuBfsyiCdfz4g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 636FE100CCC2;
 Tue, 26 May 2020 12:50:44 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64A216FB86;
 Tue, 26 May 2020 12:50:38 +0000 (UTC)
Date: Tue, 26 May 2020 14:50:35 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH 10/14] hw/mips/fuloong2e: Fix typo in Fuloong machine name
Message-ID: <20200526125035.GO2995787@angien.pipo.sk>
References: <20200526104726.11273-1-f4bug@amsat.org>
 <20200526104726.11273-11-f4bug@amsat.org>
 <20200526115353.GN2995787@angien.pipo.sk>
 <CAHiYmc6csbt=fLhFtCMorCgbLd+kbBRoWO+gKdbDG_0x6NxyhA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHiYmc6csbt=fLhFtCMorCgbLd+kbBRoWO+gKdbDG_0x6NxyhA@mail.gmail.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 26, 2020 at 14:37:41 +0200, Aleksandar Markovic wrote:
> > >
> > > +mips ``fulong2e`` machine (since 5.1)
> > > +'''''''''''''''''''''''''''''''''''''
> > > +
> > > +This machine has been renamed ``fuloong2e``.
> > > +
> >
> > Libvirt doesn't have any special handling for this machine so this
> > shouldn't impact us.
> >
> 
> Well, Peter,
> 
> I was also wondering libvirt listed as a recipient, and I think it
> creates unneeded noise in your group, but Philippe uses some his
> system for automatic picking of recipients, and libivrt somehow
> appears there during that process. Philippe, either correct that
> detail in this particular component of your workflow, or change
> entirely your system for recipient choice - the current workflow
> creates incredible amount of noise, wasting time of many people.

Note that my message above was not a criticism of why we've got it but
more of a review. This review though it just that removing this is okay
and no action needs to be taken. Unfortunately I'm usually not familiar
enough with qemu to do a full review.

> 
> This happened before in case of deprecating an ancient mips machine,
> that absolutely  doesn't have anything to do with linvirt.

In some cases it might seem like that. Specifically for things where
libvirt isn't impacted such as machine type change because we try to
stay machine type agnostic or for something that we don't use.

On the other hand there were plenty cases where we were impacted and
where we do want to know about these deprecations. It's in fact the
primary reason why this was established after an agreement between qemu
and libvirt projects and in fact I was one of those who argued for
adding such a thing.

As I was one of the proponents I feel obliged to always respond to these
notifications as we've more than once encountered something that in the
end impacted libvirt.

Please do keep sending these to libvirt. It's appreciated to know that
something is going to change! In some cases we don't get a notification
(such as in the recent QAPIfication of netdev-add where non-well-formed
string stopped to be accepted by qemu) and then we have to figure out
only after it trickles down to users.


