Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF38C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2D2246AC
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="srYt+6vh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2D2246AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eEF-0004m8-OU
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7eDG-00033B-4F
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:53:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7eDE-0003mi-0K
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:53:49 -0500
Received: from mail-am6eur05on2099.outbound.protection.outlook.com
 ([40.107.22.99]:49504 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j7eDA-0003hU-9V; Fri, 28 Feb 2020 06:53:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVgRcqfsQOkPA77TYDjt+gSX9rspg7LkjZOxuZ5axU2fw9DHyYp5wDy2boI0OZD/0QrIDNJHbq3UaNnDeDDGgnN/rberH7fyrGT/SIXOTQOEWchA7YODV9RTvwYvqTdgbBapU7n8WeA/d+Aphn1kSc20j9vTHKXD2+bbKfUC4IzOf/auz9HZvjUXJ8wF24+QZvXvNmNINW+LtmKsuAwdXQPEZQI4KA90gsFid98/I45pjwp2bkKF+v771QyY0oPArReYgQcz5ozLEcy4UhRpzG2td/vp99dJn10S3y6iPWgRHCpVKWrJJUW9V/PgaCUCPy4h+FsHpmwVmIXmmmAv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUewHQvsDbmVSf8cZLgv17DV50R/4Bpg6jsobpBUlU8=;
 b=EVktIspqzICk18PBtKVZT8ulWzCtnuHkKm59zC/ttOlWcRQikD5ACRgNgzBAvbOuun7BiLbSju90icMwXm+aYZVCMXVHy8YbkHlnK5OqnFe2hAkjGIU4544frPxyLW/SJRrimOOLiMKVlsr6xS12Fzr4RokytbC2GWGKrE/wC7IH6uM4dumVv0VHVsg4MiYzdGSMCCeztVMWllXt1OifN/dO2rj11aIWpSxdsQ1HTpFO615PwwbCaJkLlH9B2hVwEQjiCbSluWD9VlM6cdKsFDR+GKdyuw8FzAghVBRXS0DI/7BrxJrqh8aGaLNLc2IJGhLv7PXxi7rFfTXYiMDtFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUewHQvsDbmVSf8cZLgv17DV50R/4Bpg6jsobpBUlU8=;
 b=srYt+6vh2ZDZyAWVD3uhAYJlP+aINFcm2b6zOe/n8N1PuToeQ3hZ9JIKMjbwco5VDLO+O9gTPI1LFUJS8ebM1J4UFKpQ5XMsDn9z03FmTtBxkBJipZwk9Xd1RJj91FcPJka+kMW6DNmaF1YNXJHHE0+a6HyIraAG/6bh0xU4l1E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3890.eurprd08.prod.outlook.com (20.178.82.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Fri, 28 Feb 2020 11:53:40 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219%4]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 11:53:40 +0000
Subject: Re: [PATCH v1 4/8] iotests: filter out compression_type
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-5-dplotnikov@virtuozzo.com>
 <e3a3a3b1-8cd0-fa26-c5a3-46065c5888fe@redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <1a256e60-1c92-0402-38f1-e4f5c09d1bd2@virtuozzo.com>
Date: Fri, 28 Feb 2020 14:53:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <e3a3a3b1-8cd0-fa26-c5a3-46065c5888fe@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR0501CA0004.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::14) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.162.229) by
 HE1PR0501CA0004.eurprd05.prod.outlook.com (2603:10a6:3:1a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Fri, 28 Feb 2020 11:53:39 +0000
X-Originating-IP: [178.34.162.229]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22ef5659-036d-4ce0-8e49-08d7bc44da3a
X-MS-TrafficTypeDiagnostic: AM0PR08MB3890:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3890AB900E72F30A612AF90DCFE80@AM0PR08MB3890.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(366004)(136003)(39850400004)(396003)(189003)(199004)(81166006)(8936002)(81156014)(6486002)(4326008)(478600001)(53546011)(5660300002)(186003)(16526019)(31696002)(8676002)(26005)(31686004)(36756003)(2616005)(956004)(107886003)(316002)(16576012)(52116002)(66476007)(66556008)(66946007)(86362001)(2906002)(6666004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3890;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PoD5hxOKpvixvS5SOxJFLAxLGApDUVvrEMNJqX6YWRlybekNFjd9ZrImlsnY0dnW0gxJIc+fSUDYoEQGCq+WsX/PhH/XY63Ez5mtJIlfVCbAEda4pcLViB+y+NU5fB6mpVMq5r9YdvXcVZxV8NpxAXnn9AXgRypdFIWOSCLEybnNrihMnPtCFFZ9xCXF7/4RUQtAP1utJBn8020lxznTOfwoY0psJyYy7L/4pvyv/3AcWF0qWQ/Y2Nc2NtlZ/xLvyYNAxwDDaZC9PcqoUQ6xeaezCY2gPb75O1shZhWWYRgHoLkrZG53slLj3Ubjm/v7+JYJfUrCf2hXLYP8g+XRPyS9+NGfhwh1chazdHGpSw992stCHPmp/hEAj4WvBnzmkZoq2r0A7oc+nVxOkczQJrnhUILK4RLnJF4+mx9s6TxhyzHPKoPdRGiMGdvKZ54K
X-MS-Exchange-AntiSpam-MessageData: lLvCX/ycFK48WrhvrRifsNnbjmwCicx4v2vTb2jHgRTYFwDLEoV17ogvuPcudT+P93WP8n1TvCETae4bzH8zUPSfrwuFbiaUY5X+CWmCelikntVWFoput/ms+bXyWMkJu3gsL8aWCEXmN3w81SqTYg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ef5659-036d-4ce0-8e49-08d7bc44da3a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 11:53:40.2682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+6xk/QE/L5abhoT5NKeI5qOeZeRkduQbMmark9jeiTCPMDs98Rt78avprtbxB7xJuTZ9XmQwZq6Gme9ZyPsmKLO9dXuid159KHAYlLY9HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3890
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.99
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 27.02.2020 17:03, Eric Blake wrote:
> On 2/27/20 1:29 AM, Denis Plotnikov wrote:
>> After adding compression type feature to qcow2 format, qemu framework
>> commands reporting the image settingd, e.g. "qemu-img create", started
>
> settings
>
>> reporting the compression type for the image which breaks the iotests
>> output matching.
>>
>> To fix it, add compression_type=3Dzlib to the list of filtered image=20
>> parameters.
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>> =A0 tests/qemu-iotests/common.filter | 3 ++-
>> =A0 1 file changed, 2 insertions(+), 1 deletion(-)
>
> This should be squashed in to the patch that caused the breakage (3/8,=20
> if I'm right).
>
>>
>> diff --git a/tests/qemu-iotests/common.filter=20
>> b/tests/qemu-iotests/common.filter
>> index 3f8ee3e5f7..c6962d199c 100644
>> --- a/tests/qemu-iotests/common.filter
>> +++ b/tests/qemu-iotests/common.filter
>> @@ -152,7 +152,8 @@ _filter_img_create()
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 -e "s# refcount_bits=3D[0-9]\\+##g" \
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 -e "s# key-secret=3D[a-zA-Z0-9]\\+##g" \
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 -e "s# iter-time=3D[0-9]\\+##g" \
>> -=A0=A0=A0=A0=A0=A0=A0 -e "s# force_size=3D\\(on\\|off\\)##g"
>> +=A0=A0=A0=A0=A0=A0=A0 -e "s# force_size=3D\\(on\\|off\\)##g" \
>> +=A0=A0=A0=A0=A0=A0=A0 -e "s# compression_type=3Dzlib##g"
>
> Do you really want to hard-code just zlib, or should this be more=20
> generic as compression_type=3D[a-zA-Z0-9]\\+ as done on other lines like=
=20
> key-secret?
When I did this I meant additional implicit check that the default=20
compression type is zlib. But non of the other items in the filter don't=20
do it. So I'll change it to be consistent. Thanks!

Denis
>
>


