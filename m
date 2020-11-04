Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACEDC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BEF2221F8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRF+sbgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEF2221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaFBi-0007Fq-F4
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 04:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaFAD-0006KY-2v
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:33:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaFAB-0003YL-F8
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604482386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q9Cwed3ZMgnDFljShgJZ7DTabXaHNPpySuNYLpEMFGA=;
 b=CRF+sbgDUYZ4A+wF35E71jFG/4UU0o94EprrCJyXD6CEsJJE2oPAUJsnD5UPEp/AvdoWGN
 cvkN3T46cq9WC4X5dnui+thpMAnBj+5B0Vq8e+2sIy693RyNMytRmvCKiebxTF96UneP3n
 gHMsE8UVCgY4pH7nl3MMa0GXxjwe88A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-lzSg9shzNv-5r3X9N36lOQ-1; Wed, 04 Nov 2020 04:33:04 -0500
X-MC-Unique: lzSg9shzNv-5r3X9N36lOQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C501E8049FE;
 Wed,  4 Nov 2020 09:33:02 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C45DC10589A8;
 Wed,  4 Nov 2020 09:33:00 +0000 (UTC)
Subject: Re: [PULL 18/30] hw/block/nvme: update nsid when registered
To: Klaus Jensen <its@irrelevant.dk>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
References: <20201027104932.558087-1-its@irrelevant.dk>
 <20201027104932.558087-19-its@irrelevant.dk>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <eb0b8a08-d5c4-1bde-f278-58f0c3d0ef05@redhat.com>
Date: Wed, 4 Nov 2020 10:32:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201027104932.558087-19-its@irrelevant.dk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Keith Busch <kbusch@kernel.org>, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27.10.20 11:49, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> If the user does not specify an nsid parameter on the nvme-ns device,
> nvme_register_namespace will find the first free namespace id and assign
> that.
> 
> This fix makes sure the assigned id is saved.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 5768a6804f41..2225b944f935 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -2578,7 +2578,7 @@ int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
>          for (int i = 1; i <= n->num_namespaces; i++) {
>              NvmeNamespace *ns = nvme_ns(n, i);
>              if (!ns) {
> -                nsid = i;
> +                nsid = ns->params.nsid = i;

Coverity reports that @ns is NULL here.  I think the problem is that we
want to access the *ns given to nvme_register_namespace() here, but it’s
shadowed by another @ns in this for () loop.

Max

>                  break;
>              }
>          }
> 


