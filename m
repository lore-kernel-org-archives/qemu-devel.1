Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FC7C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD10D2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD10D2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvjF-0005gX-OH
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:56:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEvIj-00060J-5t
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEvIi-0005Ms-7l
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:29:01 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:57669)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hEvIg-0005Ko-Av
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:28:59 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MIMXC-1h2s3z3spQ-00EKbu; Fri, 12 Apr 2019 14:28:44 +0200
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
	qemu-devel@nongnu.org
References: <20190412121626.19829-1-berrange@redhat.com>
	<20190412121626.19829-2-berrange@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <301236a7-18f3-1b63-5785-eb8ec93ff583@vivier.eu>
Date: Fri, 12 Apr 2019 14:28:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190412121626.19829-2-berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jZUzzMacHUt+fv0PmX21TLXLEwwMRsmHt7kDKfSbGOVDkJskZZQ
	0ODVWuKBV8D9qWEx0R1iAiLZMfRNrbRqM9gYNk7uhzyUQxGhqLx5C822BVqRqcBZaX5quz2
	89GAicpPh9PxUznhzVO0PRoD7S+zqHWqmPprEg9hhOZGVRg0TLckDEhZhLb+KjMQb7T30nP
	ZPOIdGdpiaolMh6bC7HFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0yFKuWneZ8Q=:r7iOU6f/GPGtL27H7detEo
	vhcO0ylXaCbc2dNgJ2VDX7NUAnnwh5x0wAgpDw6iQ/vUjbPxrL3L5tbfA7EE/Q9yn8uhxN/xz
	WT0JtMx5Ll2GA7WIaM+75wSgnQhWeKBOQzgK8vlJPYxVlvgp26N9hy3PCajYGvBZCsYBQjmzW
	jiIevSCvcBnCA965duG8SXyrd1zlyYHv31ZCe4fKmlU2N+foefJWPXRA4thSevqfXtWWc3MA4
	Mb0Vy5wByw9qQXCYAewIjRXn18WvIm6G0DLGvxTyGQwC0EHGgHhUY95BIDcuBiBAfwsBv8xW1
	rKWOIdl6i0IA+yQz304STbtZIVLjkBfLMugC5zK7K6q+htBjH1brmggbfWdeCmLRB4K/jjGBf
	+gsQdOY0tQMeVUnUOcYbd8MVwAstOPQNLmRP9psdWKFDCgzuoziWTOLerv9WlcN793h0aULg0
	QiP/V4I4UQ5m1sLge40wMdS1e2ER1dWhi8cTJpl3VV4zVCHUNfs+Jpe831fX6SCw1T++tysIZ
	rslUS97ZRV4CYS+MWskTP8V+9gLAHWeorI6xWG7ooCTA9YB9wTg4AQ0HBdbUI4NxofZ7iqbTl
	2vkmjZluzV5+bo8O/9jjKNRiYJsPlcMefrhZvmbPiddKxN1I9oW6uO1i3yJ6JS6nZQcgNqK3L
	aB57EliCR5ZUrn1MqtYNcIpr+gIeFiwv4S04HlXpyrT/2S0iXRCy2rdEOSfI0mtqz7Oi9T1Jw
	gVhCaXU3cGZTtCMW5FgZ5O0MG4b6FZ2/reoqfCqZqN67l8LcUtCL3Ij9WqM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [PATCH v2 1/5] linux-user: avoid string truncation
 warnings in uname field copying
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412122841.X2FBnkvr35E8X4ZqqsdiQCXzhrp94wIbJ8is8qyeaeM@z>

On 12/04/2019 14:16, Daniel P. Berrangé wrote:
> In file included from /usr/include/string.h:494,
>                  from include/qemu/osdep.h:101,
>                  from linux-user/uname.c:20:
> In function ‘strncpy’,
>     inlined from ‘sys_uname’ at linux-user/uname.c:94:3:
> /usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ output may be truncated copying 64 bytes from a string of length 64 [-Wstringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> We don't care where the NUL terminator in the original uname
> field was. It suffices to copy the entire original field and
> simply force a NUL terminator at the end of the new field.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  linux-user/uname.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/uname.c b/linux-user/uname.c
> index 313b79dbad..3dff33effe 100644
> --- a/linux-user/uname.c
> +++ b/linux-user/uname.c
> @@ -73,7 +73,7 @@ const char *cpu_to_uname_machine(void *cpu_env)
>  #define COPY_UTSNAME_FIELD(dest, src) \
>    do { \
>        /* __NEW_UTS_LEN doesn't include terminating null */ \
> -      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
> +      memcpy((dest), (src), MIN(sizeof(src), __NEW_UTS_LEN));   \

If we use sizeof(), I think we should use it for both:

  MIN(sizeof(dest), sizeof(src))

Thanks,
Laurent

