Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA12C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE7723697
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE7723697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59C5-0001i0-Kd
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i599B-0007mZ-J5
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i599A-0002JC-HO
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:47:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i5997-0002GR-HO; Tue, 03 Sep 2019 09:46:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 623B73172D8D;
 Tue,  3 Sep 2019 13:46:56 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-195.ams2.redhat.com
 [10.36.116.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A46A05C21A;
 Tue,  3 Sep 2019 13:46:54 +0000 (UTC)
Date: Tue, 3 Sep 2019 15:46:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <20190903134653.GJ4582@localhost.localdomain>
References: <20190828125654.10544-1-dplotnikov@virtuozzo.com>
 <20190828125654.10544-2-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828125654.10544-2-dplotnikov@virtuozzo.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 03 Sep 2019 13:46:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 1/3] qcow2: introduce compression type
 feature
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
Cc: vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.08.2019 um 14:56 hat Denis Plotnikov geschrieben:
> The patch adds some preparation parts for incompatible compression type
> feature to QCOW2 header that indicates that *all* compressed clusters
> must be (de)compressed using a certain compression type.
> 
> It is implied that the compression type is set on the image creation and
> can be changed only later by image conversion, thus compression type
> defines the only compression algorithm used for the image.
> 
> The goal of the feature is to add support of other compression algorithms
> to qcow2. For example, ZSTD which is more effective on compression than ZLIB.
> It works roughly 2x faster than ZLIB providing a comparable compression ratio
> and therefore provides a performance advantage in backup scenarios.
> 
> The default compression is ZLIB. Images created with ZLIB compression type
> are backward compatible with older qemu versions.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>

> @@ -359,6 +364,13 @@ typedef struct BDRVQcow2State {
>  
>      bool metadata_preallocation_checked;
>      bool metadata_preallocation;
> +    /*
> +     * Compression type used for the image. Default: 0 - ZLIB
> +     * The image compression type is set on image creation.
> +     * The only way to change the compression type is to convert the image
> +     * with the desired compression type set
> +     */
> +    uint32_t compression_type;

Should this use the enum Qcow2CompressionType instead of a plain int?

If you don't need to respin, I can make this change while applying.

Kevin

