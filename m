Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9DEC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41EC214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41EC214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58474 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfiff-0008Tm-Vh
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36978)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hfidj-0006xd-SQ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hfidh-0007ke-NC
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:25:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hfidf-0007VV-Bv
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:25:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so17208839wrt.6
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 03:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cRW/B6l0zuoihNMudRH8YLzYP9RD4w+Xh/wnNK0rRL0=;
 b=JCWzfhu8DPT6kLbjhrtyGi+GFYWSROV4LsdnZhATs5q3DCGSE+Eld9HTVn1jXyXZSG
 w2oHEiKNo1wZgmOl10e1rUjkphN9gISwq3dAUdA4i8awRzAIVrfpVHKuQVcnEdwcSnxT
 sToZiMNRnjRkBSm2Utvb3+6PYAeihdE+Nt7s6cBAMmx+SbOFu2HvBM2oywNtzOJJ2N6D
 YoBFEXGkLHgzpLMYFW682VSi4aIfpDgxbYGXoBO2pVhUhiTBqbYTFXOB2WGeCB1cn0wz
 zgY9KTG9o0GS6uIk1GmBhvT9/0187st1vOtuq66r/vfEkQo8PuwVVXkEBRQ6XBCS4EHR
 EYTA==
X-Gm-Message-State: APjAAAWjHunT+m195pSZ/Jwnfs9ZyKRCx+ASfrjBvqJaqtsQmtkDNE8U
 ZkmmgVXQ2NXaqxrHdDdgmePADQ==
X-Google-Smtp-Source: APXvYqydfSoe31v8avgdb0lAgmMhmO3zK26dew8Pn8HtpMzwlJp4V7sXrHJ2P3/zuMzmceZ2W+fcxQ==
X-Received: by 2002:adf:f948:: with SMTP id q8mr15760383wrr.196.1561458309780; 
 Tue, 25 Jun 2019 03:25:09 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id x20sm23099095wrg.52.2019.06.25.03.25.09
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 03:25:09 -0700 (PDT)
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
References: <20190624180139.GA17161@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f61a2457-e8f2-0363-e793-dffa6880dd32@redhat.com>
Date: Tue, 25 Jun 2019 12:25:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624180139.GA17161@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] qemu-system-x86_64: hw/usb/core.c:720: usb_ep_get:
 Assertion `dev != NULL' failed
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing more people.

On 6/24/19 8:01 PM, Guenter Roeck wrote:
> Hi,
> 
> I have seen the following problem several times recently. This is with qemu-4.0.
> 
> qemu-system-x86_64: hw/usb/core.c:720: usb_ep_get: Assertion `dev != NULL' failed
> 
> Backtrace gives me the following call path.
> 
> main_loop()
>   main_loop_wait()
>     glib_pollfds_poll()
>       aio_ctx_dispatch()
> 	aio_dispatch()
> 	  aio_bh_poll()
>             ehci_work_bh()
>               ehci_advance_async_state()
>                 ehci_advance_state()
>                   ehci_execute()
>                     usb_ep_get()
> 
> The problem always happens during shutdown, maybe once every 100 boots.
> It seems to be more likely to happen when the system is under heavy load.
> 
> ...
> umount: devtmpfs busy - remounted read-only
> [   49.018682] EXT4-fs (sda): re-mounted. Opts: (null)
> [   49.028052] sd 6:0:0:0: [sda] Synchronizing SCSI cache
> qemu-system-x86_64: hw/usb/core.c:733: usb_ep_get: Assertion `dev != NULL' failed.
> 
> Essentially that means that p->queue->dev is NULL in ehci_execute().
> 
> Has anyone else seen this problem ? Any idea what I can do to debug
> this further ?
> 
> Thanks,
> Guenter
> 

