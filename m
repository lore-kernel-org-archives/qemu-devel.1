Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46402C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A632B22247
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ickbw8bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A632B22247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUtxV-00013s-LH
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kUtw0-0000VC-90
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kUtvx-00038a-7G
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603209138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8n/on4Z/Oh7lJPYd88doDAwhT4k58dwS5EYpuuM9s8=;
 b=ickbw8bu/TWiCyYS9X5R2gYq6uUR9wzNHdkgQ4KYOIs15WLL3H2xe/yhgVP8gzHnAKAe6N
 /4YJTKfxYFO8/QTF+lahdCH2UhkzWvnwWpyobCDRSncknTo4gHMJxghU6I4ve1c69ew4Jo
 fsx4CYuWzdW8DAHEScIoe6ql6T/EMXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-AUnnJkCFMBa-UOC2Pm1hKg-1; Tue, 20 Oct 2020 11:52:15 -0400
X-MC-Unique: AUnnJkCFMBa-UOC2Pm1hKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 224271006C9D;
 Tue, 20 Oct 2020 15:52:13 +0000 (UTC)
Received: from gondolin (ovpn-114-95.ams2.redhat.com [10.36.114.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEB9560C0F;
 Tue, 20 Oct 2020 15:52:01 +0000 (UTC)
Date: Tue, 20 Oct 2020 17:51:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v26 07/17] vfio: Register SaveVMHandlers for VFIO device
Message-ID: <20201020175158.784e92ca.cohuck@redhat.com>
In-Reply-To: <34146d7a-6b38-132d-ab2e-90f5d8b71f9e@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-8-git-send-email-kwankhede@nvidia.com>
 <20200925135318.7afaf234.cohuck@redhat.com>
 <34146d7a-6b38-132d-ab2e-90f5d8b71f9e@nvidia.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eauger@redhat.com, yi.l.liu@intel.com, quintela@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, zhi.a.wang@intel.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 02:25:28 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 9/25/2020 5:23 PM, Cornelia Huck wrote:
> > On Wed, 23 Sep 2020 04:54:09 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> Define flags to be used as delimeter in migration file stream.
> >> Added .save_setup and .save_cleanup functions. Mapped & unmapped migration
> >> region from these functions at source during saving or pre-copy phase.
> >> Set VFIO device state depending on VM's state. During live migration, VM is
> >> running when .save_setup is called, _SAVING | _RUNNING state is set for VFIO
> >> device. During save-restore, VM is paused, _SAVING state is set for VFIO device.
> >>
> >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >> ---
> >>   hw/vfio/migration.c  | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>   hw/vfio/trace-events |  2 ++
> >>   2 files changed, 93 insertions(+)
> >>  
> > 
> > (...)
> >   
> >> +/*
> >> + * Flags used as delimiter:
> >> + * 0xffffffff => MSB 32-bit all 1s
> >> + * 0xef10     => emulated (virtual) function IO  
> > 
> > Where is this value coming from?
> >   
> 
> Delimiter flags should be unique and this is a magic number that 
> represents (e)mulated (f)unction (10) representing IO.
> 
> >> + * 0x0000     => 16-bits reserved for flags
> >> + */
> >> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
> >> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
> >> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
> >> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)  
> > 
> > I think we need some more documentation what these values mean and how
> > they are used. From reading ahead a bit, it seems there is always
> > supposed to be a pair of DEV_*_STATE and END_OF_STATE framing some kind
> > of data?
> >   
> 
> Adding comment as below, hope it helps.
> 
> /*
>   * Flags used as delimiter for VFIO devices should be unique in 
> migration stream

Maybe

"Flags to be used as unique delimiters for VFIO devices in the
migration stream" ?

>   * These flags are composed as:
>   * 0xffffffff => MSB 32-bit all 1s
>   * 0xef10     => Magic ID, represents emulated (virtual) function IO
>   * 0x0000     => 16-bits reserved for flags
>   *
>   * Flags _DEV_CONFIG_STATE, _DEV_SETUP_STATE and _DEV_DATA_STATE marks 
> start of
>   * respective states in migration stream.
>   * FLAG _END_OF_STATE indicates end of current state, state could be any
>   * of above states.
>   */

"The beginning of state information is marked by _DEV_CONFIG_STATE,
_DEV_SETUP_STATE, or _DEV_DATA_STATE, respectively. The end of a
certain state information is marked by _END_OF_STATE." ?

> 
> Thanks,
> Kirti
> 


