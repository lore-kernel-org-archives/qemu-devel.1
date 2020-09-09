Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93543C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C8920757
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZkaFTal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C8920757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFzaC-0005rQ-1b
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 08:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFzZC-00050S-Bl
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:51:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40819
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFzZ9-0000Ur-Lf
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599655870;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hJH1ZAaAU0aMT4XrfSRqAXM13zWj9mNRmfE867EBXY4=;
 b=LZkaFTalCo6zY3CbE+jBJJzmrZE3RWzABiTvfJIF0wjVjgSfQEKQmIx5k4CaOoZL/UZ66C
 Xy18Pb7T4vPLiUnc6HyaLNudle0OHhmAWnazWtW5+3gHFJpb3kIa3tyXe1smLLZ/sQVWG2
 IzO4V9YuECUTa4lGJJEMkWh/Sllj0bY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-Frc_WoGXOZCGFzGvuy2x3Q-1; Wed, 09 Sep 2020 08:51:01 -0400
X-MC-Unique: Frc_WoGXOZCGFzGvuy2x3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D3CD64083;
 Wed,  9 Sep 2020 12:50:59 +0000 (UTC)
Received: from redhat.com (ovpn-113-81.ams2.redhat.com [10.36.113.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B265383560;
 Wed,  9 Sep 2020 12:50:52 +0000 (UTC)
Date: Wed, 9 Sep 2020 13:50:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v2 03/21] configure: Fixes ncursesw detection under
 msys2/mingw and enable curses
Message-ID: <20200909125049.GU1011023@redhat.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-4-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200909094617.1582-4-luoyonggang@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 02:43:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 05:45:59PM +0800, Yonggang Luo wrote:
> The mingw pkg-config are showing following absolute path and contains : as the separator,
> so we must handling : properly.
> 
> -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC:/CI-Tools/msys64/mingw64/include/ncursesw:-I/usr/include/ncursesw:
> -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC -pipe -lncursesw -lgnurx -ltre -lintl -liconv
> -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC -lncursesw
> -DNCURSES_WIDECHAR -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC -lcursesw
> -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -pipe -lncursesw -lgnurx -ltre -lintl -liconv
> -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lncursesw
> -DNCURSES_WIDECHAR /CI-Tools/msys64/mingw64/include/ncursesw -lcursesw
> -DNCURSES_WIDECHAR -I/usr/include/ncursesw -pipe -lncursesw -lgnurx -ltre -lintl -liconv
> -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lncursesw
> -DNCURSES_WIDECHAR -I/usr/include/ncursesw -lcursesw
> 
> msys2/mingw lacks the POSIX-required langinfo.h.
> 
> gcc test.c -DNCURSES_WIDECHAR -I/mingw64/include/ncursesw -pipe -lncursesw -lgnurx -ltre -lintl -liconv
> test.c:4:10: fatal error: langinfo.h: No such file or directory
>     4 | #include <langinfo.h>
>       |          ^~~~~~~~~~~~
> compilation terminated.
> 
> So we using g_get_codeset instead of nl_langinfo(CODESET)
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  configure   |  9 +++------
>  ui/curses.c | 10 +++++-----
>  2 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/configure b/configure
> index f4f8bc3756..2e6d54e15b 100755
> --- a/configure
> +++ b/configure
> @@ -3653,8 +3653,8 @@ if test "$iconv" = "no" ; then
>  fi
>  if test "$curses" != "no" ; then
>    if test "$mingw32" = "yes" ; then
> -    curses_inc_list="$($pkg_config --cflags ncurses 2>/dev/null):"
> -    curses_lib_list="$($pkg_config --libs ncurses 2>/dev/null):-lpdcurses"
> +    curses_inc_list="$($pkg_config --cflags ncursesw 2>/dev/null):-I/${MSYSTEM,,}/include/ncursesw:"
> +    curses_lib_list="$($pkg_config --libs ncursesw 2>/dev/null):-lncursesw"

The original code would try  ncurses via pkg-config and if that failed, would
falback to pdcurses.

The new code tries ncursesw via pkg-config and then tries ncursesw again
via manually specified args, and doesn't try  ncurses or pdcurses at all.

This fixes your build as you've installed ncursesw, but breaks anyone
who was using ncurses or pdcurses previously. At least on Fedora only
pdcurses is available for mingw, so I don't think we should be dropping
this. It looks like we just need to check all three of ncursesw, ncurses
and pdcurses.

Copying Samuel who introduced this logic originally in 
commit 8ddc5bf9e5de51c2a4842c01dd3a97f5591776fd

>    else
>      curses_inc_list="$($pkg_config --cflags ncursesw 2>/dev/null):-I/usr/include/ncursesw:"
>      curses_lib_list="$($pkg_config --libs ncursesw 2>/dev/null):-lncursesw:-lcursesw"
> @@ -3664,17 +3664,14 @@ if test "$curses" != "no" ; then
>  #include <locale.h>
>  #include <curses.h>
>  #include <wchar.h>
> -#include <langinfo.h>
>  int main(void) {
> -  const char *codeset;
>    wchar_t wch = L'w';
>    setlocale(LC_ALL, "");
>    resize_term(0, 0);
>    addwstr(L"wide chars\n");
>    addnwstr(&wch, 1);
>    add_wch(WACS_DEGREE);
> -  codeset = nl_langinfo(CODESET);
> -  return codeset != 0;
> +  return 0;
>  }
>  EOF
>    IFS=:
> diff --git a/ui/curses.c b/ui/curses.c
> index a59b23a9cf..12bc682cf9 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -30,7 +30,6 @@
>  #endif
>  #include <locale.h>
>  #include <wchar.h>
> -#include <langinfo.h>
>  #include <iconv.h>
>  
>  #include "qapi/error.h"
> @@ -526,6 +525,7 @@ static void font_setup(void)
>      iconv_t nativecharset_to_ucs2;
>      iconv_t font_conv;
>      int i;
> +    g_autofree gchar *local_codeset = g_get_codeset();
>  
>      /*
>       * Control characters are normally non-printable, but VGA does have
> @@ -566,14 +566,14 @@ static void font_setup(void)
>        0x25bc
>      };
>  
> -    ucs2_to_nativecharset = iconv_open(nl_langinfo(CODESET), "UCS-2");
> +    ucs2_to_nativecharset = iconv_open(local_codeset, "UCS-2");
>      if (ucs2_to_nativecharset == (iconv_t) -1) {
>          fprintf(stderr, "Could not convert font glyphs from UCS-2: '%s'\n",
>                          strerror(errno));
>          exit(1);
>      }
>  
> -    nativecharset_to_ucs2 = iconv_open("UCS-2", nl_langinfo(CODESET));
> +    nativecharset_to_ucs2 = iconv_open("UCS-2", local_codeset);
>      if (nativecharset_to_ucs2 == (iconv_t) -1) {
>          iconv_close(ucs2_to_nativecharset);
>          fprintf(stderr, "Could not convert font glyphs to UCS-2: '%s'\n",
> @@ -581,7 +581,7 @@ static void font_setup(void)
>          exit(1);
>      }
>  
> -    font_conv = iconv_open(nl_langinfo(CODESET), font_charset);
> +    font_conv = iconv_open(local_codeset, font_charset);
>      if (font_conv == (iconv_t) -1) {
>          iconv_close(ucs2_to_nativecharset);
>          iconv_close(nativecharset_to_ucs2);
> @@ -602,7 +602,7 @@ static void font_setup(void)
>      /* DEL */
>      convert_ucs(0x7F, 0x2302, ucs2_to_nativecharset);
>  
> -    if (strcmp(nl_langinfo(CODESET), "UTF-8")) {
> +    if (strcmp(local_codeset, "UTF-8")) {
>          /* Non-Unicode capable, use termcap equivalents for those available */
>          for (i = 0; i <= 0xFF; i++) {
>              wchar_t wch[CCHARW_MAX];
> -- 
> 2.28.0.windows.1
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


