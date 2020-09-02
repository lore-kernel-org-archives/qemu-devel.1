Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096DBC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 07:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B444820826
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 07:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gk20bKEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B444820826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNT8-00085t-Sp
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 03:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kDNQJ-0006R9-87
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29383)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kDNQH-0006wu-Fs
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599032592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyCuIhKfOjZBQv5nEu3j+75Sd+9wulra5acBDXMBps0=;
 b=Gk20bKECsTpc4bOXWvzm36puXO0WvfjcZ2MT9swe3HlgeWJwVtA11BqW38VxJOKsuf6bme
 yu4mZZVzfLpRig5lWWGJjSJANmZMejuDBk+P4lLpGA4hzrv2+gVcIJIQX+kJtA+NJtAEYO
 sxbPLw4P0vMrxW7LWzv0T16YDG3dzvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-Oel67lhvOkaCX1nD4lywHA-1; Wed, 02 Sep 2020 03:43:10 -0400
X-MC-Unique: Oel67lhvOkaCX1nD4lywHA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68D63801AE0;
 Wed,  2 Sep 2020 07:43:09 +0000 (UTC)
Received: from [10.72.13.160] (ovpn-13-160.pek2.redhat.com [10.72.13.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2FD71972A;
 Wed,  2 Sep 2020 07:42:45 +0000 (UTC)
Subject: Re: VHOST_USER_PROTOCOL_F_VDPA
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
References: <20200821110822.GA205318@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0763f11f-513e-2115-5075-7b9291226e0c@redhat.com>
Date: Wed, 2 Sep 2020 15:42:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821110822.GA205318@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.327
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Tiwei Bie <tiwei.bie@intel.com>, Cindy Lu <lulu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, kraxel@redhat.com,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Adrian Moreno Zapata <amorenoz@redhat.com>,
 Changpeng Liu <changpeng.liu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/8/21 下午7:08, Stefan Hajnoczi wrote:
> The first vDPA ioctls have been added to the vhost-user protocol and I
> wonder if it's time to fully change the vhost-user protocol's focus to
> providing a full VIRTIO device model like vDPA does.
>
> Initially vhost-user was just used for vhost-net. As a result it didn't
> need the full VIRTIO device model including the configuration space and
> device status register.
>
> Over the years device-specific messages were added to extend vhost-user
> to cover more of the VIRTIO device model. vhost-user-blk needed
> configuration space support, for example.
>
> The problem for VMMs and device backend implementors is that the
> protocol is currently positioned halfway between the original vhost-net
> approach and the full VIRTIO device model. Even if a VMM implements
> VHOST_USER_GET_CONFIG, it can only expect it to work with
> vhost-user-blk, not vhost-user-net. Similarly, a vhost-user-net device
> backend cannot implement VHOST_USER_GET_CONFIG and expect all VMMs to
> allow it to participate in configuration space emulation because
> existing VMMs won't send that message.
>
> The current approach where each device type uses a undocumented subset
> of vhost-user messages is really messy. VMM and device backend
> implementors have to look at existing implementations to know what is
> expected for a given device type. It would be nice to switch to the
> VIRTIO device model so that the VIRTIO specification can be used as the
> reference for how device types work.
>
> Now that vDPA is here and extends the kernel vhost ioctls with a full
> VIRTIO device model, it might be a good time to revise the vhost-user
> protocol.
>
> A vdpa-user protocol (or vhost-user 2.0) would replace the current mess
> with a full VIRTIO device model. Both VMMs and device backends would
> require changes to support this, but it would be a cleaner path forward
> for the vhost-user protocol.
>
> One way of doing this would be a new VHOST_USER_PROTOCOL_F_VDPA feature
> bit that indicates all the currently existing Linux vDPA ioctl messages
> are available. Legacy vhost-user messages with overlapping functionality
> must not be used when this bit is set. Most importantly, device backends
> need to implement the full VIRTIO device model, regardless of device
> type (net, blk, scsi, etc).
>
> The device type most affected by this change would be virtio-net. The
> other device types are already closer to the full VIRTIO device model.
>
> I wanted to share this idea in case someone is currently trying to
> figure out how to add more VIRTIO device model functionality to
> vhost-user.


Cc Adrian.

I think this makes sense.

Thanks


>
> Stefan


