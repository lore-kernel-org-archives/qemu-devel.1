Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE87C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA4120738
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnNYmeh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA4120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFEXg-0007Cx-53
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 06:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFEWn-0005nb-TT
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:37:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFEWl-0004Dc-2v
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599475054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cnINg1J2bCej3r7Z8gr9dtDdjjmqX6IoTmfKECstSoQ=;
 b=dnNYmeh/xqjt6iymFkKVvWDC2/kIIOQKa4/LpWJlYlUvL+WTIobKsbWGSmkm3QAZrMJquF
 6W9/HZq2kHt4rcOIqBrwRAQjn2wFshKrYnLg/2oeGj23Drh/0Q8c1hLDxlPHFDvLoE6Yvj
 yodfWdoxSdjNtLWCpqHgkW1iFBjFAmM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-h6JQsTEgOOCyqZwNgfuhGA-1; Mon, 07 Sep 2020 06:37:32 -0400
X-MC-Unique: h6JQsTEgOOCyqZwNgfuhGA-1
Received: by mail-wr1-f69.google.com with SMTP id r15so5544239wrt.8
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 03:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=cnINg1J2bCej3r7Z8gr9dtDdjjmqX6IoTmfKECstSoQ=;
 b=QzlaVauPAuInxejYqb4rBQVdvooqgrutfO7Qn/09lEsohpxn7vleFlGptaa0M75+3O
 D6g314zfREUkh9e8GM1lsWhfnQ/UoX4U5WsdfE0oFd63J9YtrpCziJC+KM5wDjYjOMMa
 UPH6w9WlBkGfDntba2ynKWbdHp9Yyl46z05klaSEKtK29IcDU3ZH0y6Lsdyd8C8Y7aBh
 FkC69OqGzHyA8yF0aedKXMg+z/QCtFjMgOehH3/+KfRnq/5i7hVDS+M6ZMRMRFNYXrqA
 ufudh3TU9OyPS62ONytXYCg9Fs028gt/Rjjlc+uKiQoHOeGgrcdyz+y5uB7fpf4sdi0j
 wTHg==
X-Gm-Message-State: AOAM533aKTvCwgfOS0nw9Yshpw/RqQXvJV/CY5RgIB2DNXm7xa8aRKwp
 Q68i3XD536RMBCRjoUkiNvJrNfyn1IpAwzivkyeiFvxouv7xEZ7FeW8q9FDpxUl49WdXDZyTc0Q
 RDOMVD4Twv4hI5Uk=
X-Received: by 2002:a1c:9a8c:: with SMTP id
 c134mr19094173wme.136.1599475051584; 
 Mon, 07 Sep 2020 03:37:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0HP48YkdgFwwki3M4qL26Uu7KVraRZgU8Cq9Zw9qMOE70OiGmLvE00GFBCVeFeQg+C0iC1A==
X-Received: by 2002:a1c:9a8c:: with SMTP id
 c134mr19094128wme.136.1599475051271; 
 Mon, 07 Sep 2020 03:37:31 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d2sm8197847wro.34.2020.09.07.03.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 03:37:30 -0700 (PDT)
Subject: Re: [PATCH 1/4] Acceptance tests: use an available kernel image
 package for arm
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200907042000.415931-1-crosa@redhat.com>
 <20200907042000.415931-2-crosa@redhat.com>
 <001385a1-92eb-d311-88b5-8e1e7f6f1f48@redhat.com>
 <20200907093930.GD810755@redhat.com>
 <34814b29-a47a-efd3-971b-520bc5ac6309@redhat.com>
 <20200907102849.GE810755@redhat.com>
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
Message-ID: <8b99d285-3225-1fdd-3e49-56c9752698f0@redhat.com>
Date: Mon, 7 Sep 2020 12:37:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907102849.GE810755@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 02:54:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.69, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 qemu-arm@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 12:28 PM, Daniel P. Berrangé wrote:
> On Mon, Sep 07, 2020 at 11:59:18AM +0200, Philippe Mathieu-Daudé wrote:
>> On 9/7/20 11:39 AM, Daniel P. Berrangé wrote:
>>> On Mon, Sep 07, 2020 at 10:06:13AM +0200, Philippe Mathieu-Daudé wrote:
>>>> [Cc'ing Daniel who usually have good ideas for that
>>>> kind if project-wide problem]
>>>>
>>>> On 9/7/20 6:19 AM, Cleber Rosa wrote:
>>>>> Which means a newer kernel version.  Expected output was changed
>>>>> to match the new kernel too.
>>>>
>>>> Nack.
>>>>
>>>> Acceptance tests are not to test the latest Linux kernel,
>>>> they aim to assert a specific kernel tested by some developer
>>>> still works while QEMU evolves.
>>>> QEMU doesn't have to adapt to the latest kernel;
>>>> QEMU should keep boot an old kernel.
>>>>
>>>> Testing new kernels is good, you are adding coverage. But
>>>> this break the acceptance testing contract "keep testing
>>>> the same thing over time".
>>>>
>>>> The problem you are trying to fix is the "where to keep
>>>> assets from public locations where they are being removed?"
>>>> one. Two years ago [*] you suggested to use some storage on
>>>> the avocado-project.org:
>>>>
>>>>   For Avocado-VT, there are the JeOS images[1], which we
>>>>   keep on a test "assets" directory.  We have a lot of
>>>>   storage/bandwidth availability, so it can be used for
>>>>   other assets proven to be necessary for tests.
>>>>
>>>>   As long as distribution rights and licensing are not
>>>>   issues, we can definitely use the same server for kernels,
>>>>   u-boot images and what not.
>>>>
>>>>   [1] - https://avocado-project.org/data/assets/
>>>
>>> If I look at stuff under that directory I see a bunch of "Jeos" qcow2
>>> images, and zero information about the corresponding source for the
>>> images, nor any information about the licenses of software included.
>>> IOW what is stored their right now does not appear to comply with the
>>> GPL licensing requirements for providing full and corresponding source.
>>>
>>>> It is time to have QEMU assets managed the same way.
>>>
>>> I'd rather we didn't do anything relying on binary blobs with no
>>> info about how they were built. Pointing to the 3rd party download
>>> URLs was the easy way to ensure we don't have to worry about licensing
>>> problems.
>>
>> I tried to be very strict including the recipe about how to rebuild
>> and description of the source (for licensing) in each commits (Alex
>> Bennée once said Debian/Fedora based was OK):
> 
> ..snip...
> 
> Well that looks better than what is done for the JEOS images currently
> on avocado-project.org, as I can't tell what distro those came from
> at all.
> 
> If we're hosting images built by some 3rd party, and we intend to rely
> on the 3rd party to satisfy source availability, then we need to be sure
> that the 3rd party is themselves still distributing the same images.
> 
> IIUC, from Cleber's commit here the original images we're pointing to
> are now 404s. If the URLs moved, we just need to update to fix the URLs
> to point the new location. If the content was entirely removed though,
> we shouldn't mirror it ourselves, because we can't rely on the original
> vendor to be providing the source at that point.

Having backups and the SHA1 of the files already commited in our
repository, this is the outcome I prefer.
Let see what other think on this topic.

Thanks for your insights :)

> 
> Regards,
> Daniel
> 


