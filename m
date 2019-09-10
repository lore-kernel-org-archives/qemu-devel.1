Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB3BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC9920872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC9920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7fpX-0003cK-KK
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 09:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i7fVJ-0004sQ-Ct
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i7fVI-00063l-Ah
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:44:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i7fVI-00063O-59
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:44:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 75CEB4FCDF;
 Tue, 10 Sep 2019 12:44:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-121-171.rdu2.redhat.com
 [10.10.121.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0509160BE2;
 Tue, 10 Sep 2019 12:44:06 +0000 (UTC)
Date: Tue, 10 Sep 2019 08:44:05 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190910124405.GA27485@localhost.localdomain>
References: <20190904005218.12536-1-crosa@redhat.com>
 <CAFEAcA_TB4c6T2ZGu8xCx_H2Uzs8j2Jcs9ZbASTgXfv87KdSwg@mail.gmail.com>
 <CAFEAcA_tPYRmCW+2u4Ae883iKGXoo1eJVTTmDohhku04DmksPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_tPYRmCW+2u4Ae883iKGXoo1eJVTTmDohhku04DmksPw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 10 Sep 2019 12:44:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] Fedora images: use URLs from stable
 "archives.fedoraproject.org"
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
Cc: Yash Mankad <ymankad@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 09:38:55AM +0100, Peter Maydell wrote:
> On Tue, 10 Sep 2019 at 09:31, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Wed, 4 Sep 2019 at 01:52, Cleber Rosa <crosa@redhat.com> wrote:
> > >
> > > The LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16 test,
> > > from tests/acceptance/linux_initrd.py, is currently failing to fetch
> > > the "vmlinuz" file.  The reason for the failure is that the Fedora
> > > project retires older versions from the "dl.fedoraproject.org" URL,
> > > and keeps them in "archives.fedoraproject.org".  As an added note,
> > > that test uses a Fedora 28 image, because of the specific Linux kernel
> > > version requirements of the test.
> > >
> > > For the sake of stability, let's use URLs from the archived and
> > > supposedely ever stable URLs.  The good news is that the currently
> > > supported versions are also hosted on the later.  This change limits
> > > itself to change the URLs, while keeping the fetched files the same
> > > (as can be evidenced by the unchanged hashes).
> > >
> > > Documentation and the "vm tests" fedora definition were also updated.
> > >
> > > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > > ---
> >
> > I was planning to apply this to master to fix the Travis builds,
> > but it doesn't apply -- conflicts in qemu-doc.texi. Could you respin?
> 
> Ah, never mind -- Alex tells me he's already picked this patch up
> in a pending pull request and has done the rebase and fixup there.
> 
> thanks
> -- PMM

Oh, OK, good!

Thanks!
- Cleber.

