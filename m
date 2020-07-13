Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC83C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C50C205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tpybagor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C50C205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzO3-0004l9-CT
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juzGV-0007Jh-V3
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:17:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50435
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juzGS-0007Nb-V4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594649823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cverBh+Mzq6PyftR3eb27WY0EREdwzop+e65mlllqoU=;
 b=TpybagoroWW0on3wUsmK7HGVOjgOfhb2IcqUFtE74krt993/XkYBmKrR6O5+5+mhE0DhX5
 uVe8uXK/FGu7g2rfCjAw+iXabhLwLM2cU3PLXP+UvA3eQuOlnJ8424iICzbIoElYE17IDA
 2U3sgQ/P2l/ZLO2pd8+Azc2KwGp97Ec=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-YmaM4iJQMJWBufS4GM7sPA-1; Mon, 13 Jul 2020 10:16:54 -0400
X-MC-Unique: YmaM4iJQMJWBufS4GM7sPA-1
Received: by mail-ed1-f69.google.com with SMTP id c25so21309191edr.5
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=cverBh+Mzq6PyftR3eb27WY0EREdwzop+e65mlllqoU=;
 b=n/HR6EH8Qaz7SHucR8wWJWxcA7mEP1V7VNTBs87w/WjqFLn1EjIdoiWaM3GcdY2zr7
 OugPaX6bcXnCZivxf4Zko7U7Olhxfwr+3rsuihwbDwSdHpqeTHM9QtkLyUsvsA6jgvZh
 3ZovKMTYBy8zPh+b/oROC5N3pn2N3Zw4boLac9m0oDZlPD0twp/7QHlEplcA1eH1D5jt
 1bsKeKAYwhTUGSTO0unm8RIoqOKB+e13KwyjpTvk4T23iScShjd1NL2tnPXQSHAiKAW5
 CRj6lLbv+dOEPmTepfOmJ/n2cgNbZdJwYXXljmkZJONUFXAWjGaiRMCRYlP568LCiIlI
 ZiDg==
X-Gm-Message-State: AOAM53285JX4Buf+v84vWjFuLQXn+5kgh1kOMl8V4evpNBw5h1wSY2Z6
 W571vuMEm2+RERhKeqzK/iPBQZAsglQBVqA0jI18rbpmvuDQK40qk32wl48ZyzzWhg/Rhr84Oqf
 JQGm/86D+OUNXmzc=
X-Received: by 2002:a17:906:7709:: with SMTP id
 q9mr16811033ejm.123.1594649812903; 
 Mon, 13 Jul 2020 07:16:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9Pxsm9FUgZVTNPnjLaKriIXo53FE3KtjOpBBtWini7M7rljGyAF2L54vCW43i7zCGRqAmSg==
X-Received: by 2002:a17:906:7709:: with SMTP id
 q9mr16810996ejm.123.1594649812613; 
 Mon, 13 Jul 2020 07:16:52 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id cn16sm11476074edb.86.2020.07.13.07.16.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 07:16:52 -0700 (PDT)
Subject: Re: [PULL 10/41] python/qemu: Add ConsoleSocket for optional use in
 QEMUMachine
To: John Snow <jsnow@redhat.com>, Robert Foley <robert.foley@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
 <20200707070858.6622-11-alex.bennee@linaro.org>
 <fa8ee177-3a53-cde0-a8f1-8b0e8eba678f@redhat.com>
 <CAEyhzFsYb4KvDaeMGwjocSjU0QO957Eg_TQbi0oEr1c=rE5vwQ@mail.gmail.com>
 <9cec0aa2-afc8-43fd-31bc-d74e80588ecd@redhat.com>
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
Message-ID: <bd35e56d-118e-0b04-c708-424ec5bfa723@redhat.com>
Date: Mon, 13 Jul 2020 16:16:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9cec0aa2-afc8-43fd-31bc-d74e80588ecd@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 3:57 PM, John Snow wrote:
> On 7/11/20 12:15 PM, Robert Foley wrote:
>> Hi,
>> Thanks for the detailed feedback!  I will look at making these changes.
>>
> 
> Sorry that it came so late ...

I was looking for the patch that makes the python-next series rebase
to fail and now I see your comments :(

So we lost the race. I'll see what can still be merged.

Sorry it took so long due to the Avocado tests failing :(

OTOH I think it is time to declare the Python scripts need more
maintainers because we can't keep up. There are various scripts
and tests written in Python that missed the 5.1 freeze.

Cleber/Eduardo what do you think (about getting more maintainers
involved)?

Phil.

> 
>> On Fri, 10 Jul 2020 at 15:20, John Snow <jsnow@redhat.com> wrote:
>>>
>>>
>>>
>>> On 7/7/20 3:08 AM, Alex Bennée wrote:
>>>> From: Robert Foley <robert.foley@linaro.org>
>>>>
>>>
>> <snip>
>>>> +    def recv(self, n=1, sleep_delay_s=0.1):
>>>> +        """Return chars from in memory buffer"""
>>>> +        start_time = time.time()
>>>> +        while len(self._buffer) < n:
>>>> +            time.sleep(sleep_delay_s)
>>>> +            elapsed_sec = time.time() - start_time
>>>> +            if elapsed_sec > self._recv_timeout_sec:
>>>> +                raise socket.timeout
>>>> +        chars = ''.join([self._buffer.popleft() for i in range(n)])
>>>> +        # We choose to use latin1 to remain consistent with
>>>> +        # handle_read() and give back the same data as the user would
>>>> +        # receive if they were reading directly from the
>>>> +        # socket w/o our intervention.
>>>> +        return chars.encode("latin1")
>>>> +
>>>
>>> console_socket.py:89:4: W0221: Parameters differ from overridden 'recv'
>>> method (arguments-differ)
>>>
>>> Seems pretty different from the asyncore.dispatcher recv method, is that
>>> intentional?
>>
>> The intention is that the API be the same as asyncore.dispatcher recv.
>> The sleep_delay_s can be removed, and n is the same as buffer_size in
>> asyncore.dispatcher recv.  Will plan to rename n -> buffer_size.
>>
>>> https://github.com/python/cpython/blob/master/Lib/asyncore.py
>>>
>> <snip>
>>>>      def __enter__(self):
>>>>          return self
>>>> @@ -580,7 +591,11 @@ class QEMUMachine:
>>>>          Returns a socket connected to the console
>>>>          """
>>>>          if self._console_socket is None:
>>>> -            self._console_socket = socket.socket(socket.AF_UNIX,
>>>> -                                                 socket.SOCK_STREAM)
>>>> -            self._console_socket.connect(self._console_address)
>>>> +            if self._drain_console:
>>>> +                self._console_socket = ConsoleSocket(self._console_address,
>>>> +                                                    file=self._console_log_path)
>>>
>>> Needs one more space, but the line is already too long as-is.
>>>
>>>> +            else:
>>>> +                self._console_socket = socket.socket(socket.AF_UNIX,
>>>> +                                                     socket.SOCK_STREAM)
>>>> +                self._console_socket.connect(self._console_address)
>>>>          return self._console_socket
>>>>
>>>
>>> This makes the typing for _console_socket really tough ... but
>>> technically not a regression as the mypy code isn't merged yet.
>>
>> From the comment on mypy, I understand that we need to return a
>> constant type?
>>
> 
> It keeps the API simpler to do that, yeah.
> 
>> One option to provide a constant type is to simply always return
>> ConsoleSocket here.
>>
>> A few changes would be needed inside of ConsoleSocket,
>> but essentially ConsoleSocket would handle the detail
>> of draining the console (or not), and thus eliminate this
>> if/else above reducing it to something like this:
>>
>> self._console_socket = ConsoleSocket(self._console_address,
>>                                      file=self._console_log_path,
>>                                      drain=self._drain_console)
>>
>> How does this sound?
>>
>> Thanks & Regards,
>> -Rob
>>
> 
> That would be one way, but I'm not sure how hard it will be because
> other clients in the acceptance tests use the socket.makefile() routine
> -- does that work for the asyncore object?
> 
> The other way would be to offer a .drain_console() style routine that
> takes the existing console socket object, wraps it in the asyncore
> dispatcher, and returns a new object with its own type and behaviors.
> 
> It looks like asyncore is deprecated already, so isolating it into its
> own method would make it a bit easier to replace in the future, I'd think.
> 
> (I was working on prototyping something for you, but hadn't worked on it
> much over the weekend!)
> 
> Thanks,
> --js
> 


