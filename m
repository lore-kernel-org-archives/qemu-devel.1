Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED375C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B89452173E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRoeRxBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89452173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1QUh-0004Wm-Vn
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 04:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k1QTs-00042W-7K
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 04:33:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24044
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k1QTq-0005fJ-Dw
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 04:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596184409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BJYipzeIQkr7oClglhK+UEeawJLTkQD93EgPLyDdjao=;
 b=WRoeRxBLvn4ijpkZiiFJdtvpM5f36RVbEZQSfvDpjyZ63Ai4w0QvEecyXK4BygZQgWCMTi
 3+5FcV2kgfFAhcKJ7QJLmlb64bNIhTkoBGlEUPKvAoeVQIex08ZpJ1xprXPPltrTDvDmMj
 4PzqLu+q05+alysbarddosjmKlbzJrs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-kiIFaeCYMsmmXIG677C1cQ-1; Fri, 31 Jul 2020 04:33:25 -0400
X-MC-Unique: kiIFaeCYMsmmXIG677C1cQ-1
Received: by mail-wr1-f70.google.com with SMTP id w7so8907820wrt.9
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 01:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=BJYipzeIQkr7oClglhK+UEeawJLTkQD93EgPLyDdjao=;
 b=IBcEYha8PkYkHWusAR9NK8Ss+RcR7oJzRnH3VXxjYiIZqz4ShUwuFdMry9D/cmiur4
 LEPEIxtsUh/9bR3+hK/pQO48eqlaHXK/gj+86Xmdun0Y0IKMZbqBPbEfe0lFPezhkCKc
 MhgiIthKvgoIi7STpAkuF54HANmW5/YMDmEuATzHSD8rYB7NF/N/vAkm6ftFkcMvRSDL
 +hR2AXc5L1lYqCNs0J8lYOi1Lta6ois857nIff1gYLXFdA1toHPAs3dR4pzT4tvIilb8
 Mt6lhbj/lsJwSxx+EbjiUyj2EzMGt90LeQCRoeSonrBx6DVwzuRK7KgsmNynekiUTsJp
 VIVQ==
X-Gm-Message-State: AOAM533SP4mQOZD12BmdiuMrZC66oGe+5LvkAM4j9w1QpBhUp9QfT3s4
 viyh9tpX94eW4N4oZeVVrikLGtItZZW6WqfquJyMdhfUVDAdWSi4r/El2hrLemeBp2RXHLMnQat
 gVxgfmRTKNym34P8=
X-Received: by 2002:adf:dcc8:: with SMTP id x8mr2635155wrm.16.1596184404198;
 Fri, 31 Jul 2020 01:33:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI1Fv6all2fSja9GzV6ZSbKQnZB6quQinLXE3jrhSXMOHN77piMzg2frWY59pNrzITOJq20g==
X-Received: by 2002:adf:dcc8:: with SMTP id x8mr2635133wrm.16.1596184403969;
 Fri, 31 Jul 2020 01:33:23 -0700 (PDT)
Received: from [192.168.1.39] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id z63sm13390145wmb.2.2020.07.31.01.33.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 01:33:23 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] testing: Build WHPX enabled binaries
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: "Justin Terry (VM)" <juterry@microsoft.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190920113329.16787-1-philmd@redhat.com>
 <01f2f0ee-a288-921a-58f4-78aeb4d457e1@redhat.com>
 <BYAPR21MB1208F0D09B3E5CA80F1B7C3BB6880@BYAPR21MB1208.namprd21.prod.outlook.com>
 <2acf854f-c49a-0811-31af-80e1e958f058@redhat.com>
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
Message-ID: <324f5002-be0a-563e-b5a6-e08ee5e1ddad@redhat.com>
Date: Fri, 31 Jul 2020 10:33:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2acf854f-c49a-0811-31af-80e1e958f058@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 04:33:29
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>, 1879672@bugs.launchpad.net,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Justin, Sunil,

On 5/20/20 12:26 PM, Philippe Mathieu-Daudé wrote:
> +launchpad ticket
> 
> On 9/20/19 6:53 PM, Justin Terry (VM) wrote:
>> Hey Phil,
>>
>> I have contacted our legal department for guidance on this specific
>> use case and will update you when I hear back. Thank you for your
>> patience.

I recently understood legal changes can be very complex, thus it is
implicit it can take years before getting updates.

Since the project is still actively developed, maybe you could provide
a Azure CI job to build a WHPX binary. We don't need to have access to
the binary, just to the exit status (success/fail) and build logs.

Do you think it is doable?

Thanks,

Phil.

>>
>> Justin Terry
>>
>>> -----Original Message-----
>>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> Sent: Friday, September 20, 2019 8:18 AM
>>> To: qemu-devel@nongnu.org; Justin Terry (VM) <juterry@microsoft.com>
>>> Cc: Daniel P . Berrangé <berrange@redhat.com>; Fam Zheng
>>> <fam@euphon.net>; Thomas Huth <thuth@redhat.com>; Paolo Bonzini
>>> <pbonzini@redhat.com>; Alex Bennée <alex.bennee@linaro.org>; Richard
>>> Henderson <rth@twiddle.net>; Eduardo Habkost <ehabkost@redhat.com>;
>>> Stefan Weil <sw@weilnetz.de>
>>> Subject: Re: [PATCH v2 0/3] testing: Build WHPX enabled binaries
>>>
>>> On 9/20/19 1:33 PM, Philippe Mathieu-Daudé wrote:
>>>> Add a job to cross-build QEMU with WHPX enabled.
>>>>
>>>> Since the WHPX is currently broken, include the patch required to have
>>>> successful Shippable build.
>>>>
>>>> I previously included the WHPX headers shared by the Android project,
>>>> and Daniel asked me to check the EULA. While trying to manually
>>>> install the Windows SDK, I noticed the installer fetches archives
>>>> directly, kindly asking where they are stored via the /fwlink API.
>>>> Do the same, fetch the required archives and extract them. No need to
>>>> accept EULA...
>>>>
>>>> Docker build the image first, then build QEMU in a instance of this
>>>> image. The image is internal to Shippable, the instances are not
>>>> reachable and are thrown once the build is finished. What we collect
>>>> from Shippable is the console output of QEMU build process, and if the
>>>> build process succeed or failed. So far we do not redistribute the
>>>> image or built binaries.
>>>>
>>>> Philippe Mathieu-Daudé (3):
>>>>    target/i386: Fix broken build with WHPX enabled
>>>>    tests/docker: Add fedora-win10sdk-cross image
>>>>    .shippable.yml: Build WHPX enabled binaries
>>>
>>> FWIW here is the result of this series:
>>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fapp.
>>> shippable.com%2Fgithub%2Fphilmd%2Fqemu%2Fruns%2F516%2F11%2Fcon
>>> sole&amp;data=02%7C01%7Cjuterry%40microsoft.com%7C733a566f3233427
>>> 8ae6f08d73dddb39f%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6
>>> 37045894733463150&amp;sdata=55URgDII5r74QMUpLOD%2FWT5%2B5jbzyv
>>> nfCSdv%2FNaWDAw%3D&amp;reserved=0
>>> Duration 17 minutes (1076 seconds)
>>>
>>> 4m49s building the qemu:fedora-win10sdk-cross docker image, 11m10s
>>> building WHPX QEMU.
> 


