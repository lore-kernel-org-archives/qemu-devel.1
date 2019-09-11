Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230E7C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 17:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72F42084F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 17:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72F42084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i86Tg-0006HS-10
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 13:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1i86SV-0005oM-5b
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 13:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1i86ST-0006d8-UH
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 13:31:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58601)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1i86ST-0006c1-Mq
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 13:31:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B45CE10CC1EC;
 Wed, 11 Sep 2019 17:31:06 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-127.ams2.redhat.com
 [10.36.116.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE9B019C6A;
 Wed, 11 Sep 2019 17:30:50 +0000 (UTC)
To: Igor Mammedov <imammedo@redhat.com>
References: <add488d0-df13-830f-28c5-c7232ccb741f@redhat.com>
 <20190905154925.30478-1-imammedo@redhat.com>
 <dbe8cc44-ef30-3104-2bd3-6a6fe4438ada@redhat.com>
 <20190910175841.176b26e4@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8ed1ab55-d5ee-9703-dd28-cf50fbda5408@redhat.com>
Date: Wed, 11 Sep 2019 19:30:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190910175841.176b26e4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Wed, 11 Sep 2019 17:31:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] q35: lpc: allow to lock down 128K RAM at
 default SMBASE address
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
Cc: yingwen.chen@intel.com, devel@edk2.groups.io, phillip.goerl@oracle.com,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, jiewen.yao@intel.com,
 jun.nakajima@intel.com, michael.d.kinney@intel.com, pbonzini@redhat.com,
 boris.ostrovsky@oracle.com, rfc@edk2.groups.io, joao.m.martins@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/19 17:58, Igor Mammedov wrote:
> On Mon, 9 Sep 2019 21:15:44 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:

[...]

> It looks like fwcfg smi feature negotiation isn't reusable in this case.
> I'd prefer not to add another device just for another SMI feature
> negotiation/activation.

I thought it could be a register on the new CPU hotplug controller that
we're going to need anyway (if I understand correctly, at least).

But:

> How about stealing reserved register from pci-host similar to your
> extended TSEG commit (2f295167 q35/mch: implement extended TSEG sizes)?
> (Looking into spec can (ab)use 0x58 or 0x59 register)

Yes, that should work.

In fact, I had considered 0x58 / 0x59 when looking for unused registers
for extended TSEG configuration:

http://mid.mail-archive.com/d8802612-0b11-776f-b209-53bbdaf67515@redhat.com

So I'm OK with this, thank you.

More below:

>> ... I've done some testing too. Applying the QEMU patch on top of
>> 89ea03a7dc83, my plan was:
>>
>> - do not change OVMF, just see if it continues booting with the QEMU
>> patch
>>
>> - then negotiate bit#1 too, in step (1a) -- this is when I'd expect (3a)
>> to break.
>>
>> Unfortunately, the result is worse than that; even without negotiating
>> bit#1 (i.e. in the baseline test), the firmware crashes (reboots) in
>> step (3a). I've checked "info mtree", and all occurences of
>> "smbase-blackhole" and "smbase-blackhole" are marked [disabled]. I'm not
>> sure what's wrong with the baseline test (i.e. without negotiating
>> bit#1). If I drop the patch (build QEMU at 89ea03a7dc83), then things
>> work fine.
> 
> that was a bug in my code, which always made lock down effective on
> feature_ok selection, which breaks relocation for reasons you've
> explained above.
> 
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 17a8cd1b51..32ddf54fc2 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -383,7 +383,7 @@ static const MemoryRegionOps smbase_blackhole_ops = {
>  
>  static void ich9_lpc_smbase_locked_update(ICH9LPCState *lpc)
>  {
> -    bool en = lpc->smi_negotiated_features & ICH9_LPC_SMI_F_LOCKED_SMBASE_BIT;
> +    bool en = lpc->smi_negotiated_features & (UINT64_C(1) << ICH9_LPC_SMI_F_LOCKED_SMBASE_BIT);
>  
>      memory_region_transaction_begin();
>      memory_region_set_enabled(&lpc->smbase_blackhole, en);

I see.

ICH9_LPC_SMI_F_LOCKED_SMBASE_BIT is 1, with the intended value for
bitmask checkin) being 1LLU<<1 == 2LLU.

Due to the bug, the function would check value 1 in the bitmask -- which
in fact corresponds to bit#0. Bit#0 happens to be
ICH9_LPC_SMI_F_BROADCAST_BIT.

And because OVMF would negotiate that feature (= broadcast SMI) even in
the baseline test, it ended up enabling the "locked smbase" feature too.

So ultimately I think we can consider this a valid test (= with
meaningful result); the result is that we can't reuse these fw_cfg files
for "locked smbase", as discussed above.

Thanks!
Laszlo

