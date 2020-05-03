Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739D3C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 12:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4759A2063A
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 12:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4759A2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVE80-0005Um-Bq
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 08:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jVE7E-0004d5-OF; Sun, 03 May 2020 08:53:04 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:63100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jVE7B-00037F-I4; Sun, 03 May 2020 08:53:03 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id D2431746353;
 Sun,  3 May 2020 14:52:49 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AD844746351; Sun,  3 May 2020 14:52:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A9309746307;
 Sun,  3 May 2020 14:52:49 +0200 (CEST)
Date: Sun, 3 May 2020 14:52:49 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 1/2] audio/mixeng: Fix Clang 'int-conversion' warning
In-Reply-To: <20200503113220.30808-2-f4bug@amsat.org>
Message-ID: <alpine.BSF.2.22.395.2005031450260.61821@zero.eik.bme.hu>
References: <20200503113220.30808-1-f4bug@amsat.org>
 <20200503113220.30808-2-f4bug@amsat.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-498830709-1588510369=:61821"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/03 08:52:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-498830709-1588510369=:61821
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 3 May 2020, Philippe Mathieu-Daudé wrote:
> When building with Clang 10 on Fedora 32, we get:
>
>    CC      audio/mixeng.o
>  audio/mixeng.c:274:34: error: implicit conversion from 'unsigned int' to 'float' changes value from 4294967295 to 4294967296 [-Werror,-Wimplicit-int-float-conversion]
>  static const float float_scale = UINT_MAX / 2.f;
>                                   ^~~~~~~~ ~
>  /usr/lib64/clang/10.0.0/include/limits.h:56:37: note: expanded from macro 'UINT_MAX'
>  #define UINT_MAX  (__INT_MAX__  *2U +1U)
>                     ~~~~~~~~~~~~~~~~~^~~
>
> Fix by using a 64-bit float for the conversion, before casting
> back to 32-bit float.
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> audio/mixeng.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/audio/mixeng.c b/audio/mixeng.c
> index 739a500449..9946bfeaec 100644
> --- a/audio/mixeng.c
> +++ b/audio/mixeng.c
> @@ -271,7 +271,7 @@ f_sample *mixeng_clip[2][2][2][3] = {
> #define CONV_NATURAL_FLOAT(x) (x)
> #define CLIP_NATURAL_FLOAT(x) (x)
> #else
> -static const float float_scale = UINT_MAX / 2.f;
> +static const float float_scale = UINT_MAX / 2.;

Maybe writing it as 2.0 is easier to read and looks nicer.

Regards,
BALATON Zoltan
--3866299591-498830709-1588510369=:61821--

