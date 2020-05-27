Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BCFC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64E92084C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvE+YUYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64E92084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jds1B-00028o-Ug
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 05:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jds0R-0001il-Lq
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:05:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27149
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jds0P-0002oq-Sz
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590570344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6EMwl90RPKpuow5zXLNftKrJ4+MZ0Lm1il355gUWcVo=;
 b=fvE+YUYmUNs3BKc+0tb8BMOyW8dp08feY4xxxewkE+smYz/p6gnh78fcXb7zYfiQrwYxUN
 LObjx6bHCMR5dkbfc7nYWb+MMOUheiL5aszVOP8YZzzgPus3cEa7Vktg5vKUPzH/lo3P7I
 mauSSlf57tY0H3+v8BfcRA8kL8y4W40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-RvusyIN2O3yH6RhvOrLY3A-1; Wed, 27 May 2020 05:05:42 -0400
X-MC-Unique: RvusyIN2O3yH6RhvOrLY3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14460107ACCA;
 Wed, 27 May 2020 09:05:41 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0307F6E9F3;
 Wed, 27 May 2020 09:05:34 +0000 (UTC)
Date: Wed, 27 May 2020 11:05:32 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH 10/14] hw/mips/fuloong2e: Fix typo in Fuloong machine name
Message-ID: <20200527090532.GP2995787@angien.pipo.sk>
References: <20200526104726.11273-1-f4bug@amsat.org>
 <20200526104726.11273-11-f4bug@amsat.org>
 <20200526115353.GN2995787@angien.pipo.sk>
 <CAHiYmc6csbt=fLhFtCMorCgbLd+kbBRoWO+gKdbDG_0x6NxyhA@mail.gmail.com>
 <20200526125035.GO2995787@angien.pipo.sk>
 <CAHiYmc5mT+10mYBpRnmaKT4hTh=Nd2Kz19T1iHj9Jh=gbEAHFA@mail.gmail.com>
 <CAHiYmc6UqmqAeC0QE=EKRncXGU7wvCAxjQXDawj2rZHYuiQKPQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHiYmc6UqmqAeC0QE=EKRncXGU7wvCAxjQXDawj2rZHYuiQKPQ@mail.gmail.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 27, 2020 at 10:51:21 +0200, Aleksandar Markovic wrote:
> уто, 26. мај 2020. у 15:04 Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> је написао/ла:
> >
> > уто, 26. мај 2020. у 14:50 Peter Krempa <pkrempa@redhat.com> је написао/ла:
> > >
> > > On Tue, May 26, 2020 at 14:37:41 +0200, Aleksandar Markovic wrote:
> > > > > >
> > > > > > +mips ``fulong2e`` machine (since 5.1)
> > > > > > +'''''''''''''''''''''''''''''''''''''
> > > > > > +
> > > > > > +This machine has been renamed ``fuloong2e``.
> > > > > > +
> > > > >
> > > > > Libvirt doesn't have any special handling for this machine so this
> > > > > shouldn't impact us.
> > > > >
> > > >
> > > > Well, Peter,
> > > >
> > > > I was also wondering libvirt listed as a recipient, and I think it
> > > > creates unneeded noise in your group, but Philippe uses some his
> > > > system for automatic picking of recipients, and libivrt somehow
> > > > appears there during that process. Philippe, either correct that
> > > > detail in this particular component of your workflow, or change
> > > > entirely your system for recipient choice - the current workflow
> > > > creates incredible amount of noise, wasting time of many people.
> > >
> > > Note that my message above was not a criticism of why we've got it but
> > > more of a review. This review though it just that removing this is okay
> > > and no action needs to be taken. Unfortunately I'm usually not familiar
> > > enough with qemu to do a full review.
> > >
> > > >
> > > > This happened before in case of deprecating an ancient mips machine,
> > > > that absolutely  doesn't have anything to do with linvirt.
> > >
> > > In some cases it might seem like that. Specifically for things where
> > > libvirt isn't impacted such as machine type change because we try to
> > > stay machine type agnostic or for something that we don't use.
> > >
> > > On the other hand there were plenty cases where we were impacted and
> > > where we do want to know about these deprecations. It's in fact the
> > > primary reason why this was established after an agreement between qemu
> > > and libvirt projects and in fact I was one of those who argued for
> > > adding such a thing.
> > >
> > > As I was one of the proponents I feel obliged to always respond to these
> > > notifications as we've more than once encountered something that in the
> > > end impacted libvirt.
> > >
> 
> But, Peter Krempa,
> 
> I see libvirt-dev listed as a recipient for a patch (from this series)
> that changes an e-mail of a colleague of mine. Why would be

Currently the tooling creates a union of recipients based on the set of
files changed by the patchset and then sends the whole series to
everybody.

That is to ensure that the recipient has the full context.

> libvirt-dev be interested in that? Is libvirt really so sensitive to
> the degree that to be afraid that changing an e-mail of a QEMU
> contributor would impact libvirt design and/or its interface towards

No, we don't care about that. We care about changes to the
'docs/system/deprecated.rst'. In this very specific instance we usually
don't even care about the context of the other patches and can look them
up manually if necessary.

The problem is that the tooling currently doesn't really allow this
usage. The next best thing is to send more emails rather than forget to
send the notification.

> QEMU? If you wishes that to remain so, I am of course fine with it,
> who am I to determine that, but it looks like a severe overkill to me.

Feel free to fix the git-publish tool. IMO asking
maintainers/contributors to just CC patches which change
'docs/system/deprecated.rst' to libvirt-list would create too
complicated rules and is in general not worth doing. Just if we can do
it programatically.

If this ever becomes a problem for libvir-list I'm sure that we'll drop
ourselves from the CC if we reach such consensus.

Please don't question this approach any more if you don't plan to fix
the tooling.


