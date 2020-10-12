Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B608C43457
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 08:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC88020757
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 08:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObB7lQWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC88020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRsxC-0000fK-On
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 04:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kRswR-0000Db-IT
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 04:12:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kRswO-0005WV-ON
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 04:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602490338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCXtuhFzMk/Ks2rIKxt04ykuNvrepl9tHbIsmGRGBxU=;
 b=ObB7lQWyx9JnV2eaGeFi1W3CCaZfQIRpmtEnRjWNEDWC5JnJcHBBA6giQbAzXWzQiqCZa4
 xNcMOnI4YoJQ78XfYmEVr9UvpNl6eobt9Gj/apVujsG26zy1OFPBELjM9AIPq/uV6zZmJz
 9cgDQo68vjREa1K+R4JH/SUTAr5rmrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-syaVSAXxMUux9FQKSBBAIg-1; Mon, 12 Oct 2020 04:12:16 -0400
X-MC-Unique: syaVSAXxMUux9FQKSBBAIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2CF5802B48;
 Mon, 12 Oct 2020 08:12:15 +0000 (UTC)
Received: from work-vm (ovpn-113-244.ams2.redhat.com [10.36.113.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A40535C22A;
 Mon, 12 Oct 2020 08:12:08 +0000 (UTC)
Date: Mon, 12 Oct 2020 09:12:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/10] migration queue
Message-ID: <20201012081206.GA2837@work-vm>
References: <20201008191046.272549-1-dgilbert@redhat.com>
 <CAFEAcA-U2BjAne57Zn7c4_J97NAZSYzzy6r59iVeGmtgfD3APg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-U2BjAne57Zn7c4_J97NAZSYzzy6r59iVeGmtgfD3APg@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 zhengchuan@huawei.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Thu, 8 Oct 2020 at 20:13, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> >
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > The following changes since commit e64cf4d569f6461d6b9072e00d6e78d0ab8bd4a7:
> >
> >   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20201008' into staging (2020-10-08 17:18:46 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/dagrh/qemu.git tags/pull-migration-20201008a
> >
> > for you to fetch changes up to ee02b58c82749adb486ef2ae7efdc8e05b093cfd:
> >
> >   migration/dirtyrate: present dirty rate only when querying the rate has completed (2020-10-08 19:57:00 +0100)
> >
> > ----------------------------------------------------------------
> > Migration and virtiofs pull 2020-10-08
> >
> > v2 (from yesterdays)
> >   Updated types in comparison to fix mingw build
> >   rebased
> >
> > -
> > Migration:
> >   Dirtyrate measurement API cleanup
> >   Postcopy recovery fixes
> >
> > Virtiofsd:
> >   Missing qemu_init_exec_dir call
> >   Support for setting the group on socket creation
> >   Stop a gcc warning
> >   Avoid tempdir in sandboxing
> 
> This seems to hang in 'make check' trying to run
> tests/qtest/migration-test on s390x and ppc, ie
> the big-endian hosts.

OK, I'll give it a try.

Dave

> thanks
> -- PMM
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


