Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E46C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:28:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF392173E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=precibake-com.20150623.gappssmtp.com header.i=@precibake-com.20150623.gappssmtp.com header.b="Nnc1HpME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF392173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=precibake.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Aiy-0007Lo-Tj
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <c.heinze@precibake.com>) id 1i5AKB-0005Jx-KR
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <c.heinze@precibake.com>) id 1i5AKA-0001O9-51
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:02:27 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:33577)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <c.heinze@precibake.com>)
 id 1i5AK9-0001Lz-N9
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:02:26 -0400
Received: by mail-pg1-x52f.google.com with SMTP id n190so9311287pgn.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=precibake-com.20150623.gappssmtp.com; s=20150623;
 h=to:from:openpgp:autocrypt:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=wkB67aSsrrMIio9RYlk9q0HWTGI7lt5NgVJbPKzLE54=;
 b=Nnc1HpMEOH0jbhg21vAc4j+jCWYa/xSQaJoVG9hWeXTnbrtPL3aKS02ByNQ5mlzg3V
 2MiaM4kTsFjVld5U1kSMIwTgXyiHVHYpoMukBk+NEE5qNVd+lG86BQvMiFcXh+dTb5Lp
 tkWdMnFFza/NVGMNFoHnPN9ryVUQcaeKQ1/7DmspM1gEDxJTDlZYTLlar/6f1ziPz30S
 tWJTH0C0p7zqFLAX5r7lW/PYdG884RFfpPCrWdxgC8ZXBxjS+gbvqamI2Ox+41l1HdG9
 GLbirHxqFnZ6kJA3K5TGIdo5N7J5xHt7dibnmJC2C8f8ap1lIj6LmXXoOtICwjOvC1Hs
 xn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:openpgp:autocrypt:subject:message-id
 :date:user-agent:mime-version:content-language
 :content-transfer-encoding;
 bh=wkB67aSsrrMIio9RYlk9q0HWTGI7lt5NgVJbPKzLE54=;
 b=AYhGIHW1ybDzRKDXZX2rQJBC6ZQ8wQbSZccvawj893/yvdn4b8u3lo8V8v73jS9LKR
 OBZTK5NdgXtLQPqjP6cby5vR3G3WRqZKSg/niGHN+YAjndcVLz4ONML2cg8qyr+WkM3s
 Ix0eB1RuPY7bIKNzSvQF3gQMWCe1Kuv0SPLReflugsOeHRIM47PgnalrC5revZOmR8bf
 27ci5//e+k1M7V19ztdBf+AKk+C2s1HaPJgVqP7PmjCn4KKiz/n3tFtFHrGp1G5LEjpq
 330fH+YeLuKdYDiwJu4gCLJi/jpidLMWpoUqoouzC6VHVaLwZ3kIn5eGDVYvR9bKH9sR
 MhdA==
X-Gm-Message-State: APjAAAW1e2hznatZLXatpsyfIdEpgu4Nlj75XbSQL1/VQkxD9jxtDu+N
 NCLjRVT+a7t2pwiyefZT+PrlgyQrbWEKYmck
X-Google-Smtp-Source: APXvYqyzQuUwLFl1mwF7wXmeErrYZORQ5eg1SqMGMd+T9eY5pC2cHeBnsfzlHsldXzRixilUV+1sYw==
X-Received: by 2002:aa7:8005:: with SMTP id j5mr2242624pfi.50.1567522942241;
 Tue, 03 Sep 2019 08:02:22 -0700 (PDT)
Received: from [0.0.0.0] (62-210-37-82.rev.poneytelecom.eu. [62.210.37.82])
 by smtp.gmail.com with ESMTPSA id em21sm2665294pjb.31.2019.09.03.08.02.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Sep 2019 08:02:21 -0700 (PDT)
To: qemu-devel@nongnu.org
From: Chris Heinze <c.heinze@precibake.com>
Openpgp: preference=signencrypt
Autocrypt: addr=c.heinze@precibake.com; prefer-encrypt=mutual; keydata=
 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 FA==
Message-ID: <0115e29c-2254-09c3-13d5-6dfb5307d968@precibake.com>
Date: Tue, 3 Sep 2019 17:02:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52f
X-Mailman-Approved-At: Tue, 03 Sep 2019 11:27:12 -0400
Subject: [Qemu-devel] slirp, incoming packets get truncated
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

with slirp, incoming packets to the guest get truncated (outgoing seem to work correctly).

this has been observed on a x86_64 machine with devuan2 and qemu 4.1.0.

e.g. on the host:
root@host:~# qemu-system-x86_64 -net nic,model=virtio -net user,hostfwd=udp::19003-:19003
root@host:~# head -c 9000 /dev/zero | nc -u 127.0.0.1 19003

on the guest:
root@guest:~# tcpdump -ni eth0 port 19003
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
16:49:39.430959 IP 10.0.2.2.33294 > 10.0.2.15.19003: UDP, bad length 9000 > 1472

these packets obviously are truncated to 1472 bytes.

i tried to change slirp/src/if.h to: 

#define IF_MTU 9000
#define IF_MRU 9000

but the resulting qemu-system-x86_64 binary did not behave differently.

-- 

Mit freundlichen Grüßen / Kind regards,

Chris Heinze
*Network-/System-/DevOps-Engineer*

*PreciBake GmbH*
Gollierstr. 70
80339 München
Deutschland / Germany
*P:* +49-(0)-89-2154895-30 <+49.89.2154895.30>
*F:* +49-(0)-89-2154895-99
*E:* c.heinze@precibake.com
*W:* www.precibake.com

<http://www.precibake.com/>

Handelsregister / Commercial Register:
Amtsgericht München, HRB 206356
Steuer-Nr. / Tax-ID143/172/11644
Umsatzsteuer-ID / VAT registration number: DE290040302
Geschäftsführer / Managing Director: Dr. Ingo Stork-Wersborg

Der Inhalt dieser E-Mail ist ausschliesslich fuer den/die bezeichneten Empfaenger bestimmt. Wenn Sie nicht der vorgesehene Adressat dieser E-Mail oder dessen Vertreter sein sollten, so beachten Sie bitte, dass jede Form der Kenntnisnahme, Veroeffentlichung, Vervielfaeltigung oder Weitergabe des Inhalts dieser E-Mail unzulaessig ist. Wir bitten Sie, sich in diesem Fall mit dem Absender der E-Mail in Verbindung zu setzen. Wir moechten Sie ausserdem darauf hinweisen, dass die Kommunikation per E-Mail ueber das Internet unsicher ist, da fuer unberechtigte Dritte grundsaetzlich die Moeglichkeit der Kenntnisnahme und Manipulation besteht.
The information contained in this email is intended solely for the recipient(s). Access to this email by anyone else is unauthorized. If you are not the intended recipient, any form of disclosure, reproduction, distribution or any action taken or refrained from in reliance on it, is prohibited. Please notify the sender of this email immediately. We also like to inform you that communication via email over the internet is insecure because third parties may have the possibility to access and manipulate emails.

