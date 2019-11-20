Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4A0C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB142223D1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOBzpmW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB142223D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXMSZ-0000xV-0Q
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 04:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXMQg-0006wP-SV
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXMQe-0004cC-Jy
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:37:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44996
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXMQe-0004bk-G0
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574242660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPvn60zkncPKPfL8x6mQNtMSRNzCVa057PHz9BY83+A=;
 b=GOBzpmW2K2vZLwF3/U9copi3j9fTVjq7yNww5JD4n1y/IuxPRcr6p70pA7IoNZqGoVvfji
 cuQc7nuI1JjGbEzt/Y6Iybw8kQEBYpuVTh1+C+rS4iZ1T/FBTcKBBu38CG+l+NY+LoLTpf
 F20bN5BoCqyiFcrx+Tf8knM7h8V3b/8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-n24Ji2ncP3yeJO4HxjZbCg-1; Wed, 20 Nov 2019 04:37:38 -0500
Received: by mail-wr1-f69.google.com with SMTP id e10so20655345wrt.16
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 01:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3F493hOXcT30RR0VKdYZmqAmCUlv6EOzoIpFF6ohQos=;
 b=DzMg+byammknZumlrAKVMgRYeieyzjXSF2p9Vl/hKyY32so3rixN8gJDhNrI8AxYru
 PgBqle1c9haF9UNa1EpNpNsWI79zrUzvBc7JCLn93eaQ4wQ8CG4jbWzzOmTujB2A8nQu
 CsP6Dmq4RdEc03i3grKVyCNco/YvU6d3nmXyMjYTSIC3VXe5+xuGOpPBNVtThNbzzHDx
 LK69rWw48LNBjqeKWrhiRsxoj7R4oujXOjzb2Cnp14RB6dDQDRz+8YvnUIeS0MTZ2fs2
 F3BEvkFmDTjYrYV2A81sKeVWI+qQ3ONBDiPZetMDhxGPXKpecaN61WEHMe5PLoZqlruY
 np3w==
X-Gm-Message-State: APjAAAU5MGpdgz+T7c/3Js1yD0D5v3JoWZe6nTEd2sbMEKoChq1xUvgW
 LOCcyfA4O98bgFJ3BouzUSZhHjjJ8pcMkxaCB7q646lov8e6GFvkkT93tlEu4isT/3FW81KV5OY
 0FtjiVbCusGxZnVQ=
X-Received: by 2002:a5d:460b:: with SMTP id t11mr2044331wrq.185.1574242657708; 
 Wed, 20 Nov 2019 01:37:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqSgSYmrdkXOSyFzk1Jz3rns84FeP5/LufY2tRsMTgWhxAJAFJD2ufK92WcUtjpmPVDxvaDw==
X-Received: by 2002:a5d:460b:: with SMTP id t11mr2044311wrq.185.1574242657536; 
 Wed, 20 Nov 2019 01:37:37 -0800 (PST)
Received: from [192.168.43.238] (92.red-95-127-154.staticip.rima-tde.net.
 [95.127.154.92])
 by smtp.gmail.com with ESMTPSA id w4sm30696388wrs.1.2019.11.20.01.37.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 01:37:37 -0800 (PST)
Subject: Re: [PATCH] vhost-user-input: use free(elem) instead of g_free(elem)
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20191119111626.112206-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6b45458f-386f-3be0-c3d8-20c88ca37a2b@redhat.com>
Date: Wed, 20 Nov 2019 10:37:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119111626.112206-1-stefanha@redhat.com>
Content-Language: en-US
X-MC-Unique: n24Ji2ncP3yeJO4HxjZbCg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 12:16 PM, Stefan Hajnoczi wrote:
> The virtqueue element returned by vu_queue_pop() is allocated using
> malloc(3) by virtqueue_alloc_element().  Use the matching free(3)
> function instead of glib's g_free().
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Fixes: 06914c97d3a ?
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   contrib/vhost-user-input/main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/contrib/vhost-user-input/main.c b/contrib/vhost-user-input/m=
ain.c
> index 449fd2171a..ef4b7769f2 100644
> --- a/contrib/vhost-user-input/main.c
> +++ b/contrib/vhost-user-input/main.c
> @@ -77,7 +77,7 @@ static void vi_input_send(VuInput *vi, struct virtio_in=
put_event *event)
>           len =3D iov_from_buf(elem->in_sg, elem->in_num,
>                              0, &vi->queue[i].event, sizeof(virtio_input_=
event));
>           vu_queue_push(dev, vq, elem, len);
> -        g_free(elem);
> +        free(elem);
>       }
>  =20
>       vu_queue_notify(&vi->dev.parent, vq);
> @@ -153,7 +153,7 @@ static void vi_handle_sts(VuDev *dev, int qidx)
>                            0, &event, sizeof(event));
>           vi_handle_status(vi, &event);
>           vu_queue_push(dev, vq, elem, len);
> -        g_free(elem);
> +        free(elem);
>       }
>  =20
>       vu_queue_notify(&vi->dev.parent, vq);
>=20


