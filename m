Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8987C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 01:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AEF0222C3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 01:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEF0222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irXwS-0002S9-LI
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 20:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1irXvj-0001iY-1s
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 20:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1irXvh-0004Dt-Sx
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 20:57:10 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2428 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1irXvh-0004DC-Iv
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 20:57:09 -0500
Received: from dggemi405-hub.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id ACF4B124C25220A23EFC;
 Wed, 15 Jan 2020 09:57:07 +0800 (CST)
Received: from DGGEMI422-HUB.china.huawei.com (10.1.199.151) by
 dggemi405-hub.china.huawei.com (10.3.17.143) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 09:57:07 +0800
Received: from DGGEMI529-MBX.china.huawei.com ([169.254.6.126]) by
 dggemi422-hub.china.huawei.com ([10.1.199.151]) with mapi id 14.03.0439.000;
 Wed, 15 Jan 2020 09:57:01 +0800
From: fengzhimin <fengzhimin1@huawei.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: RE: [PATCH RFC 03/12] migration: Create the multi-rdma-channels
 parameter
Thread-Topic: [PATCH RFC 03/12] migration: Create the multi-rdma-channels
 parameter
Thread-Index: AQHVyicUIfcQ3EueWkiSQgSKd71pY6fq+Xcw
Date: Wed, 15 Jan 2020 01:57:01 +0000
Message-ID: <03C2A65461456D4EBE9E6D4D0D96C583FBC7CE@DGGEMI529-MBX.china.huawei.com>
References: <20200109045922.904-1-fengzhimin1@huawei.com>
 <20200109045922.904-4-fengzhimin1@huawei.com>
 <87v9pfwesp.fsf@dusky.pond.sub.org>
In-Reply-To: <87v9pfwesp.fsf@dusky.pond.sub.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.198]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.187
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "jemmy858585@gmail.com" <jemmy858585@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for your review. I will fix these errors in the next version(V2).

-----Original Message-----
From: Markus Armbruster [mailto:armbru@redhat.com]=20
Sent: Monday, January 13, 2020 11:35 PM
To: fengzhimin <fengzhimin1@huawei.com>
Cc: quintela@redhat.com; dgilbert@redhat.com; eblake@redhat.com; jemmy85858=
5@gmail.com; qemu-devel@nongnu.org; Zhanghailiang <zhang.zhanghailiang@huaw=
ei.com>
Subject: Re: [PATCH RFC 03/12] migration: Create the multi-rdma-channels pa=
rameter

Zhimin Feng <fengzhimin1@huawei.com> writes:

> From: fengzhimin <fengzhimin1@huawei.com>
>
> Indicates the number of RDMA threads that we would create.
> By default we create 2 threads for RDMA migration.
>
> Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
[...]
> diff --git a/qapi/migration.json b/qapi/migration.json index=20
> c995ffdc4c..ab79bf0600 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -588,6 +588,10 @@
>  # @max-cpu-throttle: maximum cpu throttle percentage.
>  #                    Defaults to 99. (Since 3.1)
>  #
> +# @multi-rdma-channels: Number of channels used to migrate data in
> +#                       parallel. This is the same number that the

same number as

> +#                       number of multiRDMA used for migration.  The

Pardon my ignorance: what's "the number of multiRDMA used for migration"?

> +#                       default value is 2 (since 4.2)

(since 5.0)

>  # Since: 2.4
>  ##
>  { 'enum': 'MigrationParameter',
> @@ -600,7 +604,8 @@
>             'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
>             'multifd-channels',
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
> -           'max-cpu-throttle' ] }
> +           'max-cpu-throttle',
> +           'multi-rdma-channels'] }
> =20
>  ##
>  # @MigrateSetParameters:
> @@ -690,6 +695,10 @@
>  # @max-cpu-throttle: maximum cpu throttle percentage.
>  #                    The default value is 99. (Since 3.1)
>  #
> +# @multi-rdma-channels: Number of channels used to migrate data in
> +#                       parallel. This is the same number that the
> +#                       number of multiRDMA used for migration.  The
> +#                       default value is 2 (since 4.2)

See above.

>  # Since: 2.4
>  ##
>  # TODO either fuse back into MigrationParameters, or make @@ -715,7=20
> +724,8 @@
>              '*multifd-channels': 'int',
>              '*xbzrle-cache-size': 'size',
>              '*max-postcopy-bandwidth': 'size',
> -	    '*max-cpu-throttle': 'int' } }
> +     	    '*max-cpu-throttle': 'int',

Please use spaces instead of tab.

> +            '*multi-rdma-channels': 'int'} }
> =20
>  ##
>  # @migrate-set-parameters:
> @@ -825,6 +835,10 @@
>  #                    Defaults to 99.
>  #                     (Since 3.1)
>  #
> +# @multi-rdma-channels: Number of channels used to migrate data in
> +#                       parallel. This is the same number that the
> +#                       number of multiRDMA used for migration.  The
> +#                       default value is 2 (since 4.2)
>  # Since: 2.4

See above.

>  ##
>  { 'struct': 'MigrationParameters',
> @@ -847,8 +861,9 @@
>              '*block-incremental': 'bool' ,
>              '*multifd-channels': 'uint8',
>              '*xbzrle-cache-size': 'size',
> -	    '*max-postcopy-bandwidth': 'size',
> -            '*max-cpu-throttle':'uint8'} }
> +     	    '*max-postcopy-bandwidth': 'size',
> +            '*max-cpu-throttle':'uint8',
> +            '*multi-rdma-channels':'uint8'} }
> =20
>  ##
>  # @query-migrate-parameters:

Please use spaces instead of tab.


