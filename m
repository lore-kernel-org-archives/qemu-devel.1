Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0413C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 19:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6868121994
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 19:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="4TAflEbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6868121994
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr61P-0005QO-Jy
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 15:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36097)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hr61D-00050w-NI
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 15:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hr61C-00087z-Ki
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 15:36:43 -0400
Received: from mail-eopbgr800099.outbound.protection.outlook.com
 ([40.107.80.99]:24928 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hr61C-00084k-BN
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 15:36:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FL7tcitZnxacgksVv4PWZNhdIbkbSYHwoWJFVxOOh4TsdKfHbnMbQy9v3vrf7VhLm5h0g/MxAslyUwogvvGX0Rb3W6jNf8mwqUeF01KzinCLQA8lFjCEnBsD/kuhBJG9+aHEtkAS6MWfoRcHmSlOsZHilg4X0AGB+RqkRfaqh/mMfxbF/qz7lSq+6LRF5eglwjIa/Ib5djnBRIdkYvEO1be17agKboWfNPI7GlQdAq/1R1xh/Tf6PC4e4VQD6Yfar4ptAULG37ukdmHm3k203+xt4orb3ESTzwY5YIZDGECuiSsLU/IgvxQgbD41jWUmJ/PWJ/KX1P9uoCNe4DbjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69BkTStWiQYZ1AFlaAL7o3FCQ6BvmmE17VuZQcLzQYU=;
 b=b0PZ5LumnPU/IEgnrdEO65wfsCQ4NQZDJVqD0Uu/GttPQqcFw0+VvjxHYQv6KcQ9hPvFRosCZyFSSxxl8DLEdg6Uh3nZQRwmQrYsOJHsX7fK7fIf6lBfBK2ddONnpjIcPXOIa5LphNDeXJprDAXtSxgROzqefDGXVa/kfRaW7j6bgm4rOy92EdmUjSIEGeWv8MVtBHfZ3vRPWvvHyr6iLk5hIzcJQOTGSkXcc8iXAm6TKACg0WBgvCUfF/upSHwBkwZ/V84pXOwky/tH+B3fHPA/In/Ewzxb497D/ZxOLaPcJMhEwcZo+i1Vbjw0Xfs7fhWcUZUjHgSu+/GGdSwUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69BkTStWiQYZ1AFlaAL7o3FCQ6BvmmE17VuZQcLzQYU=;
 b=4TAflEbXo7lXF2no2OEUjiD6Wb2WLPzNFWqhR2IXxeQ9zDpRvJZbPuCQ+swkKYV27mu6v14+8fapSPC1UrGuuAco6O0oZy0lcF1jN9oxyYDlkDtrR09uY3Zf2RLfn0q31zuvrxIcbac18ypMOW7iB+cp+BIiQ5G/42csSI3WHLk=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2487.namprd03.prod.outlook.com (10.168.165.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Fri, 26 Jul 2019 19:36:39 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Fri, 26 Jul 2019
 19:36:39 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: Stefan Hajnoczi <stefanha@gmail.com>
Thread-Topic: [Qemu-devel] [RFC 06/19] fuzz: Add ramfile for fast
 vmstate/vmload
Thread-Index: AQHVQphfm5R9EtrmLUa21dtVrN4MJqbc23OAgAByOwA=
Date: Fri, 26 Jul 2019 19:36:39 +0000
Message-ID: <0f5f2119-bfae-c88b-c67a-5018e6e364f0@bu.edu>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-7-alxndr@bu.edu>
 <20190726124745.GC25977@stefanha-x1.localdomain>
In-Reply-To: <20190726124745.GC25977@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.54.222.142]
x-clientproxiedby: BN6PR1401CA0021.namprd14.prod.outlook.com
 (2603:10b6:405:4b::31) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e31a8ac5-97ca-41c4-30aa-08d712009432
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2487; 
x-ms-traffictypediagnostic: CY4PR03MB2487:
x-microsoft-antispam-prvs: <CY4PR03MB24878461BDAA57691AC7A85FBAC00@CY4PR03MB2487.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(4326008)(66066001)(81166006)(66476007)(8936002)(66556008)(64756008)(66446008)(66946007)(36756003)(8676002)(316002)(3846002)(2616005)(7736002)(81156014)(2906002)(71200400001)(478600001)(14444005)(54906003)(25786009)(31696002)(14454004)(486006)(68736007)(26005)(6506007)(229853002)(446003)(6246003)(52116002)(53936002)(6436002)(5660300002)(1411001)(6916009)(53546011)(102836004)(386003)(31686004)(186003)(88552002)(76176011)(305945005)(6512007)(71190400001)(86362001)(256004)(6486002)(476003)(99286004)(786003)(75432002)(6116002)(11346002)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2487;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JQEDUnnpe8/SQ+/5h7b4XD19GRdpFDEGRFFze/XYidPeQaCBXnNdfj6sSHJH2I03g50PwO6G+68g5D25RJ1qEw0tYL37kRO0GhfpOyDmaJlCMfzX979dQvs+VeTns36vfDT54S2AXF3PCGl1POCu70q5P/kdgDOow7Tzq7wooLf5WWDmm5PhvwH4pvHJKJ9ZiHvB6pbqHaTl99HNG4WK4ZoXtVXJchopJL8XoAEy4KkdxeBa7wD4o3Vc9BZ1zWH/1uJ9mn7iDxA9Iq2b2kJ36NboNg33rmzZ4LGEezZbXXMGxvl5zx6NJRJxoZT2RM8y4xq/1g9mlWW5lOhQYR/tjZmU7sT7dXpSYjlIAw+GWBssd+eeACKkx8BuXUvC/S5eeBJWYoZgmcK3cAVb8/DmaNYMk56AlDABvPlxs/SsVZA=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <7EA3929726C12F49BE5389DA7EB8FF1A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e31a8ac5-97ca-41c4-30aa-08d712009432
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 19:36:39.6379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2487
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.99
Subject: Re: [Qemu-devel] [RFC 06/19] fuzz: Add ramfile for fast
 vmstate/vmload
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/26/19 8:47 AM, Stefan Hajnoczi wrote:
> On Thu, Jul 25, 2019 at 03:23:49AM +0000, Oleinik, Alexander wrote:
>> The ramfile allows vmstate to be saved and restored directly onto the
>> heap.
>>
>> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
>> ---
>>   tests/fuzz/ramfile.c | 127 +++++++++++++++++++++++++++++++++++++++++++
>>   tests/fuzz/ramfile.h |  20 +++++++
>>   2 files changed, 147 insertions(+)
>>   create mode 100644 tests/fuzz/ramfile.c
>>   create mode 100644 tests/fuzz/ramfile.h
>>
>> diff --git a/tests/fuzz/ramfile.c b/tests/fuzz/ramfile.c
>> new file mode 100644
>> index 0000000000..8da242e9ee
>> --- /dev/null
>> +++ b/tests/fuzz/ramfile.c
>=20
> Please put this in migration/.  This code doesn't do fuzzing and is
> general-purpose enough to be used by other parts of QEMU dealing with
> live migration.
>=20
>> @@ -0,0 +1,127 @@
>> +/*
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + *
>> + *       Filename:  ramfile.c
>> + *
>> + *    Description:  QEMUFile stored in dynamically allocated RAM for fa=
st VMRestore
>> + *
>> + *         Author:  Alexander Oleinik (), alxndr@bu.edu
>> + *   Organization:
>> + *
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> + */
>=20
> Please use license headers with all new files that are created.
> Fine-grained filename and authorship information is already kept by git
> so it's not necessary to duplicate it here.
>=20
>> +#include <stdlib.h>
>> +#include "qemu/osdep.h"
>=20
> osdep.h already includes stdlib.h.
>=20
>> +#include "qemu-common.h"
>> +#include "exec/memory.h"
>> +#include "migration/qemu-file.h"
>> +#include "migration/migration.h"
>> +#include "migration/savevm.h"
>> +#include "ramfile.h"
>> +
>> +#define INCREMENT 10240
>> +#define IO_BUF_SIZE 32768
>> +#define MAX_IOV_SIZE MIN(IOV_MAX, 64)
>> +
>> +struct QEMUFile {
>> +    const QEMUFileOps *ops;
>> +    const QEMUFileHooks *hooks;
>> +    void *opaque;
>> +
>> +    int64_t bytes_xfer;
>> +    int64_t xfer_limit;
>> +
>> +    int64_t pos; /* start of buffer when writing, end of buffer
>> +                    when reading */
>> +    int buf_index;
>> +    int buf_size; /* 0 when writing */
>> +    uint8_t buf[IO_BUF_SIZE];
>> +
>> +    DECLARE_BITMAP(may_free, MAX_IOV_SIZE);
>> +    struct iovec iov[MAX_IOV_SIZE];
>> +    unsigned int iovcnt;
>> +
>> +    int last_error;
>> +};
>=20
> Wait, what?! :)
>=20
> Please add the ram file to qemu-file.c instead of duplicating QEMUFile.
>=20
I think we should be able to replace all of this simply by using=20
memfd_create. Since it acts as a regular file, it will work with the=20
existing code (likely with performance gains).

