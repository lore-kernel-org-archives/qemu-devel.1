Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1FAC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F332073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EW+riJqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F332073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxuna-0002e2-A9
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 12:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxujS-00074Z-3v
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 12:03:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52625
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxujP-0003XW-II
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 12:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595347381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=qAT1tq1gzwDKvIvzjVmUSYExSiE1pM2yRC9ZlJgB6W0=;
 b=EW+riJqDOeC83Kuzlxex6WU/aK9xIYFq51C3y+IGAekFlinVI/S9+6seI7Pvvj0cDEbGIC
 FocjsdSdKjwkAROJ59oBillG0O1+9MVKpE9Od3zmrSruAvnzkSQHP1pmeilc1LX2UUE5MA
 Dqva+5n6w78CsnrNbDRHRAKhuZOodi4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-Wi4CKkGJNfCCFi9_U6WqQQ-1; Tue, 21 Jul 2020 12:02:59 -0400
X-MC-Unique: Wi4CKkGJNfCCFi9_U6WqQQ-1
Received: by mail-wm1-f71.google.com with SMTP id t63so1408596wmf.6
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 09:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:autocrypt:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=qAT1tq1gzwDKvIvzjVmUSYExSiE1pM2yRC9ZlJgB6W0=;
 b=en2RGXBLCNr1QCTdjqB4p1RVA2rD1PiAbf2tn3COmPcfOqxUZzEqGnKF7VwlqBDvix
 Bd5ifUamwoMRB9vsmmc6c/VVHlOWHEWsF5Wo60Bw0VG1i5G/o+BZ7ZEjB41zsg0nDD9+
 vdkhOSlhk/ukhAcFKzZ2AiJd4fDMMZEIr8OK81lVyeOSEied5xUpXZa2kMS0Jx230rZe
 nztCMhrtMDqx4Ql0+DwSfd5o4S3kTBZhgV2mEYdJqfGPES8qyxJHeB+nau0kUFH1hR15
 SKDmFNCWmCeqWsIm9AYdYg2cWT2XoswXuKMgIqhrF8JMInGuNfzSbK1r9FTzoh45/IYz
 4RaA==
X-Gm-Message-State: AOAM530QAhvzpRQajm8smf9y6usB1jTOCzzDnrGsjn72FwDo06GRHSuL
 bGyDGREfAait4XIWvkCQkOXP7tVOfzr5mZxDVroDujRB62gcj6wNcWYTwcAnyIldLktqX5R2MLR
 fCeDTd/mZgLNkoT0=
X-Received: by 2002:a5d:608f:: with SMTP id w15mr25957713wrt.136.1595347378705; 
 Tue, 21 Jul 2020 09:02:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfeiK8exlyfDJFKXk1Y+ghHDJcQJ7ib8ZcLJyiHePTqbXSdAz3IX7gwuaXKKn5L64TbMhJ6Q==
X-Received: by 2002:a5d:608f:: with SMTP id w15mr25957702wrt.136.1595347378520; 
 Tue, 21 Jul 2020 09:02:58 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id x13sm2475454wro.64.2020.07.21.09.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 09:02:57 -0700 (PDT)
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel
 <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Subject: What is TYPE_TPM_TIS_ISA? (Not an ISA Device)
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
Message-ID: <8f5a171a-59db-f5d1-477c-1ddf7af45da7@redhat.com>
Date: Tue, 21 Jul 2020 18:02:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:20:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Safford <safford@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

I'm trying to understand what is modelling the
TYPE_TPM_TIS_ISA device.

It inherits from TYPE_ISA_DEVICE, so I expected
to see an ISA device, but then I noticed:

1/ it doesn't use the ISA I/O space, it directly
maps the device in the system memory at a fixed
address that is not addressable by the ISA bus:

#define TPM_TIS_ADDR_BASE           0xFED40000

2/ it is not plugged to an ISA BUS (ISABus*)

3/ no machine plug it using isa_register_ioport()
   (it is not registered to the ISA memory space)

4/ the only thing slightly related to ISA is it
checks the IRQ number is < ISA_NUM_IRQS


So it seems this is a plain SysBusDevice. But then
there is TYPE_TPM_TIS_SYSBUS... What is the difference?

Thanks,

Phil.


