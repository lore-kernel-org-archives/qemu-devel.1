Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593F0C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229B3224FE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdbgQZtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229B3224FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2kY-0004Z6-88
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iF2TY-0007Ws-Qr
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iF2TU-0008CD-41
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:40:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34370
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iF2TS-0008BH-8f
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569876048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=0rhPNx2WJFGUlu/rcZ8mNA97RR5VlB3sKqmlW+gLUAU=;
 b=DdbgQZtAhNdWFhrQ2PvoT4u+lgByZNSrBXB2IxoadFNEVctr3522/NB7WsyFa9IYdBqG9o
 9ywex6o/ssQSv0VsxEYY0wKwPNt8aywJB5bILsAsllVyByAd3ceZpqwm33uuiw/zKFV7mD
 Nyxl9fv0ngBNMFn3WXlPqpB0jI8ajJs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-d4_KZUG7PJ2juJrkR2ZXlQ-1; Mon, 30 Sep 2019 16:40:46 -0400
Received: by mail-wm1-f71.google.com with SMTP id s25so224001wmh.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LgP5hMgf5DWnR89ROyHMfaoJ8KxhzaVnYrXm4sIVUTk=;
 b=hXrugLeUWjBcW50W3CEXGF2AyVYtFZZVO+ZoL1u0Xo7rqk0/TlqAR1Lb4rrmGgLQsT
 fgjtNFy4cP8uE+pe0Wl8UiLUlx3CMthqvNxozsFhaxb/iDOfqpWByysVsuqLevnSa8xV
 E9TfhqywN6v1HCZIjc3Hg89wjKpvVekxK0fniUrJRptJLR4Rtzztf2Ndeu+Soj4lHBw+
 lgzLBTyF/W+2oz+opAusr+qEqOK3zKmV1wLb50fbQeIrMjJYlsA6l3VyKwisEX8dS0+R
 jjdS6aWyX2QQuJMWnjz6aYN2TRJYukTAcLoyJpqPaYwOnqrYmRn7/8+/Q08pROIivAWZ
 YX7g==
X-Gm-Message-State: APjAAAVIPVOMXp1ZTNQYq/i5ytvTSyZanTELqLPYdwb3DFW/5MwMuNuu
 hI9er2kuYhAfNXaAUFVCgOtQxsByGcLScjE4BCH36IMW/ejGz/XVzjFURYbNx4yD8xSc98DbjS2
 B4fyT9W4+yLjPLhc=
X-Received: by 2002:adf:e28e:: with SMTP id v14mr14966509wri.184.1569876045139; 
 Mon, 30 Sep 2019 13:40:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxxN48ZtCi/YVdDb60EefS41PZkyLYevwpcDa1tN+P4Nwrxly3WeKnrH86bs+sjhsZzIh3q8Q==
X-Received: by 2002:adf:e28e:: with SMTP id v14mr14966493wri.184.1569876044880; 
 Mon, 30 Sep 2019 13:40:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d958:8ffa:a1f9:6bfa?
 ([2001:b07:6468:f312:d958:8ffa:a1f9:6bfa])
 by smtp.gmail.com with ESMTPSA id y186sm1133115wmb.41.2019.09.30.13.40.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2019 13:40:44 -0700 (PDT)
Subject: Re: Lockup with --accel tcg,thread=single
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <CAEfK_44VEF17nRgzNvVe+MPmAfS34kiJ_ozubWFkVYV0rm71sw@mail.gmail.com>
 <CAFEAcA9nz9S4R+O9fwa0k38dB3r1smguG4bQRzwm1s0zJCvfDA@mail.gmail.com>
 <96703fc4-cbeb-5487-89b2-78c37b40237a@redhat.com> <87ftkdlhet.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9cdb8f02-0aa4-f0ec-d482-244e346bfc96@redhat.com>
Date: Mon, 30 Sep 2019 22:40:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87ftkdlhet.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: d4_KZUG7PJ2juJrkR2ZXlQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Doug Gale <doug16k@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/19 21:20, Alex Benn=C3=A9e wrote:
> Does seem to imply the vCPU CPUState is where the queue is. That's not
> to say there shouldn't be a single work queue for thread=3Dsingle.

Indeed it doesn't.  I confused this with commit a8efa60633 ("cpus: run
work items for all vCPUs if single-threaded", 2018-11-27).

Are you going to make a patch to have a single work queue, or should I?

Paolo


