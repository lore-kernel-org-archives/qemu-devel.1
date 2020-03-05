Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E8BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21EB72072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="ihViNg0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EB72072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9q5h-0001bd-Bk
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1j9q4n-00013S-UV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1j9q4m-0004md-T5
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:58:09 -0500
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:41263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1j9q4m-0004m9-4N
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:58:08 -0500
Received: by mail-yw1-xc44.google.com with SMTP id p124so1579766ywc.8
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JtT0OF0dleUvPZlgLiPL71NANb5N5V/jdC6WvztdW3I=;
 b=ihViNg0unQ6Ca0ch1X/ELic/Wuhj2EI5I+dmU0gr24I4uDcCat6icaBxiZZnsEPOxC
 emmDxMzs1y9V2KLE3Rt4LeoTsK24o4anrEd7WGyprQSIT31bGVCoVgsfQP2QeQ6575OR
 0SD8AtxqiNga8XZwSWaut33Pe1JWgxGeuTIcfJGGW4KC4pdSRF63NK7ee3YfIvseqaLL
 d17hy5re7sRIJAb31f58EcPwEfA322KG/WXRVNCzHXXNaKBZUB0QfjNB0TaIXidJ6S9x
 34L926R9G+kMYwdMcdrvZi03naAsZMUwEUSTFrGYXy3B1nmr0UhkHJchSAkpb+NzQSxG
 EpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JtT0OF0dleUvPZlgLiPL71NANb5N5V/jdC6WvztdW3I=;
 b=MlZ0CevYDLDZLxEdl0fWYUaTbevYJsHajR+0XfoqOdY0N2hHHLXKG7n4mirvpneKL5
 vdMXBQJ4SHVUyz3ds45fH7m4AfqVx9VA/EuISFS9xmcqqd0trCp8n3oEDxLhHtdAJzcN
 kQAyHMGWprWM8g/GQ7rk8MB9nAqZBtpdSjiE0zU6e/ocXNcMOMrIMJAwv/2T7wth/mM3
 wh7LLjj/Dggt33+pjUSg10mZgN3Z+DgRgGus9dPj70YiOAzE49ZVQsxB2LecAbbqMwWs
 xGSRbbOa44M4vdIacZOI2C8BO7KpI6fYQL1pb4AgHA/ET9kruD7L//RWhtK4gZWphdN+
 U7ug==
X-Gm-Message-State: ANhLgQ1e2YUjSl+LHuj+xTfQ0mmCIVA98lx4Vue7YcGcM1WQNstwLhVp
 G+GbZsh5HiOWyNh5zyyOTeJfOyLG2ja0mehXcRnEjgD0S+Q=
X-Google-Smtp-Source: ADFU+vt3/HBqEErLELhJ5JKh7JpbGmyqjq4LhVH9pD2C8t7ytn+ji16eVCQ3CXeBQ0jYPcw2jIZw/bemuCCCdRij+S0=
X-Received: by 2002:a25:ca46:: with SMTP id a67mr7643424ybg.447.1583413086619; 
 Thu, 05 Mar 2020 04:58:06 -0800 (PST)
MIME-Version: 1.0
References: <20200226174809.9675-1-yuri.benditovich@daynix.com>
In-Reply-To: <20200226174809.9675-1-yuri.benditovich@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 5 Mar 2020 14:57:55 +0200
Message-ID: <CAOEp5Oeup=6syqmEnpWsR_c8xKP4QSeFyG+Wqp1rd=caaiwDKA@mail.gmail.com>
Subject: Re: [PATCH 0/3] reference implementation of RSS
To: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
Cc: Yan Vugenfirer <yan@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping

On Wed, Feb 26, 2020 at 7:48 PM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> Support for VIRTIO_NET_F_RSS feature in QEMU for reference
> purpose. Implements Toeplitz hash calculation for incoming
> packets according to configuration provided by driver.
>
> This series requires previously submitted and accepted
> patch to be applied:
> https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06448.html
>
> Yuri Benditovich (3):
>   virtio-net: introduce RSS RX steering feature
>   virtio-net: implement RSS configuration command
>   virtio-net: implement RX RSS processing
>
>  hw/net/trace-events                         |   3 +
>  hw/net/virtio-net.c                         | 234 +++++++++++++++++++-VIRTIO_NET_F_RSS
>  include/hw/virtio/virtio-net.h              |  12 +
>  include/standard-headers/linux/virtio_net.h |  37 +++-
>  4 files changed, 273 insertions(+), 13 deletions(-)
>
> --
> 2.17.1
>

