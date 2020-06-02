Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56065C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 01:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2730520885
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 01:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2730520885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfvKP-0004uc-Cx
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 21:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jfvJX-0004Q8-DM
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 21:01:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:1893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jfvJW-0002hu-38
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 21:01:59 -0400
IronPort-SDR: 9UDolDFOH6YIg7KoGFxaKMD5bZo0bfVS26MlB7CF95YkATwMBJIcyxeNCmDXaBl8HXvElhy2+k
 6TjiQGSGJ4qw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2020 18:01:50 -0700
IronPort-SDR: gAJgkDAlHhM2qR3iaiTDpbo5QxcUovA7XBZudgUQy7ciRbrS/X6ch7tSaHJ4E/CUSvn/ZzQxZ/
 DFVTe0UdEcZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; d="scan'208";a="347228235"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga001.jf.intel.com with ESMTP; 01 Jun 2020 18:01:50 -0700
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 1 Jun 2020 18:01:49 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 2 Jun 2020 09:01:47 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Tue, 2 Jun 2020 09:01:47 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/5] block/quorum.c: stable children names
Thread-Topic: [PATCH 1/5] block/quorum.c: stable children names
Thread-Index: AQHWJ4+IBcpD62T+0kGBJfRDfTvN1KjEozqA
Date: Tue, 2 Jun 2020 01:01:47 +0000
Message-ID: <3b36fa4bb2ec4e37a8245a278af8b480@intel.com>
References: <cover.1589199922.git.lukasstraub2@web.de>
 <9df6b3723ec30cb749ceaa555d82a29a6d79496d.1589199922.git.lukasstraub2@web.de>
In-Reply-To: <9df6b3723ec30cb749ceaa555d82a29a6d79496d.1589199922.git.lukasstraub2@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.120; envelope-from=chen.zhang@intel.com;
 helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 21:01:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Monday, May 11, 2020 8:27 PM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Alberto Garcia <berto@igalia.com>; Dr. David Alan Gilbert
> <dgilbert@redhat.com>; Zhang, Chen <chen.zhang@intel.com>
> Subject: [PATCH 1/5] block/quorum.c: stable children names
>=20
> If we remove the child with the highest index from the quorum, decrement
> s->next_child_index. This way we get stable children names as long as we
> only remove the last child.
>=20

Looks good for me, and it can solve this bug:
colo: Can not recover colo after svm failover twice
https://bugs.launchpad.net/bugs/1881231

Reviewed-by: Zhang Chen <chen.zhang@intel.com>

> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  block/quorum.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/quorum.c b/block/quorum.c index 6d7a56bd93..acfa09c2cc
> 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -29,6 +29,8 @@
>=20
>  #define HASH_LENGTH 32
>=20
> +#define INDEXSTR_LEN 32
> +
>  #define QUORUM_OPT_VOTE_THRESHOLD "vote-threshold"
>  #define QUORUM_OPT_BLKVERIFY      "blkverify"
>  #define QUORUM_OPT_REWRITE        "rewrite-corrupted"
> @@ -972,9 +974,9 @@ static int quorum_open(BlockDriverState *bs, QDict
> *options, int flags,
>      opened =3D g_new0(bool, s->num_children);
>=20
>      for (i =3D 0; i < s->num_children; i++) {
> -        char indexstr[32];
> -        ret =3D snprintf(indexstr, 32, "children.%d", i);
> -        assert(ret < 32);
> +        char indexstr[INDEXSTR_LEN];
> +        ret =3D snprintf(indexstr, INDEXSTR_LEN, "children.%d", i);
> +        assert(ret < INDEXSTR_LEN);
>=20
>          s->children[i] =3D bdrv_open_child(NULL, options, indexstr, bs,
>                                           &child_format, false, &local_er=
r); @@ -1026,7 +1028,7
> @@ static void quorum_add_child(BlockDriverState *bs, BlockDriverState
> *child_bs,  {
>      BDRVQuorumState *s =3D bs->opaque;
>      BdrvChild *child;
> -    char indexstr[32];
> +    char indexstr[INDEXSTR_LEN];
>      int ret;
>=20
>      if (s->is_blkverify) {
> @@ -1041,8 +1043,8 @@ static void quorum_add_child(BlockDriverState *bs,
> BlockDriverState *child_bs,
>          return;
>      }
>=20
> -    ret =3D snprintf(indexstr, 32, "children.%u", s->next_child_index);
> -    if (ret < 0 || ret >=3D 32) {
> +    ret =3D snprintf(indexstr, INDEXSTR_LEN, "children.%u", s-
> >next_child_index);
> +    if (ret < 0 || ret >=3D INDEXSTR_LEN) {
>          error_setg(errp, "cannot generate child name");
>          return;
>      }
> @@ -1069,6 +1071,7 @@ static void quorum_del_child(BlockDriverState *bs,
> BdrvChild *child,
>                               Error **errp)  {
>      BDRVQuorumState *s =3D bs->opaque;
> +    char indexstr[INDEXSTR_LEN];
>      int i;
>=20
>      for (i =3D 0; i < s->num_children; i++) { @@ -1090,6 +1093,11 @@ sta=
tic void
> quorum_del_child(BlockDriverState *bs, BdrvChild *child,
>      /* We know now that num_children > threshold, so blkverify must be
> false */
>      assert(!s->is_blkverify);
>=20
> +    snprintf(indexstr, INDEXSTR_LEN, "children.%u", s->next_child_index =
- 1);
> +    if (!strncmp(child->name, indexstr, INDEXSTR_LEN)) {
> +        s->next_child_index--;
> +    }
> +
>      bdrv_drained_begin(bs);
>=20
>      /* We can safely remove this child now */
> --
> 2.20.1


