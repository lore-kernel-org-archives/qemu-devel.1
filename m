Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68C5C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 14:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61029207C3
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 14:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gX46znHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61029207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFIHW-0008Ob-Jp
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 10:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFIGM-0007Ei-6u
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 10:36:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58030
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFIGK-0008U4-DP
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 10:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599489411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q8qy1JyNZHP1g2Yy+czfmr61N3M0fuZb5GbtfxBjxUs=;
 b=gX46znHqz1Oq/IaDeSYsyJaF163bUaIcVZsZ3v6IVkhM5EI3T2IUyVgSzZKNSYTEcP15ea
 KX33KFp+foL52QWWvm0qaqXa7WhUqMe+Tqn0tOS6LDZRHJOtTTbLMSLFXAQnYkJph4/PWK
 JdEcdcpVTMENhWkP+R48R8AvZISOjSo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-m6PIdgj8PEWru9LZFw6rgw-1; Mon, 07 Sep 2020 10:36:50 -0400
X-MC-Unique: m6PIdgj8PEWru9LZFw6rgw-1
Received: by mail-ed1-f71.google.com with SMTP id r9so4624219edi.9
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 07:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Q8qy1JyNZHP1g2Yy+czfmr61N3M0fuZb5GbtfxBjxUs=;
 b=ERjHHvbtJa2Luxa8eijZnuk+Aju17fMfLfh0f3HWpzhkVXSciPuk1AeKXI2D7U8KLw
 3/QaDV0T+cWVf7ihhZEyq+KTVpknkTH51YSIXLQDjJ+RsiwM8J/5/qbLwIX12uyaclUY
 8dS4tlvnbn6VZp5dPvmYZMIxur9t/2Ohum6YIGMMYvXt/0NgZAstJlmc3xjcCvJ1NKET
 W01ba3Czc62w45xen2sNGiYdXDxjr8cS/hVKvJ3Yd+yQGxEL7ETO28SiJU0ZW+EBIrrV
 5PuoR1jJ0dWJ+NWZDdJTOTlyACzSalaszYE0gE5pTYo2UxhX7pkc9ZfWsJ0G+6GSSN0V
 qVGw==
X-Gm-Message-State: AOAM530J3PuQgqN3CvwPMCOEs9dX3CNjxPC+Yqyom2o/IN0TZS+5T2fi
 NX/xjVF3Bg6QSBcpbZdA2m9O0qugtLLZ7XFn4YgbZabiNiXOr1rZay2UHbfY2IGrom8iKJXYM/f
 YQQiQegWCy0Jv+Rw=
X-Received: by 2002:a17:906:e50:: with SMTP id
 q16mr22219953eji.544.1599489409022; 
 Mon, 07 Sep 2020 07:36:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJ9ZT45WB5UHnCNQ4qxx7ebieAXH9Eq7kM8r0piCZiYHB0l0O2xBXAIDwPNkGhYVOFUDdqeA==
X-Received: by 2002:a17:906:e50:: with SMTP id
 q16mr22219942eji.544.1599489408830; 
 Mon, 07 Sep 2020 07:36:48 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id lz22sm15018453ejb.98.2020.09.07.07.36.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 07:36:48 -0700 (PDT)
Subject: Re: [RFC PATCH-for-5.2 4/5] qom: Let ObjectPropertyGet functions
 return a boolean value
To: Markus Armbruster <armbru@redhat.com>
References: <20200715175835.27744-1-philmd@redhat.com>
 <20200715175835.27744-5-philmd@redhat.com>
 <87ft9rrfol.fsf@dusky.pond.sub.org> <87mu21mznm.fsf@dusky.pond.sub.org>
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
Message-ID: <d54649b0-e3fc-ccfb-56c2-2ab00fbe48d4@redhat.com>
Date: Mon, 7 Sep 2020 16:36:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87mu21mznm.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:19:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 4:26 PM, Markus Armbruster wrote:
> Making more functions taking Error ** return bool (commit
> b6d7e9b66f..a43770df5d) created a number of false positive
> CHECKED_RETURN Coverity issues.  Peter notified me back then.  This
> series could help (we'd have to double-check), but it covers only the
> getters, not the setters.
> 
> Peter, are you still interested in reducing the false positives (as
> opposed to marking them)?
> 
> Philippe, are you still pursuing this series?

Have you looked at/audited the ObjectPropertySet call sites?

I'm not sure updating ObjectPropertySet is really interesting,
and only changing ObjectPropertyGet letting an impaired API
doesn't seem a great idea :)


