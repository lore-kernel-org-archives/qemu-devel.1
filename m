Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857A0C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249A7206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYJs233R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249A7206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKWI-000774-75
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kOKTZ-0004OA-AS
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:47:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kOKTX-0007zX-HZ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601642870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OrkmzMv/0VWKCk+2+WI5ZhEbUjhpuS4ELN8u5HTArqY=;
 b=JYJs233RPywZ9pwbeYX4bOW3nS2SCriG38HaAX5ebeIG3q3gvhy3rIDLyaTbMLoTDYF09Z
 u+a4DbxYBiUOLDMrUGw9JUEOQ9noYor/8eN56DCQu0FHDCkmw9kFEkgb7er4Zvu65nznlp
 hTEkHaAtZmfffMBWzc2JqY9AlL/f7kE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-Afb1-OyCNs2k7ob10nxtTg-1; Fri, 02 Oct 2020 08:47:47 -0400
X-MC-Unique: Afb1-OyCNs2k7ob10nxtTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D220C1882FA0;
 Fri,  2 Oct 2020 12:47:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9059C60BE2;
 Fri,  2 Oct 2020 12:47:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CAA9317538; Fri,  2 Oct 2020 14:47:44 +0200 (CEST)
Date: Fri, 2 Oct 2020 14:47:44 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 0/4] Fixes curses on msys2/mingw
Message-ID: <20201002124744.whdgh4xtmvifi72y@sirius.home.kraxel.org>
References: <20201001173230.829-1-luoyonggang@gmail.com>
 <89710921-1d64-14fd-f8ce-05ee58f412c5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <89710921-1d64-14fd-f8ce-05ee58f412c5@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Yonggang Luo <luoyonggang@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 01, 2020 at 07:39:33PM +0200, Paolo Bonzini wrote:
> On 01/10/20 19:32, Yonggang Luo wrote:
> > And also convert related configure script to meson.
> > V5-V6
> > Dropping configure: Fixes ncursesw detection under msys2/mingw by convert the=
> > m to meson first.
> > That need the meson 0.56 upstream to fixes the curses detection.
> > Add
> > * configure: fixes indent of $meson setup
> > 
> > Yonggang Luo (4):
> >   configure: fixes indent of $meson setup
> >   curses: Fixes compiler error that complain don't have langinfo.h on
> >     msys2/mingw
> >   curses: Fixes curses compiling errors.
> >   win32: Simplify gmtime_r detection not depends on if  _POSIX_C_SOURCE
> >     are defined on msys2/mingw
> > 
> >  configure                 | 42 ++++-----------------------------------
> >  include/sysemu/os-win32.h |  4 ++--
> >  ui/curses.c               | 14 ++++++-------
> >  util/oslib-win32.c        |  4 ++--
> >  4 files changed, 15 insertions(+), 49 deletions(-)
> > 
> > --=20
> > 2.28.0.windows.1
> > 
> > 
> 
> Looks good (though there is no conversion to meson yet in this version).
> 
> Not trivial, but perhaps Gerd can take it?

Sure, series looks good.

Can't finish this today due to -ENOTIME and I'm offline next week so
this has to wait a bit in the UI patch queue ...

take care,
  Gerd


