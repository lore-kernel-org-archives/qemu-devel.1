Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9621EC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E162070C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=precibake-com.20150623.gappssmtp.com header.i=@precibake-com.20150623.gappssmtp.com header.b="rxnSNewp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E162070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=precibake.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Btt-0003um-FY
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 06:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <c.heinze@precibake.com>) id 1i6Bsw-0003Qf-3b
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:54:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <c.heinze@precibake.com>) id 1i6Bsu-00051h-M8
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:54:34 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50493)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <c.heinze@precibake.com>)
 id 1i6Bsu-0004yS-6I
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:54:32 -0400
Received: by mail-wm1-x344.google.com with SMTP id c10so6039665wmc.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 03:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=precibake-com.20150623.gappssmtp.com; s=20150623;
 h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LILxCiW4z/XIK1pa48bID8PYQbFIbme4o6KbSX2dmKg=;
 b=rxnSNewpGg8qV22A9o4JEcszziAx6mdBVZLknvusHTd6KWqljUesAcE1S0TSHp5QCj
 JSrndVtzUD8HKHIzHp5bWEZNqsPhcsjG+wh05DDmNcbnuELYe2I5XM2d9cltWPrhFvQu
 Uuk6oK+SO1qRgH1b9i/Y63I6AEYKh6hbxLmaotO0XLB9N5WxqpjX2Sjn39XtPBOR0Jq/
 dgxvaADy8LRPZAj5IanGtddaVPh59d8O9cLHOh5pwxe0aRBE462zdSbsYbISCg3Jhyb/
 588vhNI+K4PEeEoGrKrQZyaRUfHtiEbHWl+YNuXIiC1y65BhbbZD23uPhjDrJi3IpmF+
 yhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=LILxCiW4z/XIK1pa48bID8PYQbFIbme4o6KbSX2dmKg=;
 b=L+fdRpX16ByYpzWhfjqNopixN0sOocAISeDeuMRTUwBtvl1VcxSKrJKwxRAx+dx2Nk
 W7u7nnelJSCjFw5kQDUfMz9q3rp+cwesVZkQFSLzFA6pdRaS9++Yp0U+jxeQj3augM9c
 urvYVJYuwC/lIO2E3apogVcU+bKxEorhKn/YWfa8a9p0GnY+1yl8u0CSzfr28oUtWFky
 pV4/H9BqGiztXIQkVF+cwkxU3t3AVWIqAy1bj7i2d18lqve3q2drd9IKIif2aRz2sMZq
 8p/Xbtr6WWkOqhz2/bSoUN8rgbQkrrWH0SrGNo0R1lZ3u5c7kgNfbyyo5EFsyppKJ75d
 WuOQ==
X-Gm-Message-State: APjAAAVT93hrkQi/QUexlltZ0zK6zoUP0gV01qif9JbJnfj62963z+6C
 +wOZbOC5SA6RQagVAHbPBt98YLVX8GII4ncK
X-Google-Smtp-Source: APXvYqwTUfkcE2egq3C713wTKCLet7Q3VbgwNgVLBnAgeMVCU4YxO+SdtnDrtY8p0stdvP1mOeXeKA==
X-Received: by 2002:a1c:1d8d:: with SMTP id d135mr7094553wmd.7.1567767268146; 
 Fri, 06 Sep 2019 03:54:28 -0700 (PDT)
Received: from [0.0.0.0] ([185.100.87.129])
 by smtp.gmail.com with ESMTPSA id v4sm8602955wrg.56.2019.09.06.03.54.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Sep 2019 03:54:27 -0700 (PDT)
To: Samuel Thibault <samuel.thibault@gnu.org>
References: <0115e29c-2254-09c3-13d5-6dfb5307d968@precibake.com>
 <20190906095905.44hrurx3vlbqidkq@function>
From: Chris Heinze <c.heinze@precibake.com>
Openpgp: preference=signencrypt
Autocrypt: addr=c.heinze@precibake.com; prefer-encrypt=mutual; keydata=
 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 FA==
Message-ID: <68838709-01f9-3bf6-ac5d-461e76a1585e@precibake.com>
Date: Fri, 6 Sep 2019 12:54:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190906095905.44hrurx3vlbqidkq@function>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] slirp, incoming packets get truncated
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hi,

On 9/6/19 11:59 AM, Samuel Thibault wrote:
[...]
>> 16:49:39.430959 IP 10.0.2.2.33294 > 10.0.2.15.19003: UDP, bad length 9000 > 1472
> 
> Just to be sure: did you configure your guest mru to 9000 ? Does the
> emulated network hardware card support jumbo frames?

hm! all interfaces (host and guest) are configured to a mtu of 9000 (except for lo which is always 64k). there's no serial/ppp involved, so i can not set a mru (for non-p2p links the 'mru' kindof should be the mtu of the respective other interface of traffic?). i found no way to configure slirp (in qemu) itself except for the DEFINEs in the if.h.
i tried all available nic-emulations, then continued with virtio, which is one that accepts the mtu settings (and sending jumbo frames out does work). the other nics where jumbo frames can be configured do not behave differently.
i'm not aware of any (canonical) parameters to set a max size for received packets - i guess when implementing an interface one could decide to truncate according to the mtu (but i guess i would not and i would also argue against it, i guess when i need a mru size for fixed receive-buffers (which i'd try to avoid) i'd assume the mtu). afaik even with ppp mru is just used to signal a max mtu to set to the peer.

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

