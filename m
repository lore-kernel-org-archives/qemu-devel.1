Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E4FC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC3F20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKF2No0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC3F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1o9J-0002UO-Rv
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 04:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j1o87-0001Kp-7A
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:16:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j1o85-0007FU-1J
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:16:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38445)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j1o7z-0007CB-RE
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581498973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5JkDH1B4lCtLpE4CvWTZmOnEMpHfE5iAVpg1lkIuOSk=;
 b=fKF2No0+eeQl5Sq79mR2twXPQqhWEEWBONHCjW/Osb+syt708gzCVgTAUyGcdo0X7KUAtu
 sqnoz43KZt8Tpcrw8oRM8zXID8EuyVtbRA7HPerljrPI31Fu9ZZ8YuTMon2Uxbo+CulC7U
 DqOCebWwyZvDWyDZygrP56fX+u06Ft8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-OmuJGthHPzmMoQkeuN6dwQ-1; Wed, 12 Feb 2020 04:16:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A884E801E7A;
 Wed, 12 Feb 2020 09:16:06 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C31B1001281;
 Wed, 12 Feb 2020 09:16:04 +0000 (UTC)
Message-ID: <bb13e4e3d519f1afa3af7eec98e4d16850801579.camel@redhat.com>
Subject: Re: [PATCH v5 04/26] nvme: add missing fields in the identify data
 structures
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org
Date: Wed, 12 Feb 2020 11:15:53 +0200
In-Reply-To: <20200204095208.269131-5-k.jensen@samsung.com>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095218eucas1p25d4623d82b1b7db3e555f3b27ca19763@eucas1p2.samsung.com>
 <20200204095208.269131-5-k.jensen@samsung.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: OmuJGthHPzmMoQkeuN6dwQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-02-04 at 10:51 +0100, Klaus Jensen wrote:
> Not used by the device model but added for completeness. See NVM Express
> 1.2.1, Section 5.11 ("Identify command"), Figure 90 and Figure 93.
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> ---
>  include/block/nvme.h | 48 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 8fb941c6537c..d2f65e8fe496 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -543,7 +543,13 @@ typedef struct NvmeIdCtrl {
>      uint8_t     ieee[3];
>      uint8_t     cmic;
>      uint8_t     mdts;
> -    uint8_t     rsvd255[178];
> +    uint16_t    cntlid;
> +    uint32_t    ver;
> +    uint32_t    rtd3r;
> +    uint32_t    rtd3e;
> +    uint32_t    oaes;
> +    uint32_t    ctratt;
> +    uint8_t     rsvd100[156];
>      uint16_t    oacs;
>      uint8_t     acl;
>      uint8_t     aerl;
> @@ -551,10 +557,22 @@ typedef struct NvmeIdCtrl {
>      uint8_t     lpa;
>      uint8_t     elpe;
>      uint8_t     npss;
> -    uint8_t     rsvd511[248];
> +    uint8_t     avscc;
> +    uint8_t     apsta;
> +    uint16_t    wctemp;
> +    uint16_t    cctemp;
> +    uint16_t    mtfa;
> +    uint32_t    hmpre;
> +    uint32_t    hmmin;
> +    uint8_t     tnvmcap[16];
> +    uint8_t     unvmcap[16];
> +    uint32_t    rpmbs;
> +    uint8_t     rsvd316[4];
> +    uint16_t    kas;
> +    uint8_t     rsvd322[190];
>      uint8_t     sqes;
>      uint8_t     cqes;
> -    uint16_t    rsvd515;
> +    uint16_t    maxcmd;
>      uint32_t    nn;
>      uint16_t    oncs;
>      uint16_t    fuses;
> @@ -562,8 +580,14 @@ typedef struct NvmeIdCtrl {
>      uint8_t     vwc;
>      uint16_t    awun;
>      uint16_t    awupf;
> -    uint8_t     rsvd703[174];
> -    uint8_t     rsvd2047[1344];
> +    uint8_t     nvscc;
> +    uint8_t     rsvd531;
> +    uint16_t    acwu;
> +    uint8_t     rsvd534[2];
> +    uint32_t    sgls;
> +    uint8_t     rsvd540[228];
> +    uint8_t     subnqn[256];
> +    uint8_t     rsvd1024[1024];
>      NvmePSD     psd[32];
>      uint8_t     vs[1024];
>  } NvmeIdCtrl;
> @@ -653,13 +677,21 @@ typedef struct NvmeIdNs {
>      uint8_t     mc;
>      uint8_t     dpc;
>      uint8_t     dps;
> -
>      uint8_t     nmic;
>      uint8_t     rescap;
>      uint8_t     fpi;
>      uint8_t     dlfeat;
> -
> -    uint8_t     res34[94];
> +    uint8_t     rsvd33;
This is wrong. nawun comes right after dlfeat
> +    uint16_t    nawun;
> +    uint16_t    nawupf;
And here the error cancels out since here there should be 'nacwu' field.
> +    uint16_t    nabsn;
> +    uint16_t    nabo;
> +    uint16_t    nabspf;
> +    uint8_t     rsvd46[2];
> +    uint8_t     nvmcap[16];
> +    uint8_t     rsvd64[40];
> +    uint8_t     nguid[16];
> +    uint64_t    eui64;
>      NvmeLBAF    lbaf[16];
>      uint8_t     res192[192];
Not related to the patch, but maybe rename this to rsvd192 for the sake of consistency?
>      uint8_t     vs[3712];


I reviewed this patch by cross referencing the nvme structures as defined in the kernel,
and the spec.

I prefer to merge this patch with all other spec updates you do in following patches,
to bring nvme.h up to date to 1.3d,
so that it will be easier to review this and remove some noise from other patches.

Best regards,
	Maxim Levitsky


