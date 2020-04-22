Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D18AC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A0220767
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ug+ixpIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A0220767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRIFa-00031p-9r
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRIEk-0002Nn-Ts
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRIEk-0001n2-8C
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:28:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57484
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRIEj-0001dy-Qk
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587572912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EhhJOgkvvgqWnCQhfPTHhYvZqwUPRLVCqsjEJV5ms8g=;
 b=Ug+ixpILvQxyCequawLCFfDN/W+yLTkvaleM11JfB5eqmZ2HAdqJlXXW+UqICigPm5xqCR
 A44CNxp9QJpQifkveQPHGQ/p5TfEDtDYR9COMmxN3QBBwvux4SUoW0I2DPwkbKYNbRI8YE
 y8UN3zjNiuY8+tKOD5+J1rZe2F+UG/8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-Js2wZ7LeOci8T7Ha-ssWHw-1; Wed, 22 Apr 2020 12:28:30 -0400
X-MC-Unique: Js2wZ7LeOci8T7Ha-ssWHw-1
Received: by mail-wr1-f70.google.com with SMTP id v9so1312021wrt.7
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 09:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6LqgKd+F2jQRZ5qu50Gpb8LaVWo0UzWevkBvO5TN73s=;
 b=RdcUFGKHi8egdl1TXqmwODn5r3B8PO0lK9hrXI54oLZiFsOGB81kyioAiJPSw0bZB1
 mVwjh6ULI9ygrmkiYsaly4AuxY1loir/qZLJIQbyutoB7qKta1lwwKXjZEcuJHlz3niw
 lcgH5FrIlX0vIraeKmBCQfcVvktWDPMRgxLkU0Btj3tvwoO7d7R4jg1wZ1paOck31EO6
 WrT/mgjE3WoB143Udkwq1FBcmRLyF35jBiJwtESBHYnqXi5//tpm0aZAaKKDZjJOY2Ov
 uVgsHXfHhuQjg+z2aplbAlRQsA4XymBjKDftAS0Iuco6vr0if1ZmKs36JYTc/WjFmcTi
 ZYpQ==
X-Gm-Message-State: AGi0PubxO2icko26F+c1vQFa+Yhyn11muZPg8DmhRc+rLp7cXZmgb3T1
 k7Uv3UFRwDMJHidocaPCOoLBLdP5e2yKTltqkWQfoZrvIH7mebZ7Pe96ClrAXVZHBV/+Kv3oFGZ
 HWjW1a+faTE02NhY=
X-Received: by 2002:adf:f004:: with SMTP id j4mr14458987wro.123.1587572908855; 
 Wed, 22 Apr 2020 09:28:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypI83ZBZgi4i3aJN4JmYjAIgPadTp3BKV26m1QdlLaDf0uz5FO14ANwKF6rcQffsk56FJMWy6g==
X-Received: by 2002:adf:f004:: with SMTP id j4mr14458969wro.123.1587572908602; 
 Wed, 22 Apr 2020 09:28:28 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id s18sm9600653wra.94.2020.04.22.09.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 09:28:28 -0700 (PDT)
Subject: Re: [PATCH v2 12/14] tests/test-logging: Fix test for -dfilter
 0..0xffffffffffffffff
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
References: <20200422130719.28225-1-armbru@redhat.com>
 <20200422130719.28225-13-armbru@redhat.com>
 <8b72369a-482c-a32f-648d-050c22dadf2e@redhat.com>
 <3b33f4de-dfeb-416f-1e48-ddb73153205d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8622b0a0-67ad-8580-a507-496b0d3d4dff@redhat.com>
Date: Wed, 22 Apr 2020 18:28:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3b33f4de-dfeb-416f-1e48-ddb73153205d@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 4:49 PM, Eric Blake wrote:
> On 4/22/20 8:35 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Markus,
>>
>> On 4/22/20 3:07 PM, Markus Armbruster wrote:
>>> Fixes: 58e19e6e7914354242a67442d0006f9e31684d1a
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>> =C2=A0 tests/test-logging.c | 4 ++--
>>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/test-logging.c b/tests/test-logging.c
>>> index 6387e4933f..8580b82420 100644
>>> --- a/tests/test-logging.c
>>> +++ b/tests/test-logging.c
>>> @@ -73,10 +73,10 @@ static void test_parse_range(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(qemu_log_in_addr_range(UINT64_M=
AX));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_false(qemu_log_in_addr_range(UI=
NT64_MAX - 1));
>>> -=C2=A0=C2=A0=C2=A0 qemu_set_dfilter_ranges("0..0xffffffffffffffff", &e=
rr);
>>> +=C2=A0=C2=A0=C2=A0 qemu_set_dfilter_ranges("0..0xffffffffffffffff", &e=
rror_abort);
>>
>> Why sometime use this form, ...
>=20
> This call must not produce an error (if it does, the test aborts,=20
> proving we had a bug).
>=20
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(qemu_log_in_addr_range(0));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(qemu_log_in_addr_range(UINT64_M=
AX));
>>> -
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_set_dfilter_ranges("2..1", &err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_free_or_abort(&err);
>>
>> ... and then this other form?
>=20
> This call must produce an error (if we do not diagnose the caller's=20
> error, our code is buggy, and the test must fail)

Ah OK it makes sense, thanks!


