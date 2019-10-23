Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FE0CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A1F20640
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A1F20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNFQD-0004Io-81
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 08:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNEyj-0005Jt-22
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNEyh-0005eP-A1
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:39:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNEyh-0005cd-0N
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:38:59 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C13FAC0568FA
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 11:38:57 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id z5so5661011wma.5
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 04:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WcYlKaqZ5QlZLXf1AJA7h2HtklaqRPbbFWAJuQWfLG8=;
 b=aFSbH6H8U7DLboxKF0a1O2I1z+qK/s7NILGDzFWzWhNmrVFcTsH7mm91eWpUzOHArk
 i/iPLSi4QDBacBa1G3pKAFjWE/JzNjH8gEOmDVV9ZCCJ25ag+zYukRK8E2O3z+b4sg7n
 ++D4HdeYg9Rat4FuDrK+zn2Wwj1g9r2cLxrZ/PTiNV5UUtSGEm1+noKsPyoUHyyLyR/f
 sDIHUjD5VriTxVqNXzhku10tiA6B8eB5wj3SopuP7F46KehHZlW/7pg4Nhh4OQiIFXte
 ezmsNlCjkDIA+fnzOUCKLLS3Fj1j4OeuTyzMGNywiXmBEUAA/F1BiDvTOhllPwYHC2Z3
 B1og==
X-Gm-Message-State: APjAAAV3zLX/w1tz6I5lvp0dXt/PK7p/kP296BMTzokO4VKl4Q6/FU4D
 KYmqvFYJChyqekmMO6SnOlfSwqVebmQ+j9aN4Hm4PuF89CocNsgPNj5NPoqWwC+5WC4wrpgw3kq
 q4WMBX/GPD7HbIls=
X-Received: by 2002:a05:6000:44:: with SMTP id
 k4mr8208016wrx.170.1571830736576; 
 Wed, 23 Oct 2019 04:38:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxCNlw4oabzu7Be343MTb/0BJhOOjleLZkxRs8kg1iMyp8T7uAaGwtDz5zk6fluCTC6L18gjA==
X-Received: by 2002:a05:6000:44:: with SMTP id
 k4mr8208002wrx.170.1571830736391; 
 Wed, 23 Oct 2019 04:38:56 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id r3sm36745763wre.29.2019.10.23.04.38.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 04:38:55 -0700 (PDT)
Subject: Re: [RFC PATCH 1/4] net/awd.c: Introduce Advanced Watch Dog module
 framework
To: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
References: <20191016112209.9024-1-chen.zhang@intel.com>
 <20191016112209.9024-2-chen.zhang@intel.com>
 <e294876e-d26b-b401-78ab-487e1b44685f@redhat.com>
 <9CFF81C0F6B98A43A459C9EDAD400D78062C3894@shsmsx102.ccr.corp.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bea650cd-b790-ba3c-3872-3b1af5682318@redhat.com>
Date: Wed, 23 Oct 2019 13:38:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D78062C3894@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 1:09 PM, Zhang, Chen wrote:
>> -----Original Message-----
>> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Sent: Wednesday, October 23, 2019 7:01 PM
>> To: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
>> <jasowang@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; qemu-
>> dev <qemu-devel@nongnu.org>
>> Cc: Zhang Chen <zhangckid@gmail.com>
>> Subject: Re: [RFC PATCH 1/4] net/awd.c: Introduce Advanced Watch Dog
>> module framework
>>
>> Hi Chen,
>>
>> On 10/16/19 1:22 PM, Zhang Chen wrote:
>>> From: Zhang Chen <chen.zhang@intel.com>
>>>
>>> This patch introduce a new module named Advanced Watch Dog, and
>>> defined the input and output parameter. AWD use standard chardev as
>>> the way of communicationg with the outside world.
>>> Demo command:
>>> -object
>>> advanced-
>> watchdog,id=3Dheart1,server=3Don,awd_node=3Dh1,notification_node=3Dhe
>>> artbeat0,opt_script=3Dopt_script_path,iothread=3Diothread1,pulse_inte=
rval=3D
>>> 1000,timeout=3D5000
>>>
>>> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
>>> ---
>>>    net/Makefile.objs |   1 +
>>>    net/awd.c         | 261
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>    qemu-options.hx   |   6 ++
>>>    3 files changed, 268 insertions(+)
>>>    create mode 100644 net/awd.c
>>>
>>> diff --git a/net/Makefile.objs b/net/Makefile.objs index
>>> c5d076d19c..139b1394e9 100644
>>> --- a/net/Makefile.objs
>>> +++ b/net/Makefile.objs
>>> @@ -19,6 +19,7 @@ common-obj-y +=3D colo-compare.o
>>>    common-obj-y +=3D colo.o
>>>    common-obj-y +=3D filter-rewriter.o
>>>    common-obj-y +=3D filter-replay.o
>>> +common-obj-y +=3D awd.o
>> Can you add a net/Kconfig file introducing the ADVANCED_WATCHDOG
>> selector?
>>
>> config COLO_ADVANCED_WATCHDOG
>>       bool
>>       default n
>>
>> Then use here:
>>
>>       common-obj-$(COLO_ADVANCED_WATCHDOG) +=3D awd.o
>>
>=20
> Sure, but AWD is a universal module,  COLO is just the first user.
> Maybe use "config ADVANCED_WATCHDOG" is better.

Oh I see, better then.

Then we might add (later)

   config COLO
       ...
       select ADVANCED_WATCHDOG

Thanks!

Phil.

>>>    tap-obj-$(CONFIG_LINUX) =3D tap-linux.o
>>>    tap-obj-$(CONFIG_BSD) =3D tap-bsd.o
>> [...]

