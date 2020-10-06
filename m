Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DB0C47095
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C842080A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clzDDH11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C842080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPiLR-0000ry-Jl
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 04:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kPiKp-0000Ki-Db
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 04:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kPiKn-0001Aa-FQ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 04:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601972912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+DF/jcvVN/dTbVQOJC/V6E1VowJvWwnMrc6yIBNNZuk=;
 b=clzDDH11JPVi2dPU7+ljQ61XqwMGjo+CIHvDl8GnnXTKrofSI7Vvp9cVUoSSyCXk8FhPLY
 zPTnBuqGENyBX+HMzJcNdxtX0u2w5coQbqylCwrNLrDzesKJgp+CAyaYbz9VLR1l0cWUKf
 8e0r7FKLwyYD14PxaqYlgUKvYxHkcFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-1-QHBkCSOf29pmQYtNAl5w-1; Tue, 06 Oct 2020 04:28:30 -0400
X-MC-Unique: 1-QHBkCSOf29pmQYtNAl5w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 828988D9864;
 Tue,  6 Oct 2020 08:28:29 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-235.ams2.redhat.com
 [10.36.112.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B7141A8AC;
 Tue,  6 Oct 2020 08:28:24 +0000 (UTC)
Subject: Re: [RFC PATCH 1/3] qom: Always register
 FW_CFG_DATA_GENERATOR_INTERFACE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201005105442.2093105-1-philmd@redhat.com>
 <20201005105442.2093105-2-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ab0313b0-57e1-c6ab-0415-1d0c3bde05df@redhat.com>
Date: Tue, 6 Oct 2020 10:28:23 +0200
MIME-Version: 1.0
In-Reply-To: <20201005105442.2093105-2-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/05/20 12:54, Philippe Mathieu-Daudé wrote:
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
> could not be triggered at linktime,

O_o

I'll defer the review of this work to others with actual QOM knowledge.

Please ping me when the series is otherwise ready; I'll be happy to ACK
the fw_cfg parts (if any).

Laszlo

> and we don't have test
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
> 


