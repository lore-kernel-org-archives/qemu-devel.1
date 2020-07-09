Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EBAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F6662077D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cj9o2UpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6662077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYqe-0001Qc-UL
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtYpc-0008FY-G1
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:51:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24752
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtYpZ-0006Va-VA
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594309884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f5ZV6/6ryeyF807pr3s7qroVuMVRX8WUDSqe0DWSAlA=;
 b=Cj9o2UpFtFaQW/TEPIxzQ6s+Qj43b2GgU7Tfe/hc2MFb/bmSmQuCokzNVGYFiYZYMym9d7
 yxwr1SwaPsAt5o26iBGZkch+IaUbSYcR1xNBmguVawiNGz4DvYkDBZ5G6VZ+ISvC5wc3iF
 yV4uDAWwP+ZJJorw5m8kms6IIBiesDg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-kgJz_AXYMmmP_h-xLKWh3A-1; Thu, 09 Jul 2020 11:51:22 -0400
X-MC-Unique: kgJz_AXYMmmP_h-xLKWh3A-1
Received: by mail-wr1-f72.google.com with SMTP id o12so2279829wrj.23
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 08:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=f5ZV6/6ryeyF807pr3s7qroVuMVRX8WUDSqe0DWSAlA=;
 b=KDaoJjH8EKMew60DMcTy2Js1OcNnrafAtjXU9ga0wK9bQEg3tE6QUKN7e6es8CBecR
 DGUjG6m9j07mUVAVE+Nb+mHz38h4D6hBm5Wu/hJYf03OYhrK4hmG0EHLEjln5VUk4dpK
 F+Q2FmL5jNuxMImeNr82zUPlZxk1vYaigKddypkxh7HEY6mwTJwLd+8mjlcSKuy/xojc
 kYcpUQHyKni0GZSH2ScDoIvkobcP1qmBMRIRbgv6TKklWYmOeGOZODIEb8eg1RM8RskH
 jHVgNWL0HJwFEk7dyAI09WqBUBRP6oz/PeXSdjYw87UtUf4vALEDxtsBHY4YcPn1S4++
 cSMQ==
X-Gm-Message-State: AOAM532hOHJrWBSsnGcjebhjm3GNvLZoMiXrEYG872IFxp2gjZrHL7+B
 3Rm9CORGhfjPvQ6boRPds602eeLA0RDb23NQsdugG5ZE9MvKp8me6ith9nb1nwln7wCk0VaTjRr
 +ioSLFtDyi8cxy/A=
X-Received: by 2002:a5d:6603:: with SMTP id n3mr66480943wru.142.1594309881507; 
 Thu, 09 Jul 2020 08:51:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbAROqf83Uhc4FwXYw3au0aGkisFgKBXMp6gz47heqCJLoIW/nlW7JfiMCnh50IRIl1AA+Jw==
X-Received: by 2002:a5d:6603:: with SMTP id n3mr66480935wru.142.1594309881320; 
 Thu, 09 Jul 2020 08:51:21 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c25sm4875728wml.46.2020.07.09.08.51.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 08:51:20 -0700 (PDT)
Subject: Re: [PATCH] softmmu/vl: Include "qemu/rcu.h" for rcu_disable_atfork()
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200709133411.23929-1-philmd@redhat.com>
 <20200709152531.meffwc6sw2tqbpha@mozz.bu.edu>
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
Message-ID: <3dfa7b68-8172-30c4-4d77-37a14ad12717@redhat.com>
Date: Thu, 9 Jul 2020 17:51:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200709152531.meffwc6sw2tqbpha@mozz.bu.edu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:25:17
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 5:25 PM, Alexander Bulekov wrote:
> Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
> 
> If rcu.h should be explicitly included, should any of these other files
> that reference the rcu but do not explicitly #include qemu/rcu.h also
> get such includes?

Personally I think so, yes.

> 
> util/qht.c
> 166:    struct rcu_head rcu;
> 
> migration/savevm.c
> 1822:    rcu_register_thread();
> 
> util/log.c
> 43:    rcu_read_lock();
> 
> linux-user/syscall.c
> 6000:    rcu_register_thread();
> 
> hw/virtio/virtio.c
> 74:    struct rcu_head rcu;
> 
> target/arm/kvm.c
> 998:    rcu_read_lock();
> 


