Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050D9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB6620575
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB6620575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYy3m-00010e-0m
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 16:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYy2r-0008Cc-Pc
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:32:01 -0400
Received: from relay64.bu.edu ([128.197.228.104]:44785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYy2q-0006Bj-9o
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:32:00 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 04DKV5pN029101
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 13 May 2020 16:31:06 -0400
Date: Wed, 13 May 2020 16:31:05 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v2 1/3] megasas: use unsigned type for reply_queue_head
 and check index
Message-ID: <20200513203105.qjdby3s55kt6c7li@mozz.bu.edu>
References: <20200513192540.1583887-1-ppandit@redhat.com>
 <20200513192540.1583887-2-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513192540.1583887-2-ppandit@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 16:31:59
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Ding Ren <rding@gatech.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Prasad,
On 200514 0055, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> A guest user may set 'reply_queue_head' field of MegasasState to
> a negative value. Later in 'megasas_lookup_frame' it is used to
> index into s->frames[] array. Use unsigned type to avoid OOB
> access issue.
> 
> Also check that 'index' value stays within s->frames[] bounds
> through the while() loop in 'megasas_lookup_frame' to avoid OOB
> access.
> 
> Reported-by: Ren Ding <rding@gatech.edu>
> Reported-by: Hanqing Zhao <hanqing@gatech.edu>
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---

Acked-by: Alexander Bulekov <alxndr@bu.edu>

I applied these patches and could not reproduce the heap-overflow, or
LP1878259

Thanks
-Alex

>  hw/scsi/megasas.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Update v1 -> v2: fix OOB access when index > MEGASAS_MAX_FRAMES(=2048)
>  -> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg03131.html
> 
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index af18c88b65..6ce598cd69 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -112,7 +112,7 @@ typedef struct MegasasState {
>      uint64_t reply_queue_pa;
>      void *reply_queue;
>      int reply_queue_len;
> -    int reply_queue_head;
> +    uint16_t reply_queue_head;
>      int reply_queue_tail;
>      uint64_t consumer_pa;
>      uint64_t producer_pa;
> @@ -445,7 +445,7 @@ static MegasasCmd *megasas_lookup_frame(MegasasState *s,
>  
>      index = s->reply_queue_head;
>  
> -    while (num < s->fw_cmds) {
> +    while (num < s->fw_cmds && index < MEGASAS_MAX_FRAMES) {
>          if (s->frames[index].pa && s->frames[index].pa == frame) {
>              cmd = &s->frames[index];
>              break;
> -- 
> 2.25.4
> 

