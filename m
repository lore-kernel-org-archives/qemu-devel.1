Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E59C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 441A22080A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeNG34rt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441A22080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVSs6-0002c5-1I
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVSqh-0001g5-DH
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVSqe-0002sK-3S
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603343351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IcCMixcWis1VXGRNU90DFifqiCp8+8m4kZnFdn0RwwA=;
 b=UeNG34rteY+rFIFI0u+LLoXimpDvDhg/EwoHN9/sKOzt10qDtHsBNevqX1i8P07bmlA5zs
 7wBli9GLUT6YUzXOXpX1X37UbKzXmdjqQ6kq+ie4j3ufG6c4nD8F1bGohta+uE9HVM3ZEL
 2CWlXSTV2KCQm2ueHKpCUor9lGczQEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-uTPHZKsdOsiSCZhUFoAlnw-1; Thu, 22 Oct 2020 01:09:08 -0400
X-MC-Unique: uTPHZKsdOsiSCZhUFoAlnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 008A18049F1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 05:09:08 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E12591002388;
 Thu, 22 Oct 2020 05:09:05 +0000 (UTC)
Subject: Re: [PATCH 02/22] machine: remove deprecated -machine
 enforce-config-section option
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201021205716.2359430-1-pbonzini@redhat.com>
 <20201021205716.2359430-3-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3d3e6f4d-c977-d691-295d-0928828e50b2@redhat.com>
Date: Thu, 22 Oct 2020 07:09:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201021205716.2359430-3-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:54:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: berrange@redhat.com, jsnow@redhat.com, ehabkost@redhat.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/2020 22.56, Paolo Bonzini wrote:
> Deprecated since 3.1 and complicates the initialization sequence,
> remove it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/system/deprecated.rst | 12 ++++++------
>  hw/core/machine.c          | 24 +-----------------------
>  include/hw/boards.h        |  1 -
>  migration/migration.c      | 10 ----------
>  qemu-options.hx            |  8 --------
>  5 files changed, 7 insertions(+), 48 deletions(-)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 895433c356..0ebce37a19 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -21,12 +21,6 @@ deprecated.
>  System emulator command line arguments
>  --------------------------------------
>  
> -``-machine enforce-config-section=on|off`` (since 3.1)
> -''''''''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -The ``enforce-config-section`` parameter is replaced by the
> -``-global migration.send-configuration={on|off}`` option.
> -
>  ``-usbdevice`` (since 2.10.0)
>  '''''''''''''''''''''''''''''
>  
> @@ -689,6 +683,12 @@ Support for invalid topologies is removed, the user must ensure
>  topologies described with -smp include all possible cpus, i.e.
>  *sockets* * *cores* * *threads* = *maxcpus*.
>  
> +``-machine enforce-config-section=on|off`` (removed 5.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``enforce-config-section`` property was replaced by the
> +``-global migration.send-configuration={on|off}`` option.
> +
>  Block devices
>  -------------
>  
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index d740a7e963..80a918895a 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -26,6 +26,7 @@
>  #include "sysemu/qtest.h"
>  #include "hw/pci/pci.h"
>  #include "hw/mem/nvdimm.h"
> +#include "migration/misc.h"

This new include does not make much sense to me, if all you did was removing
code from this file. Why did you add this here?

With this hunk removed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


