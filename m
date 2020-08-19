Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B014CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 21:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7C1207DE
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 21:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqnhr8/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7C1207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8VxR-0004uV-P5
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 17:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8Vwo-00046r-My
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 17:48:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22212
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8Vwm-0002Fo-A9
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 17:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597873718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SvQVmI2WC85PtqAUCJ1j+GuGXD+9MmpDAmZ7N0f2VO8=;
 b=fqnhr8/gJqHrOS7S2MMCAQ/eRZw8RywmqFlu+PR5ucxEHLdVHjOqL5YLPfkOYUID0cXWVB
 9Ib25V4VAlqvMsQZm9XDLMEOwSApS6lVYgjoHnABQwO0pDpssFi9r9M/nQGS20473wTMtN
 D77NRxQD6eGzVmv4yiqWpkbO9aLoxxk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-rGV4dZBlM32G65Iv4RozjA-1; Wed, 19 Aug 2020 17:48:37 -0400
X-MC-Unique: rGV4dZBlM32G65Iv4RozjA-1
Received: by mail-wm1-f70.google.com with SMTP id b73so113583wmb.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 14:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SvQVmI2WC85PtqAUCJ1j+GuGXD+9MmpDAmZ7N0f2VO8=;
 b=fKBet2DJva4r8Gwq5xcyg19amLJ6xp5XpgU9TvHUqV3Xg0+rIs/DV3e9qaqPP/hOEZ
 GegiAaQU19maoHTv+LHiiE6R8HPQ3jXULdzM00ZeIWCujnxBfKYLc5T3z7OyLpduyT2a
 ueXrMCZO8d7bW9R/pKU92PIS5TjoHf3YfxSMstOClqI82FUApY+oD19L9Ew5J+KU3Rf7
 VqbfNO+7/DHAwCFeEBC8/jbw/jBtY49p1UKDA6nOaLKld0e1vEH70mbe9Q99MRnLifcq
 3HsA2vaGmExaLAlWmnkSB1rZ+fj+3xdMlvRP7IorM/unMhMFjI8u+2V+Ht5mOJZFND4M
 Y2SQ==
X-Gm-Message-State: AOAM5326iPxWeFIIngbSxgSzfQ7IzkceIkxy0yH8xkHrxH7jU2ExEm10
 LD8WNO5qleXfFdKehDT1yFuJxY/yrO9hpkdV+AwXyoGijJX3Uy6mnw/kmePz0KR+Ei7NVG+2RhF
 bIa5FXbdZui3GMFQ=
X-Received: by 2002:a1c:f609:: with SMTP id w9mr289993wmc.150.1597873715645;
 Wed, 19 Aug 2020 14:48:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTlDedU9eo4WtnZWtCL7ysGJTr3Ie2Egh1S9sxFs6jHtCN09wyGmvZAC27lL7Ky+ouvspeBg==
X-Received: by 2002:a1c:f609:: with SMTP id w9mr289977wmc.150.1597873715391;
 Wed, 19 Aug 2020 14:48:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id n12sm279287wrq.63.2020.08.19.14.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 14:48:34 -0700 (PDT)
Subject: Re: [PATCH] qtest: add fuzz test case
To: Alexander Bulekov <alxndr@bu.edu>, Li Qiang <liq3ea@gmail.com>
References: <20200819141533.66354-1-liq3ea@163.com>
 <baabaa94-e4bf-3578-2f78-624704eb29c4@redhat.com>
 <CAKXe6S+Vpe5NH4j22deQLxZaX7NRFtwvGR0FhEoBPPNdK33ibQ@mail.gmail.com>
 <20200819162211.5z6blwmgy35mw6dk@mozz.bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fd078ae3-cd7c-318b-b27a-16cb61abea92@redhat.com>
Date: Wed, 19 Aug 2020 23:48:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200819162211.5z6blwmgy35mw6dk@mozz.bu.edu>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/08/20 18:22, Alexander Bulekov wrote:
> 
> For the issue in question, there are already some trace points.
> If I run the repro with -trace 'pci*' -trace 'megasas*' -trace 'scsi*' :
> Reformat the trace somewhat and add some annotations for the data that
> comes from DMA:
> 
> # megasas_init Using 80 sges, 1000 cmds, raid mode
> # scsi_device_set_ua target 0 lun 0 key 0x06 asc 0x29 ascq 0x00
> # megasas_reset firmware state 0xb0000000
> outl 0xcf8 0x80001818
> outl 0xcfc 0xc101
> # pci_cfg_write megasas 03:0 @0x18 <- 0xc101
> outl 0xcf8 0x8000181c
> outl 0xcf8 0x80001804
> outw 0xcfc 0x7
> # pci_cfg_write megasas 03:0 @0x4 <- 0x7
> # pci_update_mappings_add d=0x7fd3b8fbd800 00:03.0 2,0xc100+0x100
> outl 0xcf8 0x8000186a
> write 0x14 0x1 0xfe     # DMA Buffer
> write 0x0 0x1 0x02      # DMA Buffer
> outb 0xc1c0 0x17
> # megasas_mmio_writel reg MFI_IQPL: 0x17
> # megasas_qf_new frame 0x0 addr 0x0
> # megasas_qf_enqueue frame 0x0 count 11 context 0x0 head 0x0 tail 0x0 busy 1
> #  LD Write dev 0/0 lba 0x0 count 254
> #  len 0 limit 520192
> # scsi_req_parsed target 0 lun 0 tag 0 command 138 dir 2 length 520192
> # scsi_req_parsed_lba target 0 lun 0 tag 0 command 138 lba 0
> # scsi_req_alloc target 0 lun 0 tag 0
> # scsi_disk_new_request Command: lun=0 tag=0x0 data= 0x8a 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xfe 0x00 0x00
> # scsi_disk_dma_command_WRITE Write (sector 0, count 254)
> # scsi_req_continue target 0 lun 0 tag 0
> 
> I don't know how useful this trace is, but maybe we can provide it
> alongside the reproducer that we commit to the repo. Maybe it could be
> improved with better trace events. Just a suggestion if we want more
> context around the raw qtest trace..

It's very useful and it would be great to have it as comments in the
testcase.  In particular, it would help anyone who wants to minimize the
testcase and/or convert it to a "real" test.

Thanks,

Paolo


