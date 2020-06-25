Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E32C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D78D20702
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZINeqwkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D78D20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRcW-0005sO-3D
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joRSG-0007Ds-Qq
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:58:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45828
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joRSF-0003u8-2I
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593089890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ng52OiKCUk7i5VLGfsx9WBQjG5ym5SJ0Y0pvMd4jdo8=;
 b=ZINeqwkwiPkNRYcyuJlvAplN5cJK4wvVC/nkEnqZ7eblid7tC0GUpeXtN9mZy6Nxtj98UV
 q4spqShTEUVn58mO2sY3ZF16CcoWJ4O5CdSFGrFguGHAPKQq8kQhxPQW5x/MkzKtO+mBbc
 VA6wPnDdrDgOq6VaWmq2wUrkcxDDTsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-wGs0gamVPVeV27HXmG7i2g-1; Thu, 25 Jun 2020 08:58:08 -0400
X-MC-Unique: wGs0gamVPVeV27HXmG7i2g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8438318FE860;
 Thu, 25 Jun 2020 12:58:07 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1823100EBB8;
 Thu, 25 Jun 2020 12:58:02 +0000 (UTC)
Subject: Re: [RFC v5 12/12] pc-bios: s390x: Cleanup jump to ipl code
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200624075226.92728-1-frankja@linux.ibm.com>
 <20200624075226.92728-13-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <48329294-4c31-a1fa-20fb-ef6bb13e8550@redhat.com>
Date: Thu, 25 Jun 2020 14:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200624075226.92728-13-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/2020 09.52, Janosch Frank wrote:
> jump_to_IPL_code takes a 64 bit address, masks it with the short psw
> address mask and later branches to it using a full 64 bit register.
> 
> * As the masking is not necessary, let's remove it
> * Without the mask we can save the ipl address to a static 64 bit
>    function ptr as we later branch to it
> * Let's also clean up the variable names and remove the now unneeded
>    ResetInfo
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/jump2ipl.c | 27 +++++++++++----------------
>   1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
> index 767012bf0c..aef37cea76 100644
> --- a/pc-bios/s390-ccw/jump2ipl.c
> +++ b/pc-bios/s390-ccw/jump2ipl.c
> @@ -13,20 +13,15 @@
>   #define KERN_IMAGE_START 0x010000UL
>   #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
>   
> -typedef struct ResetInfo {
> -    uint64_t ipl_psw;
> -    uint32_t ipl_continue;
> -} ResetInfo;
> -
> -static ResetInfo save;
> +static void (*ipl_continue)(void);
> +static uint64_t psw_save;

I wonder whether there was a reason for having ipl_continue in the 
lowcore instead of using a simple static function pointer... Christian, 
do you remember?

>   static void jump_to_IPL_2(void)
>   {
> -    ResetInfo *current = 0;
> +    uint64_t *psw_current = 0;

Mhh, what about using uint64_t *psw_current = (uint64_t *)lowcore 
instead, to make it more more explicit?

> -    void (*ipl)(void) = (void *) (uint64_t) current->ipl_continue;
> -    *current = save;
> -    ipl(); /* should not return */
> +    *psw_current = psw_save;
> +    ipl_continue(); /* should not return */
>   }
>   
>   void jump_to_IPL_code(uint64_t address)
> @@ -46,15 +41,15 @@ void jump_to_IPL_code(uint64_t address)
>        * content of non-BIOS memory after we loaded the guest, so we
>        * save the original content and restore it in jump_to_IPL_2.
>        */
> -    ResetInfo *current = 0;
> +    uint64_t *psw_current = 0;

dito.

> -    save = *current;
> +    psw_save = *psw_current;
>   
> -    current->ipl_psw = (uint64_t) &jump_to_IPL_2;
> -    current->ipl_psw |= RESET_PSW_MASK;
> -    current->ipl_continue = address & PSW_MASK_SHORT_ADDR;
> +    *psw_current = (uint64_t) &jump_to_IPL_2;
> +    *psw_current |= RESET_PSW_MASK;
> +    ipl_continue = (void *)address;
>   
> -    debug_print_int("set IPL addr to", current->ipl_continue);
> +    debug_print_int("set IPL addr to", (uint64_t)ipl_continue);
>   
>       /* Ensure the guest output starts fresh */
>       sclp_print("\n");
> 

The patch sounds like a good idea to me ... but since this code proofed 
to be very fragile in the past, let's wait for Christian to say whether 
there was a good reason for ipl_continue in the lowcore or not.

  Thomas


