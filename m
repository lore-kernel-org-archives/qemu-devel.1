Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B17DC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37B62070D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37B62070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsDWy-0001Nu-83
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 17:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33959)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hsDWG-0000Mc-8X
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hsDWE-0003xd-71
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:49:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hsDWA-0003vp-CV
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:49:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so63415881wru.10
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 14:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kFaQs789xoU7Sau+z1r0Pg6ZdeWmYI304Wu/G9SYmF0=;
 b=msCLyIUHWrRY9TcUwIomu3EWgsvu5E7UF4ihmVC2IFVUI6ZFQf5WCvtoTRU24i+V3O
 YVqv8sp2Jn+tSun48UEGQsYVcemwklvebdLq6CFGVn2VDMU9Jd3oRDZTma+xwLc9xVdA
 efVDGklqbhx1WHwFXk3h6WfiVe+hQJZV+l6vjOtldVfE7TWOadKp0KpMM5NIaQRXxCkj
 A/5xr0w6kCxqrqLbW8I+ugdpsLiVf5Go7RCn1gZqdNWrGmolTZ8Ep7Plk2C9SQGF7ra2
 X4K6EuqXwnwoojkG3U2sALGrZPTOiSrKV0xZ5UytirJR0a/reF9WIO7yPcBiAtFbw1nG
 E5QA==
X-Gm-Message-State: APjAAAXpnsvGWRbqKOnfDRXdvfMLpAcHGw1w6zZmO9O7S2t2VfColM2t
 WYL/f45spQ+W9ZPegEdDcJ2YTA==
X-Google-Smtp-Source: APXvYqxcv37rcKmrGfPIADY2L5ukSf8dHnbFKCnwyZzbVuC77Xa6ish1TWPVJHhltIHp5rhkcYDQJQ==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr32546433wru.280.1564436956638; 
 Mon, 29 Jul 2019 14:49:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04?
 ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
 by smtp.gmail.com with ESMTPSA id u186sm112016090wmu.26.2019.07.29.14.49.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 14:49:16 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <1562554503-177179-1-git-send-email-shaju.abraham@nutanix.com>
 <087e6cb5-b24d-b144-744c-d74defeadb86@redhat.com>
 <34a8030e-a173-162d-6786-3dafa5a1d4ed@redhat.com>
 <20190729100946.GC3369@stefanha-x1.localdomain>
 <9c34e70f-5ead-309c-865c-4a64d8a28724@redhat.com>
 <7005cc99-3bb2-fa70-aaf6-86870c37827b@redhat.com>
 <e846dfd4-3bf5-1e28-dfd9-3315168f3144@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <62159041-f54a-a486-4d40-1943cda9fc2b@redhat.com>
Date: Mon, 29 Jul 2019 23:49:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e846dfd4-3bf5-1e28-dfd9-3315168f3144@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] Fix Guest VM crash due to iSCSI Sense Key
 error
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
Cc: Kevin Wolf <kwolf@redhat.com>, shaju.abraham@nutanix.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/07/19 23:37, John Snow wrote:
>>>
>>> If it does -- if there are indeed no places in the code today that
>>> artificially inject -ECANCELED -- I need to remove these special stanzas
>>> from the IDE code and allow the IDE state machine to handle these errors
>>> as true errors.
>> The bug is that there is no place to inject -ECANCELED in the dbs->bh
>> case.  I've sent an obviously^W untested patch.
>
> Where does it inject -ECANCELED in the non-dbs->bh case?

It's simply part of the contract of bdrv_aio_cancel_async that the
completion callback will be invoked (most of the time the I/O will just
go on without any cancellation, as you noted).

Paolo

