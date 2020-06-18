Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBE2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD07206F7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSqHai9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD07206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlu14-0006Ub-2K
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 08:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jlu0T-0005h2-Ax
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:51:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39575
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jlu0R-0007x8-Gy
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592484658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33jMmnmY4b/XGlQl7CsmGdcXPXz0nYXQMvQ5K17gxk4=;
 b=JSqHai9FdJJvGNdL9CFqYo+M2plSZyPixJR7wATPBmt3z4Ot7vGAwcDvLuMs7LkOetBvUE
 BnJCTt2wsmzkWRdrms9jvxyOsJdwP6aFUGUU/wc+EuUjbSF31wwYENNngRlNwAJvSP5TlI
 YPx5swre54cTFcM6f4/gqB87SAlhDIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-wz97DAwiP5WaL73ynuDbaA-1; Thu, 18 Jun 2020 08:50:56 -0400
X-MC-Unique: wz97DAwiP5WaL73ynuDbaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E65B464
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 12:50:55 +0000 (UTC)
Received: from [10.72.13.100] (ovpn-13-100.pek2.redhat.com [10.72.13.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 162AE100238D;
 Thu, 18 Jun 2020 12:50:47 +0000 (UTC)
Subject: Re: [PATCH] docs: vhost-user: add Virtio status protocol feature
To: Maxime Coquelin <maxime.coquelin@redhat.com>, mst@redhat.com,
 lulu@redhat.com, amorenoz@redhat.com, qemu-devel@nongnu.org
References: <20200618112908.130528-1-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1208fc0b-3ca1-8735-e74b-9f71aefc3bb1@redhat.com>
Date: Thu, 18 Jun 2020 20:50:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618112908.130528-1-maxime.coquelin@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/6/18 下午7:29, Maxime Coquelin wrote:
> This patch specifies the VHOST_USER_SET_STATUS and
> VHOST_USER_GET_STATUS requests, which are sent by
> the master to update and query the Virtio status
> in the backend.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>
> Changes since v1:
> =================
> - Only keep the spec part in this patch, the implementation will
>    be part of Cindy's Vhost vDPA series it depends on. The goal is
>    to be able to implement it in next DPDK release even if Qemu part
>    is not merged.
> - Add GET_STATUS after discussions with Michael and Jason. It can
>    be used by the master to ensure FEATURES_OK bit set is
>    acknowledged by the backend.
>
>   docs/interop/vhost-user.rst | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 688b7c6900..866d7c2fb7 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -816,6 +816,7 @@ Protocol features
>     #define VHOST_USER_PROTOCOL_F_RESET_DEVICE         13
>     #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
>     #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
> +  define VHOST_USER_PROTOCOL_F_STATUS                16


Miss a '#"?

Other looks good.

Thanks


>   
>   Master message types
>   --------------------
> @@ -1307,6 +1308,29 @@ Master message types
>     ``VHOST_USER_ADD_MEM_REG`` message, this message is used to set and
>     update the memory tables of the slave device.
>   
> +``VHOST_USER_SET_STATUS``
> +  :id: 39
> +  :equivalent ioctl: VHOST_VDPA_SET_STATUS
> +  :slave payload: N/A
> +  :master payload: ``u64``
> +
> +  When the ``VHOST_USER_PROTOCOL_F_STATUS`` protocol feature has been
> +  successfully negotiated, this message is submitted by the master to
> +  notify the backend with updated device status as defined in the Virtio
> +  specification.
> +
> +``VHOST_USER_GET_STATUS``
> +  :id: 40
> +  :equivalent ioctl: VHOST_VDPA_GET_STATUS
> +  :slave payload: ``u64``
> +  :master payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_STATUS`` protocol feature has been
> +  successfully negotiated, this message is submitted by the master to
> +  query the backend for its device status as defined in the Virtio
> +  specification.
> +
> +
>   Slave message types
>   -------------------
>   


