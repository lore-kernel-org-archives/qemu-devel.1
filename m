Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A034C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5DD721897
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DD721897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5CfC-0003P7-4V
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 13:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i5CeN-0002xD-5r
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i5CeL-0006aT-T4
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:31:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i5CeL-0006a0-N6
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:31:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 308854ACA5
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 17:31:25 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F12260C18;
 Tue,  3 Sep 2019 17:31:14 +0000 (UTC)
Date: Tue, 3 Sep 2019 18:31:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190903173112.GU2744@work-vm>
References: <20190827095437.18819-1-stefanha@redhat.com>
 <20190827095437.18819-5-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827095437.18819-5-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 03 Sep 2019 17:31:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/4] virtiofsd: add vhost-user.json file
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
Cc: virtio-fs@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> Install a vhost-user.json file describing virtiofsd.  This allows
> libvirt and other management tools to enumerate vhost-user backend
> programs.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  Makefile                                    | 1 +
>  .gitignore                                  | 1 +
>  contrib/virtiofsd/50-qemu-virtiofsd.json.in | 5 +++++
>  3 files changed, 7 insertions(+)
>  create mode 100644 contrib/virtiofsd/50-qemu-virtiofsd.json.in
> 
> diff --git a/Makefile b/Makefile
> index ef6eca07cc..c6e2f4e7a0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -318,6 +318,7 @@ HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = qemu-bridge-helper$(EXE
>  
>  ifdef CONFIG_LINUX
>  HELPERS-y += virtiofsd$(EXESUF)
> +vhost-user-json-y += contrib/virtiofsd/50-qemu-virtiofsd.json
>  
>  ifdef CONFIG_VIRGL
>  ifdef CONFIG_GBM
> diff --git a/.gitignore b/.gitignore
> index fd6e6c38c7..554c7abe81 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -6,6 +6,7 @@
>  /config-target.*
>  /config.status
>  /config-temp
> +/contrib/virtiofsd/50-qemu-virtiofsd.json
>  /elf2dmp
>  /trace-events-all
>  /trace/generated-events.h
> diff --git a/contrib/virtiofsd/50-qemu-virtiofsd.json.in b/contrib/virtiofsd/50-qemu-virtiofsd.json.in
> new file mode 100644
> index 0000000000..9bcd86f8dc
> --- /dev/null
> +++ b/contrib/virtiofsd/50-qemu-virtiofsd.json.in
> @@ -0,0 +1,5 @@
> +{
> +  "description": "QEMU virtiofsd vhost-user-fs",
> +  "type": "fs",
> +  "binary": "@libexecdir@/virtiofsd"
> +}
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

