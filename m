Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66486C5ACC4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F58B20656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeasiUju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F58B20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Y8u-00015n-BD
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 17:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4Y7n-00009L-TW
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:47:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4Y7l-0008Vu-Oq
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:47:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37994
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4Y7l-0008VK-II
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582152440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dhIDwymXLnh9pYIppZLU9NAdEfgVhb0wEMh6gikuVTU=;
 b=BeasiUjuXAm1lMr4TUU7qg3hFCXdojy1ElalmNkp0d1iIdPW9O3JOrwL6VI4M5Yf3Fe0nr
 1f16DbTyQ/GPGTmG4ixvZLfshTEc5DxyvNMYoDDhdBNmt1enTiHJX0bYYcGL6TrOGSF642
 EQOcBW1XVQiWsf0empEYvPwbQceq5Io=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-9ndK5G7yPYi58Y5egfpGzg-1; Wed, 19 Feb 2020 17:47:18 -0500
Received: by mail-qt1-f200.google.com with SMTP id c22so1248167qtn.23
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 14:47:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=g83+ZtRFmgkhBHRnY2cUkXLDivXTklH+qdWFwDSDIHo=;
 b=icQeJwwC6OiNsIxeTyo1oO8tGQKyj4P7mJjvB8hh/9shNGhg9JnBOHwJf15mhwA2cm
 elrasCfl2wpkxTFGj2tNjSdp9eWDaN1hjFv/DldbAXzEdKEeydv1kYCDToTubaq4FLt1
 aLZwbLNSZRPDHCAlKFMS4DjOfFwNjhs/HjsMFoL/OcrAtNObdfWzEnNIBsxhREYHziEi
 J6VBh4yp5EY8YScIGOFUzcydC0uQiACilHA3KDJzaTHrIWGEsSUrDw+GaGrhJ/G9okVn
 nR0aNn9POjb2vRBW7IdY2TWv2NxXdN4ICSb3aiia4XfpUqQYVC8KksXZODGBIcIYSyFa
 vVKQ==
X-Gm-Message-State: APjAAAUePKFDepBpCUPpN2bTJMGRtytGGPQZIJwF+h4Z4c2Y3kFsMltJ
 ZVZJK2B8JXawRKSjrYnNGepFdOgRf6SY/7syO1nLzeLB0ws4MW3tHl/jO3oic/t/Wf9Qu5U6ti3
 BlxvsJbxy+WTqric=
X-Received: by 2002:a05:620a:9cc:: with SMTP id
 y12mr25414082qky.446.1582152438143; 
 Wed, 19 Feb 2020 14:47:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4nO25IY3NMgciFOOSqGzfmeCzY0OWokKpw5M6ISKjngYOR01CAOn73KEJ/lPEaY/b3enT+w==
X-Received: by 2002:a05:620a:9cc:: with SMTP id
 y12mr25414072qky.446.1582152437915; 
 Wed, 19 Feb 2020 14:47:17 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id t23sm775674qto.88.2020.02.19.14.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 14:47:17 -0800 (PST)
Date: Wed, 19 Feb 2020 17:47:15 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 fixed 09/16] util/mmap-alloc: Factor out reserving of
 a memory region to mmap_reserve()
Message-ID: <20200219224715.GB42076@xz-x1>
References: <20200212134254.11073-1-david@redhat.com>
 <20200212134254.11073-10-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200212134254.11073-10-david@redhat.com>
X-MC-Unique: 9ndK5G7yPYi58Y5egfpGzg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 02:42:47PM +0100, David Hildenbrand wrote:
> We want to reserve a memory region without actually populating memory.
> Let's factor that out.
>=20
> Reviewed-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
> Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


