Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F826C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 15:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394982075D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 15:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avueENPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394982075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k44mE-0002zC-Fe
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 11:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k44la-00028J-AC
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 11:58:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57023
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k44lX-0006rp-A3
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 11:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596815921;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gI0fEwBIUmrdXBMn4W4Ywv5ioDsow7oYf0klWsBf5Bw=;
 b=avueENPFKMt70VrXGRIXEeWmHRMP1fKCnlQD5fWD9ZI5eXknD2LsuAywmh2cdZLkunoJtz
 nvtewPa4ht4ypaPPYrHxyZszReb6TsEz4fNAffZOAMcCKePowjQ1nkjb4Hmenf0m8A9Fq9
 7aK0BY47xLzmTf2I45ybw3VLhUSlzvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-k2LiT8zNOMqPaNNph1fFpQ-1; Fri, 07 Aug 2020 11:58:33 -0400
X-MC-Unique: k2LiT8zNOMqPaNNph1fFpQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F58D57;
 Fri,  7 Aug 2020 15:58:32 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A74B65DA30;
 Fri,  7 Aug 2020 15:58:27 +0000 (UTC)
Date: Fri, 7 Aug 2020 16:58:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
Message-ID: <20200807155824.GN120942@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <87364y28jp.fsf@dusky.pond.sub.org>
 <9d7b7f59-ec3e-1f74-d1d4-359e3388f0f8@redhat.com>
 <87ft8yd0ht.fsf@dusky.pond.sub.org>
 <CAFEAcA8-qAh9RzAZNqFS9HphAEDuCVVGzZO7vKem-1WCJogyjw@mail.gmail.com>
 <f8cb36ff-a98a-9147-1c31-6f6394a4ec77@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f8cb36ff-a98a-9147-1c31-6f6394a4ec77@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 07, 2020 at 05:14:06PM +0200, Paolo Bonzini wrote:
> Stuff like automatically cloning git submodules will never be in Meson,

> and we can keep Make forever as a small escape hatch for that.  However,
> using Make as a Turing-complete language to build our own DSLs on top of
> is just a bad idea.  Shell+Make can remain simply as a driver for
> executing commands, which is what Make does best.
> 
> We also have parts that have effectively separate build systems: I have
> no plans to convert the TCG tests at all, the firmware could be
> converted to Meson or Autotools (yes I am serious :)) or left aside, and
> so on.

Using meson for submodules too is potentially appealing, as you can
then take advantage of Meson's subproject support. This makes it easy
for distro vendors to turn off building of the bundled pieces in favour
of the distro provided equivalent.

> That one exception, the one thing that disappoints me of the whole
> conversion, is the trace.h files.  The current solution is one of the
> first parts I did of the conversion and I have never touched it since; I
> think it can be improved (I can even think of two ways to do it), but I
> don't really have the time to do it now.  But even that bit is just
> ugly, not unmaintainable, and I really see nothing in the conversion
> that is a step back for QEMU's long term maintainability and our ability
> to develop new features.

I was never entirely happy with the trace.h stuff even in "make".
Trying to maintain the "trace.h" name for every generated header
was probably a mistake in retrospect. it caused me so much pain
trying to get the "make" rules correct so that we resolved the
right trace.h in each case. I was deperately trying to avoid
updating the #include lines, but I'm not sure it was worth
it in the end. Would have been easier to just generate a unique
header file name for each dir and update the #includes.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


