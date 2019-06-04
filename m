Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D62CC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 15:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560572075B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 15:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560572075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53806 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYB2E-00072z-1A
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 11:07:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hYB1E-0006Nz-Po
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hYB1C-0000sW-1w
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:06:32 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:43558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hYB1B-0000kS-CQ
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:06:29 -0400
Received: by mail-wr1-f49.google.com with SMTP id r18so7209417wrm.10
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 08:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=VpJ87L5tZcuTdiTAfVn2ZCImKbEBJ9ywf089femknq0=;
	b=DDYCNM59/cql+cKJdwwuH3u9NI0tx5GeE6mgcbzx4QzIy5OfuJnylmzAIIEbtIEr9n
	Lqhd5kgGHxmQdSGaIbfPzJ4/VRZaHeDMkriodpRFM1/zamHaAZ7KRtsgk3/d1Sl3i0rC
	gG6crwljBGiu+g+xsy5THzjm4tmtCYWeoJoTBjfIY72ILszT48EXWHilxt7Hr6ydAZOk
	Q6GzC6ne93XNZbV57XcDPnUckKNaxfMmXemhMHB3uZ32++0v67m4OKcjfMsILNTFDsKV
	INctNQtx0xuBGvliPF832FDLOpElmvBxtHXXizExHO+TyC9oxEZLydkkhCRSM+m02/Uv
	OF0g==
X-Gm-Message-State: APjAAAWd9tNE6aLhlxFGlUn/ZFLsUEFJ9NZom3KSgceCM1vfFGmE9FOJ
	chspeg3bvn4dQrcnLAWiWUg7Dg==
X-Google-Smtp-Source: APXvYqyGzQfXD5TS6VV5GQDWPl4hJzQvShIcXyRqolAuRBpu9UmOKVw35dKE6xP1LljOTZxC4CCDBA==
X-Received: by 2002:a5d:4e83:: with SMTP id e3mr3821009wru.263.1559660782146; 
	Tue, 04 Jun 2019 08:06:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:657f:501:149f:5617?
	([2001:b07:6468:f312:657f:501:149f:5617])
	by smtp.gmail.com with ESMTPSA id
	e6sm10405681wrw.83.2019.06.04.08.06.21
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 08:06:21 -0700 (PDT)
To: Natalia Fursova <Natalia.Fursova@ispras.ru>, qemu-devel@nongnu.org,
	=?UTF-8?B?0J/QsNGI0LA=?= <Pavel.Dovgaluk@ispras.ru>
References: <5cf62de9.1c69fb81.66fc.8f4fSMTPIN_ADDED_BROKEN@mx.google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1e9e4edd-f4ad-d8d6-95a2-e0aeab89510d@redhat.com>
Date: Tue, 4 Jun 2019 17:06:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5cf62de9.1c69fb81.66fc.8f4fSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.49
Subject: Re: [Qemu-devel] qgraph
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/06/19 10:37, Natalia Fursova wrote:
> Hello, Paolo!
> 
> We develop GUI for Qemu and want to implement graphical interface for
> configuring the device tree. To do this we need to detect list of the
> devices supported by any specific platform.
> 
> Then we use this tree for command line generation.
> 
> Existing qmp commands don't supply enough information to build the tree.
> They miss bus and interface data.

Hi!

Bus data is implicit in the parent class provided by QMP.  For example,
pci-device is the superclass of PCI devices, scsi-device is the
superclass of SCSI devices, etc.

qgraph is indeed similar, but it is only used by test cases, not by QEMU
itself.  The difference is that qgraph links together _drivers_ for the
devices, and so it is limited to those devices that have tests.  For
some ideas behind qgraph, see
https://wiki.qemu.org/Features/qtest_driver_framework.

Paolo

> 
>  
> 
> There is something called 'qgraph' in Qemu. It looks similar to data
> structures in our GUI tool.
> 
>  
> 
> Tell me please, do you have a plan on improving this interface? We found the
> following hardcoded lines in the tests:
> 
> qos_node_consumes("megasas", "pci-bus", &opts);
> 
> qos_node_produces("megasas", "pci-device");
> 
>  
> 
> And we wanted to extend QMP to query this kind of information.
> 
>  
> 
>  
> 
> Best regards, 
> 
> Natalia
> 
>  
> 


