Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C712C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 17:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E167620651
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 17:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsscOkVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E167620651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxxVW-00081m-PX
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 13:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <u9012063@gmail.com>) id 1hxxUQ-0007Nv-OZ
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <u9012063@gmail.com>) id 1hxxUO-0004qI-Jm
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:55:14 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730]:35814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <u9012063@gmail.com>) id 1hxxUO-0004pH-9M
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:55:12 -0400
Received: by mail-qk1-x730.google.com with SMTP id r21so83323273qke.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 10:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=ayRLVfzA9K5sR3JIzaiZYKZSYMoyMH8iYFFRoU5vOF4=;
 b=bsscOkVsZckLkkGRkszJPAE9MziTW2wekvLkUhvhJ3zqMx+5bCOnRzboZe72f7uZqB
 799bI7Ra/+14MVOgMhlwuN9ksj+LsOJBOhmBmj8efEhj2dfoRa131SNT4avXXb1lHsYL
 aYkF/O8SpxBneRv0AOm4chXhq9E92D6TMWqr/N0Hja6HCGvjeevx9VLshspfDi31HeEd
 Zbku5F8hIevKxaOSVnjflu+e/YOlJPrPrYAi/NUCznNGqymguFlKml57SwM6sqYwPyJT
 ckm0+2IqAaxlVzc3101AiWrKAK6zfZ4IaLOBQ0S6immRYLCrFjXlFvaphvo+1ZCRd7c+
 3xAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=ayRLVfzA9K5sR3JIzaiZYKZSYMoyMH8iYFFRoU5vOF4=;
 b=ju1EIYX6YrWfJyohAbD7oRfEkak19FOZ8CUEPdefceMp0esrZzEqjQTFxwz9OK7h7h
 HUeDjFgL2jJsym1KnBoJWlALW7BLnVY+Un0dglBpyLk+AP02AAqtVUDy9kMJHiavtVjE
 ZpxmRx0nBDt+nNY7nH4aj+0OjNftyKmLbzhX4PAPFrnJeeatGIhTZo0nDRXey+n30skY
 QEbi/2DDcN2HtBzraJPR7C4nepBRktSkuT1rHqDyS0eQBIIN0JwNDkHCNmq5omfGO34t
 aMW0TkrvfnV97k4dfauoJ/aF4SQc421g4Iu05GINeo4WWHzntbGbWuXChQf7/vTncYKm
 RQ8A==
X-Gm-Message-State: APjAAAXLs3mgl2L9mpg2KvqpnNoHzdfKSohDujrWf/4jG3uX6Kr6dfgO
 GHVqAB46CGENC5cks0sHxInm4L/QHMcyUvd+R0XBZtoYs6M=
X-Google-Smtp-Source: APXvYqxRIogmqijcEtcYvrSPFvRydT7lZFdSE1sQUDWNu3QiAa6iHBBfCQk4IrroYI8H6KY8KQO70kZSOzNwIBymwzc=
X-Received: by 2002:a37:a492:: with SMTP id n140mr583450qke.137.1565805311346; 
 Wed, 14 Aug 2019 10:55:11 -0700 (PDT)
MIME-Version: 1.0
From: William Tu <u9012063@gmail.com>
Date: Wed, 14 Aug 2019 10:54:34 -0700
Message-ID: <CALDO+SbRvSSW3OQimwVe59HcHqv0PPLwoAW6yGg_UOnzounPtQ@mail.gmail.com>
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::730
Subject: [Qemu-devel] Question about libvhost-user and vhost-user-bridge.c
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I'm using libvhost-user.a to write a vhost backend, in order to receive and
send packets from/to VMs from OVS. I started by reading the vhost-user-bridge.c.
I can now pass the initialization stage, seeing .queue_set_started get invoked.

However, I am stuck at receiving the packet from VM.
So is it correct to do:
1) check vu_queue_empty, started, and aval_bytes, if OK, then
2) elem = vu_queue_pop(&dev->vudev, vq, sizeof(VuVirtqElement));
3) the packet payload should be at elem->in_sg->iov_base + hdrlen? or
at elem->out_sg?

I tried to hex dump the iov_base, but the content doesn't look like
having a ethernet header. I saw in vubr_backend_recv_cb at vhost-user-bridge.c,
we're creating another iovec and recvmsg(vubr->backend_udp_sock, &msg, 0);
I don't think I have to create backend UDP sock, am I correct?

Thanks
William

