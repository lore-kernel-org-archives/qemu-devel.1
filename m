Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF87C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D7D2133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D7D2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40711 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTr0o-0006is-Lp
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 12:56:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hTqwC-0003Ld-2k
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hTqwA-00069T-9G
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:51:28 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:39684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hTqwA-00061m-2N
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:51:26 -0400
Received: by mail-wr1-f52.google.com with SMTP id w8so7057541wrl.6
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 09:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=+l1KFl548lVy+J7Yjdbh9qZFSu5ezbf7mS+mJ9x0YCs=;
	b=CRUYbzSCZvgJi8nTw4dXVR2W6HPt7YpIG6wLuXZoFp+0lGiHojeOBk9jDdlNiOgaGA
	iC2NUhkiz2YerGljABSW8olOGfRJI2zvgzSSu9IQt4iScZLYiMweyrkN2Mrpkigijli0
	OZaTAHNrR31PvaIAls4or1AORFAenlQJKj641n+W9qG/v+xOG0Ex3XVuEkjlvlRxuhmS
	Jzj6tHBfpNfo+ayjVwx0t6+2Ac3SrDg5h0Qs8G5CFm0PNo68nSYt2KvGF7/Re39m1yKQ
	YwsS6e2vWnn/PJE8WYc0YryWkAYublYo6O5hMlkJvg5++RPbHryzQ3Fny/OtR3vbMpX5
	md3A==
X-Gm-Message-State: APjAAAXeE35jO7IU1j16RyjLlqjvEF0pwK1dxLMigA8ujE0tnNY0EoaE
	JqSK/ztf4irrNTukyDw0Rje/mg==
X-Google-Smtp-Source: APXvYqwYMsdJOYPlbnYES17C4Qgh69tHpd1bqR5122H7+aO5On9KMPipTQhL6ZxHnnP/tfeyzrV0Ng==
X-Received: by 2002:adf:9023:: with SMTP id h32mr47461637wrh.95.1558630274312; 
	Thu, 23 May 2019 09:51:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:803b:385d:ae51:dd22?
	([2001:b07:6468:f312:803b:385d:ae51:dd22])
	by smtp.gmail.com with ESMTPSA id f126sm26255wmf.30.2019.05.23.09.51.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 09:51:13 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-6-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <db337f20-8b76-9214-533e-3e4b79c5c4d5@redhat.com>
Date: Thu, 23 May 2019 18:51:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523081538.2291-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.52
Subject: Re: [Qemu-devel] [RFC v4 5/7] tests: New make target check-source
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/05/19 10:15, Markus Armbruster wrote:
> A large number of headers don't pass this test, by design or by
> accident.  To keep things more manageable, exclude all headers outside
> include/ for now.

A lot of these, either in include/ or outside, are _meant_ to be
included many times.  What about renaming those to .inc.h and
whitelisting them in the script?

Paolo

