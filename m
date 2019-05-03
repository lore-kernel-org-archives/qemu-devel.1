Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563EEC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 09:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5942075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 09:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5942075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36873 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMU6t-0002e9-FE
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 05:04:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMU64-0002LX-7r
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMU61-0003tP-La
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:03:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMU61-0003sy-Fu
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:03:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id h11so5772722wmb.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 02:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=uBQiWz6rpQBcSl2W96tl+9ufhLU6KQjBt6e/Kbc0p4M=;
	b=oK+gLj9eaWEX+BAHECHc/Si5hpdNnJlGVVF4LXK2dUGyFbBQCDxG5Vnz65bB29FulW
	hYFb/km99zmNkncIZpU4T+5JciZLvV6uorLxR1x8hLzi+Xrck9+v0BQeG6FyN4c6j9bQ
	GFCMza+KLfzBfVGqBVW1RHR150ZkgPQ/j9X3pH6yR3cZug0BW/glFYAX9FuN6N5SIr3h
	Wc1NjlqGUu4Bvmmyr2N9YsHQ6PqcOQEoKjDcWHVTZhwlB8P25w/o3E9GOyKmLG6ibMFm
	4ueLpYzQ/5NVQu7vr/vvxhWUrAQLf7Bc7DZ7E2Do2+BvC+qaJYcEFilf3Gwv9VRL73YZ
	Sfbg==
X-Gm-Message-State: APjAAAVLTRZowY+k/emn5HmEB4Myay+MklbZoj8TnVIcPCXhXtGmZ+fv
	Njk20PV/WBf66YEiiz6f52g+LPUGTZ0=
X-Google-Smtp-Source: APXvYqwbhFgfMJdIIRq51gOQO65UhWGKpiUEp/VIf4dIVhl0tGmolo3s4hz6EyyS2Sp5S0jaXVAZ1g==
X-Received: by 2002:a1c:304:: with SMTP id 4mr3169766wmd.39.1556874187833;
	Fri, 03 May 2019 02:03:07 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id l21sm1412244wme.4.2019.05.03.02.03.07
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 02:03:07 -0700 (PDT)
To: Cao Jiaxi <driver1998@foxmail.com>, mdroth@linux.vnet.ibm.com
References: <20190503002258.9799-1-driver1998@foxmail.com>
	<20190503002556.9941-1-driver1998@foxmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1071188c-93a9-13ea-3b14-8312abc7162a@redhat.com>
Date: Fri, 3 May 2019 11:03:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503002556.9941-1-driver1998@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v3 2/4] qga: Fix mingw compilation warnings
 on enum conversion
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503090306.6O6_GV5UFXexJx8y4a7bywCnRXSphp7i1TePrNRLhCY@z>

On 5/3/19 2:25 AM, Cao Jiaxi wrote:
> The win2qemu[] is supposed to be the conversion table to convert between
> STORAGE_BUS_TYPE in Windows SDK and GuestDiskBusType in qga.
> 
> But it was incorrectly written that it forces to set a GuestDiskBusType
> value to STORAGE_BUS_TYPE, which generates an enum conversion warning in clang.
> 

Suggested-by: Eric Blake <eblake@redhat.com>

> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  qga/commands-win32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index d40d61f605..6b67f16faf 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -457,7 +457,7 @@ void qmp_guest_file_flush(int64_t handle, Error **errp)
>  
>  #ifdef CONFIG_QGA_NTDDSCSI
>  
> -static STORAGE_BUS_TYPE win2qemu[] = {
> +static GuestDiskBusType win2qemu[] = {
>      [BusTypeUnknown] = GUEST_DISK_BUS_TYPE_UNKNOWN,
>      [BusTypeScsi] = GUEST_DISK_BUS_TYPE_SCSI,
>      [BusTypeAtapi] = GUEST_DISK_BUS_TYPE_IDE,
> 

