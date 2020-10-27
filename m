Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1135C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:04:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4DB21707
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/BSuLxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4DB21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQWO-0007Ny-U9
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kXPri-0007Vb-3g
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kXPrg-0008Gk-2R
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603808539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ee7RlBNWs1TckGUa/s6mqVumHnGkzplnltpBY2y5Dbo=;
 b=W/BSuLxG2eOyhAv5MYI9Rpo9RihR8N2CbT1/kPClNdMt3L9M0pfaqNmDa65ah6pvMIJ0Bi
 DTzTfA2kRG2QjbnNfrYQHoVxxBupu8O1A5/5rVkcF7spxwckM0+cAmsqUxTYo+IAR8G5uF
 N6E9BMB4nOoeAvY3NlBnQYpk6rkoF80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-GGujqgNOOWWj7mleg2gUIw-1; Tue, 27 Oct 2020 10:22:17 -0400
X-MC-Unique: GGujqgNOOWWj7mleg2gUIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BD3F107465E
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 14:22:16 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-115-35.ams2.redhat.com [10.36.115.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C68E6EF45;
 Tue, 27 Oct 2020 14:22:15 +0000 (UTC)
Subject: Re: [PATCH 15/15] vl: remove bios_name
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-16-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4e90510f-450f-6d5d-2484-d3e14448ad42@redhat.com>
Date: Tue, 27 Oct 2020 15:22:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201026143028.3034018-16-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/2020 15.30, Paolo Bonzini wrote:
> bios_name was a legacy variable used by machine code, but it is
> no more.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/sysemu/sysemu.h | 1 -
>  softmmu/vl.c            | 2 --
>  2 files changed, 3 deletions(-)
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 817ff4cf75..1336b4264a 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -8,7 +8,6 @@
>  
>  /* vl.c */
>  
> -extern const char *bios_name;
>  extern int only_migratable;
>  extern const char *qemu_name;
>  extern QemuUUID qemu_uuid;
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index b7d7f43c88..7909709879 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -119,7 +119,6 @@
>  
>  static const char *data_dir[16];
>  static int data_dir_idx;
> -const char *bios_name = NULL;
>  enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
>  int display_opengl;
>  const char* keyboard_layout = NULL;
> @@ -4205,7 +4204,6 @@ void qemu_init(int argc, char **argv, char **envp)
>      kernel_filename = qemu_opt_get(machine_opts, "kernel");
>      initrd_filename = qemu_opt_get(machine_opts, "initrd");
>      kernel_cmdline = qemu_opt_get(machine_opts, "append");
> -    bios_name = qemu_opt_get(machine_opts, "firmware");
>  
>      opts = qemu_opts_find(qemu_find_opts("boot-opts"), NULL);
>      if (opts) {
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


