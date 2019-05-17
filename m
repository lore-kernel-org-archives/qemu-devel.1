Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D335C04E87
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1618204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1618204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47144 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRbL8-00048H-5Z
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 07:47:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hRbIb-0002Un-T0
	for qemu-devel@nongnu.org; Fri, 17 May 2019 07:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hRbIa-0002Nl-9H
	for qemu-devel@nongnu.org; Fri, 17 May 2019 07:45:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hRbIa-0002NH-3z
	for qemu-devel@nongnu.org; Fri, 17 May 2019 07:45:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so3204000pgl.5
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 04:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=7J7mou39JrvFKwIFFmgLlDlRp+4qCbOKEd+HSLRB+28=;
	b=fmRuw1xKA7EJOGrRRddtRZS6Ly4zBqacVhCJnuwXd4oUzyGumxjb5OcjhTnt3FSMi3
	vnVCE1KjOEx00mNFLJCuYoPKrGMD8wo/RbFMBlIVaoXH6lJpTJ76a10gocNJ8E6CR/yA
	lA/zG9APaPn1iH3/Ror7lfMCXo5x0cuOlHKs3ASF2Q/TMIRiYHB020x+Qf7bWbCDRpVd
	YzdCFX5CU2NPoZzBbh3oJxv3EYI+9o9LyEi5LWnnLAttnu7fwobY8Ye0UKlB0vRSkN7E
	dxcCem7/ukOKJNWyz8hysksgexHAmkIf+lAQd9+1X6i4Nk+0okAiKb0UJbCqgSj6NFaB
	+wVQ==
X-Gm-Message-State: APjAAAWfZlVWXdTXiMY8Cqa70l8jRL0yl1x5E/2YPCWC4KrfLFFm9Pht
	J/h3qs71pxdMKgNlk9cgga8HLlhZWG0=
X-Google-Smtp-Source: APXvYqzmv+arFuOcFuHm2/IZNDTwAMZW4S3uYvkssRWXEG+KHSRfiF7rlbclZvr5Vz+7H09LXmkY5Q==
X-Received: by 2002:a63:6988:: with SMTP id
	e130mr56851577pgc.150.1558093514648; 
	Fri, 17 May 2019 04:45:14 -0700 (PDT)
Received: from [172.27.174.155] (23-24-245-129-static.hfc.comcastbusiness.net.
	[23.24.245.129]) by smtp.gmail.com with ESMTPSA id
	f29sm23814699pfq.11.2019.05.17.04.45.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 04:45:13 -0700 (PDT)
To: Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-2-armbru@redhat.com>
	<2679829b-cc1d-83ce-9949-2b80d970ddec@redhat.com>
	<875zqe7b10.fsf@dusky.pond.sub.org>
	<CAFEAcA-vqnucYKuV3QKf4wBsfuXMZiC1kqrnaVcA+BEaud__Bw@mail.gmail.com>
	<877eat6xgm.fsf@dusky.pond.sub.org>
	<e562c5f5-9d01-59b0-5a4c-d040fa8b8962@redhat.com>
	<87lfz88bva.fsf@dusky.pond.sub.org>
	<1089f272-838f-e3e0-3b50-5a33cce95030@redhat.com>
	<a44c8068-406e-be4d-0e72-5cfe15ba22b3@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b1baac4d-db3e-fa75-bee5-2e2c7e6b2f41@redhat.com>
Date: Fri, 17 May 2019 13:45:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a44c8068-406e-be4d-0e72-5cfe15ba22b3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.215.193
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-bridge-helper: Fix misuse of
 isspace()
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/05/19 06:35, Jason Wang wrote:
>> Yes, your honor. :)  The helper is the only way for unprivileged users
>> to set up TAP networking, which is basically the only really way to have
>> *working* network.  It's widely used in the wild, it's self-contained
>> and the only alternative for users is the S-word (hint, it's five
>> letters long and ends with LIRP).
> 
> The issue is it can't deal with e.g vhost-net and multiqueue.


vhost-net does work with qemu-bridge-helper, the problem is that distros
set its permissions to 600 and there is really no reason for that.

There is also no reason why multiqueue shouldn't work with
qemu-bridge-helper, all it would take is a new command line argument
--num-queues probably.

Paolo

> We can
> have a simple privileged launcher to do network configuration and pass
> the fds to unprivileged qemu.

