Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85729C38A2C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53EE720771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3Ixn8w2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EE720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOcub-00018v-GI
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOctK-0007zQ-Lq
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOctI-0000kx-Lf
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:55:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24542
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOctI-0000kR-Ix
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586937320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AownEVcsxS6mm/Xjip1XD1JDXoCJroy1G7N3IHskW0Y=;
 b=S3Ixn8w25rvzmYEI8TSHmrIRLfj8lPzBdMJvQ7L8ogLm4HVfk+HjAa1Mv9p6y6hjn3a3V6
 G3ZPZ/lmQvdYoJMAAmpRGKT5v7g5U/O0CmWRXuDD7JOkANx7IyFrfBvgQ6ApYv5ATrO9s6
 zBdYrkaI81qaoSW16ObXXE4N3hDtjJQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-7Gf-pgRlPL6ME5VgMGSk2Q-1; Wed, 15 Apr 2020 03:55:18 -0400
X-MC-Unique: 7Gf-pgRlPL6ME5VgMGSk2Q-1
Received: by mail-ed1-f70.google.com with SMTP id u11so2191107edy.17
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 00:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9NRXRhj6CbLt930qAYqLVZ6D6jYWKAVwanbj9Ml6d48=;
 b=p+PKCmb7dvpzhM6ci6MiSlJwHTS5GVu72VTjuZ8Ul39A8UFXcCijkKZ4CA59GZHjY8
 tX/4FmS4dBeM9L+frPFkGmNT+8CrLQ4X8v4pLCUKIMruMZmnFu6RemrJ6y+dmtAEFJgT
 fIIsDBpj5nMUad9s6kyg+FaFMtc8Y7X2rWF6dzqpHBe5WJww2PnvKIWvGcauFksTLbCg
 /WPoCLEqzNbUol8YG9PmavR0rn9UUxJOFbocUiw8Jty/POQfMj1iIn+b+tz+itINI8pD
 m4qefYGz9so7KdIpf/2h/ICtoiEuzlktukk2dec+2JcOjmxPXQkUmJd/wcf27Qa8ta3+
 PWTQ==
X-Gm-Message-State: AGi0PuYMczIrQYx9tSNbDn29zsQyL5tzmUkFjnGoryxKHhHW1rFdZJG5
 I4Dxu3Tx9zFQD9lbH9mZC0MVtPNbHtdzibLdZ+TUpzG3zG3MDIms1d4bU4DWQHv5BhNQpZDh1t0
 rKbkIBVs4DcJvbAI=
X-Received: by 2002:a50:c0ce:: with SMTP id r14mr10156187edf.298.1586937317761; 
 Wed, 15 Apr 2020 00:55:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypKtH7EMneEApMnQiEG0M2bpPPTlDjJ7WTDuDbONWA11FhIpmHbFBdD4jIQ8Ahf2LlMXCvkNIg==
X-Received: by 2002:a50:c0ce:: with SMTP id r14mr10156169edf.298.1586937317485; 
 Wed, 15 Apr 2020 00:55:17 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id m3sm2492335ejj.22.2020.04.15.00.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 00:55:17 -0700 (PDT)
Subject: Re: [PATCH v7 11/48] nvme: refactor device realization
To: Klaus Birkelund Jensen <its@irrelevant.dk>
References: <20200415055140.466900-1-its@irrelevant.dk>
 <20200415055140.466900-12-its@irrelevant.dk>
 <e79da783-872a-4cda-a33e-4ba795fb4a59@redhat.com>
 <20200415072555.pvrircyuy2t4y3fj@apples.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aa44ad63-34a4-7c07-c2a0-3612883738a6@redhat.com>
Date: Wed, 15 Apr 2020 09:55:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415072555.pvrircyuy2t4y3fj@apples.localdomain>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 9:25 AM, Klaus Birkelund Jensen wrote:
> On Apr 15 09:14, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Klaus,
>>
>> This patch is a pain to review... Could you split it? I'd use one trivia=
l
>> patch for each function extracted from nvme_realize().
>>
>=20
> Understood, I will split it up!

Thanks, that will help the review.

As this series is quite big, I recommend you to split it, so part of it=20
can get merged quicker and you don't have to carry tons of patches that=20
scare reviewers/maintainers.

Suggestions:

- 1: cleanups/refactors
- 2: support v1.3
- 3: more refactors, strengthening code
- 4: improve DMA & S/G
- 5: support for multiple NS
- 6: tests for multiple NS feature
- 7: tests bus unplug/replug (idea)

Or less :)


