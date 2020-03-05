Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67177C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DF02073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgQ8D8+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DF02073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9njr-0001a5-97
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 05:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j9niz-0000Tk-L7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j9niy-00089P-Kh
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:27:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29268
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j9niy-000897-Gx
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583404048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdB59jU3OiSFWiROnZBr2V771FOgWosPHsghfBxr+lQ=;
 b=AgQ8D8+c/aHN25haDtg/PMw011PuVKQz9KlJYKRX58bZ9iOpYjSUEC6DxmZTaNO/IueH1B
 7jbhUYguqKDOCMhLmEzjm6xuDgvSHMbpu47/lOc8EA+3k4CtA/iphbCUquVrrBEPaEQTW1
 cStW+a3E+vQfhIeT9lOe0dLiQOIoFNU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-SRr3ZrXbM6CpWiHIF7DczQ-1; Thu, 05 Mar 2020 05:27:25 -0500
X-MC-Unique: SRr3ZrXbM6CpWiHIF7DczQ-1
Received: by mail-wm1-f72.google.com with SMTP id c18so1916005wml.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 02:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mhu0tb7JIc2h+rEoTBqBwQqSDS/cZWu/2ISLWJpKSbs=;
 b=jmc7H0SBWytGowFYWTsBjdraaSXgcTuH5kn14Q37HhQLnLYvJCP+RtAee2QYwrWYpz
 9jKzOCRwR60CtIOP5J62b2oSZbobt5LxqGSAFCRD/4rJnc44yZw9n9FHnXbqklv/kj16
 TyQvKqreE/Z/m3Ezf44mqwQjFLCJu79CLj64GQo4nF/us3E4UPUta/FANBIdxqwF4Xqg
 JlMdIs4367JBQurkHl6Ak40qqquwtrXuiyFC6jBZx58gMxH0i6u+CjkkllNAy+IRoMrC
 yXj1rzPpyV/xEEpIcH8DRe5aUo7Yv22hEpj+Pgpr4w7t6pgAq7tpvUvYpjvoZvbFs4Lm
 UM/g==
X-Gm-Message-State: ANhLgQ086LjmL5417kNgD3ZsTQFhLtVhAd3PXA3apko5HSWCRJOweCCs
 jS7mYkgV8y7lJbz2NcC7XnIdZvfvLSq3Btd3eJq7ZlrkX+t4sA6narUMe2j063EF2ubSSBKX4yX
 X8a+SFhJXYmIdR2Y=
X-Received: by 2002:a05:600c:351:: with SMTP id
 u17mr8677460wmd.22.1583404044140; 
 Thu, 05 Mar 2020 02:27:24 -0800 (PST)
X-Google-Smtp-Source: ADFU+vu+qLICKn2lbt6kCX8YgzWfXDPzB4Vibi9hBSKF3W6UHLtQQfkABrtl8ANtyAhP15rsUdcHMg==
X-Received: by 2002:a05:600c:351:: with SMTP id
 u17mr8677427wmd.22.1583404043843; 
 Thu, 05 Mar 2020 02:27:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993?
 ([2001:b07:6468:f312:9def:34a0:b68d:9993])
 by smtp.gmail.com with ESMTPSA id t133sm9345427wmf.31.2020.03.05.02.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 02:27:23 -0800 (PST)
Subject: Re: [PATCH v2 0/5] hw/scsi/spapr_vscsi: Fix time bomb zero-length
 array use
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200305083135.8270-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b4afa63b-cc4c-c4f6-5ef0-86ee2b6b9e04@redhat.com>
Date: Thu, 5 Mar 2020 11:27:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305083135.8270-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/03/20 09:31, Philippe Mathieu-Daud=C3=A9 wrote:
> This series fixes a dangerous zero-length array use.
> Simples patches first to clean the issue in the last patch:
> dissociate the buffer holding DMA requests with pointer to
> SRP Information Unit packets.
>=20
> v2: Addressed David Gibson review comments
>=20
> Philippe Mathieu-Daud=C3=A9 (5):
>   hw/scsi/viosrp: Add missing 'hw/scsi/srp.h' include
>   hw/scsi/spapr_vscsi: Use SRP_MAX_IU_LEN instead of sizeof flexible
>     array
>   hw/scsi/spapr_vscsi: Simplify a bit
>   hw/scsi/spapr_vscsi: Introduce req_iu() helper
>   hw/scsi/spapr_vscsi: Do not mix SRP IU size with DMA buffer size
>=20
>  hw/scsi/viosrp.h      |  3 ++-
>  hw/scsi/spapr_vscsi.c | 59 ++++++++++++++++++++++++-------------------
>  2 files changed, 35 insertions(+), 27 deletions(-)
>=20

I think this is clearer than the "reserved" member, and it gets one
important thing right though by decoupling SRP_MAX_IU_LEN from
sizeof(union srp_iu).

However it doesn't fix the actual time bomb, which is that,
vscsi_send_rsp can overrun the buffer size here depending on the length
of sense data:

=09memcpy(req->iu.srp.rsp.data, req->sense, req->senselen);

But with this series in place we can fix that with just a couple of
asserts, like this:

/* This #define is why Phil's changes matter! */
#define SRP_MAX_IU_DATA_LEN (SRP_MAX_IU_LEN - sizeof(union srp_iu))

=09/* in vscsi_send_rsp */
=09int sense_data_len =3D MIN(req->senselen, SRP_MAX_IU_DATA_LEN);
=09req->iu.srp.rsp.sense_data_len =3D cpu_to_be32(sense_data_len);
        memcpy(req->iu.srp.rsp.data, req->sense, sense_data_len);

=09/* in vscsi_send_iu */
=09assert(length < SRP_MAX_IU_LEN);

=09/* in vscsi_process_tsk_mgmt */

=09QEMU_BUILD_BUG_ON(SRP_MAX_IU_DATA_LEN < 4);

(Easier to write code than describe...).

Paolo


