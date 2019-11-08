Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFC8FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37C921848
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkIuxEKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37C921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT4Jm-0006xo-Qc
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 08:28:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iT4In-00068f-0x
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:27:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iT4Il-0000bO-N2
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:27:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43325
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iT4Il-0000bA-JL
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573219667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=On4KmYTZqusSvP3hteMekMGplZAc0MW1bhI59DoNIcI=;
 b=VkIuxEKGAqppO4BGiHstryYCIskXFKZPhQVfhMZp+kAS2gnhMn2GFdWIYJ/Jlg1p4kqxhN
 HBogqgYFKUiF4YHYjerSomlRgaRZvus9wVoizcpU4tfVEl7qCBq6BoXxRsA22Z4r4xJtZr
 1b61p7wY7A0q4bMONQpW7afu7QU3R9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-b2anekvsNGKKVs-C17refA-1; Fri, 08 Nov 2019 08:27:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9F301800D9C;
 Fri,  8 Nov 2019 13:27:42 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F79260856;
 Fri,  8 Nov 2019 13:27:28 +0000 (UTC)
Date: Fri, 8 Nov 2019 14:27:25 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 2/2] qapi: deprecate implicit filters
Message-ID: <20191108132725.GH9577@angien.pipo.sk>
References: <20191108101655.10611-1-vsementsov@virtuozzo.com>
 <20191108101655.10611-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20191108101655.10611-3-vsementsov@virtuozzo.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: b2anekvsNGKKVs-C17refA-1
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

On Fri, Nov 08, 2019 at 13:16:55 +0300, Vladimir Sementsov-Ogievskiy wrote:
> To get rid of implicit filters related workarounds in future let's
> deprecate them now.
>=20
> Deprecation warning breaks some bash iotests output, so fix it here
> too: in most of cases just add filter-node-name in test.
>=20
> In 161 add FIXME and deprecation warning into 161.out.
>=20
> In 249, the test case is changed, as we don't need to test "default"
> filter node name anymore.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qemu-deprecated.texi       |  6 ++++++
>  qapi/block-core.json       |  9 ++++++---
>  include/block/block_int.h  | 10 +++++++++-
>  blockdev.c                 | 10 ++++++++++
>  tests/qemu-iotests/094     |  1 +
>  tests/qemu-iotests/095     |  6 ++++--
>  tests/qemu-iotests/109     |  1 +
>  tests/qemu-iotests/127     |  1 +
>  tests/qemu-iotests/141     |  5 ++++-
>  tests/qemu-iotests/144     |  3 ++-
>  tests/qemu-iotests/156     |  1 +
>  tests/qemu-iotests/161     |  7 +++++++
>  tests/qemu-iotests/161.out |  1 +
>  tests/qemu-iotests/185     |  3 +++
>  tests/qemu-iotests/191     |  2 ++
>  tests/qemu-iotests/229     |  1 +
>  tests/qemu-iotests/247     |  8 +++++---
>  tests/qemu-iotests/249     |  5 +++--
>  tests/qemu-iotests/249.out |  2 +-
>  19 files changed, 68 insertions(+), 14 deletions(-)
>=20
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 296bfc93a3..c969faf55a 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -204,6 +204,12 @@ and accurate ``query-qmp-schema'' command.
>  Character devices creating sockets in client mode should not specify
>  the 'wait' field, which is only applicable to sockets in server mode
> =20
> +@subsection implicit filters in mirror and commit (since 4.2)
> +
> +Mirror and commit jobs insert filters, which becomes implicit if user
> +omitted @option(filter-node-name) parameter. So omitting it is deprecate=
d
> +in ``blockdev-mirror'', ``drive-mirror'' and ``block-commit'', set it al=
ways.
> +
>  @section Human Monitor Protocol (HMP) commands
> =20
>  @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (si=
nce 3.1)
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 93530d3a13..37caed775f 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1659,7 +1659,8 @@
>  # @filter-node-name: the node name that should be assigned to the
>  #                    filter driver that the commit job inserts into the =
graph
>  #                    above @top. If this option is not given, a node nam=
e is
> -#                    autogenerated. (Since: 2.9)
> +#                    autogenerated. Omitting this option is deprecated, =
it will
> +#                    be required in future. (Since: 2.9)
>  #
>  # @auto-finalize: When false, this job will wait in a PENDING state afte=
r it has
>  #                 finished its work, waiting for @block-job-finalize bef=
ore

Note that 'block-commit' and 'drive-mirror' commands are used by libvirt
in the pre-blockdev era. In those instances we gather statistics of
block devices by nesting in the output of query-blockstats and
query-block rather than selecting the appropriate info by any other
means (e.g. by node name).

This means that the output MUST stay consistend when block jobs are used
and the hack this patch is deprcating will break those.

Note that in libvirt we don't plan to invest time to add workarounds for
non-blockdev cases since blockdev by itself is complex enough and I'd
strongly prefer not having a third code path to care about.

Given that -blockdev can't be used in all cases (e.g. for sd-cards)
which also blocks deprecation of -drive I don't think that hiding of
implicit filter nodes can be deprecated until -drive is deprecated.


