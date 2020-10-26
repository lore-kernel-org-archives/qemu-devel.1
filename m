Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE25C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4136220720
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8JrvIC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4136220720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7nb-0007XN-6N
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kX7hM-0001dN-JE
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kX7hK-0005gl-07
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603738704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cv6+GnGSR0xf8Ou1arj+/0GS6C78MylhwBT0ZsywAD8=;
 b=P8JrvIC7N9ElQ6gv22r1Im3nO7oA3CDpiM9JaHYiKJecwPbC8or1aR9FMCy6qA47rBBPRk
 6AWqjUMK2Eg1DRhvz0GsoPmfaDjsRpaRW4hlBifZYa99VQzEoJJwFM2bDPFAi7a/CdZvaU
 /fdEvLJqon/7QuLFo7HufOKohd0avco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-ubTo4iA4OK630MjIYQ2tBg-1; Mon, 26 Oct 2020 14:58:22 -0400
X-MC-Unique: ubTo4iA4OK630MjIYQ2tBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E7DA186DD25;
 Mon, 26 Oct 2020 18:58:21 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A76E7366D;
 Mon, 26 Oct 2020 18:58:19 +0000 (UTC)
Subject: Re: [PATCH 12/15] s390: remove bios_name
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-13-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d6b02fc1-7582-2fae-31b5-b5a1f3aa9b13@redhat.com>
Date: Mon, 26 Oct 2020 19:58:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201026143028.3034018-13-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/2020 15.30, Paolo Bonzini wrote:
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/s390x/ipl.c             | 8 ++------
>  hw/s390x/s390-virtio-ccw.c | 3 ++-
>  2 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 3d2652d75a..61e8c967d3 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -128,11 +128,7 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
>      if (!ipl->kernel || ipl->enforce_bios) {
>          uint64_t fwbase = (MIN(ram_size, 0x80000000U) - 0x200000) & ~0xffffUL;
>  
> -        if (bios_name == NULL) {
> -            bios_name = ipl->firmware;
> -        }
> -
> -        bios_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +        bios_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, ipl->firmware);
>          if (bios_filename == NULL) {
>              error_setg(errp, "could not find stage1 bootloader");
>              return;
> @@ -154,7 +150,7 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
>          g_free(bios_filename);
>  
>          if (bios_size == -1) {
> -            error_setg(errp, "could not load bootloader '%s'", bios_name);
> +            error_setg(errp, "could not load bootloader '%s'", ipl->firmware);
>              return;
>          }
>  
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index e52182f946..a521eba673 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -258,7 +258,8 @@ static void ccw_init(MachineState *machine)
>      /* get a BUS */
>      css_bus = virtual_css_bus_init();
>      s390_init_ipl_dev(machine->kernel_filename, machine->kernel_cmdline,
> -                      machine->initrd_filename, "s390-ccw.img",
> +                      machine->initrd_filename,
> +                      machine->firmware ?: "s390-ccw.img",
>                        "s390-netboot.img", true);
>  
>      dev = qdev_new(TYPE_S390_PCI_HOST_BRIDGE);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


