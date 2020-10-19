Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C7CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F47223EA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKFJcZ7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F47223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUbjC-000104-UZ
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 16:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kUbhW-0000Cv-3L
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 16:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kUbhS-00034c-VK
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 16:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603139049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T9ntFDVn0uwbnOQkjc1Xf+iafP1dxKGYdaX6rNsxeWw=;
 b=dKFJcZ7/hWk7BNVKcQCGo4CVlQy8vM9V8kPadlWFb0gdXiITdRIJaaV+A3L+n8btDDn21B
 U+zpBVmEl/rgdy6ERCN262K5xHZUNmZ91Pq3hwD/esK4rrOtK3UBjfINtg6hRzVZJl4zyp
 hgFNgqG9rkiiUctBMMPAVGfavk+qjM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-8mBFT6ZKNQGDkPQ8SZ6Xjg-1; Mon, 19 Oct 2020 16:24:05 -0400
X-MC-Unique: 8mBFT6ZKNQGDkPQ8SZ6Xjg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9A1E87951E;
 Mon, 19 Oct 2020 20:24:04 +0000 (UTC)
Received: from [10.3.112.28] (ovpn-112-28.phx2.redhat.com [10.3.112.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCAD55B4B4;
 Mon, 19 Oct 2020 20:24:00 +0000 (UTC)
Subject: Re: [PATCH] virtio-iommu: fix incorrect print type
To: qemu-devel@nongnu.org, lizhengui@huawei.com
References: <160311477740.18439.1188807654389468914@66eaa9a8a123>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ea9ac6fc-49f4-b3e9-eebb-26d2a1ec36ff@redhat.com>
Date: Mon, 19 Oct 2020 15:24:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160311477740.18439.1188807654389468914@66eaa9a8a123>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
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
Cc: kwolf@redhat.com, xieyingtai@huawei.com, qemu-block@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 8:39 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/1603114311-7392-1-git-send-email-lizhengui@huawei.com/
> 

> c61a848 virtio-iommu: fix incorrect print type
> 
> === OUTPUT BEGIN ===
> ERROR: Missing Signed-off-by: line(s)
> 
> total: 1 errors, 0 warnings, 24 lines checked
> 
> Commit c61a8487f435 (virtio-iommu: fix incorrect print type) has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

More than just a style problem, a missing S-o-b means we can't apply the 
patch ;)

You may also want to group your related patches under a single thread 
with a 0/N cover letter, rather than sending N threads of one patch each.

More patch submission hints at https://wiki.qemu.org/Contribute/SubmitAPatch

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


