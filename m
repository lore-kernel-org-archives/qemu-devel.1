Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC925C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 852D021537
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852D021537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35324 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heKBJ-0003jN-Oc
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 10:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58791)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlureau@redhat.com>) id 1heJxs-0004Da-OE
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1heJxr-0000BX-KA
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:52:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34373)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1heJxr-00008c-G4
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:52:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so6385982otk.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 06:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IAXGhDuUFucViQqpG2UYLxicdRsxhydTaYPtkAwcF2U=;
 b=dlPRJpV2bTZpgOW2jc0fa4OllWJc6+0jKiiAn0GupwhiJDcmsdGj4hGGf0xLx1y/Nw
 RjYGuFlyXRSyBZA8OOcvIz4x3r3Ka78Z2ldi3xlgIUb3g0hd1QiED0+Zfinh0VnWPPGe
 ewJHa3mLPELwwM/OGwI6PKNdTOkejhtfbZQaZJMFpmNJQPdDjUgSmdqJTRPedRHVwsla
 aBtnUAl0idTeoSPqglCtGCEzMlhym0FNVK/vlOn5txKXjJqCsAvslKivMq7JvJNyUDVL
 OA+w2+3szGsCswOKesHfrKPsFcth5JI9kCEipGSOU9onrcPa5wZ2PANq2WH0xHY0Yo/i
 MBIA==
X-Gm-Message-State: APjAAAV4S4sFb1L6v1dLt12NV8WbK5cNMUKWYFPuLWQY+4Euw9/8oajf
 walo9R2oL2Yu96YldttV6ZUG8d1vDwVLBgcSVgYWlA==
X-Google-Smtp-Source: APXvYqxT3r73tLPyBpqp6z++VDPSlAY0crq0owm6Y8JRwLZb1dp4PXD4rNsVPwI39lG6/GElBX4gTXRtbP8xk/lyDm0=
X-Received: by 2002:a9d:3f06:: with SMTP id m6mr45407513otc.62.1561125145906; 
 Fri, 21 Jun 2019 06:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190621094005.4134-1-stefanha@redhat.com>
 <20190621094005.4134-5-stefanha@redhat.com>
In-Reply-To: <20190621094005.4134-5-stefanha@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 21 Jun 2019 15:52:14 +0200
Message-ID: <CAMxuvaw4EknmmpHhhN1HxvkkzE8qMuWc-AQDuCgpr-xOJE2f6Q@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.66
Subject: Re: [Qemu-devel] [PATCH 4/4] docs: avoid vhost-user-net specifics
 in multiqueue section
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
Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 21, 2019 at 11:41 AM Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
>
> The "Multiple queue support" section makes references to vhost-user-net
> "queue pairs".  This is confusing for two reasons:
> 1. This actually applies to all device types, not just vhost-user-net.
> 2. VHOST_USER_GET_QUEUE_NUM returns the number of virtqueues, not the
>    number of queue pairs.
>
> Reword the section so that the vhost-user-net specific part is relegated
> to the very end: we acknowledge that vhost-user-net historically
> automatically enabled the first queue pair.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  docs/interop/vhost-user.rst | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index dc0ff9211f..5750668aba 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -324,19 +324,20 @@ must support changing some configuration aspects on=
 the fly.
>  Multiple queue support
>  ----------------------
>
> -Multiple queue is treated as a protocol extension, hence the slave has
> -to implement protocol features first. The multiple queues feature is
> -supported only when the protocol feature ``VHOST_USER_PROTOCOL_F_MQ``
> -(bit 0) is set.
> +Multiple queue support allows the slave to advertise the maximum number =
of
> +queues.  This is treated as a protocol extension, hence the slave has to
> +implement protocol features first. The multiple queues feature is suppor=
ted
> +only when the protocol feature ``VHOST_USER_PROTOCOL_F_MQ`` (bit 0) is s=
et.
>
> -The max number of queue pairs the slave supports can be queried with
> -message ``VHOST_USER_GET_QUEUE_NUM``. Master should stop when the
> -number of requested queues is bigger than that.
> +The max number of queues the slave supports can be queried with message
> +``VHOST_USER_GET_QUEUE_NUM``. Master should stop when the number of requ=
ested
> +queues is bigger than that.
>
>  As all queues share one connection, the master uses a unique index for e=
ach
> -queue in the sent message to identify a specified queue. One queue pair
> -is enabled initially. More queues are enabled dynamically, by sending
> -message ``VHOST_USER_SET_VRING_ENABLE``.
> +queue in the sent message to identify a specified queue.
> +
> +The master enables queues by sending message ``VHOST_USER_SET_VRING_ENAB=
LE``.
> +vhost-user-net has historically automatically enabled the first queue pa=
ir.
>
>  Migration
>  ---------
> --
> 2.21.0
>

