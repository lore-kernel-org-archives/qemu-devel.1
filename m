Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E9BC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 02:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B806E20639
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 02:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxIpzN1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B806E20639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHI82-0005BJ-NS
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 22:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kHI7X-0004kH-1L
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 22:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kHI7U-0001Ii-FI
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 22:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599965518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jt3rZ76I5lsymMg6F1Z1/L61kpqOMaWlYnhasJQGhjw=;
 b=FxIpzN1vj334FVQ0tbmuhVOAjwpTVBYlyijGT7uI+pin+//5Nc8aJJlTzcygAmzz4uFcFb
 Le5zOJLLQY7885h6AH5lIw50zv4Yln0dkJy8o2pW7HS48f8+bTXgwBUzx0x6JZh0JePneB
 fbo3KIoxExIJZ/ZjBbuSR0e/Vrphh4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-EUDt2pUZPSmQMCLHdqVMrA-1; Sat, 12 Sep 2020 22:51:53 -0400
X-MC-Unique: EUDt2pUZPSmQMCLHdqVMrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D93F31DE01;
 Sun, 13 Sep 2020 02:51:52 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2A581002D42;
 Sun, 13 Sep 2020 02:51:51 +0000 (UTC)
Date: Sat, 12 Sep 2020 22:51:51 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: Moving to C11? (was Re: Redefinition of typedefs (C11 feature))
Message-ID: <20200913025151.GX1618070@habkost.net>
References: <20200911184919.GV1618070@habkost.net>
 <CAFEAcA-dnKVyUQ3_ZifdDvrpCbKB1zciuu224BbB1WRV0npxzw@mail.gmail.com>
 <20200911200649.GW1618070@habkost.net>
 <e2e2a955-693d-1372-f2e2-c58b7f88d0d7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e2e2a955-693d-1372-f2e2-c58b7f88d0d7@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 22:51:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Sep 12, 2020 at 08:45:19AM +0200, Thomas Huth wrote:
> On 11/09/2020 22.06, Eduardo Habkost wrote:
> > On Fri, Sep 11, 2020 at 08:06:10PM +0100, Peter Maydell wrote:
> >> On Fri, 11 Sep 2020 at 19:49, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >>>
> >>> I'm wondering: do our supported build host platforms all include
> >>> compilers that are new enough to let us redefine typedefs?
> >>>
> >>> The ability to redefine typedefs is a C11 feature which would be
> >>> very useful for simplifying our QOM boilerplate code.  The
> >>> feature is supported by GCC since 2011 (v4.6.0)[1], and by clang
> >>> since 2012 (v3.1)[2].
> >>
> >> In configure we mandate either GCC v4.8 or better, or
> >> clang v3.4 or better, or XCode Clang v5.1 or better
> >> (Apple uses a different version numbering setup to upstream).
> >> So you should probably double-check that that xcode clang has
> >> what you want, but it looks like we're good to go otherwise.
> > 
> > Can anybody confirm if the following is accurate?
> > 
> > https://gist.github.com/yamaya/2924292#file-xcode-clang-vers-L67
> > # Xcode 5.1 (5B130a)
> > Apple LLVM version 5.1 (clang-503.0.38) (based on LLVM 3.4svn)
> > Target: x86_64-apple-darwin13.1.0
> > Thread model: posix
> > 
> > If we know we have GCC 4.8+ or clang 3.4+, can we move to C11 and
> > start using -std=gnu11?
> 
> You don't have to switch to gnu11, redefintions of typedefs are already
> fine in gnu99, they are a gnu extension there to the c99 standard.
> 
> See also:
> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=7be41675f7cb16b
> 
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg585581.html

They still trigger a warning with gnu99 on clang:

$ clang --version
clang version 10.0.0 (Fedora 10.0.0-2.fc32)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
$ cat test.c
typedef struct A A;
typedef struct A A;
$ clang -std=gnu11 -c test.c
$ clang -std=gnu99 -c test.c
test.c:2:18: warning: redefinition of typedef 'A' is a C11 feature [-Wtypedef-redefinition]
typedef struct A A;
                 ^
test.c:1:18: note: previous definition is here
typedef struct A A;
                 ^
1 warning generated.
$ 

-- 
Eduardo


