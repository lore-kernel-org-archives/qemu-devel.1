Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9B1C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 10:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4DB32086D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 10:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DB32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7H2y-0002ga-SB
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 06:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i7H1V-0001eo-S0
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i7H1U-0005Cg-H9
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:35:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i7H1P-00054w-A3; Mon, 09 Sep 2019 06:35:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 343686CB24;
 Mon,  9 Sep 2019 10:35:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FB8E60BE2;
 Mon,  9 Sep 2019 10:35:44 +0000 (UTC)
Date: Mon, 9 Sep 2019 11:35:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190909103542.GD24509@redhat.com>
References: <20190906195750.17651-1-mlevitsk@redhat.com>
 <20190906195750.17651-4-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190906195750.17651-4-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 09 Sep 2019 10:35:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qemu-iotests: Add test for bz
 #1745922
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 06, 2019 at 10:57:50PM +0300, Maxim Levitsky wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  tests/qemu-iotests/263     | 75 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/263.out | 19 ++++++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 95 insertions(+)
>  create mode 100755 tests/qemu-iotests/263
>  create mode 100644 tests/qemu-iotests/263.out
> 
> diff --git a/tests/qemu-iotests/263 b/tests/qemu-iotests/263
> new file mode 100755
> index 0000000000..36951ff7b4
> --- /dev/null
> +++ b/tests/qemu-iotests/263
> @@ -0,0 +1,75 @@
> +#!/usr/bin/env bash
> +#
> +# Test encrypted write that crosses cluster boundary of two unallocated clusters
> +# Based on 188
> +#
> +# Copyright (C) 2019 Red Hat, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +# creator
> +owner=mlevitsk@redhat.com
> +
> +seq=`basename $0`
> +echo "QA output created by $seq"
> +
> +status=1	# failure is the default!
> +
> +_cleanup()
> +{
> +	_cleanup_test_img
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +
> +_supported_fmt qcow2
> +_supported_proto generic
> +_supported_os Linux
> +
> +
> +size=1M
> +
> +SECRET="secret,id=sec0,data=astrochicken"
> +
> +_make_test_img --object $SECRET -o "encrypt.format=luks,encrypt.key-secret=sec0,encrypt.iter-time=10,cluster_size=64K" $size
> +
> +IMGSPEC="driver=$IMGFMT,encrypt.key-secret=sec0,file.filename=$TEST_IMG"
> +
> +QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
> +
> +echo
> +echo "== reading the whole image =="
> +$QEMU_IO --object $SECRET -c "read -P 0 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
> +
> +echo
> +echo "== write two 512 byte sectors on a cluster boundary =="
> +$QEMU_IO --object $SECRET -c "write -P 0xAA 0xFE00 0x400" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
> +
> +echo
> +echo "== verify that the rest of the image is not changed =="
> +$QEMU_IO --object $SECRET -c "read -P 0x00 0x00000 0xFE00" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
> +$QEMU_IO --object $SECRET -c "read -P 0xAA 0x0FE00 0x400" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
> +$QEMU_IO --object $SECRET -c "read -P 0x00 0x10200 0xEFE00" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir

This tests LUKS encryption, but the code you'r changing/fixing also used
for the traditionl qcow2 encryption. The difference in IV handling for
these two methods is what made this code confusing, so I'd like to see
that the test also covers traditional qcow2 encryption.

Also can you confirm that the test succeeds when run on a qemu
built against 8c1ecb590497b0349c550607db923972b37f6963  (the change
immediately before Vladimir's threading series) ?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

