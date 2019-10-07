Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F55C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 07:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40CE21655
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 07:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40CE21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHNqq-0005N1-Tx
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 03:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iHNqD-0004rI-9j
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 03:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iHNqC-0004MA-9E
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 03:54:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39326)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iHNq9-0004Hk-W0; Mon, 07 Oct 2019 03:53:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF92130842A8;
 Mon,  7 Oct 2019 07:53:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B3F360A35;
 Mon,  7 Oct 2019 07:53:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 873541138648; Mon,  7 Oct 2019 09:53:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 07/11] block: add x-blockdev-amend qmp
 command
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-8-mlevitsk@redhat.com>
Date: Mon, 07 Oct 2019 09:53:50 +0200
In-Reply-To: <20190912223028.18496-8-mlevitsk@redhat.com> (Maxim Levitsky's
 message of "Fri, 13 Sep 2019 01:30:24 +0300")
Message-ID: <87eezpj8j5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 07 Oct 2019 07:53:57 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maxim Levitsky <mlevitsk@redhat.com> writes:

> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
[...]
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index e6edd641f1..7900914506 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4650,6 +4650,32 @@
>    'data': { 'job-id': 'str',
>              'options': 'BlockdevCreateOptions' } }
>  
> +##
> +# @x-blockdev-amend:
> +#
> +# Starts a job to amend format specific options of an existing open block device.
> +# The job is automatically finalized, but a manual job-dismiss is required.
> +#
> +# @job-id:          Identifier for the newly created job.
> +#
> +# @node-name:       Name of the block node to work on
> +#
> +# @options:         Options (same as for image creation)
> +#
> +# @force:           Allow unsafe operations, format specific
> +#                   For luks that allows erase of the last active keyslot
> +#                   (permanent loss of data),
> +#                   and replacement of an active keyslot
> +#                   (possible loss of data if IO error happens)
> +#
> +# Since: 4.2
> +##
> +{ 'command': 'x-blockdev-amend',
> +  'data': { 'job-id': 'str',
> +            'node-name': 'str',
> +            'options': 'BlockdevCreateOptions',
> +            '*force': 'bool' } }
> +
>  ##
>  # @blockdev-open-tray:
>  #
> diff --git a/qapi/job.json b/qapi/job.json
> index a121b615fb..342d29a7aa 100644
> --- a/qapi/job.json
> +++ b/qapi/job.json
> @@ -19,10 +19,12 @@
>  #
>  # @create: image creation job type, see "blockdev-create" (since 3.0)
>  #
> +# @amend: image options amend job type, see "x-blockdev-amend" (since 4.2)
> +#
>  # Since: 1.7
>  ##
>  { 'enum': 'JobType',
> -  'data': ['commit', 'stream', 'mirror', 'backup', 'create'] }
> +  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend'] }
>  
>  ##
>  # @JobStatus:

Aha, you introduce "amend" after using the concept in PATCH 02.
Rather confusing, I'm afraid.

I guess secret deletion makes sense with amend somehow, and only with
amend.  If yes, the QAPI documentaion should spell that out, and the
code should diagnose invalid use (maybe it does already; I haven't
looked at it).

