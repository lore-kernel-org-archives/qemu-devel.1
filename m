Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F98C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:30:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B7520659
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezr7Liga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B7520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhDMo-0003XO-AQ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 10:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhDLm-0002mn-GE
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:29:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37608
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhDLl-0001ww-P5
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591367376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jaLIQUPGtOhejEcdejsbdc6gnm5YV6Rm65SdPuUPyc0=;
 b=ezr7LigaEMp+sXxtZ8SkSPHzft5PeGpdF1r69NQUeoVSk0c9GGpEeUSkZyp4o/sn/mipp2
 QHEl2LYvX+rqd6LSG9+PebiUnAguYY/q2llnVdtRGhAkrKYWR9x8AuS9cY3Wn+4kqnV6c3
 LWhrt8qNQSUY8vrfVO2ap+S0J+loqDs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-XEM4TIFqNOi9SaWQQ5yqGA-1; Fri, 05 Jun 2020 10:29:35 -0400
X-MC-Unique: XEM4TIFqNOi9SaWQQ5yqGA-1
Received: by mail-wm1-f69.google.com with SMTP id u15so2758190wmm.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 07:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=jaLIQUPGtOhejEcdejsbdc6gnm5YV6Rm65SdPuUPyc0=;
 b=DjfIrVHWB0S8thim5yCOPqfH0Qioo+nFAp6BchEIbG1i8LkN7nwqeZlMej+ES6zvoW
 Owfdgl1d6J0szKP/N+wxMHjPpy6BRbIPP99Lv1gcvM/LtPsn6/PcUX1peEKtDtX9rLiv
 zTon5cg+t4XBAU4KRgqicG4RBv1wV79PfEb6QEqEYLgcsDsofcpwx+QEk+YmpsUhJ0xu
 qvKpyuWn54LG+64booYRfgmEaapVuKhdrcPLb/VrwKwXZ/3anMlUTNMXnBXFPoOg3V4V
 jmUpZcbpnKXf/yzeEVYVY2BdIqdMKYaRGLFSX7VR32xNbNr2ZY/gZFQ9Z7QOEif1t0A1
 r1bA==
X-Gm-Message-State: AOAM533kdxazwZtvcrj7dOkRpf3ttjAR9sheLsrP/VXXMqidj7TErN9s
 iqjhSeG/8PMgWSqS5A6Ps04wCW7iiqTUMXKjAKSV0yViUL2PwhQ945ga3SYfMGoEqLmKsN0F8q/
 GEcgP/D7JjUuO6W8=
X-Received: by 2002:adf:82ab:: with SMTP id 40mr9461997wrc.85.1591367374137;
 Fri, 05 Jun 2020 07:29:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzx0TsYcfrCzzUTqSpLQKgsY71BeFDfLcCaQ67RX4c5LCm4YMw4yDZ7Nt2G/iZ/ngLYvdOgew==
X-Received: by 2002:adf:82ab:: with SMTP id 40mr9461517wrc.85.1591367366894;
 Fri, 05 Jun 2020 07:29:26 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id j5sm12178840wrq.39.2020.06.05.07.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 07:29:26 -0700 (PDT)
Subject: Re: [PATCH 05/13] i386: hvf: Use ins_len to advance IP
To: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
 <20200528193758.51454-6-r.bolshakov@yadro.com>
 <be9d6f5b-5297-459f-3192-26835fdac230@redhat.com>
 <ed29b528-17bd-c418-067c-7e68c93f53c6@redhat.com>
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
Message-ID: <31a9951c-195a-f58b-7728-456b152f2e8a@redhat.com>
Date: Fri, 5 Jun 2020 16:29:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ed29b528-17bd-c418-067c-7e68c93f53c6@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 8:15 PM, Paolo Bonzini wrote:
> On 04/06/20 08:39, Philippe Mathieu-Daudé wrote:
>>>                  simulate_wrmsr(cpu);
>>>              }
>>> -            RIP(env) += rvmcs(cpu->hvf_fd, VMCS_EXIT_INSTRUCTION_LENGTH);
>>> +            RIP(env) += ins_len;
>> I'd feel safer if you change ins_len to uint64_t first.
>>
> 
> Why?  It will never be more than 15 (it's also a 32-bit field in the VMCS).

Indeed, I am now seeing the comment in target/i386/hvf/vmcs.h:132

  /* 32-bit read-only data fields */
  #define VMCS_EXIT_INSTRUCTION_LENGTH 0x0000440C

So:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks Paolo.


