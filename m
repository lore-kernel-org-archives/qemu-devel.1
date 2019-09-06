Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8C0C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A339B205ED
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A339B205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6F8y-00073q-Tr
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 10:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i6F8L-0006bO-0O
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i6F8J-00019B-7b
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:22:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47126)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i6F8I-00018a-Vs
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:22:39 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 03B4E7EBAE
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2019 14:22:37 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id x19so6421574qto.16
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 07:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6Cd4mmrqtAa77lfkrcQEtWgsVXhS/V2uNuRGV1D0MQY=;
 b=Ba3sqxZqqWwsWoB8AWgfJI1Xo3cn5WsSFTFI6eHWyDYeFTgz/ZvXZB0dzgN5lsZ77y
 nLxiWCvPhosAfVroHvQAWrh1y96xaIk9J4T2y6R8i90zyestvT3gBcf+552tTOOqv9jq
 ucXiaOl27Gr7MpUCvc66oe/P+apulL4z0+kf5XsYfdqUVEmERZXvjsQ0zTSr6/XhsOOB
 ouhkgjhYHWKvb6CM4UVY1hfoC8ohY+xaS9Qm7smyjt6/ZO2ze+ucBQZpQvIQXmR2ZU7r
 WrWiDTF8GSLCaQCdM5hXV1BvUvyARWVD5+Ng1ND89f/NdXZKVgS3EEVjObkPVqg3EDX/
 FKWQ==
X-Gm-Message-State: APjAAAXh1p6DohXn0p0AuxUaT7TPByqFRHfX/rmOkA6wxab0DGBVP+qR
 h0pSfcl7eW6cT0wnorr9C4Dg4ZmONS1UO/BlAu3Amd2gTp6hkTeJYeu/bizwxdRZ6tOzZAcx8wZ
 MsYdn5uzV0VyERsg=
X-Received: by 2002:a0c:af04:: with SMTP id i4mr5663542qvc.53.1567779756224;
 Fri, 06 Sep 2019 07:22:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxqGthgAdL5PUPa4qTKYsp+op6L+l3fsRdJ7Cl9DEF6W5SnuUkv+HKeaVSJtrwo3jr6kHPfTg==
X-Received: by 2002:a0c:af04:: with SMTP id i4mr5663514qvc.53.1567779755986;
 Fri, 06 Sep 2019 07:22:35 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id t25sm2257364qtp.29.2019.09.06.07.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 07:22:35 -0700 (PDT)
Date: Fri, 6 Sep 2019 10:22:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190906102217-mutt-send-email-mst@kernel.org>
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190906121350.29202-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906121350.29202-1-johannes@sipsolutions.net>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] libvhost-user: implement
 VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS
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
Cc: qemu-devel@nongnu.org, Johannes Berg <johannes.berg@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 06, 2019 at 03:13:50PM +0300, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

a bit more content here about the motivation for this?

> ---
>  contrib/libvhost-user/libvhost-user.c | 61 +++++++++++++++++++++++----
>  contrib/libvhost-user/libvhost-user.h |  3 ++
>  2 files changed, 56 insertions(+), 8 deletions(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index fba291c13db4..550f6416a211 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -136,6 +136,7 @@ vu_request_to_string(unsigned int req)
>          REQ(VHOST_USER_GET_INFLIGHT_FD),
>          REQ(VHOST_USER_SET_INFLIGHT_FD),
>          REQ(VHOST_USER_GPU_SET_SOCKET),
> +        REQ(VHOST_USER_VRING_KICK),
>          REQ(VHOST_USER_MAX),
>      };
>  #undef REQ
> @@ -920,6 +921,7 @@ static bool
>  vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *vmsg)
>  {
>      int index = vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
> +    bool nofd = vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK;
>  
>      if (index >= dev->max_queues) {
>          vmsg_close_fds(vmsg);
> @@ -927,8 +929,12 @@ vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *vmsg)
>          return false;
>      }
>  
> -    if (vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK ||
> -        vmsg->fd_num != 1) {
> +    if (nofd) {
> +        vmsg_close_fds(vmsg);
> +        return true;
> +    }
> +
> +    if (vmsg->fd_num != 1) {
>          vmsg_close_fds(vmsg);
>          vu_panic(dev, "Invalid fds in request: %d", vmsg->request);
>          return false;
> @@ -1025,6 +1031,7 @@ static bool
>  vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
>  {
>      int index = vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
> +    bool nofd = vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK;
>  
>      DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
>  
> @@ -1038,8 +1045,8 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
>          dev->vq[index].kick_fd = -1;
>      }
>  
> -    dev->vq[index].kick_fd = vmsg->fds[0];
> -    DPRINT("Got kick_fd: %d for vq: %d\n", vmsg->fds[0], index);
> +    dev->vq[index].kick_fd = nofd ? -1 : vmsg->fds[0];
> +    DPRINT("Got kick_fd: %d for vq: %d\n", dev->vq[index].kick_fd, index);
>  
>      dev->vq[index].started = true;
>      if (dev->iface->queue_set_started) {
> @@ -1116,6 +1123,7 @@ static bool
>  vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
>  {
>      int index = vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
> +    bool nofd = VHOST_USER_VRING_NOFD_MASK;
>  
>      DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
>  
> @@ -1128,14 +1136,14 @@ vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
>          dev->vq[index].call_fd = -1;
>      }
>  
> -    dev->vq[index].call_fd = vmsg->fds[0];
> +    dev->vq[index].call_fd = nofd ? -1 : vmsg->fds[0];
>  
>      /* in case of I/O hang after reconnecting */
> -    if (eventfd_write(vmsg->fds[0], 1)) {
> +    if (dev->vq[index].call_fd != -1 && eventfd_write(vmsg->fds[0], 1)) {
>          return -1;
>      }
>  
> -    DPRINT("Got call_fd: %d for vq: %d\n", vmsg->fds[0], index);
> +    DPRINT("Got call_fd: %d for vq: %d\n", dev->vq[index].call_fd, index);
>  
>      return false;
>  }
> @@ -1169,7 +1177,8 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
>                          1ULL << VHOST_USER_PROTOCOL_F_SLAVE_REQ |
>                          1ULL << VHOST_USER_PROTOCOL_F_HOST_NOTIFIER |
>                          1ULL << VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD |
> -                        1ULL << VHOST_USER_PROTOCOL_F_REPLY_ACK;
> +                        1ULL << VHOST_USER_PROTOCOL_F_REPLY_ACK |
> +                        1ULL << VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS;
>  
>      if (have_userfault()) {
>          features |= 1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT;
> @@ -1456,6 +1465,25 @@ vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
>      return false;
>  }
>  
> +static bool
> +vu_handle_vring_kick(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    unsigned int index = vmsg->payload.state.index;
> +
> +    if (index >= dev->max_queues) {
> +        vu_panic(dev, "Invalid queue index: %u", index);
> +        return false;
> +    }
> +
> +    DPRINT("Got kick message: handler:%p idx:%d\n",
> +	   dev->vq[index].handler, index);
> +    if (dev->vq[index].handler) {
> +        dev->vq[index].handler(dev, index);
> +    }
> +
> +    return false;
> +}
> +
>  static bool
>  vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>  {
> @@ -1538,6 +1566,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>          return vu_get_inflight_fd(dev, vmsg);
>      case VHOST_USER_SET_INFLIGHT_FD:
>          return vu_set_inflight_fd(dev, vmsg);
> +    case VHOST_USER_VRING_KICK:
> +        return vu_handle_vring_kick(dev, vmsg);
>      default:
>          vmsg_close_fds(vmsg);
>          vu_panic(dev, "Unhandled request: %d", vmsg->request);
> @@ -2010,6 +2040,21 @@ vu_queue_notify(VuDev *dev, VuVirtq *vq)
>          return;
>      }
>  
> +    if (vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS) &&
> +        vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SLAVE_REQ)) {
> +        VhostUserMsg vmsg = {
> +            .request = VHOST_USER_SLAVE_VRING_CALL,
> +            .flags = VHOST_USER_VERSION,
> +            .size = sizeof(vmsg.payload.state),
> +            .payload.state = {
> +                .index = dev->vq - vq,
> +            },
> +        };
> +
> +        vu_message_write(dev, dev->slave_fd, &vmsg);
> +        return;
> +    }
> +
>      if (eventfd_write(vq->call_fd, 1) < 0) {
>          vu_panic(dev, "Error writing eventfd: %s", strerror(errno));
>      }
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
> index 46b600799b2e..392dea306bb9 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -53,6 +53,7 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD = 10,
>      VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
>      VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD = 12,
> +    VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS = 13,
>  
>      VHOST_USER_PROTOCOL_F_MAX
>  };
> @@ -94,6 +95,7 @@ typedef enum VhostUserRequest {
>      VHOST_USER_GET_INFLIGHT_FD = 31,
>      VHOST_USER_SET_INFLIGHT_FD = 32,
>      VHOST_USER_GPU_SET_SOCKET = 33,
> +    VHOST_USER_VRING_KICK = 34,
>      VHOST_USER_MAX
>  } VhostUserRequest;
>  
> @@ -102,6 +104,7 @@ typedef enum VhostUserSlaveRequest {
>      VHOST_USER_SLAVE_IOTLB_MSG = 1,
>      VHOST_USER_SLAVE_CONFIG_CHANGE_MSG = 2,
>      VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG = 3,
> +    VHOST_USER_SLAVE_VRING_CALL = 4,
>      VHOST_USER_SLAVE_MAX
>  }  VhostUserSlaveRequest;
>  
> -- 
> 2.23.0
> 

