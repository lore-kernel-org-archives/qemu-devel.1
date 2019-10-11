Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FE2C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FC721D71
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Izh/LLkc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FC721D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIqDp-00065y-UI
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 04:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iIq85-0003Xq-CX
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iIq81-00085E-0A
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:18:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33783
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iIq80-000844-SQ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570781903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=1jV/mODnn2DVH9KFxtojSvl+p43Aps7LrdTlKd/bW9s=;
 b=Izh/LLkc+XNoOuITO/16m1saCMKyOU1vQvP4kb28l52SbpEJFl2ObKqlTkhrxtBWpe0ryw
 D9WmO56VNPlfqrLkNcKrK7GJPOypnvzfymecee/6vR+L9grvddIr+obOJCSoSH8kSn0UJV
 pcgXUuZHn1Lw8aMb2Roe3xubMmU0+k0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-9pJgGOQfNS-oLysZ64wYkw-1; Fri, 11 Oct 2019 04:18:21 -0400
Received: by mail-wr1-f69.google.com with SMTP id k4so4010853wru.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 01:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nGQHkZKxs0mrU0xBIY0tI2iUOB1oBvE192TbOdN7jT8=;
 b=OJP6Ff5n8TwqfVw4qUt2oVN5nIKPpyQvcDf+dFXpLd0NnnoR1pnnnx+rK10vkZ6o3C
 BCSEa4GB7jjiUWw6ROiE7RjaE6FP3issE9Ui4zx4fLGhx7Z2oA3b65tf2IDqkut2Zg5T
 aYFnG9AZHeC18PYTeLIoD9aXjANBS6OCkYLOtzptNfph7pu8ULH1twuiwP9qCxjY+6L/
 nlU4xpuY8J5sUZCvpPo9P34lrm+/6Hb0+j1gpCP/8YEuoRx+dfHVhR3N4H9QZThmjEd9
 HglZw1mcqx3BBJXYbYLadMLRIqobNgnVQyMep6EBP5bJ3DdLXVn0X+R7hyWLs4nVzdJw
 cfVA==
X-Gm-Message-State: APjAAAW51wMOjJDqMGXyrpuVWXNF3LF21jq3Mo6QQaLnXirLagKZ5rmK
 qoEKt7UBGG8v48bx9UVvHD/qf5QkIi1qoTGqUQWVqGmdiyj67Fe9VFevHTgFR5uwxRmqEGJ+CYB
 V61EtwvsKfm0sCdc=
X-Received: by 2002:adf:dd4c:: with SMTP id u12mr12379805wrm.170.1570781900558; 
 Fri, 11 Oct 2019 01:18:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx6XD3zMgMPY6EkCBamU6H+x/GvgsLGGbN6rBb1VxkuZ3asizyDDhJdCghQnbz8u5at7lTXRw==
X-Received: by 2002:adf:dd4c:: with SMTP id u12mr12379777wrm.170.1570781900229; 
 Fri, 11 Oct 2019 01:18:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ddc7:c53c:581a:7f3e?
 ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
 by smtp.gmail.com with ESMTPSA id e6sm8527217wre.29.2019.10.11.01.18.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 01:18:19 -0700 (PDT)
Subject: Re: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible issues
To: Jan Glauber <jglauber@marvell.com>
References: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
 <d94f18f1-986f-ec19-02c0-e83e5e7af3d0@redhat.com>
 <1864070a-2f84-1d98-341e-f01ddf74ec4b@ubuntu.com>
 <20190924202517.GA21422@xps13.dannf> <20191002092253.GA3857@hc>
 <6dd73749-49b0-0fbc-b9bb-44c3736642b8@redhat.com>
 <20191007144432.GA29958@xps13.dannf>
 <065a52a9-5bb0-1259-6c73-41af60e0a05d@redhat.com> <20191009080220.GA2905@hc>
 <d5367b2a-84ee-1211-a2dc-7d631c94fe3f@redhat.com> <20191011060518.GA6920@hc>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <966c119d-aa76-2149-108f-867aebd772f7@redhat.com>
Date: Fri, 11 Oct 2019 10:18:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191011060518.GA6920@hc>
Content-Language: en-US
X-MC-Unique: 9pJgGOQfNS-oLysZ64wYkw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
 lizhengui <lizhengui@huawei.com>, dann frazier <dann.frazier@canonical.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Bug 1805256 <1805256@bugs.launchpad.net>,
 QEMU Developers - ARM <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/10/19 08:05, Jan Glauber wrote:
> On Wed, Oct 09, 2019 at 11:15:04AM +0200, Paolo Bonzini wrote:
>>> ...but if I bump notify_me size to uint64_t the issue goes away.
>>
>> Ouch. :)  Is this with or without my patch(es)?

You didn't answer this question.

>> Also, what if you just add a dummy uint32_t after notify_me?
>=20
> With the dummy the testcase also runs fine for 500 iterations.

You might be lucky and causing list_lock to be in another cache line.
What if you add __attribute__((aligned(16)) to notify_me (and keep the
dummy)?

Paolo

> Dann, can you try if this works on the Hi1620 too?


