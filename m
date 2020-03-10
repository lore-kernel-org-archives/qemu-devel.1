Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4711C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740282071B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgHGSnWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740282071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBetv-0007kR-KM
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1jBetI-0007G7-KY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1jBetH-0003Km-Cr
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:25:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51949
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1jBetH-0003JU-80
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583846746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dm5jPvCcaAKUS7cwp/gARvsUehAyjURtsOHv5DZmzb4=;
 b=bgHGSnWyG4ilYs78cbZg8NTv9jiTSgkmbekPDDDYIeByfCT8kWr7Y4Iz6pQaVpoCeH2miZ
 6Xee6Q7OebtuNge1SJlSmyfczC+MrffB12lZdHRtpbcAXWoNC5pd0crlrwpGxAYmZBJOTJ
 IYH5Zp5hzRPSqrFrKsdBI2yjYgSEhXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-ipjgo6p_OtmamaSax6dzJA-1; Tue, 10 Mar 2020 09:25:43 -0400
X-MC-Unique: ipjgo6p_OtmamaSax6dzJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0DD1108C31C;
 Tue, 10 Mar 2020 13:25:42 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A518E5D9CA;
 Tue, 10 Mar 2020 13:25:38 +0000 (UTC)
Date: Tue, 10 Mar 2020 14:25:36 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 4/7] iotests: Test mirror with temporarily disabled
 target backing file
Message-ID: <20200310132536.GB1320660@angien.pipo.sk>
References: <20200310113831.27293-1-kwolf@redhat.com>
 <20200310113831.27293-5-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200310113831.27293-5-kwolf@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 12:38:28 +0100, Kevin Wolf wrote:
> The newly tested scenario is a common live storage migration scenario:
> The target node is opened without a backing file so that the active
> layer is mirrored while its backing chain can be copied in the
> background.
>=20
> The backing chain should be attached to the mirror target node when
> finalising the job, just before switching the users of the source node
> to the new copy (at which point the mirror job still has a reference to
> the node). drive-mirror did this automatically, but with blockdev-mirror
> this is the job of the QMP client.
>=20
> This patch adds test cases for two ways to achieve the desired result,
> using either x-blockdev-reopen or blockdev-snapshot.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/155     | 56 ++++++++++++++++++++++++++++++++++----
>  tests/qemu-iotests/155.out |  4 +--
>  2 files changed, 53 insertions(+), 7 deletions(-)

Reviewed-by: Peter Krempa <pkrempa@redhat.com>


