Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE563FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7914215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQdt8ef5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7914215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT4OZ-00030M-0z
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 08:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iT4Lo-0001Kd-3a
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iT4Lm-0002ZQ-Pa
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:30:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32945
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iT4Lm-0002Xa-ME
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573219853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ih7h0Teju2Z9JrIZgkx5Inl9dTjA0yUt/0cdZH0+kOk=;
 b=AQdt8ef5dN2NtT6Ymznn+7IrCew/aKcJphiaghxFcZsQgt5LslWTRokg6B2pXmdBlvsckm
 EXVgSkLhbehQuVC9FoxAZFC/5N8V25ZW/+bSdSOE4QSdoJADcUAxcw76lPcfa3QFUe6kJ0
 O69AfVl/onDc1u9xKVaqsutGukYy3tk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-iNGZIm-CPDq2qBjJHCSqJQ-1; Fri, 08 Nov 2019 08:30:45 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 418858017DD;
 Fri,  8 Nov 2019 13:30:44 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BBE85DA7E;
 Fri,  8 Nov 2019 13:30:30 +0000 (UTC)
Date: Fri, 8 Nov 2019 14:30:27 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 1/2] qapi: add filter-node-name option to drive-mirror
Message-ID: <20191108133027.GI9577@angien.pipo.sk>
References: <20191108101655.10611-1-vsementsov@virtuozzo.com>
 <20191108101655.10611-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20191108101655.10611-2-vsementsov@virtuozzo.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: iNGZIm-CPDq2qBjJHCSqJQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, mlevitsk@redhat.com, qemu-block@nongnu.org,
 libvir-list@redhat.com, jsnow@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, dinechin@redhat.com, den@openvz.org, mreitz@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 13:16:54 +0300, Vladimir Sementsov-Ogievskiy wrote:
> To correspond to blockdev-mirror command and make it possible to
> deprecate implicit filters in the next commit.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json | 7 +++++++
>  blockdev.c           | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index aa97ee2641..93530d3a13 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1992,6 +1992,12 @@
>  # @on-target-error: the action to take on an error on the target,
>  #                   default 'report' (no limitations, since this applies=
 to
>  #                   a different block device than @device).
> +#
> +# @filter-node-name: the node name that should be assigned to the
> +#                    filter driver that the mirror job inserts into the =
graph
> +#                    above @device. If this option is not given, a node =
name is
> +#                    autogenerated. (Since: 4.2)
> +#

Speaking for libvirt and based on what I've responded to patch 2 there's
no value in adding this parameter for libvirt's use.

This also kind of means that drive-mirror can be deprecated together
with deprecating -drive.


