Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAA4C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8CF20758
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMkcb0wR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8CF20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juurD-00084D-Km
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1juuqM-0006iy-Ab
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:33:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37561
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1juuqJ-00076o-TC
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594632827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=SVarJs7pEWgUpt4bxOZWcWFb5mF0hM9+Cy8CW9/osJ4=;
 b=QMkcb0wRevmGtkmZIEzgh7BKJmb35qEV5bXARK2+G6DpXfnlWjCV9YL4rP1L9+dXtlgIHv
 A11bgEoAAByRavHBfg/BRhotSyykIrQcX7Otb31JTVnxWFwDFouynNtsKTqyHE09WO21el
 Z4bGVoQ5kGUiquvMjG+lf5bhnQZd09k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-ge2SYrnYOhaXK6E-VqTLlQ-1; Mon, 13 Jul 2020 05:33:43 -0400
X-MC-Unique: ge2SYrnYOhaXK6E-VqTLlQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B07F88015CB;
 Mon, 13 Jul 2020 09:33:41 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-125.ams2.redhat.com [10.36.112.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10B0919D61;
 Mon, 13 Jul 2020 09:33:39 +0000 (UTC)
Subject: Re: [PATCH 04/12] scsi: Remove superfluous breaks
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594631062-36341-1-git-send-email-wang.yi59@zte.com.cn>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <bba1277b-98cd-7133-ff0c-3e855f9af583@redhat.com>
Date: Mon, 13 Jul 2020 11:33:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1594631062-36341-1-git-send-email-wang.yi59@zte.com.cn>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: xue.zhihong@zte.com.cn, QEMU Trivial <qemu-trivial@nongnu.org>,
 wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/07/2020 11.04, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove superfluous breaks, as there is a "return" before them.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org> 
> ---
>  scsi/utils.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/scsi/utils.c b/scsi/utils.c
> index c50e81f..b37c283 100644
> --- a/scsi/utils.c
> +++ b/scsi/utils.c
> @@ -32,17 +32,13 @@ uint32_t scsi_cdb_xfer(uint8_t *buf)
>      switch (buf[0] >> 5) {
>      case 0:
>          return buf[4];
> -        break;
>      case 1:
>      case 2:
>          return lduw_be_p(&buf[7]);
> -        break;
>      case 4:
>          return ldl_be_p(&buf[10]) & 0xffffffffULL;
> -        break;
>      case 5:
>          return ldl_be_p(&buf[6]) & 0xffffffffULL;
> -        break;
>      default:
>          return -1;
>      }
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


