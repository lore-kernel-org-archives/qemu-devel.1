Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B41C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23238205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23238205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBH0R-0006xy-84
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 07:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iBGzK-0006Fg-5Y
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iBGzI-000389-0P
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:22:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36240)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iBGzH-00037T-NV
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:22:07 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C448844BCF
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 11:22:04 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id f63so903443wma.7
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 04:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XKJzkBXpvUuCHIjyIlSSPvOlq2sVIO9kbHaTWrHtRj8=;
 b=rqWKNIbt5PJHt4BxIek7rPm5ySFrhX3VpE4ofEWMZ5ww6lgI3hwJ1SW6Hq3HYE3p6c
 eDhdzMgy/4Y1gRaI4szSZgxU6Urg7qa1T391t87ftEkrGpAtiIie5VZdYOt4N2EznneZ
 eNsfECJWfgYLJ/QkbWpq/fMy39csHtNytA+4PhfJ95Ou58ebEdmKTR8i31OgrbHPXf3B
 vF4k+UfKJmz4r9yQh/8QiCs+/RzlLBVu7vaDdyNm3FwNjNmfqGPJlD8fALWW9rrwxbN8
 cl7bpUsYl22NLxWJEqxddcIRrxqdy5g5kKqNOcE6l4oS8xkNgz7UvY6ZkC2eZZkNEkq5
 /kOg==
X-Gm-Message-State: APjAAAVxVulOgDYJxzY9PyDL88nvSo/ubZ0YwPqVvetZDNOVQ99GUU7s
 r1kQ1HGLbFjv7p/Q6GUM5rEfbUoo/NGORpQ8vknbV0hDTrjBMYjFKU6pSK8FjyMeYA97I2DUv4k
 JoNAjFRkD1GLdNL0=
X-Received: by 2002:a5d:548d:: with SMTP id h13mr12299127wrv.215.1568978523263; 
 Fri, 20 Sep 2019 04:22:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxwVpV8w89Oaqpq8VBfQAUdPYZBifTuq4Qx8Z12pjUPwALfK+/DccRnr8+v1ZjV0AzR53AUTA==
X-Received: by 2002:a5d:548d:: with SMTP id h13mr12299100wrv.215.1568978522993; 
 Fri, 20 Sep 2019 04:22:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8?
 ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
 by smtp.gmail.com with ESMTPSA id i14sm1915969wra.78.2019.09.20.04.22.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 04:22:02 -0700 (PDT)
Subject: Re: COMPARE_AND_WRITE support for rbd driver
To: Yaowei Bai <baiyaowei@cmss.chinamobile.com>, fam@euphon.net,
 dillaman@redhat.com, kwolf@redhat.com, mreitz@redhat.com
References: <20190919053623.GA19956@byw>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8a304065-b9ec-8245-09ae-e38724f46645@redhat.com>
Date: Fri, 20 Sep 2019 13:22:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919053623.GA19956@byw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/09/19 07:36, Yaowei Bai wrote:
> baiyaowei@cmss.chinamobile.com 
> Bcc: 
> Subject: COMPARE_AND_WRITE support for rbd driver
> Reply-To: baiyaowei@cmss.chinamobile.com
> 
> Hey guys,
> 
> I noticed that COMPARE_AND_WRITE had been supported by CEPH/librbd since
> v12.1.1. And in my company, we use this COMPARE_AND_WRITE support in
> CEPH with the ISCSI protocol. More precisely, we use tgt and CEPH with this
> COMPARE_AND_WRITE support as the SCSI target and export it to the remote
> hosts. And then VMs on remote hosts can use these SCSI targets through ISCSI
> initiator support in QEMU directly or as local SCSI disks. But unfortunately,
> there're some issues with this tgt case. So i think maybe we could also add this
> COMPARE_AND_WRITE support into the rbd driver in QEMU so we can leave the
> ISCSI/tgt alone and use this COMPARE_AND_WRITE support with the
> scsi-disk <--> virtio-scsi <--> rbd driver path. This can also apply to
> the WRITESAME support in CEPH/librbd.
> 
> So is it suitable for doing this?

Yes, it would be suitable.  In a nutshell you would have to add support
for COMPARE_AND_WRITE to block/io.c (calling into a new BlockDriver
function pointer), block/rbd.c and hw/scsi/scsi-disk.c.

Paolo

