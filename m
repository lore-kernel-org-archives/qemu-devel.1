Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D53C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D08420708
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/iBMPIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D08420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY1o0-0008PM-EY
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 02:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY1nI-0007u1-8L
 for qemu-devel@nongnu.org; Mon, 11 May 2020 02:20:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33361
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY1nG-0003O3-7o
 for qemu-devel@nongnu.org; Mon, 11 May 2020 02:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589178000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zy12sd76hKv+UuiN4e7HK7KbsMAgQuBLA9xWXALbN9Y=;
 b=a/iBMPIPL8S+e215h0vx91iwpZv0j930j8QVkfdlQJn3zCGukHKPLe8PA85RkugiWjkR7n
 J97pOLb7ORFZ8qhhhOLb4OTJCuGacG18AUFEpC2YFoZaN2A1gigUgUyzPiSLlV/xdo8zxs
 UpkPAFGx0QSZabSkBqstMuBZxnkGDXA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-05T-zGOmPYuXcQLwwRLF5A-1; Mon, 11 May 2020 02:19:54 -0400
X-MC-Unique: 05T-zGOmPYuXcQLwwRLF5A-1
Received: by mail-wr1-f71.google.com with SMTP id w9so865897wrr.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 23:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zy12sd76hKv+UuiN4e7HK7KbsMAgQuBLA9xWXALbN9Y=;
 b=Ni/GH89923YZhsJ/FLsf6UZUxFat92YKM20F6BA3FvPJq3zzyHy7yICrmvj2sVd7oW
 BbdfDregoNcn5osjwQkUsbwUqkpOoHXBUY2zYV6nmkwLxWCFX5pYNMgWF/dNQGVbJD/K
 G03xx0g/wr/5mNu+cK9CmInmS2s/wmEWf2e0ZJvwedzdUV3EmpZxDRPe9+rKvs/qgfh8
 iqlSetX1HNfnSfXADSmLPJTRi7XP3F6TN6t2R+OtcRZq6xVMzE6kuaQylQgjuEW6NCLS
 GXyoyONw1Ee2MhHb4yhZyf6+iLAq4QoeeLvRqnH7nbskM0pKvSJUa+98nWJwzrkHm8iI
 JqmQ==
X-Gm-Message-State: AGi0PubGXzfVyiaHT/1TOdhPpZ6tVMSoL4d7Tle/1tgQo6mCF9TvYPGW
 /AoBrHufqv59p5q+/4DJw6LtIX3Q58gYff0zRyYheRw9CQAmD+9UJ0a7CXm39KGO7XIKkjg/4vg
 sKhcOTUDNZlbtm2g=
X-Received: by 2002:adf:bb4e:: with SMTP id x14mr16678431wrg.63.1589177993701; 
 Sun, 10 May 2020 23:19:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ1/qH2/8NtFRsybcT+ObiovHaeXPWiGGW1XP/zHwjYRtPnaGSD4NGFDLc/HM7nS1T6luFtSg==
X-Received: by 2002:adf:bb4e:: with SMTP id x14mr16678410wrg.63.1589177993444; 
 Sun, 10 May 2020 23:19:53 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id t2sm26103743wmt.15.2020.05.10.23.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 May 2020 23:19:52 -0700 (PDT)
Subject: Re: Abort in mch_update_pciexbar
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200511045912.keffhizkobgwqcag@mozz.bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c6b66f8a-40e4-8ad5-afb4-09bddbcac529@redhat.com>
Date: Mon, 11 May 2020 08:19:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200511045912.keffhizkobgwqcag@mozz.bu.edu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 01:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/11/20 6:59 AM, Alexander Bulekov wrote:
> Hello,
> While fuzzing, I found an input that triggers an assertion failure in
> mch_update_pciexbar:
> 
> #6 0x7f38d387c55a in abort /build/glibc-GwnBeO/glibc-2.30/stdlib/abort.c:79:7
> #7 0x55c27e94ffd0 in mch_update_pciexbar hw/pci-host/q35.c:331:9
> #8 0x55c27e94db38 in mch_write_config hw/pci-host/q35.c:487:9
> #9 0x55c27e9e3f4c in pci_host_config_write_common hw/pci/pci_host.c:81:5
> #10 0x55c27e9e5307 in pci_data_write hw/pci/pci_host.c:118:5
> #11 0x55c27e9e6601 in pci_host_data_write hw/pci/pci_host.c:165:9
> #12 0x55c27ca3b17b in memory_region_write_accessor memory.c:496:5
> #13 0x55c27ca3a5e4 in access_with_adjusted_size memory.c:557:18
> #14 0x55c27ca38177 in memory_region_dispatch_write memory.c:1488:16
> #15 0x55c27c721325 in flatview_write_continue exec.c:3174:23
> #16 0x55c27c70994d in flatview_write exec.c:3214:14
> #17 0x55c27c709462 in address_space_write exec.c:3305:18

These lines don't match QEMU v5.0.0.

> 
> I can reproduce it in a qemu 5.0 build using:
> cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -M pc-q35-5.0 -display none -nodefaults -nographic -qtest stdio
> outl 0xcf8 0xf2000060
> outl 0xcfc 0x8400056e

The guest shouldn't ask for a reserved bar length (grep for 
MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_RVD). I suppose we should simply report 
it as GUEST_ERROR and ignore it.

> EOF
> 
> I also uploaded the above trace, in case the formatting is broken:
> 
> curl https://paste.debian.net/plain/1146095 | qemu-system-i386 -M pc-q35-5.0 -display none -nodefaults -nographic -qtest stdio
> 
> Please let me know if I can provide any further info.

It would help the community if you fill your bug reports with Launchpad, 
so they don't get lost in the high email flow, and we can track/update 
them. See for example:
https://bugs.launchpad.net/qemu/+bug/1835865 and
https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg06082.html 
which refers it.


