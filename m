Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAC2C56201
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A106D2463F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpzYT030"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A106D2463F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVdeB-0002Us-Bh
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 12:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVddA-0001Yf-Mn
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:40:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVdd8-0006Y7-AQ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603384796;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=A/ggxxjcoNtTFOM9tZMhIh4i5aBrCWOzGg+7Yb/JFlo=;
 b=YpzYT030qEIjaTpZ3N0uN3HFXPKqQziPT2k9q83pkqkP6btzCUMiHvjZD4wRTia3PApOwC
 FTxbDtfV+vqQYXDiZ7fcmDE4imx3I6Ax3FbU+9xCsRT2kC/Xd/7p6vhHqcVknurg0IyshW
 Cok3+sRrTviP/4QAjBd5YVK6/KdnE3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-QAuFwtyfOlGpJaiCCQgUyw-1; Thu, 22 Oct 2020 12:39:41 -0400
X-MC-Unique: QAuFwtyfOlGpJaiCCQgUyw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 152AF107465E;
 Thu, 22 Oct 2020 16:39:40 +0000 (UTC)
Received: from redhat.com (ovpn-115-44.ams2.redhat.com [10.36.115.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AA7919746;
 Thu, 22 Oct 2020 16:39:28 +0000 (UTC)
Date: Thu, 22 Oct 2020 17:39:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: Ramping up Continuous Fuzzing of Virtual Devices in QEMU
Message-ID: <20201022163925.GE428835@redhat.com>
References: <20201022161938.7clfymu6a3zl46s2@mozz.bu.edu>
 <20201022162416.iccjosbeg753qbzc@mozz.bu.edu>
MIME-Version: 1.0
In-Reply-To: <20201022162416.iccjosbeg753qbzc@mozz.bu.edu>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:33:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: peter.maydell@linaro.org, thuth@redhat.com, rjones@redhat.com,
 0ops@0ops.net, liq3ea@gmail.com, qemu-devel@nongnu.org, f4bug@amsat.org,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, andrey.shinkevich@virtuozzo.com, ppandit@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 22, 2020 at 12:24:16PM -0400, Alexander Bulekov wrote:
> +CC Prasad
> 
> On 201022 1219, Alexander Bulekov wrote:
> > Hello,
> > QEMU was accepted into Google's oss-fuzz continuous-fuzzing platform [1]
> > earlier this year. The fuzzers currently running on oss-fuzz are based on my
> > 2019 Google Summer of Code Project, which leveraged libfuzzer, qtest and libqos
> > to provide a framework for writing virtual-device fuzzers. At the moment, there
> > are a handful of fuzzers upstream and running on oss-fuzz(located in
> > tests/qtest/fuzz/). They fuzz only a few devices and serve mostly as
> > examples.
> > 
> > If everything goes well, soon a generic fuzzer [2] will land upstream, which
> > allows us to fuzz many configurations of QEMU, without any device-specific
> > code. To date this fuzzer has led to ~50 bug reports on launchpad. Once the
> > generic-fuzzer lands upstream, OSS-Fuzz will automatically start fuzzing a
> > bunch [3] of fuzzer configurations, and it is likely to find bugs.  Others will
> > also be able to send simple patches to add additional device configurations for
> > fuzzing.
> > 
> > The oss-fuzz process looks roughly like this:
> >     1. oss-fuzz fuzzes QEMU
> >     2. When oss-fuzz finds a bug, it reports it to a few [4] people that have
> >     access to reports and reproducers.
> >     3. If a fix is merged upstream, oss-fuzz will figure this out and mark the
> >     bug as fixed and make the report public 30 days later.
> >     3. After 90 days the bug(fixed or not) becomes public, so anyone can view
> >     it here https://bugs.chromium.org/p/oss-fuzz/issues/list
> > 
> > The oss-fuzz reports look like this:
> > https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=23701&q=qemu&can=2
> > 
> > This means that when oss-fuzz find new bugs, the relevant developers do not
> > know about them unless someone with access files a separate report to the
> > list/launchpad. So far this hasn't been a problem, since oss-fuzz has only been
> > running some small example fuzzers. Once [2] lands upstream, we should
> > see a significant uptick in oss-fuzz reports, and I hope that we can develop a
> > process to ensure these bugs are properly dealt with. One option we have is to
> > make the reports public immediately and send notifications to
> > qemu-devel. This is the approach taken by some other projects on
> > oss-fuzz, such as LLVM. Though its not on oss-fuzz, bugs found by
> > syzkaller in the kernel, are also automatically sent to a public list.
> > The question is: 
> > 
> > What approach should we take for dealing with bugs found on oss-fuzz?

If we assume that a non-negligible number of fuzz bugs will be exploitable
by a malicious guest OS to break out into the host, then I think it is
likely undesirable to make them public immediately without at least a basic
human triage step to catch possibly serious security issues.

Still a large % are likely to be low impact / not urgent to deal with so
we want a low overhead way to handle the fuzz output, which doesn't create
a bottleneck on a small number of people.

Overall my feeling is that we want to be able to farm out triage to the
respective subsystem maintainers, who can then decide whether the bug
needs notifying to the security team, or can be made public immediately.

I think ideally we would be doing triage in QEMU's own bug tracker, so
we don't need to have maintainers create accounts on a 3rd party tracker
to see reports.

Is is practical to identify a primary affected source file from the fuzz
crash report with any level reliablility such that we could file a private
launchpad bug, automatically CC'ing a subsystem maintainer (and the security
team)  ?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


