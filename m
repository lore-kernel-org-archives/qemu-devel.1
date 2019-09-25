Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB386C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0ED521D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0ED521D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48323 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5Pz-0006wC-TS
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iD5P9-0006GL-9F
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iD5P8-0000hY-35
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:24:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60920)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iD5P7-0000hD-Tl
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:24:18 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 09E688E587
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:24:17 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id l3so1951456wmf.8
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 04:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EFzOYLFm23RLu5W6Pgg+BUBRqwrz9rDREkbz/EyIZck=;
 b=eN4z2SIlNIlscQ8Cip5PLrQ4WXpkKYuawnM9VQNRHsrca77WGHgvUkNsKrEdPO/juF
 WOR5DpkIz4G4UOcIfdbpbAx2vnOhiFmgh8o7Dx0XRL/TfOJJ7Hyf7wAw2utnBIP1BPXR
 Opb4Zv4W6q9ZZa6kk4zvBTamBDv3uCZ7YObf62dWXJ0+UV8yu+gU7XP/CKaswzgWehyc
 w1BKYjiEJKpG6RSLABQKCQMX3or6bPojIZqxP98+PkkTj9GDGwqT2EClPHCeJviIcXqq
 yCYGFb446pSQdulYVYr21puv4cjjslmRCfpmo7RuQv7e/oBetsLlSTetJEqBltPotFpH
 J5Ng==
X-Gm-Message-State: APjAAAXNDUuKf9tQF11tQQX8uIgI5jLyw+GH7lsSwhzMCUbq+pbEe6H6
 Q7/rVGc0hjFuRBl8QVou7HKf88Wf19PbNW2adX841CxKL6RNUVRcwMZPKhYDKUmL+2CDakWWw8b
 MvWezvq7VX8XTiK4=
X-Received: by 2002:a7b:c188:: with SMTP id y8mr2178400wmi.51.1569410655753;
 Wed, 25 Sep 2019 04:24:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxmN9AV3evZVaNfej7ONIgDXC2fA+KDsddI3UJgfoVry3IOiWQY9NdXjHJUop8WPaGT2RVV4A==
X-Received: by 2002:a7b:c188:: with SMTP id y8mr2178369wmi.51.1569410655526;
 Wed, 25 Sep 2019 04:24:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id y5sm3904753wma.14.2019.09.25.04.24.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 04:24:15 -0700 (PDT)
Subject: Re: when to use virtio (was Re: [PATCH v4 0/8] Introduce the microvm
 machine type)
To: David Hildenbrand <david@redhat.com>, Sergio Lopez <slp@redhat.com>
References: <20190924124433.96810-1-slp@redhat.com>
 <c689e275-1a05-7d08-756b-0be914ed24ca@redhat.com> <87h850ssnb.fsf@redhat.com>
 <b361be48-d490-ac6a-4b54-d977c20539c0@redhat.com>
 <231f9f20-ae88-c46b-44da-20b610420e0c@redhat.com>
 <77a157c4-5f43-5c70-981c-20e5a31a4dd1@redhat.com>
 <a7001a14-3a50-b45e-a3fb-bee4c3b363db@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <92063179-559b-6dd9-9ec6-2b4e3d924e66@redhat.com>
Date: Wed, 25 Sep 2019 13:24:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a7001a14-3a50-b45e-a3fb-bee4c3b363db@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Pankaj Gupta <pagupta@redhat.com>, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, lersek@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/19 12:50, David Hildenbrand wrote:
> Can't tell if there might be extensions (if virtio-mem ever comes to
> life ;) ) that might make use of asynchronous communication. Especially,
> there might be asynchronous/multiple guest->host requests at some point
> (e.g., "I'm nearly out of memory, please send help").

Okay, this makes sense.  I'm almost sold on it. :)

Config space also makes sense, though what you really need is the config
space interrupt, rather than config space per se.

Paolo

> So yes, currently we could live without the ring buffer. But the config
> space and the virtqueue are real life-savers for me right now :)


