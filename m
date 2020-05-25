Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA53EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813CF2078B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1kknTzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813CF2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdAlj-00043S-LF
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 06:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdAl8-0003Tg-IU
 for qemu-devel@nongnu.org; Mon, 25 May 2020 06:55:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24704
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdAl6-0004RS-Tk
 for qemu-devel@nongnu.org; Mon, 25 May 2020 06:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590404103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N/PwbsGcP0iXL6gADbZYwvYqT0WL8IuddmJc2BaMXzY=;
 b=R1kknTzq8Kre97d2dl13CJTdiIrkeTp0bSc/DCuNvO1JJrLWozptpWcSbhrN5XyczUvPsQ
 XJ0fZzJ7MwnsO4It+GcTRh3DqwxGfYQbU7h11TqgSZEc3zqdHZ0tRXgov1YO28EPEiVX78
 FZk6q4dMyPj9PckKKRGY8g1+q+kC0fQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-lAN-JKkKOeqKFo1TUiqJew-1; Mon, 25 May 2020 06:55:01 -0400
X-MC-Unique: lAN-JKkKOeqKFo1TUiqJew-1
Received: by mail-wm1-f70.google.com with SMTP id f62so6580266wme.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 03:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=N/PwbsGcP0iXL6gADbZYwvYqT0WL8IuddmJc2BaMXzY=;
 b=msNi3XZTRIQCST3UP4EqekoMGi3zyX9km0pwzQCJBntXyI7wxsIRrCiVG962F1mhe6
 JGPcKTq7ZmicKU/Mk/Iz3tNbNAiNBn4F4Rye/VRawssIMWM5SXwisZ2q/AYmhXt1zeKh
 8soDHOq547ptnSXIFnSyo6c39ay+qs4VKmwBqdz7v2bZkvigTe9o03hA8kWy4jej8G5j
 h+nu5ZSkxPcpJ3eNtc0TjWgPyFVI5HwI69n3EAXRXnJsRkGtcm3RVdhRbdyc6H35VdxA
 UxvAlZHky1Yzxl2bi4plI0m98we8ZxDmn4Kn73R7MBGhlnuKkvr4A3aSqGJcY/YCLCeT
 Aaig==
X-Gm-Message-State: AOAM531BXAYfVRdAKFmDLu+/B4GDXmuSK9C7g5F9AVoI8ZPbDB+SGTLR
 DMSqr7wcbw5/jL3Z/19iNviKT/rT/3b7Jq+yTnYUllRz3VBoZtQRwD+ah7ySqZT/xn9ql7cHg1z
 VBWw1mgCPLyduOn8=
X-Received: by 2002:adf:ed51:: with SMTP id u17mr5454018wro.285.1590404100329; 
 Mon, 25 May 2020 03:55:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKK25arId7IxI/cqos7iuA2BzW2wgh2Mg4dz9VN16WaxtZgy4Awz6nMIsBd0rZwkDhgi5Ifw==
X-Received: by 2002:adf:ed51:: with SMTP id u17mr5453996wro.285.1590404100108; 
 Mon, 25 May 2020 03:55:00 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id m13sm17377222wmi.42.2020.05.25.03.54.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 03:54:59 -0700 (PDT)
Subject: Re: [PATCH v6 1/3] memory: drop guest writes to read-only ram device
 regions
To: Paolo Bonzini <pbonzini@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20200430080744.31232-1-yan.y.zhao@intel.com>
 <20200430080946.31286-1-yan.y.zhao@intel.com>
 <CAFEAcA-8NH_4ZV0J9urBZdQWmqOe-Nyy4y2gLAjTJ08MpfFY0g@mail.gmail.com>
 <9dd7f00b-1199-1097-80d4-1b700c0f28d6@redhat.com>
 <20200525011853.GB8867@joy-OptiPlex-7040>
 <f836eeb3-0655-2842-2e8a-b8a42710a765@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <229ec974-1939-31d8-3516-12e7b8fee27f@redhat.com>
Date: Mon, 25 May 2020 12:54:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f836eeb3-0655-2842-2e8a-b8a42710a765@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 06:55:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, xin.zeng@intel.com,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 12:20 PM, Paolo Bonzini wrote:
> On 25/05/20 03:18, Yan Zhao wrote:
>> On Thu, May 21, 2020 at 04:38:47PM +0200, Paolo Bonzini wrote:
>>> On 30/04/20 11:40, Peter Maydell wrote:
>>>>> This does not "drop" a write to a r/o region -- it causes it to generate
>>>>> whatever the guest architecture's equivalent of a bus error is (eg data
>>>>> abort on Arm).
>>>
>>>
>>>> More generally, this change seems a bit odd: currently we do not
>>>> check the mr->readonly flag here, but in general guests don't get
>>>> to write to ROM areas. Where is that check currently done
>>>
>>> Writes to ROM are directed to mr->ops unassigned_mem_ops.  Because _all_
>>> ram-device reads and writes go through the ops, for ram-device we have
>>> to stick the check for mr->readonly in the ops.
>>>
>>> On one hand, I was quite surprised to see that unassigned_mem_write does
>>> not return MEMTX_ERROR now that I looked at it.
>>>
>>> On the other hand, we should use MEMTX_ERROR in patch 2 as well, if we
>>> decide it's the way to go.
>>>
>>> (Sorry Yan for the late response).
>>>
>> hi Paolo,
>> thanks for your reply and never mind :)
>>
>> But there's one thing I just can't figure out the reason and eagerly need
>> your guide.
>>
>> why do we have to convert all .write operations to .write_with_attrs and
>> return MEMTX_ERROR? because of the handling of writes to read-only region?
> 
> Not all of them, only those that need to return MEMTX_ERROR.  I would
> like some guidance from Peter as to whether (or when) reads from ROMs
> should return MEMTX_ERROR.  This way, we can use that information to
> device  what the read-only ram-device regions should do.

Is it only device-specific or might it be partly arch/machine-specific
(depending on the bus it is mapped)?

Phil.


