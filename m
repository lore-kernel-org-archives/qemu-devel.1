Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F71C282E5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100CE20868
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100CE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53834 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU9Iw-0004wv-7d
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 08:28:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hU9HV-00043V-NN
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hU9HU-0003ry-KQ
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:26:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hU9HU-0003rb-EY
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:26:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id t5so9030507wmh.3
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 05:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=Ld842iSwFWPccn0EvoO0WaoljnGc65U/plTJEseq2Oo=;
	b=VqvOkn29/8fjuxv//0uSddW7S1I+zDUKJH2luXY9y/SeOAVvf1wmy+0a2/KHxNpzCO
	myFa5J9ytdo4WfcLzgGRF0wadI9IqCP+rhqo8djoawNELZ0Abd9jr8Dc1yUawQgeDGse
	9QW7/tQHT+haGqGZELTNHBLdCqx3ZyTQNvBTpeliKsMxExBxdxr8AO122HSCmgi/SqgH
	ZUwn59kp3FUS6tn3LQaOVWs+pLF5yfxjR2O+kPTAjNTJUbzx0QrtdbScZRu1/Ivd3Zdj
	nwIZ25fAjWARvA8wsysxNxZPH/7Ad7ikHo1XB0kXXBzpz+hOZasuuQXwjxB0h8tWJufh
	yrmQ==
X-Gm-Message-State: APjAAAUaSnYytkePEjKnKNF5EQHRUlrn2jv0dw4MOSUc6Vt16WEicTqq
	wgKudoxcyypYG0qNWjQ2IxT65A==
X-Google-Smtp-Source: APXvYqwzjiM8szByWWCWO5KboyDJPUdnR7YgkOn5Z+sjcZRC4iOUyUexQxx6K5fA+aoIM1yHYbUnIw==
X-Received: by 2002:a1c:2dcd:: with SMTP id
	t196mr16098468wmt.141.1558700799414; 
	Fri, 24 May 2019 05:26:39 -0700 (PDT)
Received: from steredhat (host253-229-dynamic.248-95-r.retail.telecomitalia.it.
	[95.248.229.253]) by smtp.gmail.com with ESMTPSA id
	q15sm2307056wrr.19.2019.05.24.05.26.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 05:26:38 -0700 (PDT)
Date: Fri, 24 May 2019 14:26:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190524122636.ksxng6mcwimm3mr4@steredhat>
References: <20190504060336.21060-1-philmd@redhat.com>
	<79f09ce1-076c-6f20-562b-1b0a1eec4fb9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79f09ce1-076c-6f20-562b-1b0a1eec4fb9@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] tests/docker: Update the Fedora image to
 Fedora 30
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
	qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 24, 2019 at 09:44:41AM +0200, Philippe Mathieu-Daudé wrote:
> On 5/4/19 8:03 AM, Philippe Mathieu-Daudé wrote:
> > Fedora 30 got released:
> > 
> >   https://fedoramagazine.org/announcing-fedora-30/
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > ---
> > Based-on: <20190408201203.28924-1-marcandre.lureau@redhat.com>
> >           qxl: fix -Waddress-of-packed-member
> > 
> > Based-on: <20190503112654.4393-1-laurent@vivier.eu>
> >           Pull request trivial branch 2019-05-03
> 
> 'based-on' series got merged, ping?
> 

Tested running 'make docker-test-build@fedora'

Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

