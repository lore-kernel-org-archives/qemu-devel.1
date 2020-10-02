Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79C4C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 880602074B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLFsKmXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880602074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONA0-0001LC-Cz
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kON75-00054k-Qs
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kON73-0003QK-CD
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601653008;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68dvwuykN/08qbdlvfUzc1Rz3VTGxYUBG6bCqYIJPic=;
 b=cLFsKmXg5+b5HLKepN4sJAGcOjKND8iNZaXUiRTnXBOt6Zih1nOslh4BWWvdH4JO67371y
 NaKEVJnBd0pVZ3oQCcr8QuZMSvE+CknaWLdkiqn5AvqNERJR06DxkfbSPfnPMdqRDpnylU
 AlbGwaG+y7nBhrA5YXug3NJJzoTF8J8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-dxwPn_2OPeefqrCTfM9UoQ-1; Fri, 02 Oct 2020 11:36:46 -0400
X-MC-Unique: dxwPn_2OPeefqrCTfM9UoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70D66107465A;
 Fri,  2 Oct 2020 15:36:44 +0000 (UTC)
Received: from redhat.com (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AF7271775;
 Fri,  2 Oct 2020 15:36:38 +0000 (UTC)
Date: Fri, 2 Oct 2020 16:36:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v6 4/4] win32: Simplify gmtime_r detection not depends on
 if _POSIX_C_SOURCE are defined on msys2/mingw
Message-ID: <20201002153636.GK2338114@redhat.com>
References: <20201001173230.829-1-luoyonggang@gmail.com>
 <20201001173230.829-5-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201001173230.829-5-luoyonggang@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
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

On Fri, Oct 02, 2020 at 01:32:30AM +0800, Yonggang Luo wrote:
> We remove the CONFIG_LOCALTIME_R detection option in configure, and move the check
> existence of gmtime_r from configure into C header and source directly by using macro
> `_POSIX_THREAD_SAFE_FUNCTIONS`.
> Before this patch, the configure script are always assume the compiler doesn't define
> _POSIX_C_SOURCE macro at all, but that's not true, because thirdparty library such
> as ncursesw may define -D_POSIX_C_SOURCE in it's pkg-config file. And that C Flags will
> added -D_POSIX_C_SOURCE into each QEMU_CFLAGS. And that's causing the following compiling error:
> n file included from C:/work/xemu/qemu/include/qemu/osdep.h:119,
>                  from ../softmmu/main.c:25:
> C:/work/xemu/qemu/include/sysemu/os-win32.h:53:12: error: redundant redeclaration of 'gmtime_r' [-Werror=redundant-decls]
>    53 | struct tm *gmtime_r(const time_t *timep, struct tm *result);
>       |            ^~~~~~~~
> In file included from C:/work/xemu/qemu/include/qemu/osdep.h:94,
>                  from ../softmmu/main.c:25:
> C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/time.h:284:36: note: previous definition of 'gmtime_r' was here
>   284 | __forceinline struct tm *__CRTDECL gmtime_r(const time_t *_Time, struct tm *_Tm) {
>       |                                    ^~~~~~~~
> In file included from C:/work/xemu/qemu/include/qemu/osdep.h:119,
>                  from ../softmmu/main.c:25:
> C:/work/xemu/qemu/include/sysemu/os-win32.h:55:12: error: redundant redeclaration of 'localtime_r' [-Werror=redundant-decls]
>    55 | struct tm *localtime_r(const time_t *timep, struct tm *result);
>       |            ^~~~~~~~~~~
> In file included from C:/work/xemu/qemu/include/qemu/osdep.h:94,
>                  from ../softmmu/main.c:25:
> C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/time.h:281:36: note: previous definition of 'localtime_r' was here
>   281 | __forceinline struct tm *__CRTDECL localtime_r(const time_t *_Time, struct tm *_Tm) {
>       |                                    ^~~~~~~~~~~
> Compiling C object libcommon.fa.p/hw_gpio_zaurus.c.obj
> In file included from C:/work/xemu/qemu/include/qemu/osdep.h:119,
>                  from ../hw/i2c/smbus_slave.c:16:
> C:/work/xemu/qemu/include/sysemu/os-win32.h:53:12: error: redundant redeclaration of 'gmtime_r' [-Werror=redundant-decls]
>    53 | struct tm *gmtime_r(const time_t *timep, struct tm *result);
>       |            ^~~~~~~~
> In file included from C:/work/xemu/qemu/include/qemu/osdep.h:94,
>                  from ../hw/i2c/smbus_slave.c:16:
> C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/time.h:284:36: note: previous definition of 'gmtime_r' was here
>   284 | __forceinline struct tm *__CRTDECL gmtime_r(const time_t *_Time, struct tm *_Tm) {
>       |                                    ^~~~~~~~
> In file included from C:/work/xemu/qemu/include/qemu/osdep.h:119,
>                  from ../hw/i2c/smbus_slave.c:16:
> C:/work/xemu/qemu/include/sysemu/os-win32.h:55:12: error: redundant redeclaration of 'localtime_r' [-Werror=redundant-decls]
>    55 | struct tm *localtime_r(const time_t *timep, struct tm *result);
>       |            ^~~~~~~~~~~
> In file included from C:/work/xemu/qemu/include/qemu/osdep.h:94,
>                  from ../hw/i2c/smbus_slave.c:16:
> C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/time.h:281:36: note: previous definition of 'localtime_r' was here
>   281 | __forceinline struct tm *__CRTDECL localtime_r(const time_t *_Time, struct tm *_Tm) {
>       |                                    ^~~~~~~~~~~
> Compiling C object libcommon.fa.p/hw_dma_xilinx_axidma.c.obj
> 
> After this patch, whenever ncursesw or other thirdparty libraries tried to define or not
> define  _POSIX_C_SOURCE, the source will building properly. Because now, we don't make any
> assumption if _POSIX_C_SOURCE are defined. We solely relied on if the macro `_POSIX_THREAD_SAFE_FUNCTIONS`
> are defined in msys2/mingw header.
> 
> The _POSIX_THREAD_SAFE_FUNCTIONS are defined in mingw header like this:
> 
> ```
> #if defined(_POSIX_C_SOURCE) && !defined(_POSIX_THREAD_SAFE_FUNCTIONS)
> #define _POSIX_THREAD_SAFE_FUNCTIONS 200112L
> #endif
> 
> #ifdef _POSIX_THREAD_SAFE_FUNCTIONS
> __forceinline struct tm *__CRTDECL localtime_r(const time_t *_Time, struct tm *_Tm) {
>   return localtime_s(_Tm, _Time) ? NULL : _Tm;
> }
> __forceinline struct tm *__CRTDECL gmtime_r(const time_t *_Time, struct tm *_Tm) {
>   return gmtime_s(_Tm, _Time) ? NULL : _Tm;
> }
> __forceinline char *__CRTDECL ctime_r(const time_t *_Time, char *_Str) {
>   return ctime_s(_Str, 0x7fffffff, _Time) ? NULL : _Str;
> }
> __forceinline char *__CRTDECL asctime_r(const struct tm *_Tm, char * _Str) {
>   return asctime_s(_Str, 0x7fffffff, _Tm) ? NULL : _Str;
> }
> #endif
> ```
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  configure                 | 34 ----------------------------------
>  include/sysemu/os-win32.h |  4 ++--
>  util/oslib-win32.c        |  4 ++--
>  3 files changed, 4 insertions(+), 38 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


