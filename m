Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA6CC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ACA62082F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay698HX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACA62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1x39-0004Vc-7g
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 13:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j1x2G-0003zk-1D
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j1x2E-0005pV-HZ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:46:55 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j1x2E-0005oq-BU; Wed, 12 Feb 2020 13:46:54 -0500
Received: by mail-pf1-x441.google.com with SMTP id n7so1680603pfn.0;
 Wed, 12 Feb 2020 10:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=22sSFhbdsV1ZQo5hM/tLUFsL0nUT6G4An3xw/2y359A=;
 b=Ay698HX8RLMebhZAYFwIIssr2H6lkl0lqXbe8hN0pQpvHkQ6bx3AesBAZm8N4UKMcz
 XW/M8ccCmx6S7t6nXS/69I7BXSc/zDuYKmJIOYGQYqPPG8LVLatJdWFhMeZRpbhdeq0h
 g2ZhWAhZE5sA/VHCjxq87AN0tMYKnLdzj8kehCFf3ryrCg+3A06ngU+E2Mj3pRgpyCw7
 6HkBU1XO7KXWsIF/TqzeGk/1lpFMIo6DFHCZh73bTlNTdMsL/pdzWimmgOJIMqLqorOP
 YoC3RkXZVbjWSwYLigtMzgHS+IgjgKchT+Ll7tU90+dYQJ+8oaPq55MIG9Y3vGvqskOR
 g4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :mime-version:content-disposition:user-agent;
 bh=22sSFhbdsV1ZQo5hM/tLUFsL0nUT6G4An3xw/2y359A=;
 b=Y+JQrK8mocvORle045LZ4QpU7kzq6RlFC5ISpnvKYUALPLwn/BgxYu2Cdq1TGzCrPJ
 a7VWmBtAIrbcvmdHRbfZsEeH1gGyAv6B9/V76ULe/Xh0Tqg0XQB18ppiSLxPNj8PL6x+
 UbPfjlVuHTUFIvRRfHqKaV3j8exgD9yt2jqr+Ya47ngdIoO0ASmbe9NH6rgPW7oJUP+C
 +sEmUVXrBQnsTlbgXVtsgJyMosLo9oT/5uiLgTfVP+u4vliLvHFS4ki6K3YIOwWzM7qr
 eReyS5vQM0nVW79/yNrX91aOCCQQxSyg7bBEqZRaRX2T+2Y+RlTPhSUQFCBhdczEvSmY
 6zFg==
X-Gm-Message-State: APjAAAXuPOB5SKhdAH7weoFYEsUitPJvJNdk5pso4g3Y4o0VFOUyVV80
 PVYxhtLA8IcyCTj+i0oWvvvvEfsj
X-Google-Smtp-Source: APXvYqzKLm63EvPDtFCEQd2vIrtuCVzUnNukcVgJ5oIzMn4y+Zq+82DK9h7qdiX36n3fkfjV3s/9pA==
X-Received: by 2002:a63:e509:: with SMTP id r9mr8412061pgh.274.1581533211534; 
 Wed, 12 Feb 2020 10:46:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id d22sm1585601pfo.187.2020.02.12.10.46.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Feb 2020 10:46:50 -0800 (PST)
Date: Wed, 12 Feb 2020 10:46:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Subject: Question about (and problem with) pflash data access
Message-ID: <20200212184648.GA584@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I have been playing with pflash recently. For the most part it works,
but I do have an odd problem when trying to instantiate pflash on sx1.

My data file looks as follows.

0000000 0001 0000 aaaa aaaa 5555 5555 0000 0000
0000020 0000 0000 0000 0000 0000 0000 0000 0000
*
0002000 0002 0000 aaaa aaaa 5555 5555 0000 0000
0002020 0000 0000 0000 0000 0000 0000 0000 0000
*
0004000 0003 0000 aaaa aaaa 5555 5555 0000 0000
0004020 0000 0000 0000 0000 0000 0000 0000 0000
...

In the sx1 machine, this becomes:

0000000 6001 0000 aaaa aaaa 5555 5555 0000 0000
0000020 0000 0000 0000 0000 0000 0000 0000 0000
*
0002000 6002 0000 aaaa aaaa 5555 5555 0000 0000
0002020 0000 0000 0000 0000 0000 0000 0000 0000
*
0004000 6003 0000 aaaa aaaa 5555 5555 0000 0000
0004020 0000 0000 0000 0000 0000 0000 0000 0000
*
...

pflash is instantiated with "-drive file=flash.32M.test,format=raw,if=pflash".

I don't have much success with pflash tracing - data accesses don't
show up there.

I did find a number of problems with the sx1 emulation, but I have no clue
what is going on with pflash. As far as I can see pflash works fine on
other machines. Can someone give me a hint what to look out for ?

Thanks,
Guenter

