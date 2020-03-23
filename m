Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB8FC4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94752206F8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0cju7oO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94752206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGSdC-0001Y3-Md
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 15:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGScH-0000ja-Fc
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGScF-0006iB-QJ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:20:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33557)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGScF-0006ht-JE
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584991202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANXme1CLexblvN6drAC07JgT+D1o3wAtIJcnUBbEw1k=;
 b=U0cju7oOH354uz6dIzAZXqS9Zio9IQ+zUwcn3DdLpBApkWpS1Nllg1S1MH/Wnumj3s2o7u
 I1brlzI4V4etPKPVNL9CxXxTFUgGiZ3fsACWxqtxGEkucpJ5tapyGXR0ew35nijC0apcv+
 SfpfGluneELttrXEMHXczD5sOqYJ/5g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-yuqp5KBBMFmOva783m1WxQ-1; Mon, 23 Mar 2020 15:19:59 -0400
X-MC-Unique: yuqp5KBBMFmOva783m1WxQ-1
Received: by mail-wm1-f70.google.com with SMTP id f207so215234wme.6
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 12:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tEvvyJ+hNRYzDkH7nWSfwd3a1jicRvWslHWMAbRTelg=;
 b=K0ETB0twqqyakDf+jwGlepEPG486vFcLrFY2ahHLxEEm5ycE0TNLxbjlX2im/HG9Tt
 op2iTnQvSyYT/2sZ+T8J9Gz2IgO1vjaOAaFZbzhMgxGRaQa7Vn/4fYeMwaeymsyi5cOQ
 yhQRayzqTldvAlZq08V1jeAuNB8Fe8QdxnuzxGRbu7RhkbGvRGCvlERTpripYBPXnQZc
 VCLXd+SomAFhED6zX5PfZXFrGHHhQH52EoOMrnAuPN7A12TEmWELZ9yIBKh/e7q3vF3B
 YdUIyplnxcoobD1Vf2RIQxZqE+5O9M8D+w5LAEx8abwG3GumyoFU2/ObhNwfbBdKOeP/
 GhDQ==
X-Gm-Message-State: ANhLgQ2/lCsLaAhlSjKHrinPL5B7KslURYK+Um82aRm9wxcbptB5Pq95
 9ITacG4bQeHHTjdpBmZ9pRbHUZYeFAzbIWT/1puQY32ftA8XLfb9Nw5YG5dQp03gqr3eKIjoiRZ
 h92wuRpf5AMAqlwA=
X-Received: by 2002:a5d:5141:: with SMTP id u1mr4164419wrt.146.1584991198034; 
 Mon, 23 Mar 2020 12:19:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsBjSWKsjNssk92HFt6i8jPhA8g28ER6oRxlouv+OKGqOVvlVQHdodboz93Buw4Lc92QsFTlQ==
X-Received: by 2002:a5d:5141:: with SMTP id u1mr4164395wrt.146.1584991197844; 
 Mon, 23 Mar 2020 12:19:57 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id f1sm15425661wrv.37.2020.03.23.12.19.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 12:19:57 -0700 (PDT)
Subject: Re: [PATCH v41 01/21] target/avr: Add outward facing interfaces and
 core CPU logic
To: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
References: <20200118191416.19934-1-mrolnik@gmail.com>
 <20200118191416.19934-2-mrolnik@gmail.com>
 <80141c57-7fb7-6e95-4070-54f7cc23e166@redhat.com>
 <CAK4993ie33Awp=sqUOcubqCLFqTd5mTPAkWQfhh3zvorMwnSig@mail.gmail.com>
 <8ac9a03a-a02f-1b48-c75d-77e4b8aea9ef@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <45d68295-416b-b6d2-a512-86f6120432f0@redhat.com>
Date: Mon, 23 Mar 2020 20:19:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8ac9a03a-a02f-1b48-c75d-77e4b8aea9ef@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 7:03 PM, Richard Henderson wrote:
> On 3/23/20 10:03 AM, Michael Rolnik wrote:
>> Hi Philippe.
>>
>> It's been a while. let me think about it=C2=A0and get back to you. what =
is your
>> concern ?

We are using this series with Joaquin for a Google Summit of Code=20
project, so we are noticing some bugs and fixing them.
As it has not been merged, we work in a fork.
Since it was posted on the list, I prefer to ask on the list than=20
directly to you.

>=20
> It shouldn't be there.  See commit 1f5c00cfdb81.

Ah it has been moved to cpu_common_reset, thanks :)
I suppose it is because this port is based on some quite old work.

>=20
>>      > +=C2=A0 =C2=A0 memset(env->r, 0, sizeof(env->r));
>>      > +
>>      > +=C2=A0 =C2=A0 tlb_flush(cs);
>>
>>      Why are you calling tlb_flush() here?
>=20
>=20
> r~
>=20


