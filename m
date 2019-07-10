Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E543C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 08:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2650E20693
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 08:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2650E20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl8Mu-0006mu-Cv
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 04:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35920)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hl8Lf-0005vZ-1f
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hl8Ld-0000wy-2r
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:53:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hl8Lc-0000wM-Sx
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:53:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so1355288wmj.5
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 01:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zBYxQJmFGy9eCCcN9BI7wfBg8TnYHk0yAs7+ZJn+xCs=;
 b=q5f1W6PXmSDJ0c6ziopsplRATC0lKUeQ/bFAiBgNfdSc3oPTNpuhpcdnhPsuWGq3j4
 9Dthp1yxuDx2/d3nzxRl+URmtqCVh0xl7zJltJtIxteCQvKAIMLoHhBRkWoxLgGz78ri
 GuhQZGEULZdiSRKftXKG6Zs1ARlt0hbdYr7qIxhpkCgllGVsO3TNoxtTqNqL9Hgwq6Ex
 TwtgfbrDqtMaYdwX7OyxBYm8AGFEZotgtJPqYjwLbCyLqNjkS9VJiUZACZ0ylEiLn7v0
 +qFs9SzKiSo7oIuHVJHs3JO5CSKFBGcJ+O229E1wb8yfuq6QDeLM+MucV3TN5ZrjlI+K
 gpgg==
X-Gm-Message-State: APjAAAUMvIrA71vcygw8scjl2Ldd2x/UOiAHOfBT7DNhJxTQBr3jM433
 Q9aZkEKYTM3DAYDtwF/23Tl6wA==
X-Google-Smtp-Source: APXvYqz3HM3RsImE8mE9HvQ6ZTdjIv8YemiUZPAGoJmBUOegXNTREAIsoX32VBCvlqqqTJrAaVt2fg==
X-Received: by 2002:a1c:ddc1:: with SMTP id u184mr4024183wmg.158.1562748787720; 
 Wed, 10 Jul 2019 01:53:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423?
 ([2001:b07:6468:f312:19db:ad53:90ea:9423])
 by smtp.gmail.com with ESMTPSA id y16sm2575824wrg.85.2019.07.10.01.53.06
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 01:53:06 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20190708072437.3339-1-marcandre.lureau@redhat.com>
 <20190708160442.GL3082@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8914dc43-0b99-ff83-7ff9-8f7b8f256909@redhat.com>
Date: Wed, 10 Jul 2019 10:53:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708160442.GL3082@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 0/3] Add dbus-vmstate
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/07/19 18:04, Daniel P. Berrangé wrote:
> The downside of using the bus daemon is that we have to spawn a new
> instance of dbus-daemon for every QEMU VM that's running on the host,
> which is yet more memory overhead for each VM & another process to
> manage, and yet another thing to go wrong.
> 
> QEMU already has a direct UNIX socket connection to the helper
> processes in question. I'd much rather we just had another direct
> UNIX socket  connection to that helper, using D-Bus peer-to-peer.
> The benefit of debugging doesn't feel compelling enough to justify
> running an extra daemon for each VM.

Would it be possible to make QEMU the broker?  That is, how hard would it
be to embed a minimal DBus broker (which only takes care of connecting servers
and clients---stuff like launching servers would be completely out of scope)?

Would it for example make sense to split the bus handling part of dbus-broker
into a library that QEMU could reuse?  (And if we plan to do this, should QEMU
use sd-bus instead of gdbus?)

In QOM that would be something like

  -object dbus-connection,id=client1,chardev=...,addr=foo       # p2p
  -object dbus-vmstate,connection=client1                       # the interface

  -object dbus-connection,id=client1,addr=foo                   # via external daemon
  -object dbus-vmstate,client=client1                           # the interface

  -object dbus-session,id=session1,chardev=...
  -object dbus-connection,id=client1,session=session1,addr=foo  # via internal daemon
  -object dbus-vmstate,client=client1                           # the interface

Paolo

