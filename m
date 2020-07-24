Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3881C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6DA5206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DA5206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ipxe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz0S8-0000AY-U1
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 12:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcb30@ipxe.org>) id 1jz0QH-00079z-16
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:19:49 -0400
Received: from blyat.fensystems.co.uk
 ([2a05:d018:a4d:6403:2dda:8093:274f:d185]:58548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcb30@ipxe.org>) id 1jz0QD-0006b5-2L
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:19:48 -0400
Received: from dolphin.home (unknown
 [IPv6:2a00:23c6:5495:5e00:beee:7bff:fe8d:f03d])
 by blyat.fensystems.co.uk (Postfix) with ESMTPSA id 5EBF542B34;
 Fri, 24 Jul 2020 16:19:39 +0000 (UTC)
Subject: Re: [ipxe-devel] https booting
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20200722120827.dq72uabrk26nllra@sirius.home.kraxel.org>
 <20200722122347.GF2324845@redhat.com>
 <20200722135538.wvblddvskp5j4wik@sirius.home.kraxel.org>
 <20200722141318.GJ2324845@redhat.com>
From: Michael Brown <mcb30@ipxe.org>
Message-ID: <411ac2fb-1f3e-28f0-5c9a-6ff0806cfbf7@ipxe.org>
Date: Fri, 24 Jul 2020 17:19:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722141318.GJ2324845@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a05:d018:a4d:6403:2dda:8093:274f:d185;
 envelope-from=mcb30@ipxe.org; helo=blyat.fensystems.co.uk
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 12:19:41
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: ipxe-devel@lists.ipxe.org,
 =?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/07/2020 15:13, Daniel P. Berrangé wrote:
> We could easily define etc/ipxe/https/{ciphers,cacerts} paths in a
> different format if better suited for iPXE. Libvirt can set the right
> path depending on whether its booting a VM with EDK2 vs legacy BIOS

The most useful for iPXE would probably be to expose the fw_cfg 
mechanism as a URI scheme.  This would give a general mechanism allowing 
for use cases such as running a script provided by the host via e.g.

   chain fw_cfg:///opt/org.example/script.ipxe

The ${crosscert} setting could then be pointed at a base URL within the 
fw_cfg space, e.g.

   #define CROSSCERT "fw_cfg:///etc/ipxe/crosscert/auto"

This would then work in the same way under either BIOS or UEFI (or other 
custom firmware), would provide a feature with applicability broader 
than just obtaining certificates, and would avoid any potential problems 
from allocating enough RAM to parse every root certificate from iPXE's 
fixed 512kB internal heap.

What do you think?

Michael

