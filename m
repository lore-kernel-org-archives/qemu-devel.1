Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CC8C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 04:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAE72072B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 04:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAE72072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYMwA-0003Jq-5f
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 00:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jYKSg-0007Ty-Ru
 for qemu-devel@nongnu.org; Mon, 11 May 2020 22:16:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:23592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jYKSe-0002Eq-TN
 for qemu-devel@nongnu.org; Mon, 11 May 2020 22:16:02 -0400
IronPort-SDR: DYqQ4qhJaK7KKMFvNusXpUHcze1r9eUj/gg+p4Bqg5WOZQitrVw82CIQmgQFAnJxaJqZnRnkCD
 WYChAnLwZGsw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2020 19:15:55 -0700
IronPort-SDR: iXccTIdUWJlLTJGRuHfotT/+4wwHfv8Jpssd8vmdxbb+tkTyDF/6dkLfRkU9BweAAjk2+DFxEv
 50ocevK7l+BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; d="scan'208";a="286475312"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga004.fm.intel.com with ESMTP; 11 May 2020 19:15:50 -0700
Date: Mon, 11 May 2020 22:06:03 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v16 QEMU 09/16] vfio: Add save state functions to
 SaveVMHandlers
Message-ID: <20200512020603.GB27524@joy-OptiPlex-7040>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-10-git-send-email-kwankhede@nvidia.com>
 <20200325160311.265ca037@w520.home>
 <b57322be-a337-ccb8-19e3-6c6bc3343119@nvidia.com>
 <20200504223708.6d8c94bf@x1.home>
 <0da3fe3b-1818-3c82-040b-0f9881eb7205@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0da3fe3b-1818-3c82-040b-0f9881eb7205@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.115; envelope-from=yan.y.zhao@intel.com;
 helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 22:15:55
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 May 2020 00:52:43 -0400
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 05:53:37PM +0800, Kirti Wankhede wrote:
> 
> 
> On 5/5/2020 10:07 AM, Alex Williamson wrote:
> > On Tue, 5 May 2020 04:48:14 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > 
> >> On 3/26/2020 3:33 AM, Alex Williamson wrote:
> >>> On Wed, 25 Mar 2020 02:39:07 +0530
> >>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>    

<...>

> >>>> +static int vfio_save_iterate(QEMUFile *f, void *opaque)
> >>>> +{
> >>>> +    VFIODevice *vbasedev = opaque;
> >>>> +    int ret, data_size;
> >>>> +
> >>>> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
> >>>> +
> >>>> +    data_size = vfio_save_buffer(f, vbasedev);
> >>>> +
> >>>> +    if (data_size < 0) {
> >>>> +        error_report("%s: vfio_save_buffer failed %s", vbasedev->name,
> >>>> +                     strerror(errno));
> >>>> +        return data_size;
> >>>> +    }
> >>>> +
> >>>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> >>>> +
> >>>> +    ret = qemu_file_get_error(f);
> >>>> +    if (ret) {
> >>>> +        return ret;
> >>>> +    }
> >>>> +
> >>>> +    trace_vfio_save_iterate(vbasedev->name, data_size);
> >>>> +    if (data_size == 0) {
> >>>> +        /* indicates data finished, goto complete phase */
> >>>> +        return 1;
> >>>
> >>> But it's pending_bytes not data_size that indicates we're done.  How do
> >>> we get away with ignoring pending_bytes for the save_live_iterate phase?
> >>>    
> >>
> >> This is requirement mentioned above qemu_savevm_state_iterate() which
> >> calls .save_live_iterate.
> >>
> >> /*	
> >>    * this function has three return values:
> >>    *   negative: there was one error, and we have -errno.
> >>    *   0 : We haven't finished, caller have to go again
> >>    *   1 : We have finished, we can go to complete phase
> >>    */
> >> int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
> >>
> >> This is to serialize savevm_state.handlers (or in other words devices).
> > 
> > I've lost all context on this question in the interim, but I think this
> > highlights my question.  We use pending_bytes to know how close we are
> > to the end of the stream and data_size to iterate each transaction
> > within that stream.  So how does data_size == 0 indicate we've
> > completed the current phase?  It seems like pending_bytes should
> > indicate that.  Thanks,
> > 
> 
> Fixing this by adding a read on pending_bytes if its 0 and return 
> accordingly.
>      if (migration->pending_bytes == 0) {
>          ret = vfio_update_pending(vbasedev);
>          if (ret) {
>              return ret;
>          }
> 
>          if (migration->pending_bytes == 0) {
>              /* indicates data finished, goto complete phase */
>              return 1;
>          }
>      }
> 

just a question. if 1 is only returned when migration->pending_bytes is 0,
does that mean .save_live_iterate of vmstates after "vfio-pci"
would never be called until migration->pending_bytes is 0 ?

as in qemu_savevm_state_iterate(),

qemu_savevm_state_iterate {
...
  QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
  	...
 	ret = se->ops->save_live_iterate(f, se->opaque);
	...
	if (ret <= 0) {
            /* Do not proceed to the next vmstate before this one reported
               completion of the current stage. This serializes the migration
               and reduces the probability that a faster changing state is
               synchronized over and over again. */
            break;
        }
  }
  return ret;
}

in ram's migration code, its pending_bytes(remaining_size) is only updated in
ram_save_pending() when it's below threshold, which means in
ram_save_iterate() the pending_bytes is possible to be 0, so other
vmstates have their chance to be called.

Thanks
Yan


