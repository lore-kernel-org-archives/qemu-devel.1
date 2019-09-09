Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30733C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0040B206A1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0040B206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7JcX-0002Wz-Te
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 09:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i7JXZ-0007JX-Ok
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i7JXX-0003qi-Ob
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:17:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60582)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i7JXV-0003oR-Rj
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:17:06 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 900E4745A0
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 13:17:03 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id x16so2204005wmk.6
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 06:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cvdU2NyZed4H17zOnwFjVnnVZVhxFSBdNkpyUPsSY4o=;
 b=qD2nU4yMVykBOrMnVQO2G9vAhU5E9SAuRZW5itindZ0+GLTCLjqWdQmF0jpLIXgR7Q
 /aJTCovP93zE9+yhMCVxStBkihROYjDy0ibRq8f8qcm5hDm0pTwILInqdh08udsKK6j0
 21oq8QeZ0J8C6hQ2eTEe+LT4BJxi7XST8kfrRvJEeBQsjT+40AHkU0iI7abU2woGzT5V
 ThxsCfxky8qUM+iWMQFmfEkbImzurBaGYj5CR6RQl/5U+33Xs2wLsoa9SlEbTRoGAsdH
 0dRKlFo9eWBznc0eyaZh+FwlQ/+gRfTOwr9NVW7X1onOjdLsY9zsocm8jhRW1NJ25o8p
 yDUw==
X-Gm-Message-State: APjAAAVQNEs0rLquCMfe/hysJNyGXfVYGZF/x8/dn2HhWGqUOi7Pwvx/
 5+d1YcakiBYPMq8zVMdTkINWzc89OsZE5uTf3f6I+Z/h2773ftUi/xXCW1ym8Hak3osIdF8Xtnm
 s5zIYghKGsssBHYk=
X-Received: by 2002:adf:e7c4:: with SMTP id e4mr11315525wrn.62.1568035022342; 
 Mon, 09 Sep 2019 06:17:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw/pINZBOlHO9LTiRRom4opfC26g8LcYsRUf5NaamzUfiKSKLWC4YCd786vGWoThQYAqChrXQ==
X-Received: by 2002:adf:e7c4:: with SMTP id e4mr11315516wrn.62.1568035022204; 
 Mon, 09 Sep 2019 06:17:02 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id e15sm12210830wru.93.2019.09.09.06.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2019 06:17:01 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190909130840.25117-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <325c24e1-60f0-15b6-0f61-3cb8a4a9acea@redhat.com>
Date: Mon, 9 Sep 2019 15:17:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190909130840.25117-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] win32: fix README file in NSIS installer
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
Cc: berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/19 3:08 PM, Paolo Bonzini wrote:
> Adjust after the rST conversion and consequent renaming.
>=20
> Fixes: 336a7451e8803c21a2da6e7d1eca8cfb8e8b219a
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  qemu.nsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/qemu.nsi b/qemu.nsi
> index d0df0f4e3a..da18438071 100644
> --- a/qemu.nsi
> +++ b/qemu.nsi
> @@ -119,7 +119,7 @@ Section "${PRODUCT} (required)"
>      File "${SRCDIR}\Changelog"
>      File "${SRCDIR}\COPYING"
>      File "${SRCDIR}\COPYING.LIB"
> -    File "${SRCDIR}\README"
> +    File "${SRCDIR}\README.rst"
>      File "${SRCDIR}\VERSION"
> =20
>      File "${BINDIR}\*.bmp"
>=20

Also:

-- >8 --
@@ -211,7 +211,7 @@ Section "Uninstall"
     Delete "$INSTDIR\Changelog"
     Delete "$INSTDIR\COPYING"
     Delete "$INSTDIR\COPYING.LIB"
-    Delete "$INSTDIR\README"
+    Delete "$INSTDIR\README.rst"
     Delete "$INSTDIR\VERSION"
     Delete "$INSTDIR\*.bmp"
     Delete "$INSTDIR\*.bin"
---

With the snippet amended:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

