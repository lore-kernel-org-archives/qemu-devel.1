Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49377C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA6220771
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyYaM1hh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA6220771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI7uQ-00069x-BC
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kI7tj-0005eK-LY
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kI7tg-000831-Pz
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600164550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9uJgeK1G5r+bAUDlyBghUhSCfj7p0wyM9x67c8/gsOc=;
 b=VyYaM1hhsncsAe5gOXgxzhOcIG+48cwvAen8gRnqfDY5NWtTROwGrIc7CqxNbo/BpBb2x+
 hnY1CS+gy7yuWgZFQYhE/6sI6NTdombFLUUq4qGnTLPLQy93jkX2bRo02OsGvqSPOlrNPU
 hjzanBRbj8WbJ9T+6+4cKQB6jFeXa5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-cBdjY7ReNAaTNF-EhpysKA-1; Tue, 15 Sep 2020 06:09:07 -0400
X-MC-Unique: cBdjY7ReNAaTNF-EhpysKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0A2984639B;
 Tue, 15 Sep 2020 10:09:05 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-174.ams2.redhat.com [10.36.112.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3072A27BBC;
 Tue, 15 Sep 2020 10:09:03 +0000 (UTC)
Subject: Re: [PULL 4/4] qga: add command guest-get-devices for reporting
 VirtIO devices
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200914015902.25769-1-mdroth@linux.vnet.ibm.com>
 <20200914015902.25769-5-mdroth@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bc66d00e-387f-cf94-3a8f-6f9add337394@redhat.com>
Date: Tue, 15 Sep 2020 12:09:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200914015902.25769-5-mdroth@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:23:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>,
 =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/09/2020 03.59, Michael Roth wrote:
> From: Tomáš Golembiovský <tgolembi@redhat.com>
> 
> Add command for reporting devices on Windows guest. The intent is not so
> much to report the devices but more importantly the driver (and its
> version) that is assigned to the device. This gives caller the
> information whether VirtIO drivers are installed and/or whether
> inadequate driver is used on a device (e.g. QXL device with base VGA
> driver).
> 
> Example:
> [
>     {
>       "driver-date": "2019-08-12",
>       "driver-name": "Red Hat VirtIO SCSI controller",
>       "driver-version": "100.80.104.17300",
>       "address": {
>         "type": "pci",
>         "data": {
>           "device-id": 4162,
>           "vendor-id": 6900
>         }
>       }
>     },
>     ...
> ]
> 
> Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> *remove redundant glib autoptr declaration for GuestDeviceInfo
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  qga/commands-posix.c |   9 ++
>  qga/commands-win32.c | 210 ++++++++++++++++++++++++++++++++++++++++++-
>  qga/qapi-schema.json |  51 +++++++++++
>  3 files changed, 269 insertions(+), 1 deletion(-)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 744c2b5a5d..af5a58a9fd 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2822,6 +2822,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
>      blacklist = g_list_append(blacklist, g_strdup("guest-fstrim"));
>  #endif
>  
> +    blacklist = g_list_append(blacklist, g_strdup("guest-get-devices"));
> +
>      return blacklist;
>  }
>  
> @@ -3042,3 +3044,10 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
>  
>      return info;
>  }
> +
> +GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
> +{
> +    error_setg(errp, QERR_UNSUPPORTED);
> +
> +    return NULL;
> +}
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 15c9d7944b..48d8bbe649 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -21,10 +21,11 @@
>  #ifdef CONFIG_QGA_NTDDSCSI
>  #include <winioctl.h>
>  #include <ntddscsi.h>
> +#endif
>  #include <setupapi.h>
>  #include <cfgmgr32.h>
>  #include <initguid.h>
> -#endif
> +#include <devpropdef.h>
>  #include <lm.h>
>  #include <wtsapi32.h>
>  #include <wininet.h>
> @@ -39,6 +40,36 @@
>  #include "qemu/base64.h"
>  #include "commands-common.h"
>  
> +/*
> + * The following should be in devpkey.h, but it isn't. The key names were
> + * prefixed to avoid (future) name clashes. Once the definitions get into
> + * mingw the following lines can be removed.
> + */
> +DEFINE_DEVPROPKEY(qga_DEVPKEY_NAME, 0xb725f130, 0x47ef, 0x101a, 0xa5,
> +    0xf1, 0x02, 0x60, 0x8c, 0x9e, 0xeb, 0xac, 10);
> +    /* DEVPROP_TYPE_STRING */
> +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_HardwareIds, 0xa45c254e, 0xdf1c,
> +    0x4efd, 0x80, 0x20, 0x67, 0xd1, 0x46, 0xa8, 0x50, 0xe0, 3);
> +    /* DEVPROP_TYPE_STRING_LIST */
> +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverDate, 0xa8b865dd, 0x2e3d,
> +    0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 2);
> +    /* DEVPROP_TYPE_FILETIME */
> +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3d,
> +    0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 3);
> +    /* DEVPROP_TYPE_STRING */
> +/* The following shoud be in cfgmgr32.h, but it isn't */
> +#ifndef CM_Get_DevNode_Property
> +CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
> +    DEVINST          dnDevInst,
> +    CONST DEVPROPKEY * PropertyKey,
> +    DEVPROPTYPE      * PropertyType,
> +    PBYTE            PropertyBuffer,
> +    PULONG           PropertyBufferSize,
> +    ULONG            ulFlags
> +);
> +#define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW
> +#endif

 Hi!

This is causing a build failure with MSYS2:

https://cirrus-ci.com/task/6371116979585024?command=main#L4583

Any ideas how to fix it?

 Thomas


