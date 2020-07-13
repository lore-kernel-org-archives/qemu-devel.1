Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4351BC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:25:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BFF20758
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6sYa3Wi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BFF20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juui6-00077Q-4Y
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1juuhX-0006gp-QN
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:24:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27299
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1juuhU-0005pK-V8
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594632279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tyj9qbHdEeCooNaLdeP/RYJF19Go4GbR6S1MoHuwDZ8=;
 b=d6sYa3Wit0BnwGivS+Bvp8QAO8nI9tlt7vM0UBmp+01PAEPsy6VqgYYE5pcFCza+9TTpfd
 HlBUZtmDA5uuTKC1fm5JI029LucEZzAwa7ByreiU5uZMD7K0DH/QIVoJN0R0LQj/0mUPx3
 anMz0Ylo1eyMH7VTWzHn5aoYF4hRBaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-8i5i5RG5OTuY7DSsKv8Gxg-1; Mon, 13 Jul 2020 05:24:36 -0400
X-MC-Unique: 8i5i5RG5OTuY7DSsKv8Gxg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 197DA10059A9;
 Mon, 13 Jul 2020 09:24:35 +0000 (UTC)
Received: from gondolin (ovpn-113-13.ams2.redhat.com [10.36.113.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38DAE6FEDF;
 Mon, 13 Jul 2020 09:24:34 +0000 (UTC)
Date: Mon, 13 Jul 2020 11:24:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] docs/system/s390x: Improve the 3270 documentation
Message-ID: <20200713112431.7db66007.cohuck@redhat.com>
In-Reply-To: <20200713075112.442-1-thuth@redhat.com>
References: <20200713075112.442-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 09:51:12 +0200
Thomas Huth <thuth@redhat.com> wrote:

> There is some additional information about the 3270 support in our Wiki
> at https://wiki.qemu.org/Features/3270 - so let's include this information
> into the main documentation now to have one single source of information
> (the Wiki page could later be removed).
> 
> While at it, I also shortened the lines of the first example a little bit.
> Otherwise they showed up with a horizontal scrollbar in my Firefox browser.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Added the changes that have been suggested by Cornelia
>  - Talk about "Linux kernel" instead of just saying "kernel", just in case.
> 
>  docs/system/s390x/3270.rst | 43 ++++++++++++++++++++++++++++++++------
>  1 file changed, 37 insertions(+), 6 deletions(-)

(...)

> @@ -29,4 +39,25 @@ Example configuration
>  
>      systemctl start serial-getty@3270-tty1.service
>  
> -This should get you an addtional tty for logging into the guest.
> +  This should get you an addtional tty for logging into the guest.

While you're at it,

s/addtional/additional/

> +
> +* If you want to use the 3270 device as the Linux kernel console instead of
> +  an additional tty, you can also append ``conmode=3270 condev=000a`` to
> +  the guest's kernel command line. The kernel then should use the 3270 as
> +  console after the next boot.
> +
> +Restrictions
> +------------
> +
> +3270 support is very basic. In particular:
> +
> +* Only one 3270 device is supported.
> +
> +* It has only been tested with Linux guests and the x3270 emulator.
> +
> +* TLS/SSL is not supported.
> +
> +* Resizing on reattach is not supported.
> +
> +* Multiple commands in one inbound buffer (for example, when the reset key
> +  is pressed while the network is slow) are not supported.

Looks good.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

(Feel free to send it yourself if you have some patches in your queue, I
don't have anything for s390x right now.)


