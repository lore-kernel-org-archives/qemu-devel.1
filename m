Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FE1C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:19:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CED420838
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAWlQ2+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CED420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFC5-0007As-Oi
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAFBU-0006k1-Ik
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAFBR-0004ML-P6
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598285935;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6C9vnfy79FGkgHoTaahogAabhfhEp/MSbIbKa2fs+nA=;
 b=UAWlQ2+gVhrlWRgcyxKC3DnQwSqBWNfCahrr0V08FHFoVpKqxeH50DeHDl3qScVbe8XH9D
 qDIZjo0993JlT9h+fwkug7EcHl0yPaysZ5oiO9jSsge2KhYz5cFVL9IJsBsnVIJQFV1jEK
 irZAJqZ7kf0sfcSEdb7G6fTXm7mf9Mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-fALy6cfMNUu8WsfiqLfWSQ-1; Mon, 24 Aug 2020 12:18:53 -0400
X-MC-Unique: fALy6cfMNUu8WsfiqLfWSQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 477471084C89;
 Mon, 24 Aug 2020 16:18:52 +0000 (UTC)
Received: from redhat.com (ovpn-114-223.ams2.redhat.com [10.36.114.223])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E90045C1BB;
 Mon, 24 Aug 2020 16:18:50 +0000 (UTC)
Date: Mon, 24 Aug 2020 17:18:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL v7 000/151] Meson-based build system
Message-ID: <20200824161848.GW10011@redhat.com>
References: <20200819213203.17876-1-pbonzini@redhat.com>
 <CABLmASFno04tFBRTq=V8AO7dj1d67-SNpugUJMVVa4yzrPq03Q@mail.gmail.com>
 <CABLmASECM5tVVw3TMJn+0bCT7O4H_guy5TJd9YQKYYx+QUKBKQ@mail.gmail.com>
 <dd66cee7-c6d2-a81e-2e53-eca34ed78be8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <dd66cee7-c6d2-a81e-2e53-eca34ed78be8@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 04:38:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 02:33:12PM +0200, Paolo Bonzini wrote:
> On 21/08/20 12:58, Howard Spoelstra wrote:
> > I investigated a bit further and saw:
> > ldd in Fedora tells me the executable is "not a dynamic executable".
> 
> How are you executing ldd?  I cross built a mingw executable from Fedora
> and it was definitely using system DLLs.
> 
> PIE builds and doesn't start (doesn't even reach main) but --disable-pie
> works just fine.  I don't know if the same issue is present under
> Windows or it's Wine-specific.

I've just hit this problem too,  and can demo it without QEMU involved

$ cat e.c
#include <stdio.h>
#include <stdlib.h>

  int main(int argc, char **argv) {    fprintf(stderr, "Hello\n");    exit(EXIT_SUCCESS); }

$ x86_64-w64-mingw32-gcc -pie -o e.exe e.c 

the resulting e.exe fails to run under *both* Wine and Windows 2008r2.

Either there's some extra magic compiler flags we need to pass to make
this work, or we need to just disable PIE on Windows. The original
pre-meson build used -no-pie AFAICT.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


