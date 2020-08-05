Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C712DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 02:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 976A32086A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 02:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSi9fIxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976A32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k39OW-0006js-SS
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 22:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k39Nx-0006KN-DX
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 22:42:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20809
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k39Nu-0005Wi-G1
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 22:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596595348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j55K/Dwi4G9px2pH7AKtokjX8kCpdSz/LKIcvwedD1k=;
 b=XSi9fIxXvZCkFrN++slkD8EOFMAAo1js/uI3rDrANfEeKzXr5jQMaWEW51/NBwcV5zZNKv
 4SWWHj7Btg9llQh33Athon/HgoNY6ETN/gQ/8JQT2c+numquYX1SE2uRpfON+ke8jy9Eca
 nE4q9YQgaVOmrlD2xyIuF3iSQi4et+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-0uvxif-TMCaNGmd8p_0tTQ-1; Tue, 04 Aug 2020 22:42:25 -0400
X-MC-Unique: 0uvxif-TMCaNGmd8p_0tTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97D3A101C8A0;
 Wed,  5 Aug 2020 02:42:22 +0000 (UTC)
Received: from [10.72.13.71] (ovpn-13-71.pek2.redhat.com [10.72.13.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 285AA28559;
 Wed,  5 Aug 2020 02:41:55 +0000 (UTC)
Subject: Re: device compatibility interface for live migration with assigned
 devices
To: Yan Zhao <yan.y.zhao@intel.com>
References: <20200713232957.GD5955@joy-OptiPlex-7040>
 <9bfa8700-91f5-ebb4-3977-6321f0487a63@redhat.com>
 <20200716083230.GA25316@joy-OptiPlex-7040> <20200717101258.65555978@x1.home>
 <20200721005113.GA10502@joy-OptiPlex-7040>
 <20200727072440.GA28676@joy-OptiPlex-7040> <20200727162321.7097070e@x1.home>
 <20200729080503.GB28676@joy-OptiPlex-7040>
 <20200804183503.39f56516.cohuck@redhat.com>
 <c178a0d3-269d-1620-22b1-9010f602d8ff@redhat.com>
 <20200805021654.GB30485@joy-OptiPlex-7040>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2624b12f-3788-7e2b-2cb7-93534960bcb7@redhat.com>
Date: Wed, 5 Aug 2020 10:41:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805021654.GB30485@joy-OptiPlex-7040>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 22:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, eskultet@redhat.com,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Parav Pandit <parav@mellanox.com>,
 jian-feng.ding@intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com,
 hejie.xu@intel.com, bao.yumeng@zte.com.cn,
 Alex Williamson <alex.williamson@redhat.com>, smooney@redhat.com,
 intel-gvt-dev@lists.freedesktop.org, berrange@redhat.com, corbet@lwn.net,
 Jiri Pirko <jiri@mellanox.com>, dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/8/5 上午10:16, Yan Zhao wrote:
> On Wed, Aug 05, 2020 at 10:22:15AM +0800, Jason Wang wrote:
>> On 2020/8/5 上午12:35, Cornelia Huck wrote:
>>> [sorry about not chiming in earlier]
>>>
>>> On Wed, 29 Jul 2020 16:05:03 +0800
>>> Yan Zhao <yan.y.zhao@intel.com> wrote:
>>>
>>>> On Mon, Jul 27, 2020 at 04:23:21PM -0600, Alex Williamson wrote:
>>> (...)
>>>
>>>>> Based on the feedback we've received, the previously proposed interface
>>>>> is not viable.  I think there's agreement that the user needs to be
>>>>> able to parse and interpret the version information.  Using json seems
>>>>> viable, but I don't know if it's the best option.  Is there any
>>>>> precedent of markup strings returned via sysfs we could follow?
>>> I don't think encoding complex information in a sysfs file is a viable
>>> approach. Quoting Documentation/filesystems/sysfs.rst:
>>>
>>> "Attributes should be ASCII text files, preferably with only one value
>>> per file. It is noted that it may not be efficient to contain only one
>>> value per file, so it is socially acceptable to express an array of
>>> values of the same type.
>>> Mixing types, expressing multiple lines of data, and doing fancy
>>> formatting of data is heavily frowned upon."
>>>
>>> Even though this is an older file, I think these restrictions still
>>> apply.
>>
>> +1, that's another reason why devlink(netlink) is better.
>>
> hi Jason,
> do you have any materials or sample code about devlink, so we can have a good
> study of it?
> I found some kernel docs about it but my preliminary study didn't show me the
> advantage of devlink.


CC Jiri and Parav for a better answer for this.

My understanding is that the following advantages are obvious (as I 
replied in another thread):

- existing users (NIC, crypto, SCSI, ib), mature and stable
- much better error reporting (ext_ack other than string or errno)
- namespace aware
- do not couple with kobject

Thanks


>
> Thanks
> Yan
>


