Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE84C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5CE20748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6XZEcrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5CE20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbs3U-0004xP-Dr
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jbs2l-0003ZP-Vt
 for qemu-devel@nongnu.org; Thu, 21 May 2020 16:43:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34109
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jbs2k-0000Mk-IT
 for qemu-devel@nongnu.org; Thu, 21 May 2020 16:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590093832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SVwjq3s9S0/re72OI28kqG6G0EvJSUrXZ39mL6Z6Dzw=;
 b=C6XZEcrgz1MereeRiEl0m8rGj9upCExVGuILJdlJsDQTdYnPcgMM1ij3xLhq4kH0v0G2/m
 tPSNqZ3N+U+2ZRaUpPg6TTb1o1xOB2S617OeinNVdCxS1tNqn1syotyjjkJadSnPhkatME
 rqO2bDT5V6dsMmQSiBhpCMjgGNSaBfg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-OvCYYE4uPBCyLHY-nkQFsg-1; Thu, 21 May 2020 16:43:50 -0400
X-MC-Unique: OvCYYE4uPBCyLHY-nkQFsg-1
Received: by mail-qk1-f199.google.com with SMTP id d145so89696qkg.22
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 13:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SVwjq3s9S0/re72OI28kqG6G0EvJSUrXZ39mL6Z6Dzw=;
 b=jST6Ou+E/eKjJVI2e5SfG6+xeyQ5Obu6fqnVKp+YmjLkn7W3wfYqz3Si4TmuqEFa8B
 s/53/TwSlTjEfAs0AH0Gfm7ygva9r7GzhXm6n4/N2hGxKGuG6uG2b5F57iSn1JurYsna
 +igkTcJ4hYW66QjELVxDNCfWsOb3nMLqioCev/YUuMZhSUni9w6II7NOs/HniKMzgcCi
 Pk8KCdyBAxTMzSsqr2FaeYaVesPb/py79VS3ulFzAFA1zIEuo7l6zCcapSwUKRwUuzUQ
 YDaW43hMbp7Ul7KP3oCEMyOQ5MS05TQL9ED3kGRYq5QN5bgD1jfUiYs9yT8itp7vAveo
 /kNg==
X-Gm-Message-State: AOAM531Dorri9A/jvfYjIqnS+G3tXYRrwGwujtDF8CPjBsiB+DAK4q0g
 5AIO/yG0B5BCSwqlZ4hf6eejZYNX5gH3tpoXXuTbOPfGcEw+wK47VNKQ3Egv8Q09X53MIv8gB5H
 tD0ICNVJk+nB0jH8=
X-Received: by 2002:a05:620a:1031:: with SMTP id
 a17mr11343752qkk.245.1590093829873; 
 Thu, 21 May 2020 13:43:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDhtQabS9J6L4MBBmpkPao9o+KJT+uKUQAZMkOW662jpPUvk+BDMoV8FycQ0vipqUgnCTcFw==
X-Received: by 2002:a05:620a:1031:: with SMTP id
 a17mr11343724qkk.245.1590093829617; 
 Thu, 21 May 2020 13:43:49 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id t195sm4637367qke.110.2020.05.21.13.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 13:43:48 -0700 (PDT)
Date: Thu, 21 May 2020 16:43:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v23 09/18] vfio: Add save state functions to
 SaveVMHandlers
Message-ID: <20200521204345.GE766834@xz-x1>
References: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
 <1589999088-31477-10-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1589999088-31477-10-git-send-email-kwankhede@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 14:32:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 20, 2020 at 11:54:39PM +0530, Kirti Wankhede wrote:
> In _SAVING|_RUNNING device state or pre-copy phase:
> - read pending_bytes. If pending_bytes > 0, go through below steps.
> - read data_offset - indicates kernel driver to write data to staging
>   buffer.
> - read data_size - amount of data in bytes written by vendor driver in
>   migration region.
> - read data_size bytes of data from data_offset in the migration region.
> - Write data packet to file stream as below:
> {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data,
> VFIO_MIG_FLAG_END_OF_STATE }

Hi, Kirti,

(Sorry if this question is silly, since I didn't follow up with all these
 threads...)

Can I understand this commit as it only tracks dirty device BAR memory but not
guest system memory?  How did you track device writes to system memory when
without the vIOMMU?

Thanks,

-- 
Peter Xu


