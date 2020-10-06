Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093BAC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B522075A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S96gJVNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B522075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmX3-0003pe-Cd
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kPmVN-0002F3-KJ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kPmVK-0001l3-OM
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601988941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ef2ir++f+p60tz8Cj7gIk5rwFAfwqgl0RSN5t2mG4mo=;
 b=S96gJVNkKJANdKSKNpbRzVdnac3Luos0fotn9Fn0OBgrJPTzI5wBU8PUwYvAX0zvO50YiA
 oExUfSjYoomt36njDMbxDOVo3QtIKIH5N7H8DapqQL7lpXwDjFNEhWYr8GM4OoTsPxU+xU
 cCF4JukHtAVR0qXJGgjMzRWLrEmNQ7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-eU54DPo4OwOmLXCOsQDCXw-1; Tue, 06 Oct 2020 08:55:40 -0400
X-MC-Unique: eU54DPo4OwOmLXCOsQDCXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3573956BE4;
 Tue,  6 Oct 2020 12:55:39 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-235.ams2.redhat.com
 [10.36.112.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70A31100164C;
 Tue,  6 Oct 2020 12:55:33 +0000 (UTC)
Subject: Re: [PATCH v2 1/1] hw/nvram: Always register
 FW_CFG_DATA_GENERATOR_INTERFACE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
References: <20201006111909.2302081-1-philmd@redhat.com>
 <20201006111909.2302081-2-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <218dedba-ccec-8d7f-5697-a9634c362ea4@redhat.com>
Date: Tue, 6 Oct 2020 14:55:32 +0200
MIME-Version: 1.0
In-Reply-To: <20201006111909.2302081-2-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/06/20 13:19, Philippe Mathieu-Daudé wrote:
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
>  hw/nvram/fw_cfg-interface.c | 15 +++++++++++++++
>  hw/nvram/fw_cfg.c           |  7 -------
>  MAINTAINERS                 |  2 +-
>  hw/nvram/meson.build        |  3 +++
>  4 files changed, 19 insertions(+), 8 deletions(-)
>  create mode 100644 hw/nvram/fw_cfg-interface.c
> 
> diff --git a/hw/nvram/fw_cfg-interface.c b/hw/nvram/fw_cfg-interface.c
> new file mode 100644
> index 0000000000..2b19502ffe
> --- /dev/null
> +++ b/hw/nvram/fw_cfg-interface.c
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

Can you rename *this* instance of "fw_cfg_register_types" to
"fw_cfg_register_interfaces"?

While the code is correct from the C lang perspective, duplicate
function names are not convenient when debugging with gdb, or when
jumping to tags in an editor.

With the rename:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

(If you strongly disagree, I'm OK to R-b v2 as well.)

Thanks,
Laszlo

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
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b76fb31861..a45d908ebd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2054,7 +2054,7 @@ R: Laszlo Ersek <lersek@redhat.com>
>  R: Gerd Hoffmann <kraxel@redhat.com>
>  S: Supported
>  F: docs/specs/fw_cfg.txt
> -F: hw/nvram/fw_cfg.c
> +F: hw/nvram/fw_cfg*.c
>  F: stubs/fw_cfg.c
>  F: include/hw/nvram/fw_cfg.h
>  F: include/standard-headers/linux/qemu_fw_cfg.h
> diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
> index 1f2ed013b2..fd2951a860 100644
> --- a/hw/nvram/meson.build
> +++ b/hw/nvram/meson.build
> @@ -1,3 +1,6 @@
> +# QOM interfaces must be available anytime QOM is used.
> +qom_ss.add(files('fw_cfg-interface.c'))
> +
>  softmmu_ss.add(files('fw_cfg.c'))
>  softmmu_ss.add(when: 'CONFIG_CHRP_NVRAM', if_true: files('chrp_nvram.c'))
>  softmmu_ss.add(when: 'CONFIG_DS1225Y', if_true: files('ds1225y.c'))
> 


