Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46082C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E613207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQtV5yCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E613207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jicH4-0007Gq-9V
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jicFl-0005iq-4l
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:17:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24518
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jicFk-0002yJ-DK
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591701431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VQFhY1ywxUvbHsUj8hkxzSoWdcGrvWuvSltH0l8Qus8=;
 b=KQtV5yCbMSv44Wq0ipK+Je3xzN0bv1kCMVQ4OcTVuciP03sHue6rXWWdHBNQ/UiqKf0g1h
 mC5yzH1yyXgE0JU0GsccxlsHRbsagVAAXKWaUp+PqpGLiJ/hvoaqzff76SqMIFnzg5ilPJ
 QU6kXZIZwG9FKxi69i0gJlpEqG+L+WU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-uLFqWZPEOBCh8nxgyFTiwA-1; Tue, 09 Jun 2020 07:17:08 -0400
X-MC-Unique: uLFqWZPEOBCh8nxgyFTiwA-1
Received: by mail-wm1-f70.google.com with SMTP id a7so536102wmf.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=VQFhY1ywxUvbHsUj8hkxzSoWdcGrvWuvSltH0l8Qus8=;
 b=ef+jyNJoKt4M7FP51B6IPcpE4gvWlR6OqFCv5CZamFEAR9pUe2vH3vuTxvJIjuQqWr
 /OqBCmDIGKiNGc25REHNhpNhHcYQYwliBn+HfuZnH8gDl/BYkhRFHp52bSx5gV8oyRBO
 lmuOl61BntKNFR6226lesytne7uyudk19jYW9eKSgtmk5PrE1QSs7IMjXdjv8lW3sc6g
 PbxDuCBOEtgBqCczjDiYsbjU15rcZJRpkMJol/Sj8/Ic7uawKGetlxSUofsBm5ScbaxR
 68p5Ay6j45ftDbn2wkWoYJHz+X1Cu6Jn3tqIkhCnC4JaFCJmiw1R33WDj9AsKubOLBO5
 pSMg==
X-Gm-Message-State: AOAM531iLOAXF8koCF9jPmEkCCTpYuALlZzmEFE5jkpf3MSXLIZzLKxb
 wjOuIVUuU67EQd3o3FeYuBbErCujUn/shMgJbnTUqR+0+PIGMy6ge6LN1aIEzAQV3yGnGo7Fj0V
 g//z53zAesrBfU6g=
X-Received: by 2002:adf:ed87:: with SMTP id c7mr3879887wro.108.1591701426970; 
 Tue, 09 Jun 2020 04:17:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9ZFOiG/ntK9RYFDdmymTiobDhpH3WaQpTBmKths72d/+QFkE+wvCSR6xBL6slO5hhZvk1vA==
X-Received: by 2002:adf:ed87:: with SMTP id c7mr3879859wro.108.1591701426751; 
 Tue, 09 Jun 2020 04:17:06 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id u12sm3047566wrq.90.2020.06.09.04.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 04:17:05 -0700 (PDT)
Subject: Re: [PATCH 0/1] hw/block/nvme: fix assert on invalid irq vector
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
References: <20200609094508.32412-1-its@irrelevant.dk>
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
Message-ID: <b445a413-598f-23a2-f094-8b68c60722f5@redhat.com>
Date: Tue, 9 Jun 2020 13:17:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200609094508.32412-1-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
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
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 11:45 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> I goofed up with commit c09794fe40e3 ("hw/block/nvme: allow use of any
> valid msix vector").

Kevin, since your queue isn't merged, can you directly squash the fix?

> 
> This fixes the goof by adding a new msix_qsize parameter. As a nice
> side-effect this allows a device with less interrupt vectors available
> than supported queues. Also, improve the error handling in
> nvme_init_pci().
> 
> Kevin, please consider picking this up for the block branch when
> reviewed.
> 
> Cc: qemu-devel@nongnu.org
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Klaus Jensen <its@irrelevant.dk>
> Cc: Javier Gonzalez <javier.gonz@samsung.com>
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Klaus Jensen (2):
>   hw/block/nvme: add msix_qsize parameter
>   hw/block/nvme: verify msix_init_exclusive_bar() return value
> 
>  hw/block/nvme.c | 28 ++++++++++++++++++++++------
>  hw/block/nvme.h |  1 +
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 


