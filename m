Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017A5C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A0D20758
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coIZ7H+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A0D20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGlHn-0008Lo-T6
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGlH8-0007sD-Ho
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:47:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41409
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGlH5-0001zg-MR
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599839261;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Qldg5I0egSU6mHzNQ6ouudBvy85FNvWxGdUFSTIPBxA=;
 b=coIZ7H+MbQv8LW7Gksf33s/bkBQWZKfq6G2g1v8b+PC6KKnlqbmnxyARgPsVcHqgjJgL1z
 Z2HRwY7nM3b+XpcXclKNbwKubewkbCNpiS7TMRS/gMfktFcvB6ys6ihrOz7UXKFp81/KkD
 Xc1iTI/dzyBkv3TWdG7Nn7XAXGZqgno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-nSyneRtqPyClEXGyeeEcIQ-1; Fri, 11 Sep 2020 11:47:35 -0400
X-MC-Unique: nSyneRtqPyClEXGyeeEcIQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81556801F97
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 15:47:34 +0000 (UTC)
Received: from redhat.com (ovpn-113-229.ams2.redhat.com [10.36.113.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C45612C31E;
 Fri, 11 Sep 2020 15:47:33 +0000 (UTC)
Date: Fri, 11 Sep 2020 16:47:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: About 'qemu-security' mailing list
Message-ID: <20200911154730.GK1203593@redhat.com>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 00:33:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 11, 2020 at 07:50:24PM +0530, P J P wrote:
>   Hello all,
> 
> Recently while conversing with DanPB this point came up
> 
>    -> https://www.qemu.org/contribute/security-process/
> 
> * Currently QEMU security team is a handful of individual contacts which
>   restricts community participation in dealing with these issues.
> 
> * The Onus also lies with the individuals to inform the community about QEMU
>   security issues, as they come in.
> 
> 
> Proposal: (to address above limitations)
> =========
> 
> * We set up a new 'qemu-security' mailing list.
> 
> * QEMU security issues are reported to this new list only.
> 
> * Representatives from various communities subscribe to this list. (List maybe
>   moderated in the beginning.)

For libvirt we have the list membership targetted as being nominated
security representatives of any downstream distributor of libvirt.
ie essentially the security people from various OS vendors. Other
members can be considered on a case by case basis if they want to
make their case.

FWIW, we have the libvirt-security list moderated at all times, and
manually approve mails from non-members in order to prevent it being
a spam trap. Manual moderation is not too much of a burden assuming
the rate of CVEs isn't huge !

> * As QEMU issues come in, participants on the 'qemu-security' list shall
>   discuss and decide about how to triage them further.

For libvirt-security, members are required to respect the project's
declared embargo policy. This sets as a 2 week maximum by default,
anything beyond 2 weeks has to be explicitly requested as appropriate
and not have objection from members of the list.  QEMU doesn't set any
explicit default embargo period right now just saying it is via mutual
agreement:

  https://www.qemu.org/contribute/security-process/

this might want to be clarified to set a default expectation, because
with a list of members you won't want to wait for everyone to explicitly
approve a date. You want people to know what to expect as a default
upfront, and only have the discussions in cases which need more time.

I'm not saying QEMU has to be 2 weeks - perhaps just look at a sample
of the past year's CVEs in QEMU and use them as a guide for a reasonable
default period to handle or publish the issues.

> Please kindly let us know your views about it. I'd appreciate if you have
> any suggestions/inputs/comments about the same.

I'm in favour of this, since this is what we have done for libvirt
upstream security response handling, and it has been a clear improvement
on our previous process involving CC'ing individual developers.

It makes the security response process more of a level playing field for
all downstreams QEMU distributors.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


