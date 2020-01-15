Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B24C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA76724656
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYNKbHho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA76724656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irmLX-0006FD-3F
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 12:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irmKY-0005Bg-HQ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:19:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irmKX-00054W-AN
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:19:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29452
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irmKX-00053y-6i
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579108784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VF4mtv5nQFeA6Uw4ivE6szeo0Lmn0OiOCaHj9m7FAJI=;
 b=cYNKbHhooT68/6BNQfzDgQIGA9v1J9x2D5npsihzfPbJ4KkKzUWFAG+aGnr/v8JyP2GBmZ
 SkgFx1lYwAPdG/fxHldJPhEEY+6+U86phZBsZR5IDd/+ZpOSO0lyHeoYUuQDSjkBUyYbLi
 hvdRKifiIkJ7HRWl0E0ZwuNAOMOmmTE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-_iPuXWCTNt2f0hAcBJQa3A-1; Wed, 15 Jan 2020 12:19:43 -0500
Received: by mail-wr1-f72.google.com with SMTP id z14so8319754wrs.4
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 09:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O1+XWyzL/ZcSdP7c8NBmpMoxOwt7Rplzr0Aa0suUigM=;
 b=SzDgYhIZGVw3zCzcQkXhUT/XMUqaa2e7sxQ2KDFCwWkoLeGI4sRx9l71f/s2Bwikfi
 vKxczoU+Wa4Ec/4auagBlLwvBq4WaKGyA0+xVr7hwwS8dY/Dekd93yEmBuyKLIZ6zYf9
 /hEYFrJtMTeh54OL5uzjr/PY63GGp5xElOBe8G7MmjxNm+GKP5cp+a9sxp9bMGwaoAsj
 Z9S3BosBiOl/ZdpbHJGrD7RLTJ/u80eWHKjirjrnvTfI9SkJoj2sPHJUxio+gI0lbbm7
 ezf2wM8GRgy0loi4vUKaR/RFftl/kZC+U8bUqhNU58zdukB4xto2Sdfjr+WXsJzxjs16
 NLjQ==
X-Gm-Message-State: APjAAAXSSIx7ptlvT7tzlj07XVV3qekS95JnUZvnr1BW1uQ8sc5V2tIS
 o+Qt1N+Sei/ZUBwWRnnNsp80ii1SYj8mpun+iZP1ho92VcUioXkUfjEHmHal+OymNiMgDrcJhH5
 nNpteU2Eyp0evHd4=
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr12900812wrn.140.1579108781963; 
 Wed, 15 Jan 2020 09:19:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqz+8fx0VAJtaqqpM069z5w1oy1oluHKIBYBHfLSPOGd9zvGNnWmzUAcnf4iRT++BTJU7y9aeQ==
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr12900786wrn.140.1579108781690; 
 Wed, 15 Jan 2020 09:19:41 -0800 (PST)
Received: from [192.168.1.24] (lfbn-mon-1-1519-115.w92-167.abo.wanadoo.fr.
 [92.167.83.115])
 by smtp.gmail.com with ESMTPSA id z187sm685309wme.16.2020.01.15.09.19.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 09:19:41 -0800 (PST)
Subject: Re: [PATCH 031/104] virtiofs: Add maintainers entry
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-32-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <66b55418-dae9-0956-51ea-d409c9f2da3e@redhat.com>
Date: Wed, 15 Jan 2020 18:19:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-32-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: _iPuXWCTNt2f0hAcBJQa3A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 5:37 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   MAINTAINERS | 8 ++++++++
>   1 file changed, 8 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e5e3e52d6..d1b3e262d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1575,6 +1575,14 @@ T: git https://github.com/cohuck/qemu.git s390-nex=
t
>   T: git https://github.com/borntraeger/qemu.git s390-next
>   L: qemu-s390x@nongnu.org
>  =20
> +virtiofs
> +M: Dr. David Alan Gilbert <dgilbert@redhat.com>
> +M: Stefan Hajnoczi <stefanha@redhat.com>
> +S: Supported
> +F: tools/virtiofsd/*

^ The files added by this series

> +F: hw/virtio/vhost-user-fs*
> +F: include/hw/virtio/vhost-user-fs.h

^ Files already present in the repository:

$ ./scripts/get_maintainer.pl -f hw/virtio/vhost-user-fs.c
"Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)

$ ./scripts/get_maintainer.pl -f hw/virtio/vhost-user-fs-pci.c
"Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)

$ ./scripts/get_maintainer.pl -f include/hw/virtio/vhost-user-fs.h
"Michael S. Tsirkin" <mst@redhat.com> (supporter:virtio)

Now these get more maintainers, good.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +
>   virtio-input
>   M: Gerd Hoffmann <kraxel@redhat.com>
>   S: Maintained
>=20


