Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD0EC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 14:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552DF20818
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 14:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="EfuYWvD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552DF20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60394 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEDqq-0004xI-LQ
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 10:05:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1hEDoW-0003cy-Gm
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1hEDoV-0000Ev-HH
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:02:56 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:45010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1hEDoT-0000Ch-N1
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:02:54 -0400
Received: from localhost (unknown [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id 503F541A5D;
	Wed, 10 Apr 2019 14:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
	user-agent:in-reply-to:content-disposition:content-type
	:content-type:mime-version:references:message-id:subject:subject
	:from:from:date:date:received:received:received; s=mta-01; t=
	1554904965; x=1556719366; bh=LqlBs2rGYvsNIvk8LwDXYjY//8mzOj+mcgD
	HW3/jkDg=; b=EfuYWvD9eGlIMKmthZX7YLn2X5RGd3ufEHz+Lsal1ip43JNK2wl
	EEwJF/BlKBq3B5wEN/jywshBQXYtMQtWpIKRrl/WzA72aA9OUwO/WUmeW1sM/eyz
	ktD6WwkpxCdLnZbYDYgdoWwN5us4jchDSh2IFXVoBuvmZx8UCJ6OKA5E=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
	by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E0hDZ7qiLqU8; Wed, 10 Apr 2019 17:02:45 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
	[172.17.10.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS id 750EA41949;
	Wed, 10 Apr 2019 17:02:45 +0300 (MSK)
Received: from localhost (172.17.128.60) by T-EXCH-02.corp.yadro.com
	(172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32;
	Wed, 10 Apr 2019 17:02:45 +0300
Date: Wed, 10 Apr 2019 17:02:44 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Message-ID: <20190410140244.l5viavfey2ymzw6k@SPB-NB-133.local>
References: <20190407115839.25054-1-skrtbhtngr@gmail.com>
	<20190407115839.25054-3-skrtbhtngr@gmail.com>
	<20190410115001.56bbbelcmxwcqp7v@SPB-NB-133.local>
	<CAMzgYoMqE20=L+n+tjt8Nb10Tidxr0C6OumQ8vvQ423xJxnN=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAMzgYoMqE20=L+n+tjt8Nb10Tidxr0C6OumQ8vvQ423xJxnN=w@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [172.17.128.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
	T-EXCH-02.corp.yadro.com (172.17.10.102)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 89.207.88.251
Subject: Re: [Qemu-devel] [PATCH RESEND v2 2/2] cpus: move
 hvf_cpu_synchronize* calls to cpu_synchronize* functions
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410140244.h5xAKZB0d1g6i1G1CJGj70POj3MMdCnPtJ5yCuMcOdQ@z>

On Wed, Apr 10, 2019 at 05:35:23PM +0530, Sukrit Bhatnagar wrote:
> On Wed, 10 Apr 2019 at 17:20, Roman Bolshakov <r.bolshakov@yadro.com> wrote:
> >
> > On Sun, Apr 07, 2019 at 05:28:39PM +0530, Sukrit Bhatnagar wrote:
> > > Keep the calls made to synchronize cpu by all hypervisors in one place
> > > inside cpu_synchronize_* functions in include/sysemu/hw_accel.h
> > >
> >
> > The commit itself looks sane but qemu starts to hang during BIOS boot
> > after I've applied it if I run it with hvf accel.
> 
> Hi Roman,
> Thanks for reviewing the patches.
> If this is happening, then I assume patches are not ready
> to be merged into qemu-stable.
> Do you have any idea why the problem is not detected
> during tests, but rather at runtime?
> I am not really sure if this patch (2/2) has anything to do with
> the problem but the previous patch (1/2) might.
> 

I've applied, built and tested both sequentially. Applying and running
with patch 1/2 alone doesn't result in the behavior I mentioned. I also
tried to apply only the first hunk that moves hvf_cpu_synchronize_state
into cpu_synchronize_state and it also causes the issue with BIOS.

Honestly, I don't know if the tests run qemu with hvf accel. AFAIK
kvm-unit-tests can be used to test an accel itself.

Thanks,
Roman

