Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67AFC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E644206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAYXKB9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E644206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWFT-0003vu-NY
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jVWEt-0003Vu-9M
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:14:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24251
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jVWEr-00009x-KY
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588580046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZGjbBi4ueXhodwLV25CNAoVKGSnLqFLBG0E6oo9gojY=;
 b=BAYXKB9EaXNOHu/XZS+6YwonbKoLAhj2+VX6yxDWA1+SIdRJSMFhmCpo4KRu4lDdJrbass
 leY3Ma0kE9OvwMDPJ9xl9rN8V7JuQ2v+haVkzio3Q3UKHhcsWjsijVO6F+qIOaqBX3CadM
 A/veibR+WTI3pd2wJr94UwO1Vo0aoxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-oxTqxdOdNvGAktccUt81PQ-1; Mon, 04 May 2020 04:14:01 -0400
X-MC-Unique: oxTqxdOdNvGAktccUt81PQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7C811005510;
 Mon,  4 May 2020 08:14:00 +0000 (UTC)
Received: from work-vm (ovpn-114-147.ams2.redhat.com [10.36.114.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5370648D1;
 Mon,  4 May 2020 08:13:56 +0000 (UTC)
Date: Mon, 4 May 2020 09:13:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/6] virtiofs queue
Message-ID: <20200504081354.GB3112@work-vm>
References: <20200501191500.126432-1-dgilbert@redhat.com>
 <CAFEAcA8W3kreu2s_4wjvP4mNgPpVHpv8A4T-D+etUORg18Rtew@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8W3kreu2s_4wjvP4mNgPpVHpv8A4T-D+etUORg18Rtew@mail.gmail.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: mszeredi@redhat.com, yavrahami@paloaltonetworks.com,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Fri, 1 May 2020 at 20:16, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> >
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > The following changes since commit 1c47613588ccff44422d4bdeea0dc36a0a30=
8ec7:
> >
> >   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into s=
taging (2020-04-30 19:25:41 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/dagrh/qemu.git tags/pull-virtiofs-20200501
> >
> > for you to fetch changes up to 66502bbca37ca7a3bfa57e82cfc03b89a7a11eae=
:
> >
> >   virtiofsd: drop all capabilities in the wait parent process (2020-05-=
01 20:05:37 +0100)
> >
> > ----------------------------------------------------------------
> > virtiofsd: Pull 2020-05-01 (includes CVE fix)
> >
> > This set includes a security fix, other fixes and improvements.
> >
> > Security fix:
> > The security fix is for CVE-2020-10717 where, on low RAM hosts,
> > the guest can potentially exceed the maximum fd limit.
> > This fix adds some more configuration so that the user
> > can explicitly set the limit.
> > Thank you to Yuval Avrahami for reporting this.
> >
> > Fixes:
> >
> > Recursive mounting of the exported directory is now used in
> > the sandbox, such that if there was a mount underneath present at
> > the time the virtiofsd was started, that mount is also
> > visible to the guest; in the existing code, only mounts that
> > happened after startup were visible.
> >
> > Security improvements:
> >
> > The jailing for /proc/self/fd is improved - but it's something
> > that shouldn't be accessible anyway.
> >
> > Most capabilities are now dropped at startup; again this shouldn't
> > change any behaviour but is extra protection.
> >
> > ----------------------------------------------------------------
>=20
>=20
> Applied, thanks.
>=20
> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
> for any user-visible changes.
>=20
> I notice you didn't include the usual Cc: qemu-stable@nongnu.org
> lines in the commits to be backported, but I think the stable
> branch maintainers can deal with the occasional manual notification.

Thanks, yes I sent a mail to qemu-stable as a reply to the series
saying which patches I thought should be for stable.

Dave

> thanks
> -- PMM
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


