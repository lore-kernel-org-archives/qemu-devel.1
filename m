Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2835EC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E78921D7D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ah83XwJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E78921D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG05b-0003UH-La
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kG046-0001Va-5m
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kG043-0004T3-QX
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599657786;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Ihs2GiNXwmDk+H36a/CheHg9sRUsdHhrPfN7+IKkyU=;
 b=ah83XwJPAA+r+u6xw3rCpnPsEohcIu9V7+3Uytk7Sr9BduY2gUvbeQ2izXLXcgJb2fZZlV
 4IQFgEnTTRWfwxG3EhbPD0U2Az/VnxdgzOo8dx4SXARauuSQbOpDCTdxTlLhuf48sHsBM1
 3d6SPOQQcuprEo9KwFOLLnTpzkYNVfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-PP4hDRP_MJCW-_lSOpxIpA-1; Wed, 09 Sep 2020 09:23:00 -0400
X-MC-Unique: PP4hDRP_MJCW-_lSOpxIpA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 197CD80046A;
 Wed,  9 Sep 2020 13:22:58 +0000 (UTC)
Received: from redhat.com (ovpn-113-81.ams2.redhat.com [10.36.113.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07C3280949;
 Wed,  9 Sep 2020 13:22:50 +0000 (UTC)
Date: Wed, 9 Sep 2020 14:22:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Subject: Re: [PATCH v2 03/21] configure: Fixes ncursesw detection under
 msys2/mingw and enable curses
Message-ID: <20200909132248.GL1011023@redhat.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-4-luoyonggang@gmail.com>
 <20200909125049.GU1011023@redhat.com>
 <CAE2XoE_02FDvGmwUCAFEOrog4z1iwtqoVYuSiZThBrFRLx0WfA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_02FDvGmwUCAFEOrog4z1iwtqoVYuSiZThBrFRLx0WfA@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:25:02
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 08:55:15PM +0800, 罗勇刚(Yonggang Luo) wrote:
> On Wed, Sep 9, 2020 at 8:51 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Wed, Sep 09, 2020 at 05:45:59PM +0800, Yonggang Luo wrote:
> > > The mingw pkg-config are showing following absolute path and contains :
> > as the separator,
> > > so we must handling : properly.
> > >
> > > -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L
> > -IC:/CI-Tools/msys64/mingw64/include/ncursesw:-I/usr/include/ncursesw:
> > > -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC
> > -pipe -lncursesw -lgnurx -ltre -lintl -liconv
> > > -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC
> > -lncursesw
> > > -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC
> > -lcursesw
> > > -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -pipe
> > -lncursesw -lgnurx -ltre -lintl -liconv
> > > -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lncursesw
> > > -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lcursesw
> > > -DNCURSES_WIDECHAR -I/usr/include/ncursesw -pipe -lncursesw -lgnurx
> > -ltre -lintl -liconv
> > > -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lncursesw
> > > -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lcursesw
> > >
> > > msys2/mingw lacks the POSIX-required langinfo.h.
> > >
> > > gcc test.c -DNCURSES_WIDECHAR -I/mingw64/include/ncursesw -pipe
> > -lncursesw -lgnurx -ltre -lintl -liconv
> > > test.c:4:10: fatal error: langinfo.h: No such file or directory
> > >     4 | #include <langinfo.h>
> > >       |          ^~~~~~~~~~~~
> > > compilation terminated.
> > >
> > > So we using g_get_codeset instead of nl_langinfo(CODESET)
> > >
> > > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > > Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > >  configure   |  9 +++------
> > >  ui/curses.c | 10 +++++-----
> > >  2 files changed, 8 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/configure b/configure
> > > index f4f8bc3756..2e6d54e15b 100755
> > > --- a/configure
> > > +++ b/configure
> > > @@ -3653,8 +3653,8 @@ if test "$iconv" = "no" ; then
> > >  fi
> > >  if test "$curses" != "no" ; then
> > >    if test "$mingw32" = "yes" ; then
> > > -    curses_inc_list="$($pkg_config --cflags ncurses 2>/dev/null):"
> > > -    curses_lib_list="$($pkg_config --libs ncurses
> > 2>/dev/null):-lpdcurses"
> > > +    curses_inc_list="$($pkg_config --cflags ncursesw
> > 2>/dev/null):-I/${MSYSTEM,,}/include/ncursesw:"
> > > +    curses_lib_list="$($pkg_config --libs ncursesw
> > 2>/dev/null):-lncursesw"
> >
> > The original code would try  ncurses via pkg-config and if that failed,
> > would
> > falback to pdcurses.
> >
> > The new code tries ncursesw via pkg-config and then tries ncursesw again
> > via manually specified args, and doesn't try  ncurses or pdcurses at all.
> >
> Gotcha, Indeed   $pkg_config --cflags ncurses can find curses on mingw32,
> the problem is onw mingw32 the include path
> have :, so we can not use : as the path sepaerator, for cross-paltform
> reason, which is best for path separator?

I guess it was using ":" because " " might be valid in the file path.

How about using "#" or "%" instead as those should be more unlikely to
clash.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


