Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCC7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE6020674
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE6020674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ipxe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyEii-0006z8-9u
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 09:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcb30@ipxe.org>) id 1jyEhB-0006Xz-JW
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:22:05 -0400
Received: from blyat.fensystems.co.uk ([54.246.183.96]:56052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcb30@ipxe.org>) id 1jyEh9-0000GR-Hu
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:22:05 -0400
Received: from dolphin.home (unknown
 [IPv6:2a00:23c6:5495:5e00:beee:7bff:fe8d:f03d])
 by blyat.fensystems.co.uk (Postfix) with ESMTPSA id 25E2842B39;
 Wed, 22 Jul 2020 13:21:58 +0000 (UTC)
Subject: Re: [ipxe-devel] https booting
To: Gerd Hoffmann <kraxel@redhat.com>, ipxe-devel@lists.ipxe.org,
 qemu-devel@nongnu.org
References: <20200722120827.dq72uabrk26nllra@sirius.home.kraxel.org>
From: Michael Brown <mcb30@ipxe.org>
Message-ID: <73923bb0-0a75-d8f1-fa49-87994e5354db@ipxe.org>
Date: Wed, 22 Jul 2020 14:21:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722120827.dq72uabrk26nllra@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=54.246.183.96; envelope-from=mcb30@ipxe.org;
 helo=blyat.fensystems.co.uk
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 09:22:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/07/2020 13:08, Gerd Hoffmann wrote:
> With the world moving to use https by default people start to ask for
> https being enabled by default for the qemu boot roms.
> 
> We could simply flip the DOWNLOAD_PROTO_HTTPS switch in
> src/config/qemu/general.h (ipxe git repo).  Note that this would only
> affect booting in bios mode, for uefi qemu uses the efidrv builds which
> implies https support is in the hands of the uefi firmware (edk2/ovmf).

The .efidrv builds can be used for booting via either the UEFI PXE flow 
(using iPXE as just a NIC driver) or via the iPXE flow (using iPXE as an 
application invoked via the NIC driver's EFI_LOAD_FILE_PROTOCOL entry 
point), so it might still be relevant to UEFI as well as BIOS.

> After looking at https://ipxe.org/cfg/crosscert I'm not convinced this
> is a good idea though.  This would likely put quite some load to
> ca.ipxe.org.  Also that machine becomes a single point of failure for
> worldwide ipxe https boot, and looking through the mailing list I've
> seen we already had (at least) two outages this year.

The crosscert fetches are static files (with iPXE including a query 
string only for debugging purposes), and it should be fairly 
straightforward for me to switch to hosting them in AWS S3 or 
equivalent.  The ca.ipxe.org domain is not used for anything else so 
could be pointed at a new hosting infrastructure with no disruption or 
code changes.

I would worry more about the OCSP service for the cross-signed 
certificates, since OCSP does not just serve static responses.  This 
service is currently implemented using openca-ocspd running on a VM in 
AWS.  I'm very open to suggestions on more scalable ways to host this.

> What happens if you sent crosscert to the empty string?

An empty string is equivalent to a deleted setting, so it will fall back 
to using the compiled-in default.

> Will ipxe fail or will it boot without cert verification?

iPXE does need to be able to construct a full certificate chain leading 
back to its trusted root certificate.  If the crosscert source is 
unavailable then otherwise valid certs will be treated as invalid since 
the information required to validate them is not avaiable.

> What does it take to mirror http://ca.ipxe.org/auto/?
> Just "wget -r" everything and serve it?

For the crosscert files, yes.  There's still OCSP to think about; see above.

> How does edk2 handle the root ca problem?

I'm also curious to know!

Thanks,

Michael

