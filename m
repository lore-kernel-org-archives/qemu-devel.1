Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B86AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 06:02:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FDF2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 06:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAE591jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FDF2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbeID-0004pO-Fo
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 02:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jbeHF-0004Lh-Dk
 for qemu-devel@nongnu.org; Thu, 21 May 2020 02:01:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44531
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jbeHE-00041C-1w
 for qemu-devel@nongnu.org; Thu, 21 May 2020 02:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590040915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=5oVeHoaL/aaVSZ7oUeQTMZ0RQuk9f1zqrUxLqTWUnKo=;
 b=UAE591jvtRGuuwoKXYFnyE0K5L2aUKuRQdzLpvzBpYD9PehKOr5fl9KSrSjQhV4XvlBlCg
 9cFVInGweOBWG9WscsgXc/miMM7Mt7yOdDFEAOnioQQDOp7qXFK06asFMtF2Jl4KsbKziN
 qaK9M0ksa3SGNNsgW8H6m5ysgif0yT0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-PnowWho9NSm4tBNGqKUMCw-1; Thu, 21 May 2020 02:01:51 -0400
X-MC-Unique: PnowWho9NSm4tBNGqKUMCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 314831853C6E;
 Thu, 21 May 2020 06:01:50 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8A2460C84;
 Thu, 21 May 2020 06:01:45 +0000 (UTC)
Subject: Re: [PATCH v2 8/9] pc-bios: s390x: Replace 0x00 with 0x0 or 0
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200514123729.156283-1-frankja@linux.ibm.com>
 <20200514123729.156283-9-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f8732927-1f5c-b985-d89a-5014556f3eef@redhat.com>
Date: Thu, 21 May 2020 08:01:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200514123729.156283-9-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 00:43:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/05/2020 14.37, Janosch Frank wrote:
> 0x00 looks odd, time to replace it with 0 or 0x0 (for pointers).
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/dasd-ipl.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.c
> index b932531e6f..764ee89e92 100644
> --- a/pc-bios/s390-ccw/dasd-ipl.c
> +++ b/pc-bios/s390-ccw/dasd-ipl.c
> @@ -98,18 +98,18 @@ static int run_dynamic_ccw_program(SubChannelId schid, uint16_t cutype,
>  
>  static void make_readipl(void)
>  {
> -    Ccw0 *ccwIplRead = (Ccw0 *)0x00;
> +    Ccw0 *ccwIplRead = (Ccw0 *)0x0;
>  
>      /* Create Read IPL ccw at address 0 */
>      ccwIplRead->cmd_code = CCW_CMD_READ_IPL;
> -    ccwIplRead->cda = 0x00; /* Read into address 0x00 in main memory */
> +    ccwIplRead->cda = 0x0; /* Read into address 0x00 in main memory */
>      ccwIplRead->chain = 0; /* Chain flag */
>      ccwIplRead->count = 0x18; /* Read 0x18 bytes of data */
>  }
>  
>  static void run_readipl(SubChannelId schid, uint16_t cutype)
>  {
> -    if (do_cio(schid, cutype, 0x00, CCW_FMT0)) {
> +    if (do_cio(schid, cutype, 0x0, CCW_FMT0)) {
>          panic("dasd-ipl: Failed to run Read IPL channel program\n");
>      }
>  }
> @@ -133,10 +133,10 @@ static void check_ipl2(uint32_t ipl2_addr)
>  {
>      Ccw0 *ccw = u32toptr(ipl2_addr);
>  
> -    if (ipl2_addr == 0x00) {
> +    if (ipl2_addr == 0) {
>          panic("IPL2 address invalid. Is this disk really bootable?\n");
>      }
> -    if (ccw->cmd_code == 0x00) {
> +    if (ccw->cmd_code == 0) {
>          panic("IPL2 ccw data invalid. Is this disk really bootable?\n");
>      }
>  }
> @@ -161,7 +161,7 @@ static void ipl1_fixup(void)
>      memcpy(ccwRead, (void *)0x08, 16);
>  
>      /* Disable chaining so we don't TIC to IPL2 channel program */
> -    ccwRead->chain = 0x00;
> +    ccwRead->chain = 0;
>  
>      ccwSeek->cmd_code = CCW_CMD_DASD_SEEK;
>      ccwSeek->cda = ptr2u32(seekData);
> @@ -206,7 +206,7 @@ static void run_ipl2(SubChannelId schid, uint16_t cutype, uint32_t addr)
>   */
>  void dasd_ipl(SubChannelId schid, uint16_t cutype)
>  {
> -    PSWLegacy *pswl = (PSWLegacy *) 0x00;
> +    PSWLegacy *pswl = (PSWLegacy *) 0x0;
>      uint32_t ipl2_addr;
>  
>      /* Construct Read IPL CCW and run it to read IPL1 from boot disk */
> 

Not sure whether this is really worth the churn ... but in case you insist:

Reviewed-by: Thomas Huth <thuth@redhat.com>


