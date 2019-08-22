Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78625C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 13:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416C522CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 13:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Mu3szqWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416C522CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0n1P-00005F-47
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 09:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ross.lagerwall@citrix.com>) id 1i0myl-0006o8-9c
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ross.lagerwall@citrix.com>) id 1i0myj-0000xM-Bh
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:18:15 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:60322)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ross.lagerwall@citrix.com>)
 id 1i0myh-0000tc-Cw; Thu, 22 Aug 2019 09:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566479891;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=zYVlyooVgI7lstgmEWgPQkxO49tKIRn7xJYyMzKhbYE=;
 b=Mu3szqWrCPXI8yNOph6T0SboNgUn3n7klNASTVHEvcKF1IVGmFb/zMCF
 RXnLBPK003Eo9aLAy53DJFDoRH+HLi18zF1zmqSA7a5GLZWVidnnqouzo
 0bIBugGCLiH9mtJLIFa08smYcN8VYGicW1Z/VEFfSalcKie8+N/aP9QVE U=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=ross.lagerwall@citrix.com;
 spf=Pass smtp.mailfrom=ross.lagerwall@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 ross.lagerwall@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="ross.lagerwall@citrix.com";
 x-sender="ross.lagerwall@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
 ross.lagerwall@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="ross.lagerwall@citrix.com";
 x-sender="ross.lagerwall@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="ross.lagerwall@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: GkSfQ6281CNVwPkvI+BYtwC1u6Y5M4fWU/ei12dyUXU6gIphzVa5sqXiXKUjk+ErLTQq9SmSV/
 9Bmoru3meJEg3Cp18/0dGg750dN0IZakM73RZQIiCVKk6kPB0avRH5yUvBFNLc4VLUwoVdTWD/
 HHFocYsQG67++no3opm37JK78AeKBUn6RFKm4EvNkRmMQcFxEdRZX5/qN0l3UB5xoVUzz4Q73h
 kv/Df4mcZ+0/pQKWuXbG4tclWdAG2/D/oUZoWtP3m5kn4a3TidS7dXcqxUMKWISdAtVw2FMXJC
 luI=
X-SBRS: 2.7
X-MesageID: 4836268
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,416,1559534400"; 
   d="scan'208";a="4836268"
To: Klaus Birkelund Jensen <klaus@birkelund.eu>, <qemu-block@nongnu.org>
References: <20190705072333.17171-1-klaus@birkelund.eu>
 <20190705072333.17171-17-klaus@birkelund.eu>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <79fb195f-91dc-869d-f290-40fdcb96eea3@citrix.com>
Date: Thu, 22 Aug 2019 14:18:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190705072333.17171-17-klaus@birkelund.eu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.144
Subject: Re: [Qemu-devel] [PATCH 16/16] nvme: support multiple namespaces
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
Cc: kwolf@redhat.com, armbru@redhat.com, matt.fitzpatrick@oakgatetech.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, keith.busch@intel.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/19 8:23 AM, Klaus Birkelund Jensen wrote:
> This adds support for multiple namespaces by introducing a new 'nvme-ns'
> device model. The nvme device creates a bus named from the device name
> ('id'). The nvme-ns devices then connect to this and registers
> themselves with the nvme device.
> 
> This changes how an nvme device is created. Example with two namespaces:
> 
>    -drive file=nvme0n1.img,if=none,id=disk1
>    -drive file=nvme0n2.img,if=none,id=disk2
>    -device nvme,serial=deadbeef,id=nvme0
>    -device nvme-ns,drive=disk1,bus=nvme0,nsid=1
>    -device nvme-ns,drive=disk2,bus=nvme0,nsid=2
> 
> A maximum of 256 namespaces can be configured.
> 
snip
>   static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>   {
> +    NvmeNamespace *ns = req->ns;
> +
>       uint32_t dw10 = le32_to_cpu(cmd->cdw10);
>       uint32_t dw11 = le32_to_cpu(cmd->cdw11);
>       uint32_t result;
> @@ -1464,7 +1474,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>           result = cpu_to_le32(n->features.err_rec);
>           break;
>       case NVME_VOLATILE_WRITE_CACHE:
> -        result = blk_enable_write_cache(n->conf.blk);
> +        result = blk_enable_write_cache(ns->conf.blk);
>           trace_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
>           break;

I tried this patch series by installing Windows with a single NVME 
controller having two namespaces. QEMU crashed in get_feature / 
NVME_VOLATILE_WRITE_CACHE because req->ns was NULL.

nvme_get_feature / nvme_set_feature look wrong to me since I can't see 
how req->ns would have been set. Should they have similar code to 
nvme_io_cmd to set req->ns from cmd->nsid?

After working around this issue everything else seemed to be working 
well. Thanks for your work on this patch series.

Thanks,
-- 
Ross Lagerwall

