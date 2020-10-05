Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD56C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DB7207BC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsGNBDJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DB7207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPQT9-0002qK-BS
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 09:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kPQRr-0001kP-C4
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kPQRo-0004F8-UL
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601904156;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bD3YX6ol4sBhzruYhqCcAwi9aqewE2NxyfN21oe9m7s=;
 b=JsGNBDJ9V1BMuZIR5PULzS7gXyeFGTmAMt6+VDa9PhjHMKq9T60bAkyL7cNC2gBcnHB+7x
 M4nNWaQXhbRpTQcLD3L4iPfhoUKovhmwcy69lXsybUKGZtPVeHRTAy4hOFUbIvSpVvImsU
 ykXRfasL8naQzIT3p6LA/uDsDTM24dg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-wq6eDqFbPG6WoQGwW9bt_w-1; Mon, 05 Oct 2020 09:22:34 -0400
X-MC-Unique: wq6eDqFbPG6WoQGwW9bt_w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 079FA425CB;
 Mon,  5 Oct 2020 13:22:33 +0000 (UTC)
Received: from redhat.com (ovpn-114-250.ams2.redhat.com [10.36.114.250])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FF355D9CC;
 Mon,  5 Oct 2020 13:22:27 +0000 (UTC)
Date: Mon, 5 Oct 2020 14:22:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH 1/3] qom: Always register
 FW_CFG_DATA_GENERATOR_INTERFACE
Message-ID: <20201005132225.GN2385272@redhat.com>
References: <20201005105442.2093105-1-philmd@redhat.com>
 <20201005105442.2093105-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201005105442.2093105-2-philmd@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 05, 2020 at 12:54:40PM +0200, Philippe Mathieu-Daudé wrote:
> While the FW_CFG_DATA_GENERATOR_INTERFACE is only consumed
> by a device only available using system-mode (fw_cfg), it is
> implemented by a crypto component (tls-cipher-suites) which
> is always available when crypto is used.
> 
> Commit 69699f3055 introduced the following error in the
> qemu-storage-daemon binary:
> 
>   $ echo -e \
>     '{"execute": "qmp_capabilities"}\r\n{"execute": "qom-list-types"}\r\n{"execute": "quit"}\r\n' \
>     | storage-daemon/qemu-storage-daemon --chardev stdio,id=qmp0  --monitor qmp0
>   {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 5}, "package": ""}, "capabilities": ["oob"]}}
>   {"return": {}}
>   missing interface 'fw_cfg-data-generator' for object 'tls-creds'
>   Aborted (core dumped)
> 
> Since QOM dependencies are resolved at runtime, this issue
> could not be triggered at linktime, and we don't have test
> running the qemu-storage-daemon binary.
> 
> Fix by always registering the QOM interface.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Fixes: 69699f3055 ("crypto/tls-cipher-suites: Produce fw_cfg consumable blob")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> I first used:
> 
> +if config_host.has_key('CONFIG_GNUTLS') or have_system
> +  qom_ss.add(files('fw_cfg_interface.c'))
> +endif
> 
> but then realized anything could implement a QOM interface,
> so better keep this generic.
> ---
>  hw/nvram/fw_cfg.c      |  7 -------
>  qom/fw_cfg_interface.c | 15 +++++++++++++++

I feel this should be left in hw/nvram, but still added to qom_ss.

The code location should reflect the functional area and maintainership,
so we shouldn't move code just to satisfy linkage problems.

>  MAINTAINERS            |  1 +
>  qom/meson.build        |  5 +++++
>  4 files changed, 21 insertions(+), 7 deletions(-)
>  create mode 100644 qom/fw_cfg_interface.c
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 0e95d057fd..08539a1aab 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1360,18 +1360,11 @@ static const TypeInfo fw_cfg_mem_info = {
>      .class_init    = fw_cfg_mem_class_init,
>  };
>  
> -static const TypeInfo fw_cfg_data_generator_interface_info = {
> -    .parent = TYPE_INTERFACE,
> -    .name = TYPE_FW_CFG_DATA_GENERATOR_INTERFACE,
> -    .class_size = sizeof(FWCfgDataGeneratorClass),
> -};
> -
>  static void fw_cfg_register_types(void)
>  {
>      type_register_static(&fw_cfg_info);
>      type_register_static(&fw_cfg_io_info);
>      type_register_static(&fw_cfg_mem_info);
> -    type_register_static(&fw_cfg_data_generator_interface_info);
>  }
>  
>  type_init(fw_cfg_register_types)
> diff --git a/qom/fw_cfg_interface.c b/qom/fw_cfg_interface.c
> new file mode 100644
> index 0000000000..2b19502ffe
> --- /dev/null
> +++ b/qom/fw_cfg_interface.c
> @@ -0,0 +1,15 @@
> +#include "qemu/osdep.h"
> +#include "hw/nvram/fw_cfg.h"
> +
> +static const TypeInfo fw_cfg_data_generator_interface_info = {
> +    .parent = TYPE_INTERFACE,
> +    .name = TYPE_FW_CFG_DATA_GENERATOR_INTERFACE,
> +    .class_size = sizeof(FWCfgDataGeneratorClass),
> +};
> +
> +static void fw_cfg_register_types(void)
> +{
> +    type_register_static(&fw_cfg_data_generator_interface_info);
> +}
> +
> +type_init(fw_cfg_register_types)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b76fb31861..9c89d54b41 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2055,6 +2055,7 @@ R: Gerd Hoffmann <kraxel@redhat.com>
>  S: Supported
>  F: docs/specs/fw_cfg.txt
>  F: hw/nvram/fw_cfg.c
> +F: qom/fw_cfg_interface.c
>  F: stubs/fw_cfg.c
>  F: include/hw/nvram/fw_cfg.h
>  F: include/standard-headers/linux/qemu_fw_cfg.h
> diff --git a/qom/meson.build b/qom/meson.build
> index a1cd03c82c..7335f8c8a2 100644
> --- a/qom/meson.build
> +++ b/qom/meson.build
> @@ -7,6 +7,11 @@ qom_ss.add(files(
>    'qom-qobject.c',
>  ))
>  
> +# interfaces any object might implement
> +qom_ss.add(files(
> +  'fw_cfg_interface.c',
> +))
> +
>  qmp_ss.add(files('qom-qmp-cmds.c'))
>  softmmu_ss.add(files('qom-hmp-cmds.c'))
>  
> -- 
> 2.26.2
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


