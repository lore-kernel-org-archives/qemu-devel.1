Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BC5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F146B22265
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKd/ZXth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F146B22265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQscv-0001N5-0o
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 09:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQsbr-0000ma-Gz
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQsbo-0000UN-L4
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602250734;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oB8s2N/LC4wJ5FjfuWffAT1+0i8LLmHY9fdvLgeo0V4=;
 b=aKd/ZXthhS0ZbkHNwhae97toVTsgHFX6q0r8InVsXS2ri2mj6IaytNwHYi09MK3Vahs/XS
 gvLAuLpdmZSKP9Ovo3iK3o2JUGaKb/NTVy1smfZV/KdREEyKMCcPA9TurP2rSuem57CvNM
 2sQINkHwxphxiR2HrhW2JRHd8koywPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-MjWPhQYgNgSBfejsuQom1w-1; Fri, 09 Oct 2020 09:38:45 -0400
X-MC-Unique: MjWPhQYgNgSBfejsuQom1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59019427C9;
 Fri,  9 Oct 2020 13:38:44 +0000 (UTC)
Received: from redhat.com (ovpn-114-251.ams2.redhat.com [10.36.114.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 030FF1001281;
 Fri,  9 Oct 2020 13:38:42 +0000 (UTC)
Date: Fri, 9 Oct 2020 14:38:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: How about using clang-format instead checkpatch for fixing style?
Message-ID: <20201009133840.GA25901@redhat.com>
References: <CAE2XoE9YyZwRr5j3fCATTb32pacuGrT_yUBoUTd30k+id1D3iw@mail.gmail.com>
 <27f82fe6-5b0f-7e35-29d9-7b00ae8f189e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <27f82fe6-5b0f-7e35-29d9-7b00ae8f189e@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
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
Cc: Peter Maydell <peter.maydell@linaro.org>, luoyonggang@gmail.com,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 09, 2020 at 03:25:04PM +0200, Paolo Bonzini wrote:
> On 09/10/20 15:02, 罗勇刚(Yonggang Luo) wrote:
> > We can even using clang-format to format the whole repository.
> 
> checkpatch does other checks than formatting.
> 
> Reformatting the whole repository has been mentioned many times, people
> were worried of messing up the result of "git blame".  But without doing
> that, it's hard to get rid of checkpatch because checkpatch only looks
> at the lines that are touched by the patch.

It is a no-win situation.

checkpatch.pl is code that makes people run away screaming in horror,
because who really wants to look at Perl code that tries to parse C
code with regexes. The fact that you can submit a patch and get
complaints about things you didn't actually change is a poor experiance,
especially for new contributors who will wonder what they did wrong.

Certain subsystem maintainers have done bulk cleanups for pieces of
code before, most notably culling tabs. So we have taken the pain
a little before. I presume we'll continue to periodically clean
code.

Aside from the git blame pain, there will also be a period of time
when cherry-picking patches back to old versions will be tediously
conflicting, potentially forcing cherr-picking of the style cleanup
patches too. If the cleanup patches are fine grained it might not
be too terrible though.

So we have pain with current state and we have pain with use of
clang-format. The difference is the current pain is long term
ongoing pain, while the clang-format pain will be an initial
hit whose impact will slowly fade over time.

Personally I think it would be worth the change in the long
term. I should really put my money where my mouth is though and
propose it for libvirt too.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


