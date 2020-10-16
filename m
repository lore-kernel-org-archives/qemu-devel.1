Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3595C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3F22083B
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbqYt8Tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3F22083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTPcg-0007YT-K8
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 09:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kTPav-0006aD-5Q
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kTPat-0006Sl-IX
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602854186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aBB4cVh25BA/qfLC2sloIi+6afQ0zRe8vkIieM2qN4I=;
 b=QbqYt8Tq7Euqf7htFTYmrJZWQsAkKh326J6FsKbFvuOsuo5WCz+Oy6JZf8NY2guE8pf3VO
 n80Qo0q0jH+6VaELdCIh0QY5XqLLM+JqndgbWZLqvnWsZtAFpz84pnxdt3hMLif5gBZgza
 AHnHkEONw3D98hdQaxV0NbMvCrypgN0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-RXV2IQZKNzyGlH46v_wXrA-1; Fri, 16 Oct 2020 09:16:24 -0400
X-MC-Unique: RXV2IQZKNzyGlH46v_wXrA-1
Received: by mail-wm1-f71.google.com with SMTP id i9so718845wml.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 06:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aBB4cVh25BA/qfLC2sloIi+6afQ0zRe8vkIieM2qN4I=;
 b=GNXQNqDPuQHBz7lmBfP4G5lWwEJSiPEy/JSEmS1YDXjVtYDgGYFFxnpJh5BDIMTJBh
 yt5dmS2mFLlqFOFlQI43qG4iPdmDu+RX/I5Kh2hpUzxhqZrn75sayZkqO/j6F6p/CJyW
 gZVudfs8/iS72x/Y8VTA2V3MK3qIPZ1K15ETuYE5qnVeK6vagdJxUMuHIGJR1ahex450
 J+yAs8emQp9E8NQycdcNwB/a/aSRWkwikjxsqTbK6OKUAv9WShfKFtISSaNyp7E75LtT
 Z04CfC40xjS4iiVHCmgnSG9GqG5EyWdUfTAFkKhkLPqEKa4LSXvgL3gTLw61N9Hb2RQ0
 l50Q==
X-Gm-Message-State: AOAM531QSh7r9GI3VXs/SPV+IH+A58ssQog5QngkU+/6DDRueH1qQ040
 3n4NhM09rUtrToPADgzTD3rAb/QHB0oyBlQjVRQWsKNXhEXgOloQnf2fQixg8/fTuc4ocQMf1mB
 n68zy31BO0S3xOWI=
X-Received: by 2002:a05:600c:4147:: with SMTP id
 h7mr3679997wmm.45.1602854183833; 
 Fri, 16 Oct 2020 06:16:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGoT2wM6A21zPdThVwWUaFZcWHfpB41RPXA9aTR8J/lFo5F46E8O45rYwg3s6q67cpzkDx9Q==
X-Received: by 2002:a05:600c:4147:: with SMTP id
 h7mr3679867wmm.45.1602854182094; 
 Fri, 16 Oct 2020 06:16:22 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 24sm2729984wmg.8.2020.10.16.06.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 06:16:21 -0700 (PDT)
Subject: Re: [PATCH 0/4] RfC: microvm: add second ioapic
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20201016114328.18835-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ffd81f03-b2a0-2c58-9f13-c956dfd1ca17@redhat.com>
Date: Fri, 16 Oct 2020 15:16:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016114328.18835-1-kraxel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:29:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 1:43 PM, Gerd Hoffmann wrote:
> Add a second ioapic to microvm.  Gives us more IRQ lines we can
> use for virtio-mmio devices.  Bump number of possible virtio-mmio
> devices from 8 to 24.
> 
> Gerd Hoffmann (4):
>    microvm: make number of virtio transports runtime configurable
>    microvm: make pcie irq base runtime configurable
>    microvm: add second ioapic
>    microvm: reconfigure irqs if second ioapic is available

After looking at Laurent's m68k virt machine,
I wonder if it is possible to use the Goldfish-PIC
with the MicroVM instead (or another Goldfish machine
type).


