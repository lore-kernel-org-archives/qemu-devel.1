Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2D5C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28DEE206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBMbhhvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DEE206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihGyQ-0004vf-CO
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 12:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihGvK-0001l2-Tc
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:46:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihGvF-0008Ck-AK
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:46:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32627
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihGvF-00087v-65
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576604772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hgyp8aFOxwbnjZz8MKaPAaBMpoQdNGm0eeFEmYCxueg=;
 b=VBMbhhvbOFOkqAeTSeGaX9ps/xl7db7Qpv2ZV60wq/nNzu8j3blK6tG0HTAsb6Z8+h1vm+
 wQLxr+450MUozBCvRw5Pw5B56KbSp2soHD0RaEw4TDXr1Mw3DuXxtgY691ukkcR8rWU2aU
 V0lBrbGCnXoP96szpS3o1Ohl9V6yXk8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-l1h4f-JaMXa-ojDexQ2UkQ-1; Tue, 17 Dec 2019 12:46:10 -0500
Received: by mail-wr1-f70.google.com with SMTP id c6so5614656wrm.18
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 09:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iECONfyBb+ug7OO4m/el+DIzMWF9W7nqu4KhOwtXQgI=;
 b=nQAZUdbdWXBCKF7QDHGUmRvKGA2p3vmTd5cSXQCpJjbRzNeGOh9BGkdj168cPI72LM
 AkVgUaqF8d8zyPtFia2eciUJFrVrRoDx8Obhwqtm2QIAjbjwswO13C5Dd6fMfgE+ooLG
 2wAG+jPikl/P1Fp5Ve0C+OPMJXTxR8wzBCq4Jw7/PjlfKrQVDbfeSFJw7YzLtVLymMSV
 Xm0Kl+YPM8pDydJdNI7jSyHc8qnJJffdZDai3f3l3xAHjQTt/viR/NcUMT5yZCPVg/A1
 gYAyVm9q6Edqe443aDi9W42zfq9IQqWMyJL0JuASnZIB6SWwYPOUIM8TqU4GU5Wpkaih
 PA1w==
X-Gm-Message-State: APjAAAWxUqD3BfakQb0gjuP8BhCIkwn7+09IpSJEQPnc5iIMBxjLWrwM
 sZruRQv5MD/13Jx6Fh990tXrXzc4BAHXokFYtOqTKtlvtHNFU59iWgYmItG5mh1dKgtROMr46Gw
 99AP5aaqMcFMRUXM=
X-Received: by 2002:a1c:7508:: with SMTP id o8mr6691313wmc.74.1576604769324;
 Tue, 17 Dec 2019 09:46:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZmW+XWk3gCEz+euqRif8HEwIfM0MRQrqD908icND3EVoeDiOO26gLAPhNIlBv2TxFrT6NOQ==
X-Received: by 2002:a1c:7508:: with SMTP id o8mr6691297wmc.74.1576604769117;
 Tue, 17 Dec 2019 09:46:09 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id o4sm26076835wrw.97.2019.12.17.09.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 09:46:08 -0800 (PST)
Subject: Re: [RFC PATCH 10/14] monitor/hmp: Explicit we ignore a QEMUChrEvent
 in IOEventHandler
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20191217163808.20068-1-philmd@redhat.com>
 <20191217163808.20068-11-philmd@redhat.com> <20191217173722.GD2780@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b167f6ce-c39b-370b-5016-abd2f859390b@redhat.com>
Date: Tue, 17 Dec 2019 18:46:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217173722.GD2780@work-vm>
Content-Language: en-US
X-MC-Unique: l1h4f-JaMXa-ojDexQ2UkQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 6:37 PM, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
>> The Chardev events are listed in the QEMUChrEvent enum. To be
>> able to use this enum in the IOEventHandler typedef, we need to
>> explicit when frontends ignore some events, to silent GCC the
>> following warnings:
>>
>>      CC      monitor/hmp.o
>>    monitor/hmp.c: In function =E2=80=98monitor_event=E2=80=99:
>>    monitor/hmp.c:1330:5: error: enumeration value =E2=80=98CHR_EVENT_BRE=
AK=E2=80=99 not handled in switch [-Werror=3Dswitch]
>>     1330 |     switch (event) {
>>          |     ^~~~~~
>>    cc1: all warnings being treated as errors
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>=20
>=20
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>    for HMP
>=20
> Note that the use of 'default' will make life more unpredictable
> if you ever come to add a new event type.

You are right, this patch not good as it dumbly ignore the warning...
I will add all the missing cases:

-- >8 --
@@ -1371,6 +1371,10 @@ static void monitor_event(void *opaque, int event)
          mon_refcount--;
          monitor_fdsets_cleanup();
          break;
+
+    case CHR_EVENT_BREAK:
+        /* Ignored */
+        break;
      }
  }

---

And keep your Acked-by. Thanks!

>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> ---
>>   monitor/hmp.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/monitor/hmp.c b/monitor/hmp.c
>> index 8942e28933..d84238c120 100644
>> --- a/monitor/hmp.c
>> +++ b/monitor/hmp.c
>> @@ -1371,6 +1371,10 @@ static void monitor_event(void *opaque, int event=
)
>>           mon_refcount--;
>>           monitor_fdsets_cleanup();
>>           break;
>> +
>> +    default:
>> +        /* Ignore */
>> +        break;
>>       }
>>   }
>>  =20
>> --=20
>> 2.21.0
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20


