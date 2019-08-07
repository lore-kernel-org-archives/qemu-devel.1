Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034A3C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7622229C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7622229C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvOVb-0001hV-3L
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 12:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38842)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hvOVB-0001DG-WF
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hvOVB-00089X-1B
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:09:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hvOVA-00088O-S2
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:09:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 69DC84FCC7;
 Wed,  7 Aug 2019 16:09:23 +0000 (UTC)
Received: from work-vm (ovpn-117-204.ams2.redhat.com [10.36.117.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 566805D9CD;
 Wed,  7 Aug 2019 16:09:20 +0000 (UTC)
Date: Wed, 7 Aug 2019 17:09:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
Message-ID: <20190807160917.GI2867@work-vm>
References: <8df105774471bc72bca1397b4058ecc66d963848.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8df105774471bc72bca1397b4058ecc66d963848.camel@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 07 Aug 2019 16:09:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] libvhost-user: Fix the
 VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD check
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
Cc: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Boeuf, Sebastien (sebastien.boeuf@intel.com) wrote:
> From 0a53a81db6dd069f9b7bcdcd386845bceb3a2ac6 Mon Sep 17 00:00:00 2001
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Date: Wed, 7 Aug 2019 07:15:32 -0700
> Subject: [PATCH] libvhost-user: Fix the
> VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD
>  check
> 
> Vhost user protocol features are set as a bitmask. And the following
> constant VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD value is 10 because the
> bit
> 10 indicates if the features is set or not.
> 
> The proper way to check for the presence or absence of this feature is
> to shift 1 by the value of this constant and then mask it with the
> actual bitmask representing the supported protocol features.
> 
> This patch aims to fix the current code as it was not doing the
> shifting, but instead it was masking directly with the value of the
> constant itself.
> 
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>

Nicely spotted.

Two things;
  a) I think your mail client has wrapped the lines at some point.
  b) I think this is why the has_feature() functione exists, so does
     that become

      if (!has_feature(dev->protocol_features, VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD))

Dave

> ---
>  contrib/libvhost-user/libvhost-user.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-
> user/libvhost-user.c
> index fb61142bcc..11909fb7c1 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -1112,7 +1112,7 @@ bool vu_set_queue_host_notifier(VuDev *dev,
> VuVirtq *vq, int fd,
>  
>      vmsg.fd_num = fd_num;
>  
> -    if ((dev->protocol_features & VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)
> == 0) {
> +    if ((dev->protocol_features & (1ULL <<
> VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) == 0) {
>          return false;
>      }
>  
> @@ -2537,7 +2537,7 @@ int64_t vu_fs_cache_request(VuDev *dev,
> VhostUserSlaveRequest req, int fd,
>  
>      vmsg.fd_num = fd_num;
>  
> -    if ((dev->protocol_features & VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)
> == 0) {
> +    if ((dev->protocol_features & (1ULL <<
> VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) == 0) {
>          return -EINVAL;
>      }
>  
> -- 
> 2.17.1
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

