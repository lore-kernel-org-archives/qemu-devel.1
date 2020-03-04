Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069F0C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 00:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A0120716
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 00:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cs7CBvmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A0120716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Hd8-0004PK-Q4
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 19:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9HcL-0003mS-UB
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 19:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9HcK-0005tg-U8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 19:10:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35658
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9HcK-0005sw-Qt
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 19:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583280628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RVniUVYRygY3SLjMTMIrb4u7u3AekyD10DlRdZpXe5M=;
 b=Cs7CBvmkRU9PHSJLFAfRAsBRC4Tg2JbRFVAzHUKb1fEPPJvEQj1XC+DK5oi0TszuBt83iS
 oRbGfEofz6/eb5UJadBLQ3GI6eJcWlk4jJpTmmcf962GJSSRrVU8/OSxpuXXkHyX0veflW
 3TMGhIpM4MwAl+PkFdkpNAHotNTj8XY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-JNlkxNaEO6CijxIr9mP3Ag-1; Tue, 03 Mar 2020 19:10:21 -0500
X-MC-Unique: JNlkxNaEO6CijxIr9mP3Ag-1
Received: by mail-wr1-f71.google.com with SMTP id j32so104869wre.13
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 16:10:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yqmqjAjqlW9ia9aj9VahL5KNuPi9NrDLAY10DHXBTnw=;
 b=e4Cxk2k8Zr/u/Ta9IAl/zGG2HlqbtKmORKlyQZICABau7Maj1QbZ/cLnFVa1aKY7Ks
 cQNNlrALiSKNkz3QXNZahKX/DDp2tUpr3ae3GdEPa2NPmUx7eFBPgw9Qv9sPhxptF850
 qNmYzkn0Fc2rJZW5GrQHVbA/XKMQknVYDuVqdFYDpdUdJFMfudE+cpUmfeGAiYxyXSe5
 i++9WkWivy2utWBBs+bbJkTUNwmiXVyOWgBavQB5Tcb4AASG/MxO4RfOsQfkmGYy7R+7
 9OqBx6O5I1W6tSRp3h35AHoY8nwxWdzcuYBEkS6LcJr2lpVD6TA9tkcRqxM6ma2BCTlL
 w1OA==
X-Gm-Message-State: ANhLgQ1fH2mKrna/ehobC8jfAdOJcX/cO6ARtIWaMGcpsWUvdln/1eWI
 +up65jimY6OL5sx71NrPTMBOWh19zpqgSWRc9FapYqLV8v2KwE60kf0IItIzfXR1Z9DJ0xMmL6D
 A257uNVU22JAKSD0=
X-Received: by 2002:a1c:1bd6:: with SMTP id b205mr123352wmb.186.1583280620650; 
 Tue, 03 Mar 2020 16:10:20 -0800 (PST)
X-Google-Smtp-Source: ADFU+vv4QLtfWGtbW4JOUCFN3djlPzgYgEKxkO6SYhTcV2v8+7T2FycKyYtvVJc7uNYB5nyiNqED2Q==
X-Received: by 2002:a1c:1bd6:: with SMTP id b205mr123294wmb.186.1583280620277; 
 Tue, 03 Mar 2020 16:10:20 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id f17sm26091800wrj.28.2020.03.03.16.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2020 16:10:19 -0800 (PST)
Subject: Re: [PATCH] cpu: Use DeviceClass reset instead of a special CPUClass
 reset
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200303100511.5498-1-peter.maydell@linaro.org>
 <226c0d6b-feb5-d202-2fdf-ba4ae910e463@redhat.com>
 <4f960fe0-e5f5-1f8c-76a1-b1df2bef4bd9@redhat.com>
 <CAFEAcA-H9nOzSon9eqiL5w1Rq9qVWu=B1q29D4pLTd=u2cWSwQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <87269add-a5f1-4dca-9ae8-de392d7dbfd7@redhat.com>
Date: Wed, 4 Mar 2020 01:10:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-H9nOzSon9eqiL5w1Rq9qVWu=B1q29D4pLTd=u2cWSwQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Stafford Horne <shorne@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/3/20 7:36 PM, Peter Maydell wrote:
> On Tue, 3 Mar 2020 at 18:33, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>> Nitpick: you don't need to include the bracket symbol in the diff:
>>
>>     @@
>>     -resetfn(CPUState *cpu)
>>     +resetfn(DeviceState *dev)
>>      {
>>
>> (simply indent it with a space).
>=20
> I think this was probably leftover from trying to get Coccinelle
> to not rewrap the '{' onto the previous line, before I found
> --smpl-spacing.
>=20
> In general I don't find it terribly useful to spend a great
> deal of time streamlining Coccinelle scripts -- I think they
> are basically one-shot uses almost all of the time, so once
> they're producing the right changes I prefer to move on.

I agree in this case it is not useful to add the script to the=20
repository as a file, because the cleanup is done (as you said,=20
'one-shot script'). The script is however valuable as in the commit=20
description.

Cleaning it up is not for performance, but as the script is buried into=20
the git repository, it can (and will) be used as reference/example by=20
other developers.

Anyway this patch is queued now, so let's move on :)


