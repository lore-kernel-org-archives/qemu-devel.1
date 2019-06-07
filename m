Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AF1C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F0A20840
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F0A20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZEW9-00065A-Q3
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56918)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hZETq-0005MW-Dd
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hZETp-0007lN-As
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:00:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56612)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hZETp-0007gK-50; Fri, 07 Jun 2019 09:00:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 61057356E5;
 Fri,  7 Jun 2019 13:00:15 +0000 (UTC)
Received: from gondolin (reserved-198-113.str.redhat.com [10.33.198.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED0D47DE4D;
 Fri,  7 Jun 2019 13:00:08 +0000 (UTC)
Date: Fri, 7 Jun 2019 15:00:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand
 <david@redhat.com>
Message-ID: <20190607150004.5581fd18.cohuck@redhat.com>
In-Reply-To: <CAFEAcA9hMt4TZC0DEzJ6JTV9OxLbXZbmHKshWv_20sLxLw4M6Q@mail.gmail.com>
References: <20190607095237.11364-1-cohuck@redhat.com>
 <CAFEAcA8FXh-jPMwpGN-4ES4v=nE4ZOSNB8+rkdB03E=BBDh-jw@mail.gmail.com>
 <CAFEAcA9hMt4TZC0DEzJ6JTV9OxLbXZbmHKshWv_20sLxLw4M6Q@mail.gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 07 Jun 2019 13:00:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 00/35] s390x updates
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Jun 2019 10:58:03 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 7 Jun 2019 at 10:57, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Fri, 7 Jun 2019 at 10:52, Cornelia Huck <cohuck@redhat.com> wrote:
> > >
> > > The following changes since commit 47fbad45d47af8af784bb12a5719489edcd89b4c:
> > >
> > >   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-06-04 17:22:42 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://github.com/cohuck/qemu tags/s390x-20190607-1
> > >
> > > for you to fetch changes up to 39f04d18406862bd98d6bef5415dbe7360c652de:
> > >
> > >   Merge tag 's390x-tcg-2019-06-05' into s390-next-staging (2019-06-07 11:38:42 +0200)
> > >
> > > ----------------------------------------------------------------
> > > s390x updates:
> > > - tcg: finalize implementation for the vector facility and
> > >   add it to the 'qemu' cpu model
> > > - linux-user: properly generate ELF_HWCAP
> > > - vfio-ccw: support async command subregion (for halt/clear
> > >   subchannel handling)
> > >
> > > ----------------------------------------------------------------
> >
> > Hi -- this fails to link on the windows build for me:
> >   LINK    s390x-softmmu/qemu-system-s390xw.exe
> > hw/s390x/css.o: In function `sch_handle_halt_func_passthrough':
> > /home/petmay01/qemu-for-merges/hw/s390x/css.c:1213: undefined
> > reference to `vfio_ccw_handle_halt'
> > hw/s390x/css.o: In function `sch_handle_clear_func_passthrough':
> > /home/petmay01/qemu-for-merges/hw/s390x/css.c:1223: undefined
> > reference to `vfio_ccw_handle_clear'
> > collect2: error: ld returned 1 exit status
> 
> ...and same link error on OSX host.
> 
> -- PMM

OK, I have dropped the vfio-ccw patch until I have a fixed version.
Unfortunately, I need a new tcg pull request... David, can you please
send one? Thanks!

