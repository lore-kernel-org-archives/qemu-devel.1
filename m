Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB17C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F42A24650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXKcJpg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F42A24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j56jx-0002Xo-MZ
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 06:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j56jI-0001zt-Ow
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:44:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j56jH-00025I-Ra
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:44:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52461
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j56jH-00024W-OQ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582285463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BrxS/WPLSZQoq/vG0r6Ye9JuHndQSvui9uLouqeXHn0=;
 b=BXKcJpg+s3R9x/BL3aXF05JvjI13zsrXhNdVr4bg9VZNvVr3KY8MA593mW5td1Fa1X1RW2
 26HlCGxIihSqbKBJ/oT5LTk9Tg/7D2pk+Hnz4QF+IbTK98rR+1X1N0nXLtKs+1Xs/nMckM
 y0kQu7eGvRG9V4q2sFdmiq1o9zTPmdw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-5fcHONULNjmTO0cCk-w-Sw-1; Fri, 21 Feb 2020 06:44:19 -0500
X-MC-Unique: 5fcHONULNjmTO0cCk-w-Sw-1
Received: by mail-wr1-f71.google.com with SMTP id d8so904524wrq.12
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 03:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BrxS/WPLSZQoq/vG0r6Ye9JuHndQSvui9uLouqeXHn0=;
 b=OX8+Y7Xrr4UTogJw6G7Tn2uIuND9sf5FssMrxjmb+d9KpZYNBHnV79Np0wcGQOzeaq
 nZUCRF7HbmSy9CsgvWd/h8kBAjNg2hsdPKB4iJ7HVxz2i/NgLE4zvZOSg2kIyZOq4P4y
 htmOZjJ66ljNOOCClAYBdfQc/vPV46zYBBgLUzNGH5Dx3C2wUjA2zUomJe/tekP2j0RT
 2ohISJN+bvEWy7sx3zQBcYITv3IiiX5GcT1l2UwqdLbMJ5NGy3RfsFDVLdx554grd7az
 pEhfY9XbBeRsSQ4vqKUW9BbXg0ksorpf27HFI17jGuV/S3zNINNlrGiciWX2r3cD2Ab6
 dsRQ==
X-Gm-Message-State: APjAAAXKA1wBWx1IHOaJM8gLEXPpfdjbiaXtcPVS8YRbOFs8JU9QChFy
 4BstIRRBNzLQTPmorJR81x7KkXdqnPxLJGr2tyuTyZzJ07oP+kPabltzjp4dLK4sV5SMur/tGnH
 hARLWcUDzsAXsfm0=
X-Received: by 2002:a05:600c:295d:: with SMTP id
 n29mr3313610wmd.101.1582285458442; 
 Fri, 21 Feb 2020 03:44:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqxtUEv55QtoWORzq6jqQZakcewB2UVlT00Q7H2KKm035d2Sy1k0+HBAuzeU/tJgWpdt2Vnl5Q==
X-Received: by 2002:a05:600c:295d:: with SMTP id
 n29mr3313587wmd.101.1582285458173; 
 Fri, 21 Feb 2020 03:44:18 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
 by smtp.gmail.com with ESMTPSA id b11sm3788650wrx.89.2020.02.21.03.44.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 03:44:17 -0800 (PST)
Subject: Re: [PATCH] hw/char/pl011: Output characters using best-effort mode
To: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>
References: <20200220060108.143668-1-gshan@redhat.com>
 <f3c8adba729d050ba2144cc9c834fe82@kernel.org>
 <CAFEAcA8inLO75XOcCO3bUiiJQyZT+nqmp1be+z6ZtQx2a=68+g@mail.gmail.com>
 <fda602ae-43d5-728c-a5bb-f607f0acd3df@redhat.com>
 <CAFEAcA-VB1t2XDuAHgq_p2Fz8NQ+3HFgyNOzRjk8BjixNJb0qg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eedbac05-5a17-82e6-3cdc-c3b21983545b@redhat.com>
Date: Fri, 21 Feb 2020 12:44:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-VB1t2XDuAHgq_p2Fz8NQ+3HFgyNOzRjk8BjixNJb0qg@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Marc Zyngier <maz@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Shan Gavin <shan.gavin@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/02/20 11:21, Peter Maydell wrote:
> Before you do that, I would suggest investigating:
>  * is this a problem we've already had on x86 and that there is a
>    standard solution for
Disconnected sockets always lose data (see tcp_chr_write in
chardev/char-socket.c).

For connected sockets, 8250 does at most 4 retries (each retry is
triggered by POLLOUT|POLLHUP).  After these four retries the output
chardev is considered broken, just like in Gavin's patch, and only a
reset will restart the output.

>  * should this be applicable to more than just the socket chardev?
>    What's special about the socket chardev?

For 8250 there's no difference between socket and everything else.

Paolo

> I've added the chardev backend maintainers to the cc list.


