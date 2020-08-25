Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9984C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96CCF20782
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g91OeWmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CCF20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAbV9-0001Kf-Tv
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 12:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAbUV-0000oz-Eu
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:08:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52315
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAbUS-0005N8-J3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598371683;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNI8zo0jJjOGZVuqtYxIlhwnx7g+bCd4UdnAxapRoZw=;
 b=g91OeWmSNqYQKfJxmMtSH/f0Kssi31HoUsqFK8gSzSIP+5MdPqEsDLQebB2NibbwHMMbOt
 0+Tl7z4l9U0lzp8QcN7kI1O/M+c3aqOIF01x2UEd4Zz6BxQczD2v47bd6JHdxp++aaj5nz
 0wRDCQwyR7IWp7SlE6JCCKdpLHK/Mh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-ivVLX359OXe67k5-6qhITQ-1; Tue, 25 Aug 2020 12:07:56 -0400
X-MC-Unique: ivVLX359OXe67k5-6qhITQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A847E80EF9C;
 Tue, 25 Aug 2020 16:07:55 +0000 (UTC)
Received: from redhat.com (ovpn-114-231.ams2.redhat.com [10.36.114.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EB1D5D9CA;
 Tue, 25 Aug 2020 16:07:51 +0000 (UTC)
Date: Tue, 25 Aug 2020 17:07:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 5/5] meson: add NSIS building
Message-ID: <20200825160748.GB107278@redhat.com>
References: <20200825150409.346957-1-marcandre.lureau@redhat.com>
 <20200825150409.346957-6-marcandre.lureau@redhat.com>
 <20200825151156.GW107278@redhat.com>
 <CAFEAcA_b3aGS8TFB3V6mNwxi7xG6MGNwqtnt9=XpEve+OHQQEw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_b3aGS8TFB3V6mNwxi7xG6MGNwqtnt9=XpEve+OHQQEw@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:37:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 05:03:41PM +0100, Peter Maydell wrote:
> On Tue, 25 Aug 2020 at 16:14, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > This is a verbose way of saying I think you should create a
> > nsis.py, not nsis.sh, to avoid the inherant portability problems of
> > shell that hit us over and over and over again.
> 
> Does it have to be a separate script, or can we just write inline
> Python in the meson file? The main reason the current code is
> written in shell is because that's what you need to write it in
> so you can write it inline in a Makefile, and because half of
> it is "invoke this other command ($(SIGNCODE), makensis, etc)",
> which is what build systems are good at.

Meson just wants to have a command path + list of arguments.

So if you want to have the python code inline you can do that by passing
it as an arg by telling meson to run "python -e <codeblob>".

I think that's only sensible for one-liner scripts though. Otherwise it
is nicer to have a separate script that you can invoke directly for
testing / debugging purposes separately from meson.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


