Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A966C2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 17:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4068E206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 17:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SbKB40my"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4068E206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLsSj-00015W-Ei
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 13:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLsRE-0008AY-OR
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLsRC-0006zX-GE
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:55:04 -0400
Received: from mail-eopbgr130099.outbound.protection.outlook.com
 ([40.107.13.99]:9861 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLsRB-0006yZ-R8
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:55:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2pQTJqveaJWys6MbywZsJljjPR87VCDOQHbtHmvOlk+ApL7oNrf9/U3XGgGEagSuMO3grdZUR9vvH3dP9ojkkhi6iAJXlZwNY4T+LKpNUb4zLBN0TBhOsScDzdYlxItUaJPac2CV99KvCbcd5CM5hv7x2QJBWzLXcHooxm45TJSzZS3ZkkE+cCEd6AtbXBPlS23MJefHacqkXkbr8fVUGBNFLE9w5vwpV0jfGdobq5Z3UHgPpmqvKauHmKerctEh56UpG0p2u/3PR/G7qBG2INPl1DdEKCb5g1e3BEIw+GPZEyxe8mIPNERuihMBcMdceh4QMjhPYtow9/WCeg7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8famO7b/KNd7pQKzC2e7iThcowDHbjX7VKUjL1KM0k=;
 b=VmbcQM8QDHBE2ieAomxv5XzKJ42pCpmav22GNmvdrCTdUCTReHikq9cF3xXNHFVqfPCDQu0ij5oNLXr7olECvir8Z7T50yw+wDV6UT32gXKSQxQ6U0WVpBuWaVvu2huf4TD3r9+7/NK9onEK+gH+Cs6VEIzKGTadlOmgAgxjOS2NanWi5lWNZ/uW5VEq7VY1CmO9x8Vcd0frRQR1yJphm+Ggt3hBg8fzH2F2g1JTLSvZmC9YbHeVg/GRZGR+b3rvjPUywycLhbpxRCvXbdzCHsHS6Ziay58ukvNDE6MmgqvODBjgIuQA2BHTfNdbaI25VxSI8eVLES9v1yM/t3FNow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8famO7b/KNd7pQKzC2e7iThcowDHbjX7VKUjL1KM0k=;
 b=SbKB40mytG2iz2ZW3UkBnnfasEK9ObFy6pQu5kEaMQn79Kx6vuvhfuq/gw9mXDGNUS32jNO2OKTQ6WJnt5NYFgGY+uFsjk7w50bVotMid/Za/wr/AmEbXtIcXfaAybfg7eVjlcfMgLXn72+bptZKJ1QQ0YchppJhjl+y8S67/Pc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (52.133.246.147) by
 VI1PR08MB2974.eurprd08.prod.outlook.com (52.134.31.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.19; Tue, 7 Apr 2020 17:54:57 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::28ab:e81:c912:8931]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::28ab:e81:c912:8931%7]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 17:54:57 +0000
Subject: Re: [PATCH-for-5.1 v2 48/54] scripts/coccinelle: Use &error_abort in
 TypeInfo::instance_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200406174743.16956-1-f4bug@amsat.org>
 <20200406174743.16956-49-f4bug@amsat.org>
 <04663728-06f3-85bf-74b7-45184f90aa0a@virtuozzo.com>
 <ac7213fd-3ea2-e80c-7308-5f2de02c341c@redhat.com>
 <ae9ced39-f039-ffb5-b33b-df93b0f35e36@virtuozzo.com>
 <ffd970c9-c8f3-b6c4-3592-cbace296f986@redhat.com>
 <50d08d50-3ce2-2ee1-7529-5cfbfbcc5331@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200407205455660
Message-ID: <044eece3-542a-8e99-c865-e77368478fb1@virtuozzo.com>
Date: Tue, 7 Apr 2020 20:54:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <50d08d50-3ce2-2ee1-7529-5cfbfbcc5331@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::37) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM0PR01CA0024.eurprd01.prod.exchangelabs.com (2603:10a6:208:69::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Tue, 7 Apr 2020 17:54:57 +0000
X-Tagtoolbar-Keys: D20200407205455660
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f51f7073-6b85-465f-b5b3-08d7db1cc924
X-MS-TrafficTypeDiagnostic: VI1PR08MB2974:
X-Microsoft-Antispam-PRVS: <VI1PR08MB297458C6702DDD470140BB00C1C30@VI1PR08MB2974.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39840400004)(136003)(396003)(346002)(366004)(376002)(4326008)(186003)(16526019)(956004)(86362001)(66556008)(31686004)(66946007)(31696002)(53546011)(2906002)(966005)(52116002)(66476007)(478600001)(26005)(2616005)(5660300002)(16576012)(8936002)(316002)(8676002)(36756003)(6486002)(110136005)(81156014)(81166006);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ma3aDBm2b5F9s1vzmYGhePpJZMu1IvUUYC9mKcP0KkcKaL4GPWUrb7CfYxN9EJtpdobKiW+MimmEhJyeDm5dm6ovErBHvEImQ+xQXR04IX5aTrdlYnpPAxEuz+3b2JxfYusxaeUiCrI2VYnzBx7DSKUYGOc1f5CuWLQFoFyseaCx0El4dwnTyq3eGufMIu7FVTtnA3u8YFwWq0NyGBsZY3ZXv5YlYDBGy6RPxCnPAOu4SGff6a4wHzcF2ExAJ/6Jzmn00IFGWlSM/9AGrSOH2FaY+XQxwTeq42aZRSlF4yt+iNNR5E8A90hmqKY5bAh6BCUwCszq9jSiyTROQJPT1YWLVbUbiYerVr8xEPIO5jEOjkFXTcNxCo3X+mt2+rVQSzY7Xi3b1Thj5pi70RjVzmE8lc0HqLIxDNfwRkS9zkLj69hDUlkWdzUqamS1OyXQDbpWosuqoX9P2CPvSYBa0jFTdv6VYdyz3nI60qur85wbV3HUVhJCSfXkw9eQVpkCB7rhj43qAc1SkkjmEthkgg==
X-MS-Exchange-AntiSpam-MessageData: TnkLjJsqdbuaTwPfK7gm8SCjh9+MHaxIESQY6T+F4yPg9yUFuZDJPSMUwXXjJxBrs+UK22wFX/DB37lUsXyUde9xPLmCbt+MM25N9tzan12fy8i/vccaNJfMoIKB+XqHoEuCdUhIFkDqKDp2BWym/A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51f7073-6b85-465f-b5b3-08d7db1cc924
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 17:54:57.8229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+2I9GzTgBED2OOxlokpxslnpgLIAfaRoaXFsle3TaT4lwY5s6VwTcuH6ZZLt+7adEJbOKntwxbMPvNCpGYAZTO5+yPUUlCLASm2sXm2wHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2974
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.13.99
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.04.2020 20:27, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/7/20 3:07 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 4/7/20 3:01 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> 07.04.2020 14:03, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 4/7/20 9:07 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 06.04.2020 20:47, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>> The instance_init() calls are not suppose to fail. Add a
>>>>>> Coccinelle script to use &error_abort instead of ignoring
>>>>>> errors by using a NULL Error*.
>>>>>>
>>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>>> ---
>>>>>> =C2=A0 .../use-error_abort-in-instance_init.cocci=C2=A0=C2=A0=C2=A0 =
| 52 +++++++++++++++++++
>>>>>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 1 +
>>>>>> =C2=A0 2 files changed, 53 insertions(+)
>>>>>> =C2=A0 create mode 100644 scripts/coccinelle/use-error_abort-in-inst=
ance_init.cocci
>>>>>>
>>>>>> diff --git a/scripts/coccinelle/use-error_abort-in-instance_init.coc=
ci b/scripts/coccinelle/use-error_abort-in-instance_init.cocci
>>>>>> new file mode 100644
>>>>>> index 0000000000..8302d74a0c
>>>>>> --- /dev/null
>>>>>> +++ b/scripts/coccinelle/use-error_abort-in-instance_init.cocci
>>>>>> @@ -0,0 +1,52 @@
>>>>>> +// Use &error_abort in TypeInfo::instance_init()
>>>>>> +//
>>>>>> +// Copyright: (C) 2020 Philippe Mathieu-Daud=C3=A9
>>>>>> +// This work is licensed under the terms of the GNU GPLv2 or later.
>>>>>> +//
>>>>>> +// spatch \
>>>>>> +//=C2=A0 --macro-file scripts/cocci-macro-file.h --include-headers =
\
>>>>>> +//=C2=A0 --sp-file scripts/coccinelle/use-error_abort-in-instance_i=
nit.cocci \
>>>>>> +//=C2=A0 --keep-comments --in-place
>>>>>> +//
>>>>>> +// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/m=
sg692500.html
>>>>>> +// and https://www.mail-archive.com/qemu-devel@nongnu.org/msg693637=
.html
>>>>>> +
>>>>>> +
>>>>>> +@ has_qapi_error @
>>>>>> +@@
>>>>>> +=C2=A0=C2=A0=C2=A0 #include "qapi/error.h"
>>>>>> +
>>>>>> +
>>>>>> +@ match_instance_init @
>>>>>> +TypeInfo info;
>>>>>> +identifier instance_initfn;
>>>>>> +@@
>>>>>> +=C2=A0=C2=A0=C2=A0 info.instance_init =3D instance_initfn;
>>>>>> +
>>>>>> +
>>>>>> +@ use_error_abort @
>>>>>> +identifier match_instance_init.instance_initfn;
>>>>>> +identifier func_with_error;
>>>>>> +expression parentobj, propname, childobj, size, type, errp;
>>>>>> +position pos;
>>>>>> +@@
>>>>>> +void instance_initfn(...)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0 <+...
>>>>>> +(
>>>>>> +=C2=A0=C2=A0 object_initialize_child(parentobj, propname,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 childobj, size, type,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 errp, NULL);
>>>
>>> I think, it doesn't actually differs from just object_initialize_child(=
..., NULL); and you don't need all these metavaraibles
>>>
>>>>>> +|
>>>>>> +=C2=A0=C2=A0 func_with_error@pos(...,
>>>>>> +-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 NULL);
>>>>>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 &error_abort);
>>>>>> +)
>>>>>
>>>>>
>>>>> Hmm. I don't follow, what are you trying to achieve by this ( | ) con=
struction? The second pattern (func_with_error...) will be matched anyway, =
with or without first pattern (object_initialize_child...) matched. And fir=
st pattern does nothing.
>>>>
>>>> Expected behavior :)
>>>>
>>>> If object_initialize_child() matched:
>>>> =C2=A0=C2=A0 do nothing.
>>>> Else:
>>>> =C2=A0=C2=A0 transform.
>>>
>>> Ah, understand, thanks. Checked, it works.
>>>
>>> Possibly simpler way is just define func_with_errno identifier like thi=
s:
>>>
>>> identifier func_with_error !=3D object_initialize_child;
>=20
> Thanks for the tip Vladimir, I simplified as:
>=20
> @ use_error_abort @
> identifier match_instance_init.instance_initfn;
> identifier func_with_error !=3D {qbus_create_inplace, object_initialize_c=
hild};

New syntax for me, great)

> position pos;
> @@
> void instance_initfn(...)
> {
>  =C2=A0=C2=A0 <+...
>  =C2=A0=C2=A0 func_with_error@pos(...,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 NULL);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &error_abort);
>  =C2=A0=C2=A0 ...+>
> }
>=20
> BTW do you know how to automatically add an include ("qapi/error.h" below=
)?

No, I don't.

I can guess something like this

@ already_has_include @
@@

#include <qapi/error.h>

@ depends on !already_has_include && use_error_abort @

  #include ...
+#include <qapi/error.h>

=3D=3D=3D

or maybe in one rule:

@@
... when !=3D error.h
  #include ...
+#include <qapi/error.h>
... when !=3D error.h


(possibly last line is not needed)..

what spec says about includes:

An #include may be followed by "...", <...> or simply .... With either quot=
es or angle brackets, it is possible to put a partial path, ending with ...=
, such as <include/...>, or to put a complete path. A #include with ... mat=
ches any include, with either quotes or angle brackets. Partial paths or co=
mplete are not allowed in the latter case. Something that is added before a=
n include will be put before the last matching include that is not under an=
 ifdef in the file. Likewise, something that is added after an include will=
 be put after the last matching include that is not under an ifdef in the f=
ile.

>=20
>>>
>>>>
>>>>>
>>>>>
>>>>>> +=C2=A0=C2=A0 ...+>
>>>>>> +}
>>>>>> +
>>>>>> +
>>>>>> +@script:python depends on use_error_abort && !has_qapi_error@
>>>>>> +p << use_error_abort.pos;
>>>>>> +@@
>>>>>> +print('[[manual edit required, %s misses #include "qapi/error.h"]]'=
 % p[0].file)
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index 14de2a31dc..ae71a0a4b0 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -2059,6 +2059,7 @@ F: scripts/coccinelle/error-use-after-free.coc=
ci
>>>>>> =C2=A0 F: scripts/coccinelle/error_propagate_null.cocci
>>>>>> =C2=A0 F: scripts/coccinelle/remove_local_err.cocci
>>>>>> =C2=A0 F: scripts/coccinelle/simplify-init-realize-error_propagate.c=
occi
>>>>>> +F: scripts/coccinelle/use-error_abort-in-instance_init.cocci
>>>>>> =C2=A0 F: scripts/coccinelle/use-error_fatal.cocci
>>>>>> =C2=A0 F: scripts/coccinelle/use-error_propagate-in-realize.cocci
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>=20


--=20
Best regards,
Vladimir

