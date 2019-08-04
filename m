Return-Path: <SRS0=5wN1=WA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A541C433FF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 02:00:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0408521655
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 02:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0408521655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hu5p2-0003yO-0w
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 22:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34155)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <claudio.fontana@suse.com>) id 1hu5of-0003TU-17
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 22:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <claudio.fontana@suse.com>) id 1hu5od-0003Lp-6e
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 22:00:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:49118 helo=mx1.suse.de)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <claudio.fontana@suse.com>)
 id 1hu5od-0003Jk-0M
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 22:00:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A34BBAF57;
 Sun,  4 Aug 2019 02:00:03 +0000 (UTC)
To: Jan Kiszka <jan.kiszka@web.de>
References: <99c1a7bd-1876-66a2-4b8e-d5bc86116fe7@web.de>
From: Claudio Fontana <claudio.fontana@suse.com>
Message-ID: <ce18dea4-8c8d-c278-4510-459cd1916912@suse.de>
Date: Sun, 4 Aug 2019 04:00:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <99c1a7bd-1876-66a2-4b8e-d5bc86116fe7@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 195.135.220.15
Subject: Re: [Qemu-devel] [PATCH v2] ivshmem-server: Terminate also on SIGINT
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/3/19 3:22 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Allows to shutdown a foreground session via ctrl-c.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes in v2:
>  - adjust error message
> 
>  contrib/ivshmem-server/main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/ivshmem-server/main.c b/contrib/ivshmem-server/main.c
> index 197c79c57e..e4cd35f74c 100644
> --- a/contrib/ivshmem-server/main.c
> +++ b/contrib/ivshmem-server/main.c
> @@ -223,8 +223,9 @@ main(int argc, char *argv[])
>      sa_quit.sa_handler = ivshmem_server_quit_cb;
>      sa_quit.sa_flags = 0;
>      if (sigemptyset(&sa_quit.sa_mask) == -1 ||
> -        sigaction(SIGTERM, &sa_quit, 0) == -1) {
> -        perror("failed to add SIGTERM handler; sigaction");
> +        sigaction(SIGTERM, &sa_quit, 0) == -1 ||
> +        sigaction(SIGINT, &sa_quit, 0) == -1) {
> +        perror("failed to add signal handler; sigaction");
>          goto err;
>      }
> 
> --
> 2.16.4
> 
> 
Reviewed-by: Claudio Fontana <claudio.fontana@suse.com>

