Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F26C5ACD8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4730920767
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxnZdUcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4730920767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEVFH-0000YY-G1
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 05:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jEVER-0007ui-Js
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jEVEQ-0007qO-Ly
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:43:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53164)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jEVEQ-0007o4-Hc
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584524601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tX9qTSkaUTfMACaR4bitXDCiBgkcNW0hcVOfdzavMdo=;
 b=QxnZdUcCTvTRYbqomVg/9JqzJQIkP5tENS156bUz2q8xVF81vqB5wlkKZHsDqBfraPC2KB
 kvCbz8WZqvPlPMrrOXHiT+AvPMMkr1+7WxewsO/Y+F7c/jMfBKvZdLM8NvRmsgXy8td8fb
 vL6OfX07fVQ8gHYy388RXCKWB8n2skQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-H_yZB2cVOqmCtSuj5ONfRA-1; Wed, 18 Mar 2020 05:43:16 -0400
X-MC-Unique: H_yZB2cVOqmCtSuj5ONfRA-1
Received: by mail-wr1-f72.google.com with SMTP id l16so11350412wrr.6
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 02:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ch/uTPTxpn4k5UJGvgFmSWfaFl/gjdLw1R7T5ZE8Pt0=;
 b=fHRNNQfgivc4UfIVE7xkI/4qHm5t6P8XMhMuqyDHb1mkQcvZ0IAj/Jwv41cZ8qlf2z
 9U/pyEb6e7EB3h6kWZKBodXZZD59zgNLST3IuwBZo06EIbT/4gZgiYmnelxIzWm2vcgD
 DL2Hd9M3opVt/uuGH+itE6OT6p2T1KBw6cFLd7/24IWR2iJQcDZDnzOF8x8DU3BY0Mfm
 Vn9YREJi2cSBkxrdt2j8aojcsF0kjvPJNA2TYFHxImESDZ4lFpN4yYyAk1L25b/Vop97
 IYWqaEi94eZpvtnZtkdl9abo8A81Uy+KP2l/0wMYSfCAaq835pGxxSfU9goAdI1lE/R5
 35bQ==
X-Gm-Message-State: ANhLgQ2AEuejn3TtCBVrLKcb+F5yTALEKYI+yKa4dRnhKdAChfXd18yA
 qPez72IIiiGXMVXFAe1kgKGWt8JmcOxFQvYZTn7qGaobwYbxClkE2Ev436xyloIhwmlE6V2zxGf
 nHl5Bvkoj3I5hXT8=
X-Received: by 2002:a1c:62c5:: with SMTP id w188mr4459481wmb.112.1584524595775; 
 Wed, 18 Mar 2020 02:43:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs4PnbOcqxuzbklzaYnPT1+xEkZPYV2qogsRLlEEc3QuXoyIZL/wQbmpSWh9H2LN0PHdwLBKw==
X-Received: by 2002:a1c:62c5:: with SMTP id w188mr4459465wmb.112.1584524595609; 
 Wed, 18 Mar 2020 02:43:15 -0700 (PDT)
Received: from redhat.com (bzq-79-183-62-79.red.bezeqint.net. [79.183.62.79])
 by smtp.gmail.com with ESMTPSA id
 i21sm3264490wmb.23.2020.03.18.02.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 02:43:14 -0700 (PDT)
Date: Wed, 18 Mar 2020 05:43:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v5 0/7] reference implementation of RSS and hash report
Message-ID: <20200318054245-mutt-send-email-mst@kernel.org>
References: <20200318091525.27044-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20200318091525.27044-1-yuri.benditovich@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: yan@daynix.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 18, 2020 at 11:15:18AM +0200, Yuri Benditovich wrote:
> Support for VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT
> features in QEMU for reference purpose.
> Implements Toeplitz hash calculation for incoming
> packets according to configuration provided by driver.
> Uses calculated hash for decision on receive virtqueue
> and/or reports the hash in the virtio header
>=20
> Changes from v4
> Use 16-bit field for indirection table length (patch 2)
> Add VMSTATE_VARRAY_UINT16_ALLOC for migration of
> indirection table (patch 6)


Attribution on 6/7 seems to be wrong. Except for that:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> Yuri Benditovich (7):
>   virtio-net: introduce RSS and hash report features
>   virtio-net: implement RSS configuration command
>   virtio-net: implement RX RSS processing
>   tap: allow extended virtio header with hash info
>   virtio-net: reference implementation of hash report
>   vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro
>   virtio-net: add migration support for RSS and hash report
>=20
>  hw/net/trace-events            |   3 +
>  hw/net/virtio-net.c            | 437 +++++++++++++++++++++++++++++++--
>  include/hw/virtio/virtio-net.h |  16 ++
>  include/migration/vmstate.h    |  10 +
>  net/tap.c                      |  11 +-
>  5 files changed, 449 insertions(+), 28 deletions(-)
>=20
> --=20
> 2.17.1


