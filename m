Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3619C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB59206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNV8LX/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB59206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfgru-0003gg-UJ
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 05:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfgrG-0003BQ-MG
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 05:35:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41447
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfgrF-00078c-97
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 05:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591004147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CtRe7JqBaNd3Ht3Qr5uxXiDTrRL/AI6jyVQFWO/kqhk=;
 b=eNV8LX/EXvPBVGQewejiS6p5/GU+HLt/w/1G5na7bIAt6uKYRzxl98ioL6Oou678FNCLzL
 jtO1eA5Av3ATf7A53zdAMYX7zjmuvo7DmoCNi3kJhDTOrTGpN0kBxtNvIFN4SxJeEsfVNd
 s+DerVGK2nNxb9Dae7xK/0yTVf5JVmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-SNhj150DN7mvikHMHZIj7Q-1; Mon, 01 Jun 2020 05:35:44 -0400
X-MC-Unique: SNhj150DN7mvikHMHZIj7Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 777DB108594D;
 Mon,  1 Jun 2020 09:35:43 +0000 (UTC)
Received: from work-vm (ovpn-113-144.ams2.redhat.com [10.36.113.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A8795D9C9;
 Mon,  1 Jun 2020 09:35:42 +0000 (UTC)
Date: Mon, 1 Jun 2020 10:35:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH] migration/vmstate: Remove unnecessary MemoryRegion
 forward declaration
Message-ID: <20200601093539.GD2743@work-vm>
References: <20200530165512.15225-1-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200530165512.15225-1-f4bug@amsat.org>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 05:35:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daudé (f4bug@amsat.org) wrote:
> "migration/vmstate.h" only uses pointer to MemoryRegion, which
> is already forward declared in "qemu/typedefs.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> CI: https://travis-ci.org/github/philmd/qemu/builds/692879495
> ---
>  include/migration/vmstate.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 30667631bc..eafa39f560 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1199,7 +1199,6 @@ static inline int vmstate_register(VMStateIf *obj, int instance_id,
>  void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
>                          void *opaque);
>  
> -struct MemoryRegion;
>  void vmstate_register_ram(struct MemoryRegion *memory, DeviceState *dev);
>  void vmstate_unregister_ram(struct MemoryRegion *memory, DeviceState *dev);
>  void vmstate_register_ram_global(struct MemoryRegion *memory);

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

and queued.

> -- 
> 2.21.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


