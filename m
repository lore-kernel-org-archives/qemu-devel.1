Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E58C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:42:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9088020732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhskNOBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9088020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ri0-0001kN-LO
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j9rg3-0006V9-Mp
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j9rg2-000329-Gp
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:40:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22460
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j9rg2-00031W-CZ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583419242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hn0YIGyfHl+O6XUJ5nHyG1yent3/MBPqFXxf/LfpEkk=;
 b=bhskNOBOEaqAdErTSeZyC+UhYI2tMRWr1p9ItYSfSWT2p7KdGjKsAK7CvdLmSL5JQPx8v4
 nJvnPe4RAYpVABUdx01CFD/2cQMgSnyXY3Un/+ahcQxlLaw/yZJ6ZkRegeomoi9qhsIAW1
 /PdIWUf81RACacqa3gdhguYY56682h4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-sHMUgyyrNRWePgwlgQ9HdA-1; Thu, 05 Mar 2020 09:40:40 -0500
X-MC-Unique: sHMUgyyrNRWePgwlgQ9HdA-1
Received: by mail-wr1-f71.google.com with SMTP id m13so2396002wrw.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 06:40:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5nTfBo1AjozwuH2fY56tBvVbThFhIHlIG6d3trpW31I=;
 b=g0dyzqIYwsYYx5kXpUSQeHhJwGZCmy+ftyMWy3KlImnwXPOryuEFrKbsKKhm2UkGmL
 ZII++WkantPCNXGrMdWSh0xlXcL/H4faZoN6M/eRXnqLDP5yl+jz3HTrSicYxNaXGSDj
 YZZH/GCeGA35ZAOXUBNHEZs/k6Q5paHZMT4HBSF+CPUnBPnP+w0Tn8lxVVosKRttUL8u
 VKpeZzacDIKkLRlHVZzJecO60MhpkmC/88nzI/Tq1aBGVdKmn9GypwfcASoFF8hnTFhJ
 4IdHXAJULDZ169Gy/G8vEY/IMW7CCoQIuPcdz0v8uQCtd7t34Y/yiwHy3LBjQ+JieJ6H
 ufIQ==
X-Gm-Message-State: ANhLgQ20/wxP3RwjF5T5nRcL2jcAguhTFZ6pSSZqy6D1PD99LUExPop1
 OIDRsVPneNM1srGEca7pHgN1km8dFABAC3gGGA+vkfA4BFUAIE2eK9o10nvmz+8LxlI0vwJICOv
 eGYZhih+FE4A3A6o=
X-Received: by 2002:a5d:68ce:: with SMTP id p14mr10402482wrw.315.1583419238940; 
 Thu, 05 Mar 2020 06:40:38 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtaj5cQYnkiErgB3yw7XSWXYWEMSi5KEHtnZpwZVTrTqVK5AYSfHvTi9cL8UBUCyIAAXxASgw==
X-Received: by 2002:a5d:68ce:: with SMTP id p14mr10402467wrw.315.1583419238677; 
 Thu, 05 Mar 2020 06:40:38 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993?
 ([2001:b07:6468:f312:9def:34a0:b68d:9993])
 by smtp.gmail.com with ESMTPSA id v16sm27460899wrp.84.2020.03.05.06.40.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 06:40:38 -0800 (PST)
Subject: Re: [PATCH v3 0/7] hw/scsi/spapr_vscsi: Fix time bomb buffer overflow
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200305121253.19078-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eac8c380-eb0d-b075-f70b-bd339ce5fc6e@redhat.com>
Date: Thu, 5 Mar 2020 15:40:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305121253.19078-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Fam Zheng <fam@euphon.net>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/03/20 13:12, Philippe Mathieu-Daud=C3=A9 wrote:
> This series fixes a possible buffer overflow.
>=20
> Simples patches first (dissociate the buffer holding DMA
> requests with pointer to SRP Information Unit packets) to
> clean the issue in the penultimate patch.
>=20
> v3:
> - Fixed typo reported by Greg Kurz
> - Addressed Paolo Bonzini review comments as an extra patch
> - Added another patch converting a fprintf() call while here
>=20
> v2:
> - Addressed David Gibson review comments
>=20
> Supersedes: <20200305083135.8270-1-philmd@redhat.com>
>=20
> Philippe Mathieu-Daud=C3=A9 (7):
>   hw/scsi/viosrp: Add missing 'hw/scsi/srp.h' include
>   hw/scsi/spapr_vscsi: Use SRP_MAX_IU_LEN instead of sizeof flexible
>     array
>   hw/scsi/spapr_vscsi: Simplify a bit
>   hw/scsi/spapr_vscsi: Introduce req_iu() helper
>   hw/scsi/spapr_vscsi: Do not mix SRP IU size with DMA buffer size
>   hw/scsi/spapr_vscsi: Prevent buffer overflow
>   hw/scsi/spapr_vscsi: Convert debug fprintf() to trace event
>=20
>  hw/scsi/viosrp.h      |  3 +-
>  hw/scsi/spapr_vscsi.c | 72 +++++++++++++++++++++++++------------------
>  hw/scsi/trace-events  |  1 +
>  3 files changed, 45 insertions(+), 31 deletions(-)
>=20

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


