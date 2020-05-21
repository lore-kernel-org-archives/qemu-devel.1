Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0955BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74D520671
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuZAL0w9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74D520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnpx-0008WB-Vs
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jbnpN-0007nB-5K
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:13:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50578
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jbnpL-0008BF-M9
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590077626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HjneuAgsSfc93YNZ4T57f3GUr573YmR8JUJQhPxIgrg=;
 b=IuZAL0w9Tx+4mlupcIYNMDMvvcdlg/gjeJFOnYL7IQu1NPWQWKWM/5R5KVuk97mLHqlJCb
 2BoQjuwpX0oRg4HjfrgyhX+rNWRtvJ0AWZo///sgbFptmfcke5cqFsgZb/KOO5XT8CU6Hs
 Ga5WAmwVb2ZXo21Txvnk36Oip2I3adY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-yaD6_jpHPtyNrIk2vtSDRA-1; Thu, 21 May 2020 12:13:42 -0400
X-MC-Unique: yaD6_jpHPtyNrIk2vtSDRA-1
Received: by mail-qv1-f70.google.com with SMTP id t10so7691102qvz.9
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HjneuAgsSfc93YNZ4T57f3GUr573YmR8JUJQhPxIgrg=;
 b=o6Eh2AP/OGoWKi+WJ/KWiFbCiLJEQciNuOJKa63McSqtCeKgidZ18LrhHp1u6MHs75
 57ne3rHsz6b8VKhr6Edxp0pPBmH/qc6GhGMw/urhMQBFjaYfdwSQsHL6zPF9k9IetJQr
 knDnwFMzLLRZtSqgnDMT0v5XyVqBl8TI2jzBpYRcr8OVDvTE7/CPFUE6aBkcjzisvo5H
 ZqdYaXfh/54bnDtHDaOv4ew1lAXlufp0i8ETp3O5PZx0IO9a32SXc+gnoq9sMdZiqqqR
 wTkCR8ej6GZP3NaOqrRjmmu8OTUSq57jR2lGTeVc/c3p1uVXzhaIWRkKfhcxO0xUEZcF
 sICw==
X-Gm-Message-State: AOAM5332AXe3YCCzhrTDeGcevacyL4iCu/IEGxJquxVS4bDp2gzIL3SD
 2tbu4Cay/h325jcn20kal7EzlXajfNdVGVn6L38N566a5QgpTPfKzvA1aSFRrNRiNubxDwrfI48
 nngVddkQjTRYTOPU=
X-Received: by 2002:a0c:e488:: with SMTP id n8mr10192137qvl.172.1590077621833; 
 Thu, 21 May 2020 09:13:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZNTz+0Fe556etUG7BHYZGiLhDEb+pszjT5x+fVnCoIJDFYWTez/NlANE28RxJmdq0qDKTRQ==
X-Received: by 2002:a0c:e488:: with SMTP id n8mr10192091qvl.172.1590077621545; 
 Thu, 21 May 2020 09:13:41 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id g19sm5204133qke.32.2020.05.21.09.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:13:40 -0700 (PDT)
Date: Thu, 21 May 2020 12:13:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v23 11/18] iommu: add callback to get address limit
 IOMMU supports
Message-ID: <20200521161337.GA766834@xz-x1>
References: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
 <1589999088-31477-12-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1589999088-31477-12-git-send-email-kwankhede@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, eauger@redhat.com, yi.l.liu@intel.com,
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 dgilbert@redhat.com, alex.williamson@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 11:54:41PM +0530, Kirti Wankhede wrote:
> +hwaddr memory_region_iommu_get_address_limit(IOMMUMemoryRegion *iommu_mr)
> +{
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
> +
> +    if (imrc->get_address_limit) {
> +        return imrc->get_address_limit(iommu_mr);
> +    }
> +
> +    return 0;

LGTM, besides.. Would it be better to return (hwaddr)-1 as default here?
Because if an IOMMU type didn't provide this information, IMHO we'd better
cover the whole possible address range.

Thanks,

> +}

-- 
Peter Xu


