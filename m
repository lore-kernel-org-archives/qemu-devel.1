Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF185C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBEDA2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyIFuwcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEDA2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdYAq-0007mr-03
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 07:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jdY9n-0006Fa-RC
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:54:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56734
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jdY9m-00052M-AG
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590494045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWI8HOoRT0kkH9S15DlMLyAx9ROIun3St1KcaGOo6NE=;
 b=JyIFuwcWRJXSxsY2frQ0g7Obvruo8UVYO+GThQEADtO6Fycpn2hZOtehifdR5XWqzioINy
 oOaZCES+SH4423WTYmHXA5WVsfHSjBSuh4OH7p21KTniYM/IOTTShNgZUDC0ruGVGvoNGs
 hHMC8wzVGw+IWeRRhxgshVi4ShUU1CQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-xsjEymAyPiWqUAykmJeZZg-1; Tue, 26 May 2020 07:54:03 -0400
X-MC-Unique: xsjEymAyPiWqUAykmJeZZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D30D460;
 Tue, 26 May 2020 11:54:01 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2137649D5;
 Tue, 26 May 2020 11:53:55 +0000 (UTC)
Date: Tue, 26 May 2020 13:53:53 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 10/14] hw/mips/fuloong2e: Fix typo in Fuloong machine name
Message-ID: <20200526115353.GN2995787@angien.pipo.sk>
References: <20200526104726.11273-1-f4bug@amsat.org>
 <20200526104726.11273-11-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200526104726.11273-11-f4bug@amsat.org>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 00:48:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 26, 2020 at 12:47:22 +0200, Philippe Mathieu-Daudé wrote:
> We always miswrote the Fuloong machine... Fix its name.
> Add an machine alias to the previous name for backward
> compatibility.
> 
> Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Message-id: <20200510210128.18343-5-f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---

[...]

> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 3142fac386..f0061f94aa 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -368,6 +368,11 @@ mips ``r4k`` platform (since 5.0)
>  This machine type is very old and unmaintained. Users should use the ``malta``
>  machine type instead.
>  
> +mips ``fulong2e`` machine (since 5.1)
> +'''''''''''''''''''''''''''''''''''''
> +
> +This machine has been renamed ``fuloong2e``.
> +

Libvirt doesn't have any special handling for this machine so this
shouldn't impact us.


