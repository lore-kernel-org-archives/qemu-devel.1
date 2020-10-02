Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09BEC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE5A2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDpv+2+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE5A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONEm-00071J-8w
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kON6Z-0004OR-BB
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kON6R-0003MS-UY
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601652971;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6UnijvftDmS9XWWVlyfuGQgYqCBFfDuk1hSHGZN1GG4=;
 b=YDpv+2+AgbUwCEXvG94sFiS4X+kctMAc/Wi/OVqRo94x294MCQmT88oxTkijecIRbGUO/e
 CPy3qhTIlIRX8gwaeV8ldvE+WjMzQtcoEg4H5A77h5z2Z//LTMyrHRI2YohYndcH9VRgCa
 DZ0mbErPit1WRLKjGLO+0cTqOCvvQmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-5CrSGf2sNxOTc3kXy1rmxg-1; Fri, 02 Oct 2020 11:36:09 -0400
X-MC-Unique: 5CrSGf2sNxOTc3kXy1rmxg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C40C1040C23;
 Fri,  2 Oct 2020 15:36:08 +0000 (UTC)
Received: from redhat.com (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA13F19C78;
 Fri,  2 Oct 2020 15:36:02 +0000 (UTC)
Date: Fri, 2 Oct 2020 16:35:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v6 2/4] curses: Fixes compiler error that complain don't
 have langinfo.h on msys2/mingw
Message-ID: <20201002153559.GJ2338114@redhat.com>
References: <20201001173230.829-1-luoyonggang@gmail.com>
 <20201001173230.829-3-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201001173230.829-3-luoyonggang@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 02, 2020 at 01:32:28AM +0800, Yonggang Luo wrote:
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
>  ui/curses.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
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

If you're removing use of nl_langinfo / langinfo.h then you need
to also update configure, because it is checking for this function
and header file when validating curses library support.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


