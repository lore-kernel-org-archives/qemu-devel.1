Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAA2C73C68
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 04:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B69120645
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 04:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B69120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl43L-0003hG-Ni
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 00:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57409)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hl418-0002zX-6V
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 00:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hl417-00061F-8r
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 00:15:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51716)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hl413-0005uG-Go; Wed, 10 Jul 2019 00:15:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8CE9D8535C;
 Wed, 10 Jul 2019 04:15:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCE425FCA7;
 Wed, 10 Jul 2019 04:15:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4A6301138648; Wed, 10 Jul 2019 06:15:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
References: <20190709232550.10724-1-jsnow@redhat.com>
 <20190709232550.10724-5-jsnow@redhat.com>
Date: Wed, 10 Jul 2019 06:15:30 +0200
In-Reply-To: <20190709232550.10724-5-jsnow@redhat.com> (John Snow's message of
 "Tue, 9 Jul 2019 19:25:36 -0400")
Message-ID: <875zoay17h.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 10 Jul 2019 04:15:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 04/18] qapi: add BitmapSyncMode enum
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> Depending on what a user is trying to accomplish, there might be a few
> bitmap cleanup actions that occur when an operation is finished that
> could be useful.
>
> I am proposing three:
> - NEVER: The bitmap is never synchronized against what was copied.
> - ALWAYS: The bitmap is always synchronized, even on failures.
> - ON-SUCCESS: The bitmap is synchronized only on success.
>
> The existing incremental backup modes use 'on-success' semantics,
> so add just that one for right now.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/block-core.json | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0af3866015..0c853d00bd 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1134,6 +1134,20 @@
>  { 'enum': 'MirrorSyncMode',
>    'data': ['top', 'full', 'none', 'incremental'] }
>  
> +##
> +# @BitmapSyncMode:
> +#
> +# An enumeration of possible behaviors for the synchronization of a bitmap
> +# when used for data copy operations.
> +#
> +# @on-success: The bitmap is only synced when the operation is successful.
> +#              This is the behavior always used for 'INCREMENTAL' backups.
> +#
> +# Since: 4.2
> +##
> +{ 'enum': 'BitmapSyncMode',
> +  'data': ['on-success'] }
> +
>  ##
>  # @MirrorCopyMode:
>  #

Reviewed-by: Markus Armbruster <armbru@redhat.com>

