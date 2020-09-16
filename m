Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C413EC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0878021655
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hog2XY6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0878021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIUWI-0005r2-Vc
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 06:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIUVk-0005QD-Lx
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 06:18:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIUVi-0004E4-Hn
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 06:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600251477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N8a/1nKmsclffCw3fphUHb2KMnKmOjIiLbARiP3uQho=;
 b=hog2XY6Mq2jB8CK35NF43xNBf7lX+5maUmkAhu0kqiEL6uHVg4O2F7g2cG51pEr+C/dOxB
 O/Bazyw4+HHFF5Shgewyyo9wNwbDgQgLRptpXHWcltiRFfKpURKvotmQUQ1/5dKXB2FVs8
 q6OJu342rMjxIVF2tckwyRzsQVK77sY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-Lq0FH4lDP_OvCWVwc8Cxkw-1; Wed, 16 Sep 2020 06:17:55 -0400
X-MC-Unique: Lq0FH4lDP_OvCWVwc8Cxkw-1
Received: by mail-wr1-f72.google.com with SMTP id b7so2365572wrn.6
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 03:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=2wl43MCWInQxuJe/47emjAtN40bHghr5rY+Hc61WKJw=;
 b=OAqGrQpYIfs61S05kV/P1hoRT4OIMdmZP6UsA+cjJT1t9qNq9BCNP8RGAJVAcab7H5
 8viAMR0FeoZgRB/tov6p2hSLSYxczkAIkoBhbvVqEFYxBwzn4AxJxj0O9UXHVWAmsN1A
 4EQKD2veljDJ5hBgKkGATFBk6qY4BLkhQdJz3nHiu3VxdCkeP8Mw/9iYPSoMQN11VYPE
 3auTbdSw2zzQmvaZPteAMyEYZt9RTmCnRwXT6Dn6gSiH7Jfe+aSdcyXue+QMBR8TZkWu
 CToS3wuKJ/s/aIehrqg/vy9TplLovwqama88EKKU4lJE2R0Kl+ouTSMnGVCNpXef9abg
 ctzw==
X-Gm-Message-State: AOAM532wN68WPfc/ASG1F9w3MeszHuWu0DhPyrAUeSVne71gZQe8MmWa
 p+iwzyFIqOGAvgQ6V4eKHmKZExHWBxuwZs6903UMNp9UduypqFHuw5/JgO+jct3EPGrHTo9BrVl
 SBBwAKG+Ckq+XsOI=
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr4135247wmi.105.1600251474339; 
 Wed, 16 Sep 2020 03:17:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycH0m2ajNCRaOMrpkbeMmEbu8w7g8/oXfGYqljmmK6drlC5847W0inMG+eKMzqtEbBy6BRLQ==
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr4135222wmi.105.1600251474103; 
 Wed, 16 Sep 2020 03:17:54 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id z7sm32097403wrw.93.2020.09.16.03.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 03:17:53 -0700 (PDT)
Subject: Re: [PATCH 2/3] hostmem-file: add readonly=on|off option
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200804101244.1283503-1-stefanha@redhat.com>
 <20200804101244.1283503-3-stefanha@redhat.com>
 <8f7b344e-87a5-3260-ae71-96758270fb27@redhat.com>
 <20200916093133.GA749356@stefanha-x1.localdomain>
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
Message-ID: <933eea5f-137b-a537-8165-6b5a4896aecd@redhat.com>
Date: Wed, 16 Sep 2020 12:17:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200916093133.GA749356@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 11:31 AM, Stefan Hajnoczi wrote:
> On Fri, Aug 21, 2020 at 02:50:42PM +0200, Philippe Mathieu-Daudé wrote:
>> On 8/4/20 12:12 PM, Stefan Hajnoczi wrote:
>>> Let -object memory-backend-file work on read-only files when the
>>> readonly=on option is given. This can be used to share the contents of a
>>> file between multiple guests while preventing them from consuming
>>> Copy-on-Write memory if guests dirty the pages, for example.
>>>
[...]

>>> +static bool file_memory_backend_get_readonly(Object *o, Error **errp)
>>> +{
>>> +    return MEMORY_BACKEND_FILE(o)->readonly;
>>> +}
>>> +
>>> +static void file_memory_backend_set_readonly(Object *o, bool value,
>>> +                                             Error **errp)
>>> +{
>>> +    HostMemoryBackend *backend = MEMORY_BACKEND(o);
>>> +    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
>>> +
>>> +    if (host_memory_backend_mr_inited(backend)) {
>>> +        error_setg(errp, "cannot change property 'readonly' of %s.",
>>> +                   object_get_typename(o));
>>
>>
>> The 'host_memory_backend_mr_inited()' function is not documented;
>> my understanding is a backend is considered initialized once it has
>> a MemoryRegion assigned to it.
>>
>> So this error message is not very helpful, it doesn't explain the
>> reason. I see all other setters in this file use the same error,
>> so it is almost a predating issue.
>>
>> Still I'd rather use a different message, something like:
>> "'%s' already initialized, can not set it 'readonly'".
>>
>> Preferably with the error message reworded:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> I haven't reworded the error message because it's used in
> hostmem-file.c, hostmem-memfd.c, and hostmem.c. A separate patch would
> need to change the error messages across these files.
> 
> There is no time when users can actually change these QOM properties, so
> "cannot change FOO" is a reasonable wording form the user perspective.
> Telling the user that there is a pre-initialization state when the
> property can be change isn't useful because they cannot observe that
> state (the object is created and ->complete is called in a single step).

OK, understood.


