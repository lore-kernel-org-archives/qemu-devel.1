Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF2AC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 21:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA30620820
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 21:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpD1GXIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA30620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38315 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEL7k-0008Td-2l
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 17:51:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hEL6k-00086K-Mf
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 17:50:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hEL6j-0007Sz-IE
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 17:50:14 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:37742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1hEL6j-0007S1-7W
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 17:50:13 -0400
Received: by mail-pf1-x42b.google.com with SMTP id 8so2268242pfr.4
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 14:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:user-agent:mime-version
	:content-transfer-encoding:content-disposition:message-id;
	bh=KGExD6F0ZRugIxXKP5mwH6IEtFTnweGV9pdJQ6BSbWE=;
	b=JpD1GXIZYdkxIDmn2bY5yGYf7CsmVFZCFrm1FgnQs2uQ6u/Da1UMdG4nzhrfJwH7zO
	KDxAmE2dxz5yHUkbH4aCOmZY5eECM9X0UEeKKy9lTy6rI85xEREYvm4WxubQAkXrQoSX
	FGgEar0rxQ88HDZ04Xa8mfHOj/dAB46GuqlbpPS6y56Rm833HNfjj+bZ77YwtsG2OtLj
	jeHVbF+6eQTBejMBJbUE/me1SItr4wQ3dgr9Mf0IM4K5Q5DODHoEgXIi6ByyugoHLDVP
	4yckMEY7cvdVtGHdWb7SkF5Khi/LQn6RitsudoqpkdqQZPZn57NTrUsbiyowqRczy9VY
	CivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:user-agent:mime-version
	:content-transfer-encoding:content-disposition:message-id;
	bh=KGExD6F0ZRugIxXKP5mwH6IEtFTnweGV9pdJQ6BSbWE=;
	b=hOYStyfw18plarx1Jt+y+zIhcbE9lJikVJUe3nwH/H3J4li7dW+KVRyhf3jpVMKBaZ
	j3kBaYuREtdiCMvmFoyuFqjKdVwTyCCiCT8vRfcSlYuXI+Ne9VsmxjK5Hefi1dGOhc+q
	i/OabrStuvy3vv7yXlX9RZkj/T+H6ywpfk+FqHPwUYwPr3tmaVitkf6hVgHlqZRWVQuW
	jkmS9uBJKoY9/QRIMu30ExBfEsxWGMppHY4IS9byoylpDbec+WMHJVqAaP6qdEHT1HNo
	SbsH20idUkH/ZUjrT5dOoUxyVMtGBAU0L1XyfWHYrqgFN6u0QEDfsfMZtPjHuZbQ+aPr
	8jVw==
X-Gm-Message-State: APjAAAVXhohiPx5nCSnKdJgVJK3HpEbw3c0IJU+oa8GTUh7VbPnVYUd1
	mG4CWjtyXo0DSDqrA9bmqZg=
X-Google-Smtp-Source: APXvYqxm6wfIVW1y2vvlZ7hUUPDsYP3YsksRQHYJh4LBSWMnAplW4DqdH+VC9WQsbKe/Mvwdn3JbLw==
X-Received: by 2002:a63:7150:: with SMTP id b16mr41589145pgn.83.1554933011624; 
	Wed, 10 Apr 2019 14:50:11 -0700 (PDT)
Received: from [192.168.1.100] ([176.116.252.109])
	by smtp.gmail.com with ESMTPSA id
	n21sm57834546pfb.42.2019.04.10.14.50.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Apr 2019 14:50:10 -0700 (PDT)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
To: mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 00:44:38 +0300
User-Agent: KMail/1.9.10
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201904110044.38853.randrianasulu@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42b
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 4.0.0-rc3 is now available
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410214438.-KXXfGKKAyYmD8lv3Dpa2lK4LK_FIKZPF1mPs6otwqA@z>

Please also include this patch in next -rc or final, it fixes 32-bit compilation:

https://patchew.org/QEMU/20190402073018.17747-1-kraxel%40redhat.com/
([Qemu-devel] [PATCH] curses: fix wchar_t printf warning)

without it I get 

ui/curses.c: In function 'get_ucs':
ui/curses.c:456:25: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'wchar_t {aka long int}' [-Werror=format=]
         fprintf(stderr, "Could not convert 0x%02x from WCHAR_T to UCS-2: %s\n",
                         ^
cc1: all warnings being treated as errors
make: *** [ui/curses.o] Error 1
make: *** Waiting for unfinished jobs....

