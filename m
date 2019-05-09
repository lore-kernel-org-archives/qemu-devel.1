Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26E4C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6FB021479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FB021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51790 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOg0U-0002b6-Tk
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 06:10:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOfzY-0002C9-8g
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOfzX-0001l6-Az
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:09:32 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:55485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOfzX-0001ki-4e
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:09:31 -0400
Received: by mail-wm1-f50.google.com with SMTP id y2so2472612wmi.5
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 03:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=3BicAukpMKaKuEWZ1ijQDw/rRr87otZDmaqoSFNoo/g=;
	b=Y76VEMVbSf/sDKnEPZ8LUd1OVRkRWOqt4HNVuwu1aOn20/KO9u9sFfaJYseV5pSI/B
	IkPMGl7St05t3VppN1ZQWxq8h/nscclIFB8R13iax/3mCmdF/XIqmzLf8/LLHueqNPxM
	6L7HcTJ/AXBGMqUZWafsGofs7BrpsP8OpPBavPCXkWudPlUzevgZkyXvQ+U1G9M8r6bd
	uyJ59llMkOtKj44BJUeaW2rpX2NMdWXgJU7SuGjeQ4f1GnTCpmTiXBrZahxENT0b+AOl
	ogdiHZezFEfSIwDwthgE8rIUpgaUUwm6mGAH/XNT9O9KlJa8q0CPzXpDEDRlWeMsabQD
	OSKw==
X-Gm-Message-State: APjAAAVX9fjf9oJTgRZ6D7u2ogrfXZSG2LG1XJ5Q7z4BgV/FCcpDYIMu
	HJcfBhutCvwXxf2/xCjADOc6Ww==
X-Google-Smtp-Source: APXvYqzA+NvhSavVykjoxpahuiAtzHmZLHsSVOJv763cam9Nv6v4/P9WYg0vBc2h2TkpB+EB1zb4pg==
X-Received: by 2002:a1c:24c2:: with SMTP id k185mr2247244wmk.115.1557396570075;
	Thu, 09 May 2019 03:09:30 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	c11sm1144234wrs.86.2019.05.09.03.09.28
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 03:09:29 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
References: <20190508150608.3311-1-thuth@redhat.com>
	<6cb2ea74-b3f8-09f3-90cb-e3b8344e67bd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7e7f01a6-f5a6-52bf-d4ce-c183257b0c72@redhat.com>
Date: Thu, 9 May 2019 12:09:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6cb2ea74-b3f8-09f3-90cb-e3b8344e67bd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.50
Subject: Re: [Qemu-devel] [PATCH] include/exec/poison: Mark TARGET_FMT_lu as
 poisoned, too
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 11:10 AM, Paolo Bonzini wrote:
> On 08/05/19 10:06, Thomas Huth wrote:
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  include/exec/poison.h | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Queued, thanks.

Thomas already included it in his "qtests, copyright statement
clarifications and misc patches" pull request.

