Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD37AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2942A2087E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NY9eUpAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2942A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY7b6-0003a2-W2
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 09:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kY7aC-00033V-1Q
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:03:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kY7a4-0007qV-71
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603976581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UbMC7ECF/UB+ijsoxwTWDq3h3MHDxWBI+w8ZKOQq0Ss=;
 b=NY9eUpATkKV4Vz1k2K5boaQivBwmyrk474hojBPo2Cltvfu3TlfN4qX4ahVlBtXYBmVYGC
 hmSlspuskrT32WT/KCWKsnjSZWSbb8o+FA0oTttzqtu7bk6FHEgq0BxCstWABQqaBPOuks
 X3Vul77/HzOaic20W9oP32oCPYqHqQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-iJFQgQPiNhyOZJAgzv_mKg-1; Thu, 29 Oct 2020 09:02:56 -0400
X-MC-Unique: iJFQgQPiNhyOZJAgzv_mKg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FF07809DF7;
 Thu, 29 Oct 2020 13:02:42 +0000 (UTC)
Received: from [10.72.12.209] (ovpn-12-209.pek2.redhat.com [10.72.12.209])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48D6576660;
 Thu, 29 Oct 2020 13:02:07 +0000 (UTC)
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
To: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20201027151400.GA138065@stefanha-x1.localdomain>
 <CAJSP0QWrmNN1Ci-M-4WDFZBOGHyeZvF71utg0w2ajCbOLtynJw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
Date: Thu, 29 Oct 2020 21:02:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWrmNN1Ci-M-4WDFZBOGHyeZvF71utg0w2ajCbOLtynJw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 "mst@redhat.com" <mtsirkin@redhat.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Yan Vugenfirer <yan@daynix.com>, Jag Raman <jag.raman@oracle.com>,
 Anup Patel <anup@brainfault.org>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Felipe Franciosi <felipe@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, fam <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/10/29 下午8:08, Stefan Hajnoczi wrote:
> Here are notes from the session:
>
> protocol stability:
>      * vhost-user already exists for existing third-party applications
>      * vfio-user is more general but will take more time to develop
>      * libvfio-user can be provided to allow device implementations
>
> management:
>      * Should QEMU launch device emulation processes?
>          * Nicer user experience
>          * Technical blockers: forking, hotplug, security is hard once
> QEMU has started running
>          * Probably requires a new process model with a long-running
> QEMU management process proxying QMP requests to the emulator process
>
> migration:
>      * dbus-vmstate
>      * VFIO live migration ioctls
>          * Source device can continue if migration fails
>          * Opaque blobs are transferred to destination, destination can
> fail migration if it decides the blobs are incompatible


I'm not sure this can work:

1) Reading something that is opaque to userspace is probably a hint of 
bad uAPI design
2) Did qemu even try to migrate opaque blobs before? It's probably a bad 
design of migration protocol as well.

It looks to me have a migration driver in qemu that can clearly define 
each byte in the migration stream is a better approach.


>          * How does the VMM share the migration data region with the
> device emulation process?
>              * The vfio-user protocol can trap or mmap
>      * device versioning (like versioned machine types) needed to pin
> the guest-visible device ABI
>      * Felipe will investigate live migration
>
> reconnection:
>      * How to support reconnection?
>          * QEMU has relatively little state of a vfio-user device
>          * vhost-user has more state so it's a little easier to
> reconnect or migrate


It could be even more easier, e.g for the inflight indices, we can 
design (or forcing to use in order) virtqueue carefully then we don't 
need any auxiliary data structure.

Thanks


>      * Build in reconnection and live migration from the start to avoid
> difficulties in the future
>      * Relationship between migration and reconnection?
>          * VFIO has a mechanism for saving/loading device state
>          * Lots of different reconnection cases that need to be thought through
>
> security & sandboxing:
>      * Goal: make it easy to lock down the process so developers don't
> need to reinvent sandboxing
>      * minijail
>          * in-process
>      * firecracker jailer
>      * bubblewrap
>          * launcher tool
>      * systemd-run
>          * launcher tool
>


