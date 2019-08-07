Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5853EC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9A521E6A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9A521E6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvIhx-0007dH-8s
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35031)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvIhU-0006og-EA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvIhS-0001vY-UR
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:57:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvIhS-0001uh-OB
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:57:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so90699461wrr.5
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 02:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SkjlOS+5Tmipfs2Y68D/QpMG+qMbkym2ivroHf3Mhx8=;
 b=Tgc27ITDH+CThZ/BGImx4OSNr95z0coaqrhe58JvpSJgDF01k5g0PbEJeDlApjJoVM
 FAWNbn9Z6ruVYw5uxwiuqA5m50TPYVHNswF01DgtqKnZqBGvmGPJxUNlkoseURg8Rwwv
 W08W4gUAr5ZtFp8ZsiWRW7E3vWH0shqJpZ2RJEIRKFTjBg0zK2suIgGZo7E7jiHewZjn
 XRFeLs36A9SJ8uB8ypDsEXscFZL1NZGHQ43HpxkmV4yJwznUUW+9+K2zdltdCENs2ijT
 3l4/E3XVawscv/4ysC7kD9+YEQmR3pElEbzywvK35uT2uijEpWkDRJlGZjGEZU38QrEo
 V3VA==
X-Gm-Message-State: APjAAAV6JshWM9GRapKMEVApIkIBTabBUF56NLuvg8SKQ917Mnp9uvi+
 QV8UXv9xVRIHrJuEwPyY//5LBRlOTQs=
X-Google-Smtp-Source: APXvYqyRWeNcDcGgkm39ikiu1pm6LspCm9c1QTcsAv5af7vA7WWHdjXdRX2ZiWkXJGdzw2NAKKqnkw==
X-Received: by 2002:adf:f104:: with SMTP id r4mr10169719wro.140.1565171861220; 
 Wed, 07 Aug 2019 02:57:41 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id d65sm2050143wmc.2.2019.08.07.02.57.40
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 02:57:40 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2722c486-6e92-13ae-a56b-32228a7e3cc3@redhat.com>
Date: Wed, 7 Aug 2019 11:57:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806151435.10740-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 03/29] qapi: Split error.json off
 common.json
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

On 8/6/19 5:14 PM, Markus Armbruster wrote:
> In my "build everything" tree, changing a type in qapi/common.json
> triggers a recompile of some 3600 out of 6600 objects (not counting
> tests and objects that don't depend on qemu/osdep.h).
> 
> One common dependency is QapiErrorClass: it's used only in in
> qapi/error.h, which uses nothing else, and is widely included.
> 
> Move QapiErrorClass from common.json to new error.json.  Touching
> common.json now recompiles only some 2900 objects.

Nice.

> 
> Cc: Eric Blake <eblake@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  MAINTAINERS           |  2 ++
>  include/qapi/error.h  |  2 +-
>  qapi/Makefile.objs    |  2 +-
>  qapi/common.json      | 24 ------------------------
>  qapi/error.json       | 29 +++++++++++++++++++++++++++++
>  qapi/qapi-schema.json |  1 +
>  6 files changed, 34 insertions(+), 26 deletions(-)
>  create mode 100644 qapi/error.json
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6de200453..adc64cfe33 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1874,6 +1874,7 @@ M: Markus Armbruster <armbru@redhat.com>
>  S: Supported
>  F: include/qapi/error.h
>  F: include/qemu/error-report.h
> +F: qapi/error.json
>  F: util/error.c
>  F: util/qemu-error.c
>  
> @@ -2062,6 +2063,7 @@ F: monitor/monitor-internal.h
>  F: monitor/qmp*
>  F: monitor/misc.c
>  F: monitor/monitor.c
> +F: qapi/error.json
>  F: docs/devel/*qmp-*
>  F: docs/interop/*qmp-*
>  F: scripts/qmp/
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 51b63dd4b5..3f95141a01 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -119,7 +119,7 @@
>  #ifndef ERROR_H
>  #define ERROR_H
>  
> -#include "qapi/qapi-types-common.h"
> +#include "qapi/qapi-types-error.h"
>  
>  /*
>   * Overall category of an error.
> diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
> index c5a29e86e2..dd3f5e6f94 100644
> --- a/qapi/Makefile.objs
> +++ b/qapi/Makefile.objs
> @@ -6,7 +6,7 @@ util-obj-y += qmp-event.o
>  util-obj-y += qapi-util.o
>  
>  QAPI_COMMON_MODULES = audio authz block-core block char common crypto
> -QAPI_COMMON_MODULES += dump introspect job machine migration misc net
> +QAPI_COMMON_MODULES += dump error introspect job machine migration misc net
>  QAPI_COMMON_MODULES += qdev qom rdma rocker run-state sockets tpm
>  QAPI_COMMON_MODULES += trace transaction ui
>  QAPI_TARGET_MODULES = machine-target misc-target
> diff --git a/qapi/common.json b/qapi/common.json
> index 99d313ef3b..3d4e8de1e0 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -4,30 +4,6 @@
>  # = Common data types
>  ##
>  
> -##
> -# @QapiErrorClass:
> -#
> -# QEMU error classes
> -#
> -# @GenericError: this is used for errors that don't require a specific error
> -#                class. This should be the default case for most errors
> -#
> -# @CommandNotFound: the requested command has not been found
> -#
> -# @DeviceNotActive: a device has failed to be become active
> -#
> -# @DeviceNotFound: the requested device has not been found
> -#
> -# @KVMMissingCap: the requested operation can't be fulfilled because a
> -#                 required KVM capability is missing
> -#
> -# Since: 1.2
> -##
> -{ 'enum': 'QapiErrorClass',
> -  # Keep this in sync with ErrorClass in error.h
> -  'data': [ 'GenericError', 'CommandNotFound',
> -            'DeviceNotActive', 'DeviceNotFound', 'KVMMissingCap' ] }
> -
>  ##
>  # @IoOperationType:
>  #
> diff --git a/qapi/error.json b/qapi/error.json
> new file mode 100644
> index 0000000000..3fad08f506
> --- /dev/null
> +++ b/qapi/error.json
> @@ -0,0 +1,29 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# = QMP errors
> +##
> +
> +##
> +# @QapiErrorClass:
> +#
> +# QEMU error classes
> +#
> +# @GenericError: this is used for errors that don't require a specific error
> +#                class. This should be the default case for most errors
> +#
> +# @CommandNotFound: the requested command has not been found
> +#
> +# @DeviceNotActive: a device has failed to be become active
> +#
> +# @DeviceNotFound: the requested device has not been found
> +#
> +# @KVMMissingCap: the requested operation can't be fulfilled because a
> +#                 required KVM capability is missing
> +#
> +# Since: 1.2
> +##
> +{ 'enum': 'QapiErrorClass',
> +  # Keep this in sync with ErrorClass in error.h
> +  'data': [ 'GenericError', 'CommandNotFound',
> +            'DeviceNotActive', 'DeviceNotFound', 'KVMMissingCap' ] }
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 38af54d6b3..920b03b0aa 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -80,6 +80,7 @@
>  # stable order, it's best to include each sub-schema just once, or
>  # include it first right here.
>  
> +{ 'include': 'error.json' }
>  { 'include': 'common.json' }
>  { 'include': 'sockets.json' }
>  { 'include': 'run-state.json' }
> 

