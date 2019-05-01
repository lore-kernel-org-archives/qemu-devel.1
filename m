Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922B1C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64ECD208C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64ECD208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60981 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLr3w-0002fU-Nj
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 11:22:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLr31-0002GL-8p
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLr2x-0007IF-Os
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:21:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLr2x-0007HU-JQ
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:21:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id e9so400062wrc.1
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=sBs20C05q7Q4dXs5W3ZxCu8LQI6WkJBlf/BuMXV4l7U=;
	b=rrjbhaiHr1pL3CsAegX+wN6oigJt8XfrsrheXhSD50a2BRDNKruK4YcZZw533l1jOS
	RhzPI8Gm7qx3fOHSY1qs7r92rANukn3aihFwYxTXpG/IdFV86Ok+vD+jDYfWSZmIcd1C
	24IMaCpxGeWk2v46x4+umq7sy6NnivdqrN4yM2NKDUmdvxNiCjb9ukn+SFzFD6A80OD3
	n/+Zehe+rgHZD16/bIAC25RUtFe/mrXpQ/qZ1nFSG7g9SyTyy0lXZ8Qwmz3VchFrrld2
	q5WR2u8XN91AH/HF/Uw9COjWUYtVCkgAQuFtqYI2w0f+Zt+gjtzvvaCzWO7mdR+BhqHd
	/T3Q==
X-Gm-Message-State: APjAAAVt7qTwzmOXlou6AhhUxS84sQ+DB9+M4kaQp6/Dt+j2CVOZGuTn
	+d9MJK/qRO4WNANPwKgCP2DxdQ==
X-Google-Smtp-Source: APXvYqxtEk0zhywY8z7NRjfcTz9EAXK4PySquk7UaUMt5G66ZiFA7p15NiAj1xlWgt0sYqjuXNGDjQ==
X-Received: by 2002:a05:6000:c2:: with SMTP id
	q2mr11346983wrx.324.1556724082674; 
	Wed, 01 May 2019 08:21:22 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	c131sm5754821wma.31.2019.05.01.08.21.21
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 08:21:22 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<ff51c73e3095fa503d14aafece54f8565fe99900.1556666645.git.alistair.francis@wdc.com>
	<0d585793-20a8-8dc8-98fa-13789113f672@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9abcc3db-0749-e092-ab59-8144de027ba6@redhat.com>
Date: Wed, 1 May 2019 17:21:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0d585793-20a8-8dc8-98fa-13789113f672@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 2/5] hw/usb/hcd-xhci: Fix GCC 9 build
 warning
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"laurent@vivier.eu" <laurent@vivier.eu>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501152121.Qryjq5akku8Wie_ozlF1lsnTFdicu49Oq-EhhjwbwwY@z>

On 5/1/19 4:12 PM, Richard Henderson wrote:
> On 4/30/19 4:28 PM, Alistair Francis wrote:
>>      for (i = 0; i < usbports; i++) {
>> +        g_assert(i < MAX(MAXPORTS_2, MAXPORTS_3));
> 
> I would hope that it works to move this out of the loop:
> 
>   g_assert(usbports <= MAX(MAXPORTS_2, MAXPORTS_3));

With Richard suggestion:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

