Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE7BC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E1A208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E1A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hst1n-0007aQ-U9
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45366)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hssym-00019G-2z
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hssyk-0000lu-3N
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:05:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51157)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hssyi-0000d0-8H
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:05:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so61813940wml.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 11:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UgnI+V+V0KcIN0Z0K7//jHFR4SI9Ej9KKZBxvHuiULc=;
 b=GtGqcEw8YUYhy6TNq5OIYtc8cUnP0yIEnYXUx8+BNVaJ9CJlTG6r03USPDa4eH2Uas
 79JIOY6IbxflSQQFi3LXKplaTJfvqeDIZ5bGPdPV1zsoTEb0i8a3yRTS8xT4DXvyjr3E
 /7q9VENkhEIwWbLFfPkPF3WNgOZ3KdHlUauAb7nOFi/bMOG3hiSX2ICebK3PwCBqpmIT
 hRNwJh2OvpeD0e16KqjCVOTz/eSdWxwJekI0WlY2pEOK0EhpL4nNSGuBPLTQ/BZ1N8o+
 1tHe2NXtajVZ3bGBbW7ywKPNuNgr38biQSxUTneosjy+peqkST3gNVJCrvsxnXUk+0/Q
 ya1g==
X-Gm-Message-State: APjAAAU+3qstkbNu34M3m9NxXko31Z6eIka39ZKPLmmIFoLnlERUXgk6
 C/368GVdyUAYlhC25A5CzY6NAg==
X-Google-Smtp-Source: APXvYqyI/ALfezU7gJBIhJ4WCgY4qLnBrzsg0GfkxQq9u76XUl7wRM1gd+KNCoFQzfG6b6zXAZtUfQ==
X-Received: by 2002:a1c:be19:: with SMTP id o25mr26918538wmf.54.1564596324309; 
 Wed, 31 Jul 2019 11:05:24 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id o4sm53444111wmh.35.2019.07.31.11.05.23
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 11:05:23 -0700 (PDT)
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, Samuel Thibault <samuel.thibault@gnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <156452993884.16169.12168229409049273970@sif>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3c6ebc55-9416-a467-cfbe-73d2df6a64f2@redhat.com>
Date: Wed, 31 Jul 2019 20:05:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156452993884.16169.12168229409049273970@sif>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 4.1.0-rc3 is now available
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

>   Unless there are any release critical bugs discovered, this
>   will be the last release candidate before final release of 4.1.0
>   on the 6th August. Otherwise we'll do an rc4 and release on
>   the 13th August.

We forgot to update the slirp submodule :(

Does that mean we need a rc4?

Thanks,

Phil.

