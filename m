Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AAEC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95902078E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cg0MtUJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95902078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDU3I-0007lJ-Rm
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 10:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDU2K-0006wg-Bd
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:46:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22377
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDU2F-0003vB-Lm
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599058009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XGwkAR0IElB3MEYB7s4oSUMxgyVI7QkiqmTN+xWrzew=;
 b=cg0MtUJd8VSN3TDlP0aPWCCz6DRQNT5jSlCBTuDjmRyDzXzRRdiIH3wye3PgFUUMqfifAK
 OydP/0Xl/AYeqCKb9KX46xEjWJ+TJ4p+/Sv/BVLgU76oiv8OZjIWMa6wQg9SVNuUyOSQSh
 ES+MuBqCjeb+XmerwCNusL9T2VDlj2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-yx7x4-7aOLuayT8RugFsQQ-1; Wed, 02 Sep 2020 10:46:45 -0400
X-MC-Unique: yx7x4-7aOLuayT8RugFsQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03A97801AAE;
 Wed,  2 Sep 2020 14:46:44 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-129.ams2.redhat.com [10.36.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 204015D9D3;
 Wed,  2 Sep 2020 14:46:40 +0000 (UTC)
Subject: Re: [PULL 1/1] tricore: added triboard with tc27x_soc
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20200901095924.21738-1-kbastian@mail.uni-paderborn.de>
 <20200901095924.21738-2-kbastian@mail.uni-paderborn.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f5bbb1bb-0ab9-7bcd-3cca-3891ecaef812@redhat.com>
Date: Wed, 2 Sep 2020 16:46:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200901095924.21738-2-kbastian@mail.uni-paderborn.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: peter.maydell@linaro.org, Lars Biermanski <lars.biermanski@efs-auto.de>,
 Georg Hofstetter <georg.hofstetter@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.de>,
 Robert Rasche <robert.rasche@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi,

On 01/09/2020 11.59, Bastian Koppelmann wrote:
> From: Andreas Konopik <andreas.konopik@efs-auto.de>
> 
> Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
> Signed-off-by: David Brenken <david.brenken@efs-auto.de>
> Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
> Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
> Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>
> Message-Id: <20200622131934.10328-2-david.brenken@efs-auto.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> [BK: Fixed build system to use meson]
> ---
>  hw/tricore/Kconfig             |   8 ++
>  hw/tricore/meson.build         |   2 +
>  hw/tricore/tc27x_soc.c         | 246 +++++++++++++++++++++++++++++++++
>  hw/tricore/triboard.c          | 102 ++++++++++++++
>  include/hw/tricore/tc27x_soc.h | 139 +++++++++++++++++++
>  include/hw/tricore/triboard.h  |  53 +++++++
>  6 files changed, 550 insertions(+)
>  create mode 100644 hw/tricore/tc27x_soc.c
>  create mode 100644 hw/tricore/triboard.c
>  create mode 100644 include/hw/tricore/tc27x_soc.h
>  create mode 100644 include/hw/tricore/triboard.h
> 
> diff --git a/hw/tricore/Kconfig b/hw/tricore/Kconfig
> index 9313409309..44d3e906a1 100644
> --- a/hw/tricore/Kconfig
> +++ b/hw/tricore/Kconfig
> @@ -1,2 +1,10 @@
>  config TRICORE
>      bool
> +    select TRIBOARD
> +
> +config TRIBOARD
> +    bool
> +    select TC27X_SOC

I think it would be more common to do it the other way round: TRIBOARD
should select TRICORE, and then use "CONFIG_TRIBOARD=y" in the
default-configs/tricore-softmmu.mak file instead.
(We usually set CONFIG_SOMEBOARD=y in the default-configs/*.mak files,
and the boards then select the required components)

> +config TC27X_SOC
> +    bool
> diff --git a/hw/tricore/meson.build b/hw/tricore/meson.build
> index 579aa13c78..305f7f27db 100644
> --- a/hw/tricore/meson.build
> +++ b/hw/tricore/meson.build
> @@ -1,4 +1,6 @@
>  tricore_ss = ss.source_set()
>  tricore_ss.add(when: 'CONFIG_TRICORE', if_true: files('tricore_testboard.c'))
> +tricore_ss.add(when: 'CONFIG_TRICORE', if_true: files('tc27x_soc.c'))
> +tricore_ss.add(when: 'CONFIG_TRICORE', if_true: files('triboard.c'))

You should maybe rather use CONFIG_TRIBOARD and CONFIG_TC27X_SOC here
since you've also introduced these symbols in the Kconfig file.

 Thomas


