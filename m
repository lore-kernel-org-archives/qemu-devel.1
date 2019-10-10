Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BD3C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 18:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4F7206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 18:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4F7206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIcv9-0000KD-2B
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 14:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iIcuQ-0008Fh-LI
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 14:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iIcuP-00054F-GC
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 14:11:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iIcuP-000534-AQ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 14:11:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8EA39801663
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 18:11:28 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48CF16061E;
 Thu, 10 Oct 2019 18:11:28 +0000 (UTC)
Subject: Re: [PATCH v3 3/3] qapi: Allow introspecting fix for savevm's
 cooperation with blockdev
To: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org
References: <cover.1570705279.git.pkrempa@redhat.com>
 <be94d24847d38cb5a1172ed22d0f86e7c0ec8562.1570705279.git.pkrempa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0785d26d-6495-3b23-40d7-a19bcd02181e@redhat.com>
Date: Thu, 10 Oct 2019 13:11:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <be94d24847d38cb5a1172ed22d0f86e7c0ec8562.1570705279.git.pkrempa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Thu, 10 Oct 2019 18:11:28 +0000 (UTC)
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 6:05 AM, Peter Krempa wrote:

In addition to Markus' review,

> 'savevm' was buggy as it considered all monitor-owned block device nodes
> for snapshot. With introduction of -blockdev the common usage made all

With the introduction of -blockdev, the common usage

> nodes including protocol and backing file nodes monitor-owned and thus

nodes be monitor-owned

> considered for snapshot.
> 
> This is a problem since the 'file' protocol nodes can't have internal
> snapshots and it does not make sense to take snapshot of nodes
> representing backing files.
> 
> This was fixed by commit 05f4aced658a02b02 clients need to be able to
> detect whether this fix is present.
> 
> Since savevm does not have an QMP alternative, add the feature for the
> 'human-monitor-command' backdoor which is used to call this command in
> modern use.
> 
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> ---
>   qapi/misc.json | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 6bd11f50e6..5d0070aa43 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -1020,6 +1020,12 @@
>   #
>   # @cpu-index: The CPU to use for commands that require an implicit CPU
>   #
> +# Features:
> +# @savevm-blockdev-monitor-nodes: If present, the HMP command savevm only
> +#                                 snapshots monitor-owned nodes if they have no
> +#                                 parents. This allows to use 'savevm' with
> +#                                 -blockdev. (since 4.2)

s/to use/the use of/

> +#
>   # Returns: the output of the command as a string
>   #
>   # Since: 0.14.0
> @@ -1047,7 +1053,8 @@
>   ##
>   { 'command': 'human-monitor-command',
>     'data': {'command-line': 'str', '*cpu-index': 'int'},
> -  'returns': 'str' }
> +  'returns': 'str',
> +  'features': [ 'savevm-blockdev-monitor-nodes' ] }
> 
>   ##
>   # @change:
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

