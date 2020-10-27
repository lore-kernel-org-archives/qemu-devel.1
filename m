Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F0BC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E722076D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGXF8EcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E722076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOZj-0007lj-CR
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1kXOEK-0000W2-5y
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 08:37:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1kXOEI-0006J3-KS
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 08:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603802251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I4CQ/gRqaHWS9w1ZgjL38Gbe34d2H44d5ANCaz+72sk=;
 b=GGXF8EcZe2QI1ZVBK3QyOUMIJ6K84U3H2v9x6RxNrhucuMXhZnj8t1pIMVsi0HvlndfAI9
 nkEsMjdnX0hjaZe2KC7n0EzbQfhxuz8u+P7LcchAzvKohZVazafhPS2kOCrfCHAN9sCWxd
 oTZ+5jciERSENgDqz2bg3h1ZHVJyhx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-jO-Y1oxNNmOaITuVgwX0nw-1; Tue, 27 Oct 2020 08:37:27 -0400
X-MC-Unique: jO-Y1oxNNmOaITuVgwX0nw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68D73108E1A1;
 Tue, 27 Oct 2020 12:37:26 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3CE260C11;
 Tue, 27 Oct 2020 12:37:16 +0000 (UTC)
Date: Tue, 27 Oct 2020 13:37:13 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v6 04/11] nbd: Update qapi to support exporting multiple
 bitmaps
Message-ID: <20201027123713.GI727443@angien.pipo.sk>
References: <20201027050556.269064-1-eblake@redhat.com>
 <20201027050556.269064-5-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201027050556.269064-5-eblake@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pkrempa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 "reviewer:Incompatible changes" <libvir-list@redhat.com>, armbru@redhat.com,
 rjones@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 27, 2020 at 00:05:49 -0500, Eric Blake wrote:
> Since 'block-export-add' is new to 5.2, we can still tweak the
> interface; there, allowing 'bitmaps':['str'] is nicer than
> 'bitmap':'str'.  This wires up the qapi and qemu-nbd changes to permit
> passing multiple bitmaps as distinct metadata contexts that the NBD
> client may request, but the actual support for more than one will
> require a further patch to the server.
> 
> Note that there are no changes made to the existing deprecated
> 'nbd-server-add' command; this required splitting the QAPI type
> BlockExportOptionsNbd, which fortunately does not affect QMP
> introspection.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  docs/system/deprecated.rst |  3 ++-
>  qapi/block-export.json     | 41 +++++++++++++++++++++++++++-----------
>  blockdev-nbd.c             |  6 +++++-
>  nbd/server.c               | 19 ++++++++++++------
>  qemu-nbd.c                 | 18 ++++++++---------
>  5 files changed, 58 insertions(+), 29 deletions(-)

Reviewed-by: Peter Krempa <pkrempa@redhat.com>


