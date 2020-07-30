Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16946C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D549520829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6ZUgK3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D549520829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1BBB-00063e-1j
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k1B3a-00048v-FY
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:05:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32561
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k1B3Y-0006tO-1B
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596125116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8kgf1n95m3WlqJks0OhQ8DQmo2Q5LsrYQ8SiJvHiTLA=;
 b=X6ZUgK3Ihueri9pRazFLcBuGBLKE2mcLec91riryv8lZgJOPtPdrq3Rr658ZTjhdYlQzz+
 FIKqfHfvcZVqhQxx2wugTgARiuEcTlsN3Wz8ovz3v8ozheAPkDPrOmdu8VAL6Y8PujF8zN
 jKZ/hM8chFBwbJQHWa+cU1jvl1CoYkQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-bHcBrQ0MO_ORwb5aZO6cLQ-1; Thu, 30 Jul 2020 12:05:13 -0400
X-MC-Unique: bHcBrQ0MO_ORwb5aZO6cLQ-1
Received: by mail-wm1-f69.google.com with SMTP id s12so1480805wmc.5
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 09:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8kgf1n95m3WlqJks0OhQ8DQmo2Q5LsrYQ8SiJvHiTLA=;
 b=Hr9BbBxh/4PRl3f4Hmjub1kmocmRCZDYu7o4IfeTHINgSrGfkojUEt6F0W/CEWP7Q8
 f6qrs9n8xPhk5wsLNNW7y3I6tM5gyq/9Ol5hTg8F2hXx+1JBtLQg01MtQqLzuwtfd0TM
 0HveTppyGO8lp5vd8znH5NKAnz3pwPvQpGruhT4311BSM8UtDzMJkw13QiCsTEwZZQop
 BK5ksd2UqRlOx/mjERtXhqH4BLo8ugwCGXGxtPzHJyLfUc0RXrx4u1OeW6JIx7RAR/EA
 ZlZkrNXbi3bPTLk4Y61XEqjk0rVlEMPTvkT5LQCifeMMy8atDXQPaWGTlDWMMiDNqLxk
 N9aA==
X-Gm-Message-State: AOAM530igdH9fdEoBizFqXgsT040i6958QM6ZE6arl9Slb3T6mQDFyg3
 rYYlDz68hb/81tFeIJednsdLvWjqdxqLE2WrWgsIOkJMOzCIHHQVGp9m1VmPiBXrt3LjcE/CNOd
 Zkc0JtyjYatK/dcY=
X-Received: by 2002:a1c:80d0:: with SMTP id b199mr34412wmd.28.1596125112745;
 Thu, 30 Jul 2020 09:05:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeYplbCVs8icsNkQs896ZDvvHlsp8crs3Ew3EOuGdM7O5gRSwx5WsXguaDDErckxMNT6Ym4Q==
X-Received: by 2002:a1c:80d0:: with SMTP id b199mr34381wmd.28.1596125112394;
 Thu, 30 Jul 2020 09:05:12 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id a10sm19399016wmd.3.2020.07.30.09.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 09:05:11 -0700 (PDT)
Date: Thu, 30 Jul 2020 12:05:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 0/1] RFC: pcie: parital fix for missing unplug events
Message-ID: <20200730120440-mutt-send-email-mst@kernel.org>
References: <20200722161722.51416-1-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722161722.51416-1-mlevitsk@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:59:04
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 07:17:21PM +0300, Maxim Levitsky wrote:
> As described in bugzilla #1854264 it is possible to plug
> a pcie device and then unplug it before the guest notices
> (has time to process the attention button press)
> 
> To partially fix this issue, detect and refuse the hotunplug event.
> 
> There are other ways to fix this, which is why I am sending this as RFC:
> 
> 1. Queue/remember the unplug event and fire it (press the attention button again),
> when the guest clears its pending status.
> According to the spec this should cancel the hotplug event in the guest
> if done within 5 seconds (and I think that guest actually should wait 5 seconds
> after attention button is pressed before plugging in the device too to be strictly
> up to the spec)
> 
> 2. Detect that device isn't yet powered on by the guest (for example
> checking the bus master bit) or check that attention button is still
> pressed and in this case just unplug the device immediately.

I think 2 or failing that 1 would be preferable.


> Best regards,
> 	Maxim Levitsky
> 
> Maxim Levitsky (1):
>   pci/pcie: refuse another hotplug/unplug event if attention button is
>     pending
> 
>  hw/pci/pcie.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> -- 
> 2.26.2
> 


