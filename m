Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FC0C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 09:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688A721783
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 09:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+JIeHgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688A721783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFbDo-0005xJ-Ga
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 05:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iFbCJ-0005Ac-GL
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iFbCH-0002cU-DY
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:45:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42321
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iFbCH-0002cB-4y
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570009524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=HwHarkphA9D+jIDPSZKU/4gQsD7vDw8YlYviK82k0hw=;
 b=T+JIeHgzEXkjqrWXhZ9NDUP4VfldfVE1uJ9QhmBnwWxm6VIZJmLoQ6aTmDio1Wp0zNZDMQ
 3iaJY1IlRgFfaB8UnGc3FQxCycpmLYa6VsMIaqoj1l1+YTRvo3rUVv49AZmINzpsYkCwrx
 EZiWmKJcxBi/+2kNOs+bmGevNpQOfNc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-vkdTN--hOpqJQg8oqi45NQ-1; Wed, 02 Oct 2019 05:45:22 -0400
Received: by mail-wm1-f69.google.com with SMTP id k184so2766197wmk.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 02:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Lg9JQP45K8oT6LUd1iuA45DVuRH8rq68PBEPgDP9zmw=;
 b=WwfoqLSq4XKYpKvgEdw207oeHK9YnUEbT8UDHqjSUGOM5u47tFwU5+dzXDsIdsfxoI
 u2gALuBonM2oe0u7SDUQMADkgmHjQYRq/rYFQ29fs2nvO36vhkxwyzfkNdBPgXTjGEuI
 z0SkyXbts06rP705EraSBbUCvi7sA6rqJ+LZANoEnjhPnk0GJhLj4b6lYlaLDwYta6YH
 vKPgnKX+ChwJ7qat8XpEynNE6E09KeugaiPx8vYQWlYfUwsMm1UJsgcU6TjJusUUpo/q
 YBRD2jqLfQG7SbOJfYHZRWV5U4g/ZdGWmpj4q134UQKRI3E4f/nG8cYOy8ghqwvlqSh/
 76qg==
X-Gm-Message-State: APjAAAU4hzYTkg5DVpEjZQ9lp7BbUvXsEp3sFxrx8s5Q3sZ9cRgw8cI8
 3ZW8h3gHQ3xw1UkqBgbNhtEmEi6xxVJWaWvtimYmJaOEy4GTRPgDBwDWLQ5sL0Mf0YHY3ACWQFy
 sNY5CR8QJyjVafhc=
X-Received: by 2002:a1c:c78f:: with SMTP id x137mr2262383wmf.42.1570009521465; 
 Wed, 02 Oct 2019 02:45:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzikWkd34AeZ/VuZdRXb7jkXZeEq3jiYpTiLPuW70wiYlkrkilk1+JQ82EcZao4C6w7Uu0PgQ==
X-Received: by 2002:a1c:c78f:: with SMTP id x137mr2262359wmf.42.1570009521174; 
 Wed, 02 Oct 2019 02:45:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dd94:29a5:6c08:c3b5?
 ([2001:b07:6468:f312:dd94:29a5:6c08:c3b5])
 by smtp.gmail.com with ESMTPSA id u83sm6687745wme.0.2019.10.02.02.45.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2019 02:45:20 -0700 (PDT)
Subject: Re: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible issues
To: Jan Glauber <jglauber@marvell.com>,
 dann frazier <dann.frazier@canonical.com>
References: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
 <d94f18f1-986f-ec19-02c0-e83e5e7af3d0@redhat.com>
 <1864070a-2f84-1d98-341e-f01ddf74ec4b@ubuntu.com>
 <20190924202517.GA21422@xps13.dannf> <20191002092253.GA3857@hc>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ed5c4522-9250-e403-c55d-d3dbcda82540@redhat.com>
Date: Wed, 2 Oct 2019 11:45:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002092253.GA3857@hc>
Content-Language: en-US
X-MC-Unique: vkdTN--hOpqJQg8oqi45NQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
 QEMU Developers - ARM <qemu-arm@nongnu.org>, lizhengui <lizhengui@huawei.com>,
 Bug 1805256 <1805256@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/19 11:23, Jan Glauber wrote:
> I've tried to verify me theory with this patch and didn't run into the
> issue for ~500 iterations (usually I would trigger the issue ~20 iteratio=
ns).

Awesome!  That would be a compiler bug though, as atomic_add and atomic_sub
are defined as sequentially consistent:

#define atomic_add(ptr, n) ((void) __atomic_fetch_add(ptr, n, __ATOMIC_SEQ_=
CST))
#define atomic_sub(ptr, n) ((void) __atomic_fetch_sub(ptr, n, __ATOMIC_SEQ_=
CST))

What compiler are you using and what distro?  Can you compile util/aio-posi=
x.c
with "-fdump-rtl-all -fdump-tree-all", zip the boatload of debugging files =
and
send them my way?

Thanks,

Paolo


