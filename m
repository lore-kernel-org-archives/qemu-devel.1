Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D76C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD9720776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUmZMsIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD9720776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdVfz-0004zb-P5
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 05:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdVfD-00048f-SU
 for qemu-devel@nongnu.org; Tue, 26 May 2020 05:14:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28585
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdVfC-0008F2-Co
 for qemu-devel@nongnu.org; Tue, 26 May 2020 05:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590484460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yKScylC5SvHlgHFEhOUZJm3Hh+MyeSOAKtYltDo7chI=;
 b=EUmZMsIfrFokvfwfeMzTAI8fAZQDV4ajFmvfcUcHU+h3l4+moyXvxpo6RnZeOuwq/flxPe
 ejoTVgz1irssfRu+KF6sO8QUy93hz0fGCHYfzko+nyBHcYvS4IBBcAxfPFRsutjvr3jt8B
 1Tz9qCYuF7yXxXNoSP5nLftqA6y0GC4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-mfaUMbPFMcGWNyJVwgagVQ-1; Tue, 26 May 2020 05:14:16 -0400
X-MC-Unique: mfaUMbPFMcGWNyJVwgagVQ-1
Received: by mail-ed1-f69.google.com with SMTP id y5so726461edw.19
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 02:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=yKScylC5SvHlgHFEhOUZJm3Hh+MyeSOAKtYltDo7chI=;
 b=hDTKmifq+EM9zSNs8WNTxWBkZel+bIVsp4a+r/85H8mTFB0zpVOzjjWUPQq+5PGuqW
 kSwxH5cS4ChAL/ZKG7Q3HGXFACWFUlpUaffgkP/yRO4s6P61fmLUUpDehesomGGEatVV
 Z9MwYinbNP19zTsvCA5ufWfuIyXVcwCsRbDzdcl+OZc2i0ke5nOn6xTRZXGtJh3Si3XS
 XdycrwtHiWNq4KqdnhmPuPJwwiMhFDLL2/T95kKRp/vCuWuWv8GBbZVH7owi/gqhLi4I
 FgfbI4/fBeJdytBet+iV6MHOv+FtnFPy2HibpyjLp92sUfJHpIpVAsTQq4ZRNYm5Eq+p
 xM1A==
X-Gm-Message-State: AOAM532bH+6+Hxhxkb+5yqpzw6zcTnnTtpTV20G2lAb2IIw9Xy7Hpcui
 KMz9z+d838TcTQdlZHCiXeFTR7RBm/M1k9V3KUg/BDDMF9zTucl7PmNMh8Jg+efySCQ8hcErWNy
 g8giCiF1iRlWhWg4=
X-Received: by 2002:a05:6402:348:: with SMTP id
 r8mr18510588edw.130.1590484455728; 
 Tue, 26 May 2020 02:14:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5xUVdGXYoEXRVlZvBvkUxLM/L667ABiS3XQqOX27fUMNET0x/czJ5pmr7+KJypOdAcLu4DQ==
X-Received: by 2002:a05:6402:348:: with SMTP id
 r8mr18510571edw.130.1590484455548; 
 Tue, 26 May 2020 02:14:15 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id ef13sm17702560ejb.24.2020.05.26.02.14.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 02:14:14 -0700 (PDT)
Subject: Re: [PATCH] tests/acceptance/boot_linux: Skip slow Aarch64 'virt'
 machine TCG test
To: Lukas Straub <lukasstraub2@web.de>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200507162235.1790-1-philmd@redhat.com>
 <20200509151801.780059c3@luklap>
 <CAFEAcA8g1gq4QsXxfLYSOChd_Nj6u0EKeXO-s8Qww9qA_dBiLw@mail.gmail.com>
 <20200511185101.6fd82fe5@luklap>
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
Message-ID: <ae01735c-d26f-0cfa-8cdd-747ecac392c6@redhat.com>
Date: Tue, 26 May 2020 11:14:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200511185101.6fd82fe5@luklap>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Cleber

On 5/11/20 6:51 PM, Lukas Straub wrote:
> On Mon, 11 May 2020 10:11:20 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
>> On Sat, 9 May 2020 at 14:18, Lukas Straub <lukasstraub2@web.de> wrote:
>>> Hi,
>>> Why not simply add slow tag to the test. Like:
>>> :avocado: tags=slow
>>>
>>> The slow tests can then be skipped with
>>> $ make check-acceptance AVOCADO_TAGS='-t -slow'  
>>
>> Is it possible to have the default be "do the fast stuff"
>> and only do the slow stuff if the user asks? That's the
>> way round that we do the iotests, I think.
> 
> I'd set AVOCADO_TAGS to '-t -slow' by default, but now that I look at the Makefile it's not that simple:
> 
> AVOCADO_TAGS=$(patsubst %-softmmu,-t arch:%, $(filter %-softmmu,$(TARGET_DIRS)))
> 
> We'd have to change the tests to skip if their target was not built. Than we can use tags for uses like this (and more like net, disk, ... tags). That would make it easier to filter the tests one wants to run: https://avocado-framework.readthedocs.io/en/78.0/guides/user/chapters/tags.html

Cleber what do you think of this approach?

> 
> Regards,
> Lukas Straub
> 
>> thanks
>> -- PMM
> 


