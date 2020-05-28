Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0811DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2942075F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChLAPFvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2942075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKK1-0001pM-5C
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeKJ0-0000Tz-8B
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:18:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21764
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeKIz-0001HT-2B
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590679127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3LMg3l04naYBR1t8PYzMXoFIO8h4ODxl/+LF5gk37Fc=;
 b=ChLAPFvJAoUw4UuanyBjOxwwZbBC40IX2Prz3VzDk6g24zqpsb67BNtLbKsMKKly06E4cL
 4ep6dT4eqeV3rx9vijMAwrkdJ+MiMX6ZYx527Ft1zZ96s+erkd5Quc399wg0sHtbSxTEq1
 DtkIx6eTicpBSfAUrqSqMGDZyUHvg/Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-TA0zk02NNVimzbpth_N6Mw-1; Thu, 28 May 2020 11:18:45 -0400
X-MC-Unique: TA0zk02NNVimzbpth_N6Mw-1
Received: by mail-wm1-f70.google.com with SMTP id q7so1087708wmj.9
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 08:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3LMg3l04naYBR1t8PYzMXoFIO8h4ODxl/+LF5gk37Fc=;
 b=WApVcMI+JQououwR/l/D1FYSnDkzTAfb4xPgvA9JI4W4y5T+j6pxSnDeehY8nN8e/V
 3Y5dBG3CyMxevyIyK7kqLN1zCGHqk7cbyjn76SuA9UWTV1GHcV6ywaYZgfCDyVoygpKW
 Bigyu0THaEXchhkDy8yLx6v16oDERvbCbEE88AKixz3fctb7y9zk3LHoZrp7aRHoHKPm
 +UrZ6DgNGO7y1iEF0sAaMSG3qeImO+VpAxoWFWrUA1aUYvwMaRxN66HiC5m6lEsmlpba
 +NBeAHzAm/5P4jwXqBYASbwNDAqpME7nzh7ZraNzYjJcRGFrnXx/0w0+D1oIAEwe9H84
 3ICw==
X-Gm-Message-State: AOAM533bGhHquot94GaPUtbu2ZbrdrfePvO1/V7i4VQSrpDrgYApyZf/
 UOGABRkLIrfAl8Dt6rwvUxeb/wfS/ZpLSVhvZfjISgmBBHds/HfdPFY4dcUdEEF99gM4LsCTu9+
 Zb2SQACo/byXNaVY=
X-Received: by 2002:a1c:5683:: with SMTP id k125mr4069384wmb.55.1590679124451; 
 Thu, 28 May 2020 08:18:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwppgXifHniYCYMdt2KXLAtVWhPEo+zDSH5S6URX/LwIe+GAOHy14rb683FPprdIkZkUCL0g==
X-Received: by 2002:a1c:5683:: with SMTP id k125mr4069369wmb.55.1590679124252; 
 Thu, 28 May 2020 08:18:44 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id 186sm1676951wma.45.2020.05.28.08.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 08:18:43 -0700 (PDT)
Subject: Re: [PULL 00/12] testing and plugin fixes
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200527145455.2550-1-alex.bennee@linaro.org>
 <CAFEAcA_LrZjBY_y3UR=fdOtDvnY=zGG-10Yeq0ZjbBc=EsvRfw@mail.gmail.com>
 <87blm83y5v.fsf@linaro.org>
 <CAFEAcA_QTkWA7eBwORWMmpcH1E5bF4A3mFtkzdstkucd-2+p3A@mail.gmail.com>
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
Message-ID: <591d2690-c2e7-98aa-8569-5f99737c5f71@redhat.com>
Date: Thu, 28 May 2020 17:18:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_QTkWA7eBwORWMmpcH1E5bF4A3mFtkzdstkucd-2+p3A@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Gerd

On 5/28/20 5:09 PM, Peter Maydell wrote:
> On Thu, 28 May 2020 at 15:57, Alex Bennée <alex.bennee@linaro.org> wrote:
>> I get these on commit ddc760832fa8cf5e93b9d9e6e854a5114ac63510:
>>
>>     LINK    arm-softmmu/qemu-system-arm
>>   ld: /usr/lib/libc.so and /usr/lib/crt0.o: warning: multiple common of `environ'
>>   ld: warning: libintl.so.1, needed by /usr/pkg/lib/libgio-2.0.so, may conflict with libintl.so.8
>>   ld: warning: libintl.so.1, needed by /usr/pkg/lib/libgio-2.0.so, may conflict with libintl.so.8
>>   ld: warning: libintl.so.1, needed by /usr/pkg/lib/libgio-2.0.so, may conflict with libintl.so.8
>>   ld: warning: libintl.so.1, needed by /usr/pkg/lib/libgio-2.0.so, may conflict with libintl.so.8
>>   ld: warning: libintl.so.1, needed by /usr/pkg/lib/libgio-2.0.so, may conflict with libintl.so.8
>>
>> which makes me think the build environment has changed and it was simply
>> that my PR triggered a re-build of the NetBSD VM.
> 
> Yes. I see them also now on the next pullreq I'm trying to
> process. How do I get back to an environment that doesn't
> produce all these warnings?

Maybe building back NetBSD 8.1?

$ git checkout 2cc3e591b3321a~ tests/vm/netbsd
$ make vm-build-netbsd
$ git checkout HEAD tests/vm/netbsd

> 
> thanks
> -- PMM
> 


