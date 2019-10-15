Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA356ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB79521848
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB79521848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKNMv-0004j9-Lv
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 10:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iKNM2-0004D2-Dt
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 09:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iKNM1-0005iO-Dr
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 09:59:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49384)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iKNLx-0005hY-9a; Tue, 15 Oct 2019 09:59:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 80649315C030;
 Tue, 15 Oct 2019 13:59:07 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3649A60C5D;
 Tue, 15 Oct 2019 13:59:06 +0000 (UTC)
Subject: Re: [PATCH] doc: Describe missing generic -blockdev options
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191015123854.12039-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <fbbf6bad-4434-4150-1053-a1b790d71a3c@redhat.com>
Date: Tue, 15 Oct 2019 08:59:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191015123854.12039-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 15 Oct 2019 13:59:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/19 7:38 AM, Kevin Wolf wrote:
> We added more generic options after introducing -blockdev and forgot to
> update the documentation (man page and --help output) accordingly. Do
> that now.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qemu-options.hx | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 

> @@ -885,6 +886,22 @@ name is not intended to be predictable and changes between QEMU invocations.
>   For the top level, an explicit node name must be specified.
>   @item read-only
>   Open the node read-only. Guest write attempts will fail.
> +
> +Note that some block drivers support only read-only access, either generally or
> +in certain configurations. In this case, the default value
> +@option{read-only=off} does not work and the option must be specified
> +explicitly.
> +@item auto-read-only
> +If @option{auto-read-only=on} is set, QEMU is allowed not to open the image
> +read-write even if @option{read-only=off} is requested, but fall back to
> +read-only instead (and switch between the modes later), e.g. depending on
> +whether the image file is writable or whether a writing user is attached to the
> +node.

Hard to read.  Maybe:

If @option{auto-read-only=on} is set, QEMU may fall back to read-only 
usage even when @option{read-only=off} is requested, or even switch 
between modes as needed, e.g. depending on whether the image file is 
writable or whether a writing user is attached to the node.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

