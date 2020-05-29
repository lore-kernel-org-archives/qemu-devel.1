Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B688C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2707B207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKpYNdHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2707B207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefvh-0000Fg-9L
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jefus-00070M-Vv
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:23:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25623
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jefur-00086g-D9
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590762198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXIE7hG/7ijwz7IRFpnESy894umcO9H/9SZv7iyp8FA=;
 b=AKpYNdHeHLIIbtbfMN2Mp5uVfuHzH0OPhmYXI6fOzj85FU07SGCCoZnG4sZGam3TP179gH
 W3FccBxiqY2iA4rU7CF6/5UuqS+Xrhr/r+Ya4/kbxNYaU2bt+s11gM53PubvNngtXJFBLW
 pd+hu4qprJkvNetCHnC0PvNtTc7KDig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-spV136MGPh-CgK9fhVt9_A-1; Fri, 29 May 2020 10:23:09 -0400
X-MC-Unique: spV136MGPh-CgK9fhVt9_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DF15800D24;
 Fri, 29 May 2020 14:23:07 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D5AB1001B0B;
 Fri, 29 May 2020 14:22:50 +0000 (UTC)
Subject: Re: [RFC v3 8/8] vhost-vdpa: introduce vhost-vdpa net client
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 cohuck@redhat.com, jasowang@redhat.com
References: <20200529140620.28759-1-lulu@redhat.com>
 <20200529140620.28759-9-lulu@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5595226b-dd22-9dc8-fa82-cdabb7a7df52@redhat.com>
Date: Fri, 29 May 2020 09:22:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529140620.28759-9-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:34:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, hanand@xilinx.com, hch@infradead.org, eperezma@redhat.com,
 jgg@mellanox.com, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, vmireyno@marvell.com, cunming.liang@intel.com,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 stefanha@redhat.com, zhihong.wang@intel.com, Tiwei Bie <tiwei.bie@intel.com>,
 aadam@redhat.com, rdunlap@infradead.org, maxime.coquelin@redhat.com,
 lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 9:06 AM, Cindy Lu wrote:
> From: Tiwei Bie <tiwei.bie@intel.com>
> 
> This patch set introduces a new net client type: vhost-vdpa.
> vhost-vdpa net client will set up a vDPA device which is specified
> by a "vhostdev" parameter.
> 
> Co-authored-by: Lingshan Zhu <lingshan.zhu@intel.com>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

> +static int net_vhost_vdpa_init(NetClientState *peer, const char *device,
> +                               const char *name, const char *vhostdev,
> +                               bool has_fd, char *fd)
> +{

fd is usually an int, not a string.

> +    NetClientState *nc = NULL;
> +    VhostVDPAState *s;
> +    int vdpa_device_fd = -1;
> +    Error *err = NULL;
> +    int ret = 0;
> +    assert(name);
> +
> +    nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, device, name);
> +    snprintf(nc->info_str, sizeof(nc->info_str), "vhost-vdpa");
> +    nc->queue_index = 0;
> +
> +    s = DO_UPCAST(VhostVDPAState, nc, nc);
> +
> +    if (has_fd) {
> +        vdpa_device_fd = monitor_fd_param(cur_mon, fd, &err);
> +    } else{
> +        vdpa_device_fd = open(vhostdev, O_RDWR);
> +    }

Oh, you're trying to use the old way for passing in fds.  The preferred 
way is to use qemu_open(), at which point you can pass in fds via the 
add-fd QMP command, and then pass the string "/dev/fdset/NNN" as 
vhostdev.  Then you don't need a special fd parameter here.

> +++ b/qapi/net.json
> @@ -428,6 +428,27 @@
>       '*vhostforce':    'bool',
>       '*queues':        'int' } }
>   
> +##
> +# @NetdevVhostVDPAOptions:
> +#
> +# Vhost-vdpa network backend
> +#
> +# @vhostdev: name of a vdpa dev path in sysfs
> +#            (default path:/dev/vhost-vdpa-$ID)
> +#
> +# @fd: file descriptor of an already opened vdpa device
> +#
> +# @queues: number of queues to be created for multiqueue vhost-vdpa
> +#          (default: 1)
> +#
> +# Since: 5.1
> +##
> +{ 'struct': 'NetdevVhostVDPAOptions',
> +  'data': {
> +    '*vhostdev':     'str',
> +    '*fd':           'str',
> +    '*queues':       'int' } }

Instead of having vhostdev and fd both be optional (but where the user 
has to specify exactly one of them), you should only have vhostdev be 
mandatory, and rely on the /dev/fdset/NNN string as a way to get 
vhostdev to point to a previously-passed fd.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


