Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642D2C74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 22:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE1A208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 22:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyO3oAaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE1A208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlKgG-000190-5k
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 18:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35065)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groeck7@gmail.com>) id 1hlKfC-0000gK-Lp
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 18:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1hlKfB-0001fl-Fd
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 18:02:10 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:40784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1hlKfA-0001U8-J3
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 18:02:09 -0400
Received: by mail-pf1-x430.google.com with SMTP id p184so1718162pfp.7
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=czZEALWg2F1K18PB3+BkyDlnHaxgL9PXWKE6WlqL93s=;
 b=iyO3oAaU4Drv+8yyHh/uNxf1KTG8Jtoq40DuHMp1emu2r1ustapDnmBnm0PctIBXwJ
 jqB0hp+yqPC1JKZKW6Nf/dPMNfndSLb5ZlDuyFCou4xzrFLpDoWc1l16m7A/5tZ81xFg
 xUwMoMwj3wcus6VwU9qZDLVihEi4WEesaXQAfrOm8b4En/yNEk8xcUrHrf45++FL7nrp
 y24KvF34rc29QD5sGgznSTH7BhUJyKQ7yQBZDYSOdtvdNrRXf6DvkE3K7oQzhvRak2jN
 NMMFPPob4Zfmhijyhd+gUkZ7eZ84XAINDsH3YHTPJ4vSGN7iqNK1Ypbse3iOtcQiiIsu
 vuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:subject:message-id
 :mime-version:content-disposition:user-agent;
 bh=czZEALWg2F1K18PB3+BkyDlnHaxgL9PXWKE6WlqL93s=;
 b=LCp+10dKYOnD3oKXEs8ZJA6Sp5pPC8C0WMFYh82iXmIdF/djPSag8bDFCxG8RtqfFR
 qXmelG9xIk/xIcOtRq0ZRS2mdXG94dl8g2u4R+qZIXk8lpcHT+bnAlVbVSbRgU85+aCT
 3Zt6HpTA/2mrk0Cuq51i13twzjegOPhQh3fMH3VitsUV4Fw3nQIFzfM3LWlkX+87sMs6
 +Fwx8oc0xHtWDvwJGDEqtPe/TkSEvsMCtO0Wh3WBQkXRlXz8G1USkPNbjcWg7wPm/z56
 U5h30QNiPoHlpKuD7MRd9jXr8QGezDGPY/w0QcokTnIdx8IA/3rJAvGUuMwkkOE1E8ox
 btBw==
X-Gm-Message-State: APjAAAXktqhr5UBpMtJU7umDmJTa8iTKc38t4msTmy8+u3B0ZzU6tSqh
 IjBMVY+p5sFi5smvxtLFDNWNF15U
X-Google-Smtp-Source: APXvYqy0+Z/Df+f5UODElEAxznRab9lfZd3vOVt7zCren6GH/llJXYnHgxBTaNX6i9lZeyVk11LoGQ==
X-Received: by 2002:a63:f14:: with SMTP id e20mr506002pgl.227.1562796116256;
 Wed, 10 Jul 2019 15:01:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id t17sm3301588pgg.48.2019.07.10.15.01.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 15:01:54 -0700 (PDT)
Date: Wed, 10 Jul 2019 15:01:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Message-ID: <20190710220153.GA10826@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::430
Subject: [Qemu-devel] Problems building and installing qemu v4.1.0-rc1 in
 single step
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

Hi,

when trying to run "make -j30 install" from a clean tree on v4.1.0-rc0, I get
_lots_ of undefined symbol errors.

If I run "make -j30" followed by "make -j30 install", make succeeds, but then
I get linker errors such as the following when running "make -j30 install".

/usr/bin/ld: final link failed: File truncated
/usr/bin/ld: BFD (GNU Binutils for Ubuntu) 2.26.1 internal error,
	aborting at ../../bfd/merge.c:905 in _bfd_merged_section_offset

Running "make -j30" followed by "make install" succeeds.

This looks like "make install" may have bad dependencies. Has anyone else
experienced this problem ?

Thanks,
Guenter

