Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B82C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6246320734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdPRzRLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6246320734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj10T-0003S0-KT
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jj0nE-0002r0-97
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:29:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28580
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jj0nC-0000AH-Nb
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591795760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=vtRoNo4UmrYr/jyICdCpL0uqzJ5x2K1RQRzzbDEEtbw=;
 b=SdPRzRLdDK9GGnOITEzV6er9Eab3vgK4XC1UEMhk7P15jLu1JFnZWaWZ61buKmZP6M+dva
 lCTydgeARvW34ayfyAOv0EfVw2IgpdXKcIfLWnCvG3G1tt8mfUM87noDKBs2gnQrz0VMy9
 fFjRN4aoKDTxmTVTfQXm4r12MUxyQpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-T-VjCc_fN_iHuZ84rxhcOA-1; Wed, 10 Jun 2020 09:29:17 -0400
X-MC-Unique: T-VjCc_fN_iHuZ84rxhcOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C642A107ACCA;
 Wed, 10 Jun 2020 13:29:15 +0000 (UTC)
Received: from thuth.remote.csb (unknown [10.40.192.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64EB87A8C9;
 Wed, 10 Jun 2020 13:29:13 +0000 (UTC)
Subject: Re: [RFC] hw: nios2: update interrupt_request when STATUS_PIE disabled
To: "Wu, Wentong" <wentong.wu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <DM5PR11MB18339389B4BD1BB2B4B5AB7A8D860@DM5PR11MB1833.namprd11.prod.outlook.com>
 <e816a581-2bca-a1d3-a5d3-512200298623@redhat.com>
 <DM5PR11MB18332BBC3495C9D9DDC3D4218D820@DM5PR11MB1833.namprd11.prod.outlook.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f464a208-8403-3f4e-7239-5b9c8299d24d@redhat.com>
Date: Wed, 10 Jun 2020 15:29:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <DM5PR11MB18332BBC3495C9D9DDC3D4218D820@DM5PR11MB1833.namprd11.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/06/2020 10.39, Wu, Wentong wrote:
> Hi @Thomas Huth,
> It's my first time to send patch in qemu community, not sure if there is something wrong sending patch like below and I'm happy to receive any suggestions. And by the way, could you please help review the patch? 

 Hi,

it would be good if you could send the patch as plain text e-mail, not
as HTML mail, otherwise it's impossible to apply it with "git am" or
"patch". If you can, try to use "git send-email" to send out patches.
Also see https://wiki.qemu.org/Contribute/SubmitAPatch for some more
details.

Technically, I don't have a clue about nios2, so sorry, I can't help
reviewing it. But it's a very small patch, so maybe send the plain-text
mail with CC: to qemu-trivial@nongnu.org - if Chris or Marek provide an
Reviewed-by or Acked-by then, it should get merged with the next trivial
pull request.

 HTH,
  Thomas


> Thanks
> 
> -----Original Message-----
> From: Thomas Huth <thuth@redhat.com> 
> Sent: Friday, June 5, 2020 3:07 PM
> To: Wu, Wentong <wentong.wu@intel.com>; qemu-devel@nongnu.org
> Cc: Chris Wulff <crwulff@gmail.com>; Marek Vasut <marex@denx.de>
> Subject: Re: [RFC] hw: nios2: update interrupt_request when STATUS_PIE disabled
> 
> On 05/06/2020 07.59, Wu, Wentong wrote:
>> Hi all,
>>
>> I’m running icount mode on qemu_nios2 with customized  platform(almost 
>> same with 10m50_devboard),
>>
>> but cpu abort happened(qemu: fatal: Raised interrupt while not in I/O
>> function) when guest code changes
>>
>> state register with wrctl instruction, add some debug code finding 
>> that it’s caused by the interrupt_request
>>
>> mismatch, so I made a patch as below, not sure if it’s right, hope I 
>> can have some discussion with maintainers
> 
>  Hi,
> 
> please have a look at the MAINTAINERS file in the main directory of the sources, you can find the corresponding maintainers there. Thus if you have questions related to nios2, please make sure to put Chris and Marek into CC: so that your patch gets the right attention!
> 
>  Thanks,
>   Thomas
> 
> 
> 
>> commit efdb3da4e145a7a34ba8b3ab1cdcfc346ae20a11 (HEAD -> master)
>>
>> Author: Wentong Wu <wentong.wu@intel.com>
>>
>> Date:   Fri Jun 5 09:29:43 2020 -0400
>>
>>  
>>
>>     hw: nios2: update interrupt_request when CR_STATUS_PIE disabled
>>
>>  
>>
>>     Update interrupt_request when external interupt pends for 
>> STATUS_PIE
>>
>>     disabled. Otherwise on icount enabled nios2 target there will be 
>> cpu
>>
>>     abort when guest code changes state register with wrctl instruction.
>>
>>  
>>
>>     Signed-off-by: Wentong Wu <wentong.wu@intel.com>
>>
>>  
>>
>> diff --git a/hw/nios2/cpu_pic.c b/hw/nios2/cpu_pic.c
>>
>> index 1c1989d5..b04db4d7 100644
>>
>> --- a/hw/nios2/cpu_pic.c
>>
>> +++ b/hw/nios2/cpu_pic.c
>>
>> @@ -42,7 +42,9 @@ static void nios2_pic_cpu_handler(void *opaque, int 
>> irq, int level)
>>
>>          } else if (!level) {
>>
>>              env->irq_pending = 0;
>>
>>              cpu_reset_interrupt(cs, type);
>>
>> -        }
>>
>> +        } else {
>>
>> +            cs->interrupt_request |= type;
>>
>> +       }
>>
>>      } else {
>>
>>          if (level) {
>>
>>              cpu_interrupt(cs, type);
>>
> 


