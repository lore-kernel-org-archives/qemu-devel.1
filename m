Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E44C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554E720836
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4ySS+E7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554E720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZDcE-0006dg-Cb
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 07:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZDaL-00054N-CV
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZDaJ-0005ve-CM
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:35:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27021
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZDaI-0005uE-En
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574685317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=agVfGbXbL7zaFxifhPKARr69VWdpwfMWVkda24kLoSM=;
 b=f4ySS+E7p2AyuJv3J1Uuqne8QY9J66H7+BonvTrj+arqseKykqkMLJwJKtA/nF4LjRj3Kv
 wMnXm3F3youWpGdVBd5Am0wWb72hP+pbxeGVSeLE68QcMQ8aAHe2MAIevLpLfRnbnSFsuQ
 RaJhgpj18NOloRBLjV11pL+0blV4G00=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-AbXcBJLjOxqBXCdyFg_RJg-1; Mon, 25 Nov 2019 07:35:16 -0500
Received: by mail-wr1-f70.google.com with SMTP id c6so8696261wrm.18
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 04:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=Dp2AcgTFAY76z1cVoMVr7hXhJDaDfbhUEB3qzhGxSHQ=;
 b=hlP6jOaDCxFSTkeGSmZdPtmKhhz9TfJ0gPnj0PB7kCua/3QAnRAYk7DvIkC+3cZUC7
 J8PvsBrGuOvMeKrB9zG49AWAYRqwWoCTgRSRTzIA+9Qd+3zpHi+s+lKqpn2KlKa/4VsN
 BRxslEfG/sX/QkI88bcJ2Jl/3jygKkVr7uLYaT90jRKDWHM4xeS5ZQQD2rax89HIfk0b
 N2kMsmKeUsS2GEsUzyeCh9tzAC90Sfij1EKz0xWDluOg0n/iMlt1DhQDknSIA6I9EWLa
 cFTf3TTwWxgHbrVf6zNo1YwdMLnFUD0ehjRoHWggZAnG/qNzFzsKxpaC3eWEoYhS32mJ
 1ekA==
X-Gm-Message-State: APjAAAVm10F3C2kIq3dnadFLQC6DLCDD8kn8y5fX2b0bfOl8a+Q0Dp/7
 og8YWBPc8kPxl8Nwq7h52+j7+bPpT0sFXanG4zBcbnKf3FkloQlR8Yq7ZOHgOxiHto9tqEaL7Qy
 +o8426jHQa5dIf8Y=
X-Received: by 2002:adf:e488:: with SMTP id i8mr14473620wrm.37.1574685315122; 
 Mon, 25 Nov 2019 04:35:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqwpqFLLkw+MeGFQQSTrdUU+SUa/KEp2ZAgNEUxlpWb+H3NsOMVP1LXLsEX3ZclFqz/i2/exVw==
X-Received: by 2002:adf:e488:: with SMTP id i8mr14473595wrm.37.1574685314886; 
 Mon, 25 Nov 2019 04:35:14 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id l26sm8105471wmj.48.2019.11.25.04.35.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2019 04:35:14 -0800 (PST)
To: Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Subject: Avocado notes from KVM forum 2019
Message-ID: <9b3b2ff0-a3bb-c7ba-d7ce-d178e8fbd5d8@redhat.com>
Date: Mon, 25 Nov 2019 13:35:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Language: en-US
X-MC-Unique: AbXcBJLjOxqBXCdyFg_RJg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: avocado-devel@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cleber,

Here are my notes from talking about Avocado with various people during=20
the KVM forum in Lyon last month.

All comments are QEMU oriented.


1) Working offline

Various people complained Avocado requires online access, and they would=20
like to use it offline.

   Maintainer workflow example is:

   - run avocado
   - hack QEMU, build
   - git pull
   - build
   - hack QEMU
   (go offline)
   - hack QEMU
   - build
   - run avocado <- FAILS

Failure is because mainstream added new tests, which got pulled in, and=20
the user only notice when running avocado again, but offline.
Test example is boot_linux_console.py, which added various tests from=20
other subsystems, so the maintainer has to disable the new tests=20
manually to be able to run his previous tests.

Expected solution: skip tests when artifact is not available, eventually=20
when the --offline option is used


2) Add artifacts manually to the cache

Not all artifacts can be easily downloadable, some are public but=20
require the user to accept an End User License Agreement.
Users would like to share their tests with the documentation about=20
where/how to download the requisite files (accepting the EULA) to run=20
the tests.


2b) Add reference to artifact to the cache

Group of users might share group of files (like NFS storage) and would=20
like to use directly their remote read-only files, instead of copying it=20
to their home directory.


3) Provide qemu/avocado-qemu Python packages

The mainstream project uses Avocado to test QEMU. Others projects use=20
QEMU to test their code, and would like to automatize that using=20
Avocado. They usually not rebuild QEMU but use a stable binary from=20
distributions. The python classes are not available, so they have to=20
clone QEMU to use Avocado (I guess they only need 5 python files).
When running on Continuous Integration, this is overkill, because when=20
you clone QEMU you also clone various other submodules.


4) Warn the user when Avocado is too old for the tests

Some users tried Avocado following the examples on the mailing list and=20
the one in some commit's descriptions where we simply show "avocado run=20
...". They installed the distribution Avocado package and tried and it=20
fails for few of them with no obvious reason (the .log file is hard to=20
read when you are not custom to). IIUC their distribution provides a=20
older Avocado (69?) while we use recent features (72).

We never noticed it because we use 'make check-venv' and do not test the=20
distrib Avocado. While we can not test all distribs, we could add a=20
version test if the Avocado version is too old, display a friendly=20
message to the console (not the logfile).


That it for my notes.

Eduardo/Wainer, are there other topics I forgot?


Regards,

Phil.


