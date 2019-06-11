Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ED7C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 10:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA3F2080A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 10:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA3F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56080 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hae9f-0002P3-6V
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 06:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33322)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hae42-000638-VZ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hae3t-0004DI-9x
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:31:33 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:39521)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hae3s-0004AO-VD
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:31:29 -0400
Received: by mail-wm1-f41.google.com with SMTP id z23so2302390wma.4
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WGRwtWGs/Ap/mGmuC9rPS4alww4VNmlPEVJhVpgZlnE=;
 b=nrc2rc0oJFaowFgV6bn6SdLZRGmK4584yZXzJWl88KWgKEyzdbM6b9b16pYDC/oTkr
 zDmxEOhtDGErsoDvWPX9/VKVaoMFjXdQ/edP75SMSSBZT4KCrPHdISk0r62qZEnSHuGz
 UENbjOgeC87eD70pJvTCOjcaStcGFb91a/7wyf7oxe5WxXGpYweNZL9T1jMfpyS3NtAW
 t6gVkxbE3qu/FUtQm72mqldqRGzDtkNcGrxLJcTTwhtaUJY7SJbnT4afCNLqSD7elxpb
 AD6XROFMdo2uQUWGGnNALNwnglldSDWDMk6vKMmW25BVjyCcxxHxaoWEUOMYr8ClpzT+
 N1pw==
X-Gm-Message-State: APjAAAXch8rbaQDmVMuk7eOc6O5PljhcFJYWCXBOSN95PdjGcW0H4f4x
 3/VvZvlwPSV7Q3+6zmOEUL4ONA==
X-Google-Smtp-Source: APXvYqy2ENyhl3BDgy3MWsQfBBztTpH0O1UVb3lBG8iwK50NffPyPiyyqrNezmO9CFeBw+fDUuCfJQ==
X-Received: by 2002:a1c:a6d3:: with SMTP id p202mr18093427wme.26.1560249086212; 
 Tue, 11 Jun 2019 03:31:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8cc3:8abd:4519:2cd6?
 ([2001:b07:6468:f312:8cc3:8abd:4519:2cd6])
 by smtp.gmail.com with ESMTPSA id z5sm1855091wma.36.2019.06.11.03.31.25
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:31:25 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <5cf62de9.1c69fb81.66fc.8f4fSMTPIN_ADDED_BROKEN@mx.google.com>
 <1e9e4edd-f4ad-d8d6-95a2-e0aeab89510d@redhat.com>
 <5cf7b6e6.1c69fb81.1cdca.e260SMTPIN_ADDED_BROKEN@mx.google.com>
 <ec5033a4-5c68-91b7-ca9e-a1f38c990221@redhat.com>
 <003b01d51f72$5e6f4160$1b4dc420$@Fursova@ispras.ru>
 <67806828-f666-0c9c-00fc-b520f15013d9@suse.de>
 <e4fe4dc0-f3c4-a051-d39d-afd7bfdc680d@redhat.com>
 <98826c5f-4a74-5364-2aef-28a10db12c20@suse.de>
 <39250506-f38f-c440-5728-7b970d32ab41@redhat.com>
 <79b821a4-7cc0-2461-7ca4-d71c3e5ee4ef@suse.de>
 <c49abf01-c209-b206-edee-507c31269011@redhat.com>
 <87o934sdot.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d391b41-bf6d-b83b-7b22-25fefa18c518@redhat.com>
Date: Tue, 11 Jun 2019 12:31:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87o934sdot.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.41
Subject: Re: [Qemu-devel] qgraph
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
Cc: Natalia Fursova <Natalia.Fursova@ispras.ru>,
 =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
 =?UTF-8?B?J9Cf0LDRiNCwJw==?= <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/06/19 10:56, Markus Armbruster wrote:
> Yes, this is how introspection (both QMP and QOM) is commonly used.
> Just keep in mind one difference: QMP is static, QOM is dynamic.
> 
> QMP being static means it's defined at compile time.  So is the value of
> query-qmp-schema.  Same QEMU build, same value.  This permits caching.
> 
> QOM being dynamic means to introspect an object's properties, you have
> to create it.  Worse, an object's properties may (in theory) change at
> any time.  *Properties*, not just property *values*.  In practice, I'd
> expect properties to change only at realize time.

Right, and we should move more towards class-based properties so that
the dynamic nature of QOM is only used for the bare minimum needed (e.g.
memory regions).

Paolo

