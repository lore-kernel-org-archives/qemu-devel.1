Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3265AC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 07:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9512077B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 07:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+Kdknet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9512077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iewtU-0001ta-6f
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 02:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iewsP-00010P-Lt
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 02:57:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iewsO-0000Dx-9z
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 02:57:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49579
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iewsO-0000Bo-4u
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 02:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576051059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JDT20aKapIGgJpnIA22MqTVehQMyQBhxq1PMqwGtE3M=;
 b=J+KdknetLJEKZ/SdPEmNRRxISbSmL/3RQqWuocx9aw1hra1m1fYCnlK5vMO2gSK54alW++
 f5KoM3RlhAIEfoJ4KFuosrcNC/7lmtRWSDbVAMUJbKOAAyEyorKfNdH2ip98X7Q0Bm2p2i
 CqZlZifsfH3Ibg4YgXxPE5O9dbWR9cE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-HMXTjCAgMHOkVVSiRx10uQ-1; Wed, 11 Dec 2019 02:57:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75A7F18543A0;
 Wed, 11 Dec 2019 07:57:34 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1DAC60BAB;
 Wed, 11 Dec 2019 07:57:29 +0000 (UTC)
Date: Wed, 11 Dec 2019 08:57:27 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 0/5] ARM virt: Add NVDIMM support
Message-ID: <20191211085727.1ab9564e@redhat.com>
In-Reply-To: <c2bb0be09e244ee59d27c7aaab1783a9@huawei.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
 <a133d4c4-3f60-2bb1-a7d7-35cdb06af265@redhat.com>
 <441c818f24084b4191315cf2a6267cef@huawei.com>
 <20191125164541.3f0a593f@redhat.com>
 <444efcb441fe42e5aff58b3af3ab14b4@huawei.com>
 <20191126095655.27227f59@redhat.com>
 <c2bb0be09e244ee59d27c7aaab1783a9@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: HMXTjCAgMHOkVVSiRx10uQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "drjones@redhat.com" <drjones@redhat.com>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 Auger Eric <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Dec 2019 17:39:15 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> Hi Igor/ xiaoguangrong,
> 
> > -----Original Message-----
> > From: Shameerali Kolothum Thodi
> > Sent: 28 November 2019 12:36
> > To: 'Igor Mammedov' <imammedo@redhat.com>;
> > xiaoguangrong.eric@gmail.com
> > Cc: peter.maydell@linaro.org; drjones@redhat.com;
> > shannon.zhaosl@gmail.com; qemu-devel@nongnu.org; Linuxarm
> > <linuxarm@huawei.com>; Auger Eric <eric.auger@redhat.com>;
> > qemu-arm@nongnu.org; xuwei (O) <xuwei5@huawei.com>;
> > lersek@redhat.com
> > Subject: RE: [PATCH 0/5] ARM virt: Add NVDIMM support
> > 
> > 
> >   
> > > -----Original Message-----
> > > From: Qemu-devel
> > >  
> > [mailto:qemu-devel-bounces+shameerali.kolothum.thodi=huawei.com@nongn  
> > > u.org] On Behalf Of Igor Mammedov
> > > Sent: 26 November 2019 08:57
> > > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > > Cc: peter.maydell@linaro.org; drjones@redhat.com;
> > > xiaoguangrong.eric@gmail.com; shannon.zhaosl@gmail.com;
> > > qemu-devel@nongnu.org; Linuxarm <linuxarm@huawei.com>; Auger Eric
> > > <eric.auger@redhat.com>; qemu-arm@nongnu.org; xuwei (O)
> > > <xuwei5@huawei.com>; lersek@redhat.com
> > > Subject: Re: [PATCH 0/5] ARM virt: Add NVDIMM support  
> > 
> > [..]
> >   
> > > > > 0xb8 Dirty No.  -->Another read is attempted  
> > > > > > [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: read_fit_out buf size 0x8  
> > > > > func_ret_status 3  --> Error status returned
> > > > >
> > > > > status 3 means that QEMU didn't like content of NRAM, and there is only
> > > > > 1 place like this in nvdimm_dsm_func_read_fit()
> > > > >     if (read_fit->offset > fit->len) {
> > > > >         func_ret_status = NVDIMM_DSM_RET_STATUS_INVALID;
> > > > >         goto exit;
> > > > >     }
> > > > >
> > > > > so I'd start looking from here and check that QEMU gets expected data
> > > > > in nvdimm_dsm_write(). In other words I'd try to trace/compare
> > > > > content of DSM buffer (from qemu side).  
> > > >
> > > > I had printed the DSM buffer previously and it looked same, I will double  
> > check  
> > > > that.  
> > 
> > Tried printing the buffer in both Qemu/AML code.
> > 
> > On Amr64,  
> 
> [...]
>  
> > Attached the SSDT.dsl used for debugging. I am still not clear why on ARM64,
> > 2nd iteration case, the created buffer size in NCAL and RFIT methods have
> > additional 4 bytes!.
> > 
> >     CreateField (ODAT, Zero, Local1, OBUF)
> >     Concatenate (Buffer (Zero){}, OBUF, Local7)
> > 
> > Please let me know if you have any clue.
> >   
> 
> I couldn't figure out yet, why this extra 4 bytes are added by aml code on ARM64
> when the nvdimm_dsm_func_read_fit() returns NvdimmFuncReadFITOut without
> any FIT data. ie, when the FIT buffer len (read_len) is zero.
> 
> But the below will fix this issue,
> 
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index f91eea3802..cddf95f4c1 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -588,7 +588,7 @@ static void nvdimm_dsm_func_read_fit(NVDIMMState *state, NvdimmDsmIn *in,
>      nvdimm_debug("Read FIT: offset %#x FIT size %#x Dirty %s.\n",
>                   read_fit->offset, fit->len, fit_buf->dirty ? "Yes" : "No");
> 
> -    if (read_fit->offset > fit->len) {
> +    if (read_fit->offset >= fit->len) {
>          func_ret_status = NVDIMM_DSM_RET_STATUS_INVALID;
>          goto exit;
>      }
> 
> 
> This will return error code to aml in the second iteration when there is no further
> FIT data to report. But, I am not sure why this check was omitted in the first place.
> 
> Please let me know if this is acceptable and then probably I can look into a v2 of this
> series.
Sorry, I don't have capacity to debug this right now,
but I'd prefer if 'why' question was answered first.

Anyways, if something is unclear in how concrete AML code is build/works,
feel free to ask and I'll try to explain and guide you.

> Thanks,
> Shameer
> 
> 
> 


