Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40B4C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B42392075E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvPNyBJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42392075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKtZ-00082b-RE
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOKrx-0006G3-Bw
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOKrw-00063b-Cz
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:40:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41595
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOKrw-00063E-9R
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586868047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GpufgNlQRZtHooQ2FPa8DL2VtPhuNwXZg2HswzURbBQ=;
 b=MvPNyBJ7pDW2vwcpATuHPrr7ux8PBb6Ra+MUy0HyzbuxfKLYBkBGO6/d7zopjoL66nFQu/
 asm4l1i8zYJn8TYPSz03cDFgtm/D7oui+UBbdmB9gVlkRI0PNUIF/mNgHHcgCn4euPrCgW
 s9xJ3YQd1tTXGIQV7JA6yhFoqUzMWVQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-T2N_8xlqNBG_Lgt70pHvMQ-1; Tue, 14 Apr 2020 08:40:46 -0400
X-MC-Unique: T2N_8xlqNBG_Lgt70pHvMQ-1
Received: by mail-wr1-f69.google.com with SMTP id j12so8568394wrr.18
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 05:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZsSFnEBVdDbqZgJcWo4rGkAxrN09X619eiVe6JXXvyY=;
 b=L2XAufWQ41hKek89+1XbDSmecCnOF/h2pYj4kAkWoBTS56bGueMaVjHy3tXRoGwtqI
 BmIejBFhLekZHGr5nN7RoWuxMQAkaCs6XK9d2IEXabrwhc+lMBtH4PDO1UD6TQZEwhjG
 XbIspIS/mckA3OzWIL+98APCwR47dWvACrbfJrzQZ7erJX7TmzadljDWb9rCLiSo2RbO
 M0tpwJ16DUScp3voEndLgKJvt5MHX7RvK14f7N6kKlW0ckdD/ctUMJJKTsdAJBNxAjUQ
 P3tXuvbPUxM5atU5hnsSH3dAfYtwixHEAWXnyVrlOozAKk3Kp2z4NjF4IJfcF45kkgKz
 9R6g==
X-Gm-Message-State: AGi0PuYu3rpx2+2K6pEj1ms0iaypc9No2UooTsxpTGDXEqWCLEv4CFb8
 ucyKZl/YLi601c+3mylrTbSqnpqKmngoB1fK5ybMigr/MoqDmNWDrzS4eOymCzSk42zkZYkQ5YQ
 Gn6pbCYMossKU1Xo=
X-Received: by 2002:adf:ea44:: with SMTP id j4mr12922wrn.38.1586868044925;
 Tue, 14 Apr 2020 05:40:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypIZKfLqdvIXiIjff12pU9DwnWuBOUSs9doy0TNmup/q5UUwaBorJ7HDM1HrEUHfm7If8wYPfg==
X-Received: by 2002:adf:ea44:: with SMTP id j4mr12890wrn.38.1586868044722;
 Tue, 14 Apr 2020 05:40:44 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id s27sm9769446wra.94.2020.04.14.05.40.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 05:40:44 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 0/3] virtio, vhost-gpu: Release memory returned by
 malloc() with free()
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200323112943.12010-1-philmd@redhat.com>
 <20200323094104-mutt-send-email-mst@kernel.org>
 <20200413065857-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d295642e-4192-3c6d-6c64-5da6497d5ad5@redhat.com>
Date: Tue, 14 Apr 2020 14:40:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200413065857-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/13/20 12:59 PM, Michael S. Tsirkin wrote:
> On Mon, Mar 23, 2020 at 09:41:20AM -0400, Michael S. Tsirkin wrote:
>> On Mon, Mar 23, 2020 at 12:29:40PM +0100, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> Coverity reported a ALLOC_FREE_MISMATCH in vg_handle_cursor(),
>>> because the memory returned by vu_queue_pop() is allocated with
>>> malloc(). Fix it.
>>>
>>> Similar error occurs with virtio. Document and fix.
>>
>> I will queue this. Thanks!
>=20
> So what are we doing with this patchset? Marc-Andr=C3=A9 reported issues =
-
> any plan to fix them up? Split up the patchset to 3 independent
> patches?

As noted Marc-Andr=C3=A9, patches 2 & 3 are incorrect.

Patch 1 can be queued as it with no modification.

>=20
>>> Philippe Mathieu-Daud=C3=A9 (3):
>>>    vhost-user-gpu: Release memory returned by vu_queue_pop() with free(=
)
>>>    virtio: Document virtqueue_pop()
>>>    virtio-gpu: Release memory returned by virtqueue_pop() with free()
>>>
>>>   include/hw/virtio/virtio.h              | 8 ++++++++
>>>   contrib/vhost-user-gpu/vhost-user-gpu.c | 4 ++--
>>>   contrib/vhost-user-gpu/virgl.c          | 2 +-
>>>   hw/display/virtio-gpu-3d.c              | 2 +-
>>>   hw/display/virtio-gpu.c                 | 8 ++++----
>>>   5 files changed, 16 insertions(+), 8 deletions(-)
>>>
>>> --=20
>>> 2.21.1
>=20


