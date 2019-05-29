Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E88C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700F32070D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700F32070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50705 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVv4l-0003o2-Ot
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 05:40:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVv2d-0002hX-AZ
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVv2c-0002jO-IS
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:38:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hVv2c-0002j9-DR
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:38:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id h1so1235836wro.4
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 02:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=GyeF7UAIV8Fy3xtoQTt3vNm4DRuLD7XSRn9yg2iKkDQ=;
	b=QZFxb1goU+pXJ7Fr9KtqRj796eXs8Up+g+Nzy7TJk3NPyO+njbrHkcyR8/58YV6yNM
	ZESkbQzt4KOxgt+qO/Jh1yKsgxUFirVEFde34u+Kbe1WoP8H/cRGGBqvzpKzBx++LUZ9
	Fu6rKy9vHSuaHksr/I4M/56Z9miW14tDoKgQmbV9/XPBoYRLJeNDBtm5vdGF1P3UlzpK
	5Bo0Wn7ezbEnTxF+wwOKzxzRlnb2jPoNao//mmnA1C1cHKzs1909O+bVsFvG9r+HuTCj
	uLwaNkAQii3a2d1BtQ7yt0YXPiqKdF12EZ07tGMiNUZn5Tzs3rd71mX3L6DeBlOc2ZOv
	kDxQ==
X-Gm-Message-State: APjAAAWP3AcHxpS4Luu7/UwY2ZdkMA0abHV69CzRltcJrRQEABvl4A39
	GwpjBhK4cUSdd4H/YLCwDPuwhA==
X-Google-Smtp-Source: APXvYqzOfpNRHg0GAMlkzvncMdgm9o1Y6o4xGic/wQkmFEAkRb1/0xYflBg9jbeOt6iUTv0vBALi/A==
X-Received: by 2002:adf:f909:: with SMTP id b9mr39460948wrr.119.1559122712631; 
	Wed, 29 May 2019 02:38:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c92d:f9e8:f150:3553?
	([2001:b07:6468:f312:c92d:f9e8:f150:3553])
	by smtp.gmail.com with ESMTPSA id
	o20sm23057503wro.2.2019.05.29.02.38.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 02:38:31 -0700 (PDT)
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
References: <20190528204331.5280-1-kraxel@redhat.com>
	<016bde36-9476-91c3-0a06-5cd13d317083@gmail.com>
	<20190529050123.dblwhfffwa5emhjf@sirius.home.kraxel.org>
	<f82b1632-083b-8520-4f46-b9d89de9583c@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b5c121b2-87ed-0d3b-8602-7ccf74f8dc42@redhat.com>
Date: Wed, 29 May 2019 11:38:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f82b1632-083b-8520-4f46-b9d89de9583c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] q35: fix mmconfig and PCI0._CRS
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/05/19 07:11, Marcel Apfelbaum wrote:
> I am not saying is a "big" issue since it will probably not affect the
> guests at all.
> Upgrading QEMU will look like a firmware update or something.

Yeah, this happens all the time.  This kind of bugfix is generally not
versioned.

Paolo

