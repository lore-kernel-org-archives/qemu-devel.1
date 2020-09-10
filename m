Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D2FC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BEED20872
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZ251r1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BEED20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGK7h-0003lN-1Q
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGK5w-0000wC-MF
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:46:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30990
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGK5u-0004tf-M4
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599734781;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=R8nLgHAtUi7CnmeK9vZpeK82RZ0UN/eACJxN1MaJp8k=;
 b=LZ251r1Raum0RqkAWMc9ahcyqp1IpQt1ul5YNoBEPeKV9vOBhbeG3FDfavkfN+I+JojdSW
 S0ZjrF0cku9/UEUJR471Sz4L74mRD+p8DJI4JUcwf0ZcLupgE1D8lymOYCaZT6vjPUugKn
 oVs+6DZXSLr6MDOdio+zGo1oKbFs3yA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-HgnpihNHNfSQRxYxoTQj9g-1; Thu, 10 Sep 2020 06:46:00 -0400
X-MC-Unique: HgnpihNHNfSQRxYxoTQj9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C3AF18B9F01;
 Thu, 10 Sep 2020 10:45:59 +0000 (UTC)
Received: from redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D1D08357B;
 Thu, 10 Sep 2020 10:45:54 +0000 (UTC)
Date: Thu, 10 Sep 2020 11:45:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC] QEMU as Xcode project on macOS
Message-ID: <20200910104552.GH1083348@redhat.com>
References: <2764135.D4k31Gy3CM@silver> <2421928.3WNMogbLRJ@silver>
 <20200910093910.GG1083348@redhat.com> <4878996.4JzhbN1UZ4@silver>
 <CAFEAcA_CPNppKwwJSu4O6U6qF-rfHR2NtG=hWBFatZmD4aiMdg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_CPNppKwwJSu4O6U6qF-rfHR2NtG=hWBFatZmD4aiMdg@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:23:25
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
Cc: Thomas Huth <thuth@redhat.com>, Liviu Ionescu <ilg@livius.net>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>, G 3 <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 11:35:46AM +0100, Peter Maydell wrote:
> On Thu, 10 Sep 2020 at 11:14, Christian Schoenebeck
> <qemu_oss@crudebyte.com> wrote:
> > For developers it is actually the complete opposite on Mac: you start to
> > install things from somewhere, then you need to install something from
> > somewhere else, manually build & install stuff, and you end up in conflicts
> > and misbehaviours all over the place.
> 
> This has not been my experience -- homebrew has everything, and
> it doesn't have problems like this.
> 
> > The way to go for devs on Mac is: 3rd party libs should not be installed into
> > global space, rather be built & linked either as dynamic frameworks (including
> > assets) or as static libs. Then apps always run with the precise version and
> > flags of libs they were tested with and never conflict with another app's
> > version/config of libs.
> 
> Does Apple (or anybody else) provide a framework for doing this
> so that developers of individual applications can just say "my
> app needs libs X, Y, Z" and they don't have to mess around
> finding, figuring out how to compile, and shipping the sources of
> libs X, Y, Z? If there's a better mechanism than Homebrew for this
> that's great, but at the moment what you seem to be saying is
> "you should do a lot more work to manually set something up where
> you ship the sources to all your dependencies and then build them
> all". There's no way we're ever going to do that, it is just
> way too much work for very little gain.

AFAICT both MacPorts and HomeBrew can be installed into custom locations,
at least if you do a "from source" install of them, rather than using the
pre-built packages.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


