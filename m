Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5503BC35670
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 09:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2058D206ED
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 09:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qbl/uSPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2058D206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5nwI-00060j-7q
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 04:52:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <randrianasulu@gmail.com>) id 1j5nva-0005Vh-Rg
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 04:51:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <randrianasulu@gmail.com>) id 1j5nvZ-0005VP-OK
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 04:51:58 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
 id 1j5nvZ-0005Qb-GY; Sun, 23 Feb 2020 04:51:57 -0500
Received: by mail-pf1-x443.google.com with SMTP id s1so3702906pfh.10;
 Sun, 23 Feb 2020 01:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:user-agent:mime-version
 :content-transfer-encoding:content-disposition:message-id;
 bh=UQ4dvZt+jMCUME16c1I5p16WcL1pU6h1f4GhYRJ/LIg=;
 b=Qbl/uSPg9mascv5z9HGDhVU/ByjE6ov35gqMbmPEJwu5WTNLttqU3HFVU7SbaUEjZR
 TRWcm80xv7KKFZ7lZtDSC01WugkH+eDZHZKYTwU/fOkEgHQvu41+cpFrOpHslrkdm7ZA
 qMSUrRkoU2uY2vbXmUXHfwmf14xvARS49JzvNEbFSwycdFul2IKY6ay404MzBMSbVAk6
 D5oiIYJdWWb5LnWDiNl7R5+fUdUKNndwJjz+blnIdeu1FCcrXE2Gk+dkyARv8b4hoD2B
 /Z3t6sky0l+kYHvPwTnOSi/gcTZjWp+xaNRJk4XIOrJRdtKOti0E2cA+RRci+W/Ct4yd
 y0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:user-agent:mime-version
 :content-transfer-encoding:content-disposition:message-id;
 bh=UQ4dvZt+jMCUME16c1I5p16WcL1pU6h1f4GhYRJ/LIg=;
 b=HpHniaC5pjL7r4BtKwiPC2DC3T568zTq1cgjf02sp4o81xQwfY6qdg16NdhTiG6zvT
 3R3p1ANMC0t+SWTtCxWnwAoTy8mPZJlQu3zHUWpiOLclAFhoa8zvgpnpDKUvaPAKRHtQ
 aiDQnshz3kz9I9pwbKu2x6J8KQ4S4OVqdMnEpr0ckReQU1YrFIub0oDJAVYiHKNkooHw
 yYMmriyZR8sIyrCdk2m9ShZSsd568ccyPUsQ1t5lyzzSUKuu42peHZj2qeMQXoGHuayL
 JFh7NXG4iXJF6QQap/O3Ch1fSjIddd5nH7Jas3DAIEN+V0UwH2sj0PxR2AFWZ7vr9Dg4
 6/tA==
X-Gm-Message-State: APjAAAUVylSaSA0zDl0kdFPgwrvqT40PExS9bguhBvA1x0Ybcu6oO342
 XMHTRhnPnwERRNUXEf0dx/Y=
X-Google-Smtp-Source: APXvYqxPNvBW3PRNXGHHYYVdRv106eogkJRiRKH7dDOhFrhEogkiVJaYhUUXqYWgtq89rAabEBmouw==
X-Received: by 2002:a63:f103:: with SMTP id f3mr45923823pgi.394.1582451515968; 
 Sun, 23 Feb 2020 01:51:55 -0800 (PST)
Received: from [192.168.1.100] ([176.116.252.109])
 by smtp.gmail.com with ESMTPSA id b42sm8422910pjc.27.2020.02.23.01.51.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 23 Feb 2020 01:51:55 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
To: hsp.cat7@gmail.com, qemu-devel@nongnu.org,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v4] Implement the Screamer sound chip for the mac99
 machine type
Date: Sun, 23 Feb 2020 12:43:37 +0300
User-Agent: KMail/1.9.10
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202002231243.37654.randrianasulu@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just thought I must share my uneducated guess on issue reported at

https://www.emaculation.com/forum/viewtopic.php?f=34&t=9820
> Please note that running with 1024Mb of memory will make sound stop working in Mac OS 9.x. So run with less memory.
> As will running without virtual memory.

My guess this has something to do with device memory regions, may be because Linux  always uses Virtual memory
(MMU, address translation), as well as Mac OS X 10.x - this little issue was unnoticed until recently ?

