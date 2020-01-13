Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D2FC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC449214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdcHOC0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC449214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir2Fe-0004wS-PR
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ir2EO-0003z3-TK
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:06:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ir2EJ-00045w-Kl
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:06:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40516
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ir2EJ-00042u-GC
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:06:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578931574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=DZrEM7aklK4LD47Ic4drvMCGLz421cRHJ4vCT0VgPSA=;
 b=ZdcHOC0OrA21mJw0VAOAJVPaKfOvL0EL1K/KrmFsfusr9AEO8UsxTcbcbeCoR4ff/fPD5R
 hmbASkz5sTr0yAPO0/l4Ij/SP6DBMOP0CzlzJH4E2uIG4Y9zbHtjB90QnJtepJeaI5HHDD
 GIr8njUOtG9dVBL7jONeE4JOym2jUR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-afxEuU8DPUGa-UHkJou5cQ-1; Mon, 13 Jan 2020 11:06:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4185E10239A6;
 Mon, 13 Jan 2020 16:06:12 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-87.ams2.redhat.com [10.36.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8697E19756;
 Mon, 13 Jan 2020 16:06:11 +0000 (UTC)
Subject: Re: [PATCH v1 41/59] intc/s390_flic_kvm.c: remove unneeded label in
 kvm_flic_load()
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-42-danielhb413@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <960983b9-1719-7d07-96cb-9f4663a598e8@redhat.com>
Date: Mon, 13 Jan 2020 17:06:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200106182425.20312-42-danielhb413@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: afxEuU8DPUGa-UHkJou5cQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/01/2020 19.24, Daniel Henrique Barboza wrote:
> 'out' label can be replaced by 'return' with the apropriate

s/apropriate/appropriate/

> value that is set by 'r' right before the jump.
> 
> Christian Borntraeger <borntraeger@de.ibm.com>

Missing "Cc:" ? With this line and the typo removed/fixed:

Reviewed-by: Thomas Huth <thuth@redhat.com>


> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/intc/s390_flic_kvm.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index dddd33ea61..2e1e70c61d 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -439,17 +439,14 @@ static int kvm_flic_load(QEMUFile *f, void *opaque, size_t size,
>      count = qemu_get_be64(f);
>      len = count * sizeof(struct kvm_s390_irq);
>      if (count == FLIC_FAILED) {
> -        r = -EINVAL;
> -        goto out;
> +        return -EINVAL;
>      }
>      if (count == 0) {
> -        r = 0;
> -        goto out;
> +        return 0;
>      }
>      buf = g_try_malloc0(len);
>      if (!buf) {
> -        r = -ENOMEM;
> -        goto out;
> +        return -ENOMEM;
>      }
>  
>      if (qemu_get_buffer(f, (uint8_t *) buf, len) != len) {
> @@ -460,7 +457,6 @@ static int kvm_flic_load(QEMUFile *f, void *opaque, size_t size,
>  
>  out_free:
>      g_free(buf);
> -out:
>      return r;
>  }
>  
> 


