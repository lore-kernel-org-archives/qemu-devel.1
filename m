Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DB9C31E47
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 05:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69082084B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 05:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69082084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58848 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hc1Ux-00084I-7G
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 01:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54939)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hc1Te-0007P3-0x
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 01:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hc1Td-0002Sv-5M
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 01:43:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hc1Tc-0002Qv-WE
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 01:43:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so4569154wrr.4
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 22:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v5uGUGq9ev6R+H4vzK2nrBhCNgR8tvot74Yt1F50TKo=;
 b=puOIwFt81dluXE2aUQAyZJixErt05YB/+7bohXeCGp8vxpbZMCeT3+N4tl/3QjRZAJ
 QyMarTwuf8sryfG8YcOTHB/JC34QwVdE0xvibijfXElTANKboGXFBZfhryWnpSSIbolY
 NqFEoBlKbhtxr6CIBwXHkpXZQsQZDdSVGY2fyj0atxfDtEvR5aNEyw1zRz3iohNNG+EV
 sYj+41bXaNHdnT87FAO5QprldIhEp59TCRH7YIZXOgwRwOHr6yBIw3HRyd58q9q8yY1a
 iwM14G+yymf9pmRYqESZQMhfkZaneqS+dZlG7hvdbggUDWM+LBDIz6LKy3/jKKCUzYQF
 pocQ==
X-Gm-Message-State: APjAAAXJ8OiQUuL7z/uZou6zoYbTgJ5DMlPKtNUb9g01bTZXyTZsR14O
 dKgtH+WiSFL3lRu5yTue36kIzw==
X-Google-Smtp-Source: APXvYqz6oVdYa21FoxChzcAe92WyeRLlJbKETDN0V04FIGKVwpstsR9id2zDYQjzPZTBe0JzAfG6qw==
X-Received: by 2002:a05:6000:d1:: with SMTP id
 q17mr14935061wrx.40.1560577422214; 
 Fri, 14 Jun 2019 22:43:42 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id 34sm4892657wre.32.2019.06.14.22.43.41
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 22:43:41 -0700 (PDT)
To: Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>
References: <155912548463.2019004.3515830305299809902.stgit@bahia.lan>
 <20190529125926.GD2126@perard.uk.xensource.com>
 <20190605121056.0e784daf@bahia.lab.toulouse-stg.fr.ibm.com>
 <c85d973ca2d444678e8fdc86a4cd6f4f@AMSPEX02CL03.citrite.net>
 <20190614101621.098742e2@bahia.lan>
 <c2c63dd46c684b1bb0f2e342a085d93d@AMSPEX02CL03.citrite.net>
 <alpine.DEB.2.21.1906140844150.2072@sstabellini-ThinkPad-T480s>
 <20190614185054.6f12ab30@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b40f16eb-5ae5-4b36-e0a8-02b10c3b7769@redhat.com>
Date: Sat, 15 Jun 2019 07:43:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190614185054.6f12ab30@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Change maintership of Xen
 code under hw/9pfs
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Paul Durrant <Paul.Durrant@citrix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-trivial@

On 6/14/19 6:50 PM, Greg Kurz wrote:
[...]
> Markus, Xen maintainers,
> 
> All needed Acked-by have been provided. I don't plan to send a 9pfs PR
> anytime soon. Can this go through someone else's tree please ?
> 
> Cheers,
> 
> --
> Greg
> 

