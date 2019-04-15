Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D25C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55572077C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55572077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53230 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG4pk-0000T9-6v
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 12:51:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hG4ov-00006U-8w
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hG4or-0000RT-4u
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:50:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1hG4ol-0000L6-Rf
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:50:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B38BB81129
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 16:50:46 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com
	[10.18.17.132])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 141275C1A1;
	Mon, 15 Apr 2019 16:50:43 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Daniel P. Berrange <berrange@redhat.com>
References: <jpgwojv9pwv.fsf@linux.bootlegged.copy>
Date: Mon, 15 Apr 2019 12:50:43 -0400
In-Reply-To: <jpgwojv9pwv.fsf@linux.bootlegged.copy> (Bandan Das's message of
	"Mon, 15 Apr 2019 12:47:12 -0400")
Message-ID: <jpg8swbi55o.fsf@linux.bootlegged.copy>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 15 Apr 2019 16:50:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: change default to success for
 usb_mtp_update_object
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415165043.AMa3gy5L2hENlpj9ZZakZm3P4mdxZWoLRtacbe6YMfA@z>

Forgot to cc people ...

Bandan Das <bsd@redhat.com> writes:

> Commit c5ead51f90cf (usb-mtp: return incomplete transfer on a lstat
> failure) checks if lstat succeeded when updating attributes of a
> file. However, it also changed behavior to return an error by
> default. This is incorrect because for smaller file sizes, Qemu
> will attempt to write the file in one go and there won't be
> an object for it.
>
> Fixes: c5ead51f90cf
> Signed-off-by: Bandan Das <bsd@redhat.com>
> ---
>  hw/usb/dev-mtp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index ebf210fbf8..5de22738ce 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1587,7 +1587,7 @@ done:
>  
>  static int usb_mtp_update_object(MTPObject *parent, char *name)
>  {
> -    int ret = -1;
> +    int ret = 0;
>  
>      MTPObject *o =
>          usb_mtp_object_lookup_name(parent, name, strlen(name));

