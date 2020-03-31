Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF46C2D0F1
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8967D206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Azn7AGRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8967D206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJBex-0007AA-NV
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 03:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jJBdr-0006KN-0w
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jJBdq-0005HU-26
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:48:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jJBdp-0005GQ-Ta
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585640937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JP0gf2FWDr5HleAtVxUp9TiEH4b5Sa4SKpiIp8zOFdY=;
 b=Azn7AGRymJQ3jDBspBp5zALWKpQIZ82Ht/cFLMcmS9KO/VtMK+1PMw1YKlNTUnbqwHcN5y
 vEYRIcsv5yDbfaJD4N1lW3q8gq07r7DqpRBaKMfW0A7L7gvYrCSck78WTm2FJVa/RRXa35
 9qqSfQtna6EUe7kZm2dMpHRs656hlt4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-xEYli--3PLSo3qTCSlnD9A-1; Tue, 31 Mar 2020 03:48:55 -0400
X-MC-Unique: xEYli--3PLSo3qTCSlnD9A-1
Received: by mail-wm1-f69.google.com with SMTP id u6so373681wmm.6
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 00:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JP0gf2FWDr5HleAtVxUp9TiEH4b5Sa4SKpiIp8zOFdY=;
 b=Bt7c7hP8J3vrBLvvFfaGsMgFRp/jt5YorEKn5MpM8vwwpLLFgMKfiZKBUMty/u2F94
 P/s4pSY9jOYohSf3wazVEmpkPIF15EzMzRhcdobbyfpFuc/sPs4JlhzC86PC83y/afmU
 DZInskmM11V4K914tIRwxcKBCTisIgbGik8TpEIR4qoO3UTYqBsxnk/8l9VSSKshxuZF
 z0mohunm7ZHC3u/NUR76GZt9urX/lTsMvoHd9DcaTxKJ94X4/BPKzdLABNoFwtQye1DA
 VNhG7ltKa49NTuyDmyjKUuVwWbkqyAjMU5BuhC40qqLQBL7OBiP+8GLjqW+vw1oPWHpV
 JKzg==
X-Gm-Message-State: ANhLgQ0zIALxj03y2IoEd9U79rqx4rfsQ342W0XgCazmZsvxWo93ndxU
 gJ/Q07WZrocRUtvGIujCTf78372c6Lyfuct09oekbxztCUHoX+7Aq9BtMc8T0dNuU/F/o91Jrzv
 L95DBgL1WuqJSPz8=
X-Received: by 2002:adf:fd44:: with SMTP id h4mr19153184wrs.177.1585640934348; 
 Tue, 31 Mar 2020 00:48:54 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtZmihsMW6ghs5JeAJZtgsCcIN3HrhtGPnyib+eeZGQ8V1gCoifTqCFi0J7/Y2yI6JEZagAkA==
X-Received: by 2002:adf:fd44:: with SMTP id h4mr19153161wrs.177.1585640934060; 
 Tue, 31 Mar 2020 00:48:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b55d:5ed2:8a41:41ea?
 ([2001:b07:6468:f312:b55d:5ed2:8a41:41ea])
 by smtp.gmail.com with ESMTPSA id j68sm15073443wrj.32.2020.03.31.00.48.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 00:48:53 -0700 (PDT)
Subject: Re: deprecation of in-tree builds
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <20200330134212.GO236854@redhat.com> <20200330143759.GD6139@linux.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c0a1dc94-c3f2-696e-743f-aa15ef995094@redhat.com>
Date: Tue, 31 Mar 2020 09:48:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200330143759.GD6139@linux.fritz.box>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/03/20 16:37, Kevin Wolf wrote:
> If manually dealing with separate build directories is inconvenient
> today, it will still be inconvenient with Meson, so this would mean
> introducing the automatic directly creation together with the other
> changes to enable Meson. Which is fine by me, as long as it is really
> done when the external directory becomes mandatory, so that people won't
> have to switch back and forth between directories.

Serious question: why is automatic directly creation more convenient for
developers?  Even if "./configure" generates a "build" directory for
you, you would still have to invoke the QEMU binary as
"build/x86_64-softmmu/qemu-system-x86_64".  That is less convenient than
doing "mkdir build" in the first place.

I can see why it's more convenient for packaging, as they just invoke
"make" and "make install", but as far as developers are concerned it
seems to add complexity for little or no gain.

Thanks,

Paolo


