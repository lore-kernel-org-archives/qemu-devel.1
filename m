Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF991C2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D071206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="it2YtPzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D071206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igpWA-0001yY-E5
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 07:30:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1igpVQ-00014E-Se
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:29:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1igpVN-00014S-3t
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:29:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60147
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1igpVM-0000zs-I2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576499379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XjSiUab06wBsS+0gRmDNAgPEVjCft+UYx6pkR1oStzM=;
 b=it2YtPzRLOfaqy718klSpP2JwnUuFGMQ5iNKG222bSREvxfFGFKz/5DSvVcOidGI6OSah8
 hznotinyvn9KmQqu1vhfoxyQyML14M/b+YPb1SxqQap344cTBwr5F1MczxjhAQwuNM34HM
 yIvqm/UyzpdlRsnpvpyoipPhCz4ulSw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-daYtpZsKOCa75E3YilwZJQ-1; Mon, 16 Dec 2019 07:29:36 -0500
Received: by mail-wm1-f72.google.com with SMTP id m133so972239wmf.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 04:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XjSiUab06wBsS+0gRmDNAgPEVjCft+UYx6pkR1oStzM=;
 b=Vzi042Je1S5+ivZFNPdvILxwOGOXdHkP2Gla2Dn10uV2JNDiBqcMnNaTl4bs0pDIZk
 PqUyEUTYugrxxfn8LoHdxS8E9EyHZQybYbyWJ16VgyGf2+RNsybiBAm9OhzoqLwM1PSp
 zlAO724gFoLLduwqDLzWsod+7HskRNX3SyuB+cwiIYdG9mNiCxOxF254ZOog+Fv1sohO
 TaML7WLMKBhY89dZgEvNjGPYL9YQ+E/hYlIW3DukuTSWZy0NTn3u4iv4td/f59aqi685
 /HE7qBYQXXF/RVUOD/NTtSOEHiUIx3EnIFd+nXZIF1EAUCp3Y7yXNu0k7xVGaHSe6Mvp
 ArlQ==
X-Gm-Message-State: APjAAAWgfSGcWJHAS5o++wo3Hgc1slodllUitCA33TyPDQXX3U7IGw1d
 wdX+UAVX7DEz/pObo+dveHqAd2fIhzVrVVtHcEDpZEldcMbHfefM3Em4ww0MTrQUVUcVil5unU9
 +1ITk4GPyCxKXxr8=
X-Received: by 2002:a1c:a745:: with SMTP id q66mr25340767wme.167.1576499375143; 
 Mon, 16 Dec 2019 04:29:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzrdtvFMpeWBoxASR5iaOsrNp+abbnQ05Sfner8RiC8vdO/0/TEh+maiSgGJy51Hu1Hm/X/Zw==
X-Received: by 2002:a1c:a745:: with SMTP id q66mr25340746wme.167.1576499374915; 
 Mon, 16 Dec 2019 04:29:34 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id t190sm12490802wmt.44.2019.12.16.04.29.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 04:29:34 -0800 (PST)
Subject: Re: [PULL 00/10] Bluetooth removal, and qtest & misc patches
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20191212185424.4675-1-thuth@redhat.com>
 <CAFEAcA_RQC8yswF4X8h9ya_CGLNAsJYZPZGyiqzG6sPq0bSLSQ@mail.gmail.com>
 <32967af9-3c78-0088-6e42-6ec4fa80eadc@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3d72a5d4-15ed-3201-237b-39ce8f2b5830@redhat.com>
Date: Mon, 16 Dec 2019 13:29:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <32967af9-3c78-0088-6e42-6ec4fa80eadc@redhat.com>
Content-Language: en-US
X-MC-Unique: daYtpZsKOCa75E3YilwZJQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/12/19 13:08, Thomas Huth wrote:
>> windows crossbuilds:
>>   CC      chardev/char-serial.o
>>   CC      chardev/char-socket.o
>>   CC      chardev/char-stdio.o
>>   CC      chardev/char-udp.o
>>   CC      chardev/char-win.o
>> make: *** No rule to make target
>> '/home/petmay01/qemu-for-merges/hw/bt/Kconfig', needed by
>> 'aarch64-softmmu/config-devices.mak'.  Stop.
>> make: *** Waiting for unfinished jobs....
>>   CC      chardev/char-win-stdio.o
> These ones are really surprising to me ... *-softmmu/config-devices.mak
> should have a proper dependency on hw/Kconfig so they should get
> properly rebuild as far as I can tell. Could you please check the
> *-softmmu/config-devices.mak.d dependency files whether the dependency
> on hw/Kconfig is really there? Hmm, maybe "make" also tries to check the
> old dependency to hw/bt/Kconfig first, before regenerating the files ...
> not sure how to fix this properly, maybe leave an empty hw/bt/Kconfig
> around for a while 'til all build systems have regenerated the
> dependency files?

I think in the past we've had patches where you just had to force a
"make distclean".

Paolo


