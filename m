Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B03C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6018D2073B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcifoXVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6018D2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdqY1-0003Jz-Ig
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 03:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdqX7-0002nt-Ff
 for qemu-devel@nongnu.org; Wed, 27 May 2020 03:31:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60203
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdqX4-0006U0-SY
 for qemu-devel@nongnu.org; Wed, 27 May 2020 03:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590564681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2ynpdWqHJJwEj18+gNA8pHLWNqgPhpTEp8f+FjQTjEg=;
 b=EcifoXVFP8YLqN1HoXfyh2eHz64GAN3zg3NofoTjwwHJ9VqnevygVzFDPzk/E+A1RAv0sZ
 ToqD2zkQQLS3yJvtW6Kqag6Fgj6MLp8zJ3RGECzPrpclHELvVbLA1Vu1CElO9EbH7MTnL1
 5+adppA2nfmmzzmiGDjJJXR/wyw8kfY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-LEyD4f5_NbKxnggZ6fMMaQ-1; Wed, 27 May 2020 03:31:20 -0400
X-MC-Unique: LEyD4f5_NbKxnggZ6fMMaQ-1
Received: by mail-wr1-f71.google.com with SMTP id n9so10841674wru.20
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 00:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=2ynpdWqHJJwEj18+gNA8pHLWNqgPhpTEp8f+FjQTjEg=;
 b=LlSsViQq2xBLIb/XKdU0h1fT7JeY8Y6/F/3LoYrGsio38yyho8Ilpn/q6iFNfDdvpW
 Q5LHlNobFgjAm0MT1KSpX0/VCTnB5xbIiVueKOtTT1vmHYZZNTpJY9gpg22R14Eqxt2n
 QLmFecxiIcW9S2lRlvv0wfuCqzI39FRyi2SCH+ZzXm8kLXFIhTwPazwbXHAQke1jBnkc
 u5Lxoolduaquere1kK2gXnzvi29EcurtwAwzDgOWnitG2/FyQ1CTsDHdW9Fb3UsN4+AD
 65KkiCmLPnErahu3Jkw4Ql5joKKuhMkI7kaDu4rvr2dwO4+MWeRjtZ8LzcdIGO1DsXNX
 01PQ==
X-Gm-Message-State: AOAM533PM9nCqJwvzACQRalGKA93vq7o3YhkXR8/KlwBvFYZraXB0pyI
 HhfJ6pPO8PuNbW5VqxeXS8uAn9ysebpTn/pJbXPPzGptLnT4W/Naj/qH+8rDSqW1prVSm6TUJKk
 9b1+mq1cDNWoGy0s=
X-Received: by 2002:a1c:a3c1:: with SMTP id m184mr3166364wme.91.1590564678494; 
 Wed, 27 May 2020 00:31:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhT4TkB9FI/rqJC1NP2/EHtqYerO74/SBA7tn0F+OENgbbuMzf4fEQwR5A1xUhg2oabZaDaQ==
X-Received: by 2002:a1c:a3c1:: with SMTP id m184mr3166318wme.91.1590564678140; 
 Wed, 27 May 2020 00:31:18 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id h137sm2872098wme.0.2020.05.27.00.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 00:31:17 -0700 (PDT)
Subject: Re: [PATCH v3 4/9] qapi/misc: Restrict balloon-related commands to
 machine code
To: Markus Armbruster <armbru@redhat.com>
References: <20200525150640.30879-1-philmd@redhat.com>
 <20200525150640.30879-5-philmd@redhat.com>
 <87eer787tr.fsf@dusky.pond.sub.org>
 <7e926561-c2c3-e815-8518-b283db7c60fd@redhat.com>
 <87mu5v3w3t.fsf@dusky.pond.sub.org>
 <7fb7564d-23cc-28b8-bf5f-a80797c518ec@redhat.com>
 <67d74bcb-ac60-a6f7-e485-7e419dbf50dc@redhat.com>
 <87r1v60yp8.fsf@dusky.pond.sub.org>
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
Message-ID: <cede76d5-57f5-31ce-60c4-8f148c936bbc@redhat.com>
Date: Wed, 27 May 2020 09:31:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87r1v60yp8.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:49:35
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Peter Lieven <pl@kamp.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 6:49 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 5/26/20 11:31 AM, Philippe Mathieu-Daudé wrote:
>>> +Laurent
>>>
>>> On 5/26/20 11:04 AM, Markus Armbruster wrote:
>>>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>>>
>>>>> On 5/26/20 9:38 AM, Markus Armbruster wrote:
>>>>>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>>>>>
>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>>>
>>>>>> A brief note on why restricting "to machine code" is useful would be
>>>>>> nice.  Same for the other patches.
>>>>>>
>>>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>>>>
>>>>>
>>>>> What about this?
>>>>>
>>>>> "QEMU can do system-mode and user-mode emulation.
>>>>> Only system mode emulate a machine.
>>>>> Remove this feature from the user-mode emulation."
>>>>
>>>> Is is a feature of user-mode emulation before the patch?  Or is it just
>>>> dead code?
>>>>
>>>> Hint: QMP commands tend to be dead code when the program doesn't expose
>>>> a QMP monitor :)
>>>
>>> Maybe a 'corollary' question, "How user-mode users use QMP?"
>>>
>>
>> I can't find a way to start a user-mode process with a QMP socket, is
>> there one?
> 
> As far as I can tell, only qemu-system-FOO and qemu-storage-daemon
> provide QMP monitors:
> 
> * Monitors need to be initialized with monitor_init().  Two callers:
>   monitor_init_hmp(), monitor_init_qmp().
> 
> * monitor_init() calls both, and is the common wat to create a monitor.
>   Called by vl.c via monitor_init_opts(), and by qemu-storage-daemon.
> 
> * monitor_init_hmp() has additional callers, but HMP doesn't matter
>   here.
> 

OK good to know. I'll reword the patch description, but also check if
there isn't a simpler way to avoid pulling QMP code in user-mode builds
first.

Thanks!

Phil.


