Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FA6C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD7F205CB
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD7F205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE8Bo-0003c2-Ii
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 05:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kE8AY-0001fg-83
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 05:38:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49124
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kE8AW-0006RM-9H
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 05:38:05 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-DHftipXEO6aeDdXB9V_igg-1; Fri, 04 Sep 2020 05:38:01 -0400
X-MC-Unique: DHftipXEO6aeDdXB9V_igg-1
Received: by mail-wr1-f70.google.com with SMTP id 33so2119905wrk.12
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 02:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=U0Y4H3aO3NKQExvXZmGFVpyfxOYpPDCKH0OxifGRReY=;
 b=MOsHhhp+p1trgn8cJzHmdmnqK8jquK69MAFUqO0ZHXapdLseW/zfcbEQ80BXm7yspi
 Ff87RbQ9WERt9g3EMXsmFxUP9V4erfsTrPLMvYT0mmKtmgpgF2gycPP5SY3//MGAQz+U
 L+Fq/Tu7Cf3IM7kIo+SOVjyF5uMjH0iZK5PI0Yt14ZOf83TBMjZ/KLcJMEfBbceWoA1W
 1OaJU7Gm5D1G66jz05fmgNoHIWFghE7OpUPs8vfgkz6EYpi6qlKxhiXXJIYJSIp3s5hN
 wIprgXQTwQr9fh9svNZIuA0ain6r5aNKF+ZFPhWp0t/eIVEqy/oLN8UzcuT5Vvnf7No2
 r8Kw==
X-Gm-Message-State: AOAM533c9jzR2i02Rj+KThUDuZePQ10WU8xuqIpU7hbmr+wYdrPjQfRA
 ig6eihmv2/vkNq1O7zKi2Rf4247ytF/54jLxGqkwzWMXX7FGKveW5bTXDHjrQieWWP4dcFcj+WH
 boQUt/ZX6xIWPilg=
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr6499492wrp.286.1599212280002; 
 Fri, 04 Sep 2020 02:38:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL6O5H8M06IILTcUNKo74I126a6Hrgw/P2D9fUiHW7GKZXc0o5iiV4AizFpFWYSwpIXKkD4A==
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr6499474wrp.286.1599212279776; 
 Fri, 04 Sep 2020 02:37:59 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id k4sm10068260wrx.51.2020.09.04.02.37.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 02:37:59 -0700 (PDT)
Subject: Re: [PATCH] meson: install ivshmem-client and ivshmem-server
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200903153524.98168-1-brogers@suse.com>
 <4eba2feb-a9b3-8bb7-6ed7-6b02c79519b1@redhat.com>
 <20200903154906.GA441291@redhat.com>
 <69f279ce-30e8-e83c-718b-021d3e6b264d@redhat.com>
 <87a6y6dmy4.fsf@dusky.pond.sub.org>
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
Message-ID: <22ec640f-a9e4-22ad-020c-e035e8143e6c@redhat.com>
Date: Fri, 4 Sep 2020 11:37:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87a6y6dmy4.fsf@dusky.pond.sub.org>
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: marcandre.lureau@redhat.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 9:24 AM, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 03/09/20 17:49, Daniel P. Berrangé wrote:
>>> On Thu, Sep 03, 2020 at 05:44:25PM +0200, Paolo Bonzini wrote:
>>>> On 03/09/20 17:35, Bruce Rogers wrote:
>>>>> Turn on the meson install flag for these executables
>>>>>
>>>>> Signed-off-by: Bruce Rogers <brogers@suse.com>
>>>>> ---
>>>>>  contrib/ivshmem-client/meson.build | 2 +-
>>>>>  contrib/ivshmem-server/meson.build | 2 +-
>>>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/contrib/ivshmem-client/meson.build b/contrib/ivshmem-client/meson.build
>>>>> index 1b171efb4f..83a559117f 100644
>>>>> --- a/contrib/ivshmem-client/meson.build
>>>>> +++ b/contrib/ivshmem-client/meson.build
>>>>> @@ -1,4 +1,4 @@
>>>>>  executable('ivshmem-client', files('ivshmem-client.c', 'main.c'),
>>>>>             dependencies: glib,
>>>>>             build_by_default: targetos == 'linux',
>>>>> -           install: false)
>>>>> +           install: true)
>>>>> diff --git a/contrib/ivshmem-server/meson.build b/contrib/ivshmem-server/meson.build
>>>>> index 3a53942201..a1c39aa3b3 100644
>>>>> --- a/contrib/ivshmem-server/meson.build
>>>>> +++ b/contrib/ivshmem-server/meson.build
>>>>> @@ -1,4 +1,4 @@
>>>>>  executable('ivshmem-server', files('ivshmem-server.c', 'main.c'),
>>>>>             dependencies: [qemuutil, rt],
>>>>>             build_by_default: targetos == 'linux',
>>>>> -           install: false)
>>>>> +           install: true)
>>>>>
>>>>
>>>> They weren't installed before the conversion, were they?
>>>
>>> Unfortunately they were historically installed with --enable-tools.
>>>
>>> IMHO nothing in contrib/ should be installed by default. If we consider
>>> something maintained and high enough quality for end users, it should
>>> migrate out of contrib/ into tools/.
>>
>> Ah, via the tools variable in configure.  Nice maze.  I've queued the patch.
> 
> Please don't.
> 
> These programs are examples to help people understand how the ivhsmem
> device works.  They might even be useful for debugging.  They are *not*
> to be used in production.
> 
> docs/specs/ivshmem-spec.txt:
> 
>     Example server code is in contrib/ivshmem-server/.  Not to be used in
>     production.  It assumes all clients use the same number of interrupt
>     vectors.
> 
>     A standalone client is in contrib/ivshmem-client/.  It can be useful
>     for debugging.

Renaming the file names to contain "example" would make this clear.

> 
> Installing example *source* might make sense (but I doubt it).
> Installing the binaries does not.
> 
> 


