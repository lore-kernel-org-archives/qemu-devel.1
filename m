Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD28C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599432084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599432084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45739 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWwn-00072m-Ac
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 06:28:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWrw-0002Xe-5X
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWkT-0001IS-Ob
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:16:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWkT-0001IB-Dn
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:16:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so6590526wrd.3
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 03:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=d3NOtjxHER99BInKn/txR6jRHb13DjNXBrQBXYCwe9Q=;
	b=Acf6ZV3xq9oP7UdUh6ki/7SZL6YpqCwVfdzua2gmreAeYop7nS7i1shvWA8pNZV5zZ
	8zMZyBKOvV8JwLR7NICWfML+563GUbOekdfjR3CUJciwS9ftUuGcZhvSFMPVR8onnBe5
	i3sGJZkAw7tm+SSoe/Sptfdd1asvSNUjEgoFqmUisc+9SrodCG9DlOxg7BQfva8wbsTO
	9PrVrIrZ0ifNrLS6VdAj15GiBxBT77/cos710/r4/t1CWYFCLitRjBz9+ycD461yxzsg
	nnMxqroCZw0coruGNX13qnr53AEVdBrFjteTHGDsE0UAhUGyRZ53d5kAOq0Tf38L7JyZ
	ycvg==
X-Gm-Message-State: APjAAAUZVbPW08nE3eED+x1f4O+OxU3Md0g8pQtwhiUrM3r5xbTOQNpR
	h+uMsP5daGqD2afTrB+10SARMw==
X-Google-Smtp-Source: APXvYqy5JkKAUNWTMlsCFqoIdyEEyMLUsP0Dlm/XJDoxxMw15piqdnhelLE3FnDPk61imLdDNHYKQA==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr31108154wrl.26.1554977760396; 
	Thu, 11 Apr 2019 03:16:00 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	a126sm4194044wmh.4.2019.04.11.03.15.59
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 03:15:59 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190325090047.122981-1-ysato@users.sourceforge.jp>
	<20190401140318.80498-1-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <655a45ed-cd6b-b8d8-72fa-d4ebca3dcd1a@redhat.com>
Date: Thu, 11 Apr 2019 12:15:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401140318.80498-1-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH RFC v6 00/12] Add RX archtecture support
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411101559.XG4ypwYtCBlAuDmYCd9bTR6yKW-xFRmd--uCGmTXO44@z>

Hi Yoshinori,

On 4/1/19 4:03 PM, Yoshinori Sato wrote:
> Hello.
> This patch series is added Renesas RX target emulation.
> 
> Update review comments.
> 
> My git repository is bellow.
> git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git
> 
> Testing binaries bellow.
> u-boot
> Download - https://osdn.net/users/ysato/pf/qemu/dl/u-boot.bin.gz
> 
> starting
> $ gzip -d u-boot.bin.gz
> $ qemu-system-rx -bios u-boot.bin
> 
> linux and pico-root (only sash)
> Download - https://osdn.net/users/ysato/pf/qemu/dl/zImage (kernel)
>            https://osdn.net/users/ysato/pf/qemu/dl/rx-qemu.dtb (DeviceTree)
> 
> starting
> $ qemu-system-rx -kernel zImage -dtb rx-qemu.dtb -append "earlycon"
> 
> Changes v5.
> Fix undocumented instruction behavior.
> (PUSHM/POPM/RTSD/MVFC/MVTC)
> More useful messages for invalid operands.
[...]
Please don't post your series iterations are as reply to previous
series, it makes harder to find them.

FYI I use Thunderbird as email client, with mails grouped by thread.
Since you sent v4 as reply to v3, and similar v5 -> v4 and this v6 ->
v5, my client kept all subsequent activity folded under the "v3" cover.
Then I missed to review it.

Regards,

Phil.

