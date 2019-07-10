Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049FAC73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A392054F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A392054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl9Kg-00064c-W3
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 05:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59871)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hl9JO-0005Sy-D5
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hl9JN-0003Sf-8k
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:54:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hl9JN-0003Q6-30
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:54:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so1762875wrm.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 02:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U7/c7segJ4ORFqqbJ2ay3Z0UjGaztEmOOHHf3O9Zun0=;
 b=lvjlEa1aSH0Mt+Xp5QGejXqLo8kDoRpF7YI+DQsdGxXF5he0P/+uvDo19Vygot0uIr
 hxFL9MR5bhs1JzpExhZEXXnf6c+KNpL8s5kaWhL8N5nTD2KSm9CBycb5QGtvmYRKbLjK
 /nWB/eR0FlTUE4nOWxOQJi7HBVfkyuRAR+I4RqnOdL8IKxRrpuWmcfWUxwf2cFSsm36y
 vg213dT1aRe9MhieFzLUAR/lhgd4eqfNLh/NkMJbdkO3OgXMl4RZffIsoJiJZUt5+4GX
 Xm3O3OqNnpBqBWeBdIo6hevijR80DZ6kQD3GoOmbl7HiciGLp1KgiLAAHzNHCUgYYxFE
 qPXg==
X-Gm-Message-State: APjAAAUC6pqXqlm4y+0OucYoteEoRmLrIIQsK5MtFkYNrjuJy7SQh+J7
 rA20y5D7dIKwOOpD/xjZn1THDQ==
X-Google-Smtp-Source: APXvYqwfqT8ec4TejHe5RzapZDDQNaINq38MgOWDO9AQa3cZsEzqwoCl8Qw1WoY1fIOrZt9CjJxUkQ==
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr30246110wrs.36.1562752491564; 
 Wed, 10 Jul 2019 02:54:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id w7sm1460152wmc.46.2019.07.10.02.54.50
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 02:54:51 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190708072437.3339-1-marcandre.lureau@redhat.com>
 <20190708160442.GL3082@redhat.com>
 <8914dc43-0b99-ff83-7ff9-8f7b8f256909@redhat.com>
 <20190710090350.GC30831@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f029851a-a7de-b7ca-a9c3-949fb25a9756@redhat.com>
Date: Wed, 10 Jul 2019 11:54:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710090350.GC30831@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
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
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/19 11:03, Daniel P. Berrangé wrote:
>> Would it be possible to make QEMU the broker?  That is, how hard would it
>> be to embed a minimal DBus broker (which only takes care of connecting servers
>> and clients---stuff like launching servers would be completely out of scope)?
> What would be the benefit of embedding it in QEMU ?

If in the future we want to keep only the multiprocess case then QEMU
would be able to launch subprocesses itself.  In this case you'd keep
the old command line working but QEMU would set up the bus and the
services that work together on it (for example the basic QOM operations
such as unparent and property get/set could be mapped to a DBus
interface, and QOM classes and interfaces could also become DBus
interfaces).  The broker itself could be a separate subprocess.

Paolo

