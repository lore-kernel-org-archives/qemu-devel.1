Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9E2C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE3A2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE3A2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCgYV-0005iJ-Fa
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 04:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iCgR6-0000cs-Ju
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iCgR5-0005nA-3r
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:44:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iCgR4-0005jm-S2
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:44:39 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 91FB7368DA
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 08:44:37 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id s25so518512wmh.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 01:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BTLG+h563yc7hRcZtstyPFZBK6+ucNtAo/CO8bEQhgo=;
 b=hw7TOqO72BrWJKqUSdTGXb7TPDWSiOaKMtkln2S4a2cldHuPCOrbhMf94R5y3NHFrd
 mMDxpA6s8qNmE7ggL8BJRqh83T80lOHmnoTt11ziXlGdu/NKUejOeWWVo0lMw0JpN9pA
 NIp6XJBAhhcotAL8XEmD4jPjmZrtnzFbrU2YAkvxcOZMx/ZNmHvlZmBMYBcUPB4NlOlT
 owPvB6wRTcFlBwBlj821VLnGozOWhdz5wS84+PZBrj6ycvGuF3scb8atLHd3Q8n57rW5
 xLkMa7FzH5CvqQqXoVFBFS3bct4AGcmbqN/lL7w9yHjaWctTQll2JC1Y484j3W2e4RRw
 pWGQ==
X-Gm-Message-State: APjAAAVqLTyKacd/FOA2XhuhEZr1rYIj6e/pU94gkJdOUQnZEnqZkBl0
 S70xdvIOZeLYfipRyshJEVnsgJBlKoEAFt8s5BRhwrkp8czULK/d1HG+dxf1P/FAAJp48pXsRvg
 Qr1ZcK1qN8VLFLlE=
X-Received: by 2002:adf:f9c9:: with SMTP id w9mr1304838wrr.172.1569314676198; 
 Tue, 24 Sep 2019 01:44:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz62a+OLhZ1DNmWUzxedNEk2N56ERIiaqOgaVHGYobX1gXGWfebbZjFfVqs2/TtCv40afNy/A==
X-Received: by 2002:adf:f9c9:: with SMTP id w9mr1304818wrr.172.1569314675876; 
 Tue, 24 Sep 2019 01:44:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d958:8ffa:a1f9:6bfa?
 ([2001:b07:6468:f312:d958:8ffa:a1f9:6bfa])
 by smtp.gmail.com with ESMTPSA id a6sm2381145wme.11.2019.09.24.01.44.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 01:44:35 -0700 (PDT)
Subject: Re: [PATCH] qemu-pr-helper: fix crash in mpath_reconstruct_sense
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190923233848.29445-1-mlevitsk@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4a650997-b971-fd03-b15d-093a2891af62@redhat.com>
Date: Tue, 24 Sep 2019 10:44:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923233848.29445-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/09/19 01:38, Maxim Levitsky wrote:
> The 'r' variable was accidently shadowed, and because of this
> we were always passing 0 to mpath_generic_sense, instead of original
> return value, which triggers an abort()
> 
> This is an attempt to fix the
> https://bugzilla.redhat.com/show_bug.cgi?id=1720047
> although there might be other places in the code
> that trigger qemu-pr-helper crash, and this fix might
> not be the root cause.
> 
> The crash was reproduced by creating an iscsi target on a test machine,
> and passing it twice to the guest like that:
> 
> -blockdev node-name=idisk0,driver=iscsi,transport=...,target=...
> -device scsi-block,drive=idisk0,bus=scsi0.0,bootindex=-1,scsi-id=1,lun=0,share-rw=on
> -device scsi-block,drive=idisk0,bus=scsi0.0,bootindex=-1,scsi-id=1,lun=1,share-rw=on
> 
> Then in the guest, both /dev/sda and /dev/sdb were aggregated by multipath to /dev/mpatha,
> which was passed to a nested guest like that
> 
> -object pr-manager-helper,id=qemu_pr_helper,path=/root/work/vm/testvm/.run/pr_helper.socket
> -blockdev node-name=test,driver=host_device,filename=/dev/mapper/mpatha,pr-manager=qemu_pr_helper
> -device scsi-block,drive=test,bus=scsi0.0,bootindex=-1,scsi-id=0,lun=0
> 
> The nested guest run:
> 
> sg_persist --no-inquiry  -v --out --register --param-sark 0x1234 /dev/sda
> 
> Strictly speaking this is wrong configuration since qemu is where
> the multipath was split, and thus the iscsi target was not aware of
> multipath, and thus when libmpathpersist code rightfully tried to register
> the PR key on all paths, it failed to do so.
> 
> However qemu-pr-helper should not crash in this case.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  scsi/qemu-pr-helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
> index a8a74d1dba..debb18f4aa 100644
> --- a/scsi/qemu-pr-helper.c
> +++ b/scsi/qemu-pr-helper.c
> @@ -323,10 +323,10 @@ static int mpath_reconstruct_sense(int fd, int r, uint8_t *sense)
>               */
>              uint8_t cdb[6] = { TEST_UNIT_READY };
>              int sz = 0;
> -            int r = do_sgio(fd, cdb, sense, NULL, &sz, SG_DXFER_NONE);
> +            int ret = do_sgio(fd, cdb, sense, NULL, &sz, SG_DXFER_NONE);
>  
> -            if (r != GOOD) {
> -                return r;
> +            if (ret != GOOD) {
> +                return ret;
>              }
>              scsi_build_sense(sense, mpath_generic_sense(r));
>              return CHECK_CONDITION;
> 

Nice catch, thanks!  Patch queued.

Paolo

