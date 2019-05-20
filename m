Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE4FC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 19:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A6D20645
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 19:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A6D20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40565 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSnYA-0007ZE-Mt
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 15:02:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSnWr-0005AP-70
	for qemu-devel@nongnu.org; Mon, 20 May 2019 15:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSnWf-0004Hi-An
	for qemu-devel@nongnu.org; Mon, 20 May 2019 15:00:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hSnWd-00046N-9a; Mon, 20 May 2019 15:00:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5F2130832DA;
	Mon, 20 May 2019 19:00:23 +0000 (UTC)
Received: from gondolin (ovpn-204-110.brq.redhat.com [10.40.204.110])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8FC5060C05;
	Mon, 20 May 2019 19:00:22 +0000 (UTC)
Date: Mon, 20 May 2019 21:00:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190520210018.6c4491b3.cohuck@redhat.com>
In-Reply-To: <CAFEAcA9Da213mDF9kBOhfV_m_K7X=MEGcNkfZ-2whDmDQYrABw@mail.gmail.com>
References: <20190520170302.13643-1-cohuck@redhat.com>
	<CAFEAcA9Da213mDF9kBOhfV_m_K7X=MEGcNkfZ-2whDmDQYrABw@mail.gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Mon, 20 May 2019 19:00:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 00/54] s390x update
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 May 2019 18:30:46 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 20 May 2019 at 18:03, Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > The following changes since commit d8276573da58e8ce78dab8c46dd660efd664bcb7:
> >
> >   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190510' into staging (2019-05-16 13:15:08 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/cohuck/qemu tags/s390x-20190520
> >
> > for you to fetch changes up to f9de88d07258b7288b59ebca77ff1da75b0e8e9f:
> >
> >   s390x/cpumodel: wire up 8561 and 8562 as gen15 machines (2019-05-20 08:35:42 +0200)
> >
> > ----------------------------------------------------------------
> > s390x update:
> > - have the bios tolerate bootmap signature entries
> > - next chunk of vector instruction support in tcg
> > - a headers update against Linux 5.2-rc1
> > - add more facilities and gen15 machines to the cpu model
> >
> > ----------------------------------------------------------------  
> 
> Hi -- this fails to build on aarch64:
> 
> In file included from /home/pm215/qemu/linux-headers/linux/kvm.h:14:0,
>                  from /home/pm215/qemu/target/arm/kvm-consts.h:18,
>                  from /home/pm215/qemu/target/arm/cpu.h:23,
>                  from /home/pm215/qemu/disas.c:8:
> /home/pm215/qemu/build/all/linux-headers/asm/kvm.h:38:29: fatal error:
> asm/sve_context.h: No such file or directory
>  #include <asm/sve_context.h>
>                              ^
> compilation terminated.
> 
> Looks like we need to fix update-linux-headers.sh to account for
> that new header file before we can do the header sync.

Ugh. I'll try to figure it out tomorrow.

