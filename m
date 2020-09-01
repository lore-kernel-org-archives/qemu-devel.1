Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A37C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:16:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E00A206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E00A206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3Ky-0000RS-A4
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD3Jn-0007vj-2r
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:15:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD3Jl-0006W0-Bw
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:15:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id a12so863946eds.13
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 03:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fsHn0y7UM6Va67V0qG3UBaiJqnO2aKr95wGq6fE4alk=;
 b=UYhdc1WEDznilZ29Bq4/e/H53GQ9n5TTooU3AnX7eNQB9YYqg0UlmX6cv9Zk+tTMtt
 L1U2OqoKqH33Zk8MUmXblQ2vJMgXz5E05c4sleEIziAun5BpOmgL1e5w70fOyC60lbMA
 3DXlTXIKTFcmG/r6mAdc6yprwJ/gEl1iCG7e0GkyLZg+UcVTC9DpnOwTDZPEANRTM/f4
 tSRuhCcK4ho8lWvjmkMzsc6foAfQhkuv7PA/zXyaMJ3GDyV2jIrANf1MQbpm+UUsup9W
 nav+SjjqwrvBAAueo8h0mr97FlJj7OE+Ih9BAE7tNXkhKPe0jcxkz92l4G/Cmgk+TZme
 XnwQ==
X-Gm-Message-State: AOAM533dX0Q1g+S9prnKN1ZJlAI7JCEcxjrsiUiCqKA5wwVcmUbqq1mf
 +f8EgUV10zC5T+wPJb0QYkDYjCRZV+FzLcO2quw=
X-Google-Smtp-Source: ABdhPJx/CPcrK7kVEmoRVCB2B5ETs9OeZrl8Nc7VlAnjgy0oLjg53D1Ciqz7YuDOMf5X8AjSNsddeg+31u5QNr4rcrA=
X-Received: by 2002:a05:6402:1641:: with SMTP id
 s1mr1159227edx.66.1598955307860; 
 Tue, 01 Sep 2020 03:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200827210920.111611-1-sw@weilnetz.de>
 <CAAdtpL5wdBnXO8NqArE0Fgad8EU7bXTKc83daQo4kfHW=8XvHQ@mail.gmail.com>
In-Reply-To: <CAAdtpL5wdBnXO8NqArE0Fgad8EU7bXTKc83daQo4kfHW=8XvHQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 1 Sep 2020 12:14:56 +0200
Message-ID: <CAAdtpL6itteQJqgVL0irWki=EYHUT_tGwaNtES3Bk4WbJ=43xg@mail.gmail.com>
Subject: Re: [PATCH] libvhost-user: Add GCC_FMT_ATTR and fix format string
To: Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.208.65;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 06:15:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 31, 2020 at 9:52 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
>
> Le jeu. 27 ao=C3=BBt 2020 23:09, Stefan Weil <sw@weilnetz.de> a =C3=A9cri=
t :
>>
>> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>> ---
>>  contrib/libvhost-user/libvhost-user.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-us=
er/libvhost-user.c
>> index 53f16bdf08..ff7ac876f4 100644
>> --- a/contrib/libvhost-user/libvhost-user.c
>> +++ b/contrib/libvhost-user/libvhost-user.c
>> @@ -151,7 +151,7 @@ vu_request_to_string(unsigned int req)
>>      }
>>  }
>>
>> -static void
>> +static void GCC_FMT_ATTR(2, 3)
>>  vu_panic(VuDev *dev, const char *msg, ...)
>>  {
>>      char *buf =3D NULL;
>> @@ -643,7 +643,7 @@ generate_faults(VuDev *dev) {
>>
>>          if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
>>              vu_panic(dev, "%s: Failed to userfault region %d "
>> -                          "@%p + size:%zx offset: %zx: (ufd=3D%d)%s\n",
>> +                          "@%016"PRIx64" + size:%zx offset: %zx: (ufd=
=3D%d)%s\n",
>
>
> I thought I had fixed this last month, but I don't have my email backlog,

Ah not it was you =3D) I remember having looked at it.
https://www.mail-archive.com/qemu-devel@nongnu.org/msg724900.html

> so:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>>                       __func__, i,
>>                       dev_region->mmap_addr,
>>                       dev_region->size, dev_region->mmap_offset,
>> --
>> 2.28.0
>>
>>

