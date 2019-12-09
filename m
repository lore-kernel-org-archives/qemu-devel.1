Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBF9C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497AF207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Juewnd68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497AF207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieGQZ-00021l-FP
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 05:38:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ieGPn-0001aZ-Qq
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ieGPl-0006mg-8S
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:37:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33017
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ieGPl-0006lm-4N
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575887835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VeBdhe+Q8f+LG3+KdoyBWiBrWYLd8cih8pXLi+eIdpw=;
 b=Juewnd68Lh9oRwFqWj7zEwY7CqnQ6JTpwQXOCaiepY2TWaZepXbeS5IhP1vaBcb4q3AA9Y
 I+tCXBBdavWNHnf+oftrxWgg3kZFV7wQ95jMCWysJTQpy0na/FTwaHNbJ6V94ZJZSMwShJ
 WamxiaOw7fi+gx8O47lvelGHWfEGh9U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-Y6KFBVa-NO2jcvdpRudbHw-1; Mon, 09 Dec 2019 05:37:10 -0500
Received: by mail-wm1-f70.google.com with SMTP id o135so2894848wme.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 02:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VeBdhe+Q8f+LG3+KdoyBWiBrWYLd8cih8pXLi+eIdpw=;
 b=PbE5RdhzPRgz4rxjvdI1vhB7FkRy33iLWCNe+bo+VTbWVx+FXZVuoUFTEKdTkPK4ex
 mwkfxJBM+dUQLYN0H+UmOGAWruHZQq1posztiZnjJXdOqmGTGEny/CDG1hE1BjXLK1E5
 hm4/conYAVU4kmJSrtawby5ED2YFAIvV99iHweAfYdSVZWe1/MMFolbilR6e7iY95eY5
 K9kIf6T6YsLVEZKl9uuACXolM7m6J/4qxPWGbKzNn8LBlXMmKQpfpU3YXmEPNw1l7hPw
 RxNxh4oKAXL6IjVZKrIuO5jIo/VnUAt68IRZP+d9H3tK8LukHI9U9Mv3qeO4ow6Fo7XU
 OxXw==
X-Gm-Message-State: APjAAAWYK1hQqllpJPDoN2gwejjEctsMcSVOBtA/lMxf5iQfZZT5YMc1
 kkeUlXqZGl4JEs58GxfhV+GQK16yRB3FEG9TvFX82jzuJKB8NG8EEZ+CpVeL/mT5OFOgQCPzZLQ
 nmPgfiIKhE3UIWSY=
X-Received: by 2002:adf:e812:: with SMTP id o18mr1263428wrm.127.1575887828984; 
 Mon, 09 Dec 2019 02:37:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqzPJXx8k4ZgFQSOG7pnPfUJZsAYZHfGUXEJW5oqYzuQWppM1rtlPdjhfZ6/gdbk5LCXSF/h8w==
X-Received: by 2002:adf:e812:: with SMTP id o18mr1263399wrm.127.1575887828682; 
 Mon, 09 Dec 2019 02:37:08 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id h2sm27318583wrv.66.2019.12.09.02.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 02:37:08 -0800 (PST)
Subject: Re: [RFC] Use of the Nacked-by tag by CI scripts
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <4cbaadf8-ae4f-d086-2137-b83d61a5e9a5@redhat.com>
 <CAL1e-=ja7sdqC6sm_AxYkN-m_R__4dofj-WsYreHZB813OG9OA@mail.gmail.com>
 <9f71601e-de90-86d9-7c6b-352d923bbc06@redhat.com>
 <CAL1e-=iRWsWde18AffTOwTesAbGcb5fZWeRytaOsHg5iCQpBgA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <efe5a839-96a6-b80f-1452-bb43c7bc3ebd@redhat.com>
Date: Mon, 9 Dec 2019 11:37:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iRWsWde18AffTOwTesAbGcb5fZWeRytaOsHg5iCQpBgA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: Y6KFBVa-NO2jcvdpRudbHw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/12/19 11:12, Aleksandar Markovic wrote:
> I'm afraid this would be opening a Pandora's box. For such rare cases, a
> message from a person: "Please hold on this patch until I am back from
> vacation.", "Please wait until I merge my series acting on the same
> files", or similar, would perfectly do the job, as it did in the past.

The point is when you don't see the patch until it gets in a pull
request.  It's not particularly common so I'm okay with no change (and I
agree that Philippe's patch, as is, doesn't solve *this* particular
case) but I also don't see this as causing problems in the future.

Paolo


