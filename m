Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68861C433E8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 351162074F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cOwOqbT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351162074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0OsY-0000bY-F3
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 08:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0Orr-0008Vp-OW; Tue, 28 Jul 2020 08:38:04 -0400
Received: from mail-eopbgr140115.outbound.protection.outlook.com
 ([40.107.14.115]:4450 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0Oro-0002Gv-Gi; Tue, 28 Jul 2020 08:38:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2ndUiBu4WobgeODtv3MzAGvhTAzf3LdAJ1uA54E0/zLAR2a3rcBVMc13o89FtN7w2gcC6UDNNvIRzfQzMExQWPXhgPRoqmi4IygkNUducRv/HE/5lYlYSBKBTQLT5Y+cu6hW4Hw4r50mrHsU9Q2rwmy7YtuerXHW7YKE0rslMdI13zMXWXfENci03qE5L8RAhBR58J1GAd3QkPsD0bZr2V72XPAeLmBBUYEQ0S4eMn8A7JyUmi0nytKyy88zpDH1tXrLT2bFZCF1H1NEr/eI7wibf2kuX7yTg1skYEuRu+tFLzEP6+W4GaI4UJlPkDvitbLQtkp0EWDwndYNfpifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9o51S4tsVoPIzJ3GLbfSk50A7U9TWQDlqSiU7z9sD0=;
 b=U2DXZSUcxOp45J0i8sZ3fduHt5KmEdUaQVdsLJBDJCwGh1N+BzN17LSjZRjMV0fdcPLjmSjeZUn/MAsfmrk+zWNaMUxfDTud5G622gPmjyg4l/eANn94KfifzaqyNyDxUQ66FYeqddwy7jkgC0VO/xjmDP0Kf2vBj8RDtok5hpfe8AAYT2lASULO6GYvmcBk4iG5wrLw1S5tCY9kquA0So8PO0xWENyi2y5uISK889S+fyBMtpnd10enS6Yq3kZ9B0ioBVfHkQszJLqKqTtcQuYCtHLLOn5qNOffdQh3GnPEc3t9fvYwF4q2mAGRhEv64tRtBFAsVqkj2aWCsDt5OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9o51S4tsVoPIzJ3GLbfSk50A7U9TWQDlqSiU7z9sD0=;
 b=cOwOqbT4MD6gburcKZscVf4gDz0XB2sCRxCHjIy2qDseJ5d/Ak/n07HT8HxoR3Xwc3v2udH6tuwXPL6GTyGsg+CZ05S6oWyeBiC4l5SekS1Tqx3s828HpZICfMyen3M8Ruy/egjL0Ijzatqar5BK1Ghg+SlriF4yY5qBGsn3MkA=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3894.eurprd08.prod.outlook.com (2603:10a6:20b:90::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 12:37:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 12:37:57 +0000
Subject: Re: [PATCH v11 11/11] qcow2_format.py: support dumping metadata in
 JSON format
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594973699-781898-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594973699-781898-12-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d9707b42-a1da-5485-c994-8cb19455de74@virtuozzo.com>
Date: Tue, 28 Jul 2020 15:37:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594973699-781898-12-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Tue, 28 Jul 2020 12:37:56 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65108940-e119-47b8-ebdd-08d832f30e43
X-MS-TrafficTypeDiagnostic: AM6PR08MB3894:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB38944E5F0CE6A8A23FA30CD7C1730@AM6PR08MB3894.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0X48rc5vuYm70ijaq9+mFZCyujiOrHvi6pFDqU+BBAgPEQ1OQRyEZXzGvTQRrfQGxhDuEBfyjK3ZvkgGlZyzPJOyLJxJxvAYHs5zHfZs32264Ftwt19xf4Xnisa5vwICSYWwv4L1r3BnxToM5djei1JM05vVWmXsBxB4c2yQuPse+r+dcxMV9fJeMnabMKhVZzGnVpLk9HaQmyjJ1zTINQOwQmPT9mgOmhaFRHrRcqbRIZ/iLr1kT9/JTC0ShHIx2xW24hHBOgcsw5gppcqc0KQIGzcf/lCGIB0qJKgXF8b+hDTIF/5ajhM0wmTlA0NdTLPlwQOGq6MseffM/zq7uUNVl7WctSoOepVdwxlzvjDA4EeqMNFB4TDA2sH4/Ymi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(376002)(39840400004)(396003)(366004)(31696002)(52116002)(5660300002)(86362001)(4326008)(2906002)(26005)(107886003)(66946007)(16526019)(66556008)(36756003)(66476007)(478600001)(186003)(6486002)(16576012)(19627235002)(8936002)(2616005)(316002)(8676002)(956004)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sk1ioBJ3yEwrWIioYSm26HEP2+fQg3f2YSd3I9WQKtkAAknxU0uekibiLYS7Mg1egm6/d+BrrvzxM9ONn89/RXWboP6WMnGT9d1P6e1ecR3rLL5m9vy+b/KLNkSLTKDBoIqJv4+hkL0Ub93st7dNQAKsqKgLwwTLr7/7DpVbnkJHWE+YsGFtjagAulye7bPRXIJs/KG8jOpFI2ABzS5yY00LG99ozLTqJp6LSkzsuxbj39nKTGepaHuyd5smlqyTWUoyTyOAE22DmMAr/wNNox7oCtGjic4CPRBwI6yruUdoZR7H316DoBaSd7TLGRBQkEa/XoKp81pRpbxkq7zb4oxGQGcjw9C6ybE/aVjrx7eYC3ZfN/NwpWEpTN3puvpe4FO7IIO68BIZRVLrO22RyWYnMJrh0lhZanEggJuDFQJBNCSkgc7ty8rKWwqudHKc3HJMAj+QUj5l/myPlsguIZPBoLwEVAIqa8FXMo3lUxVH8GIIy2KjOm0g2x5DkJda
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65108940-e119-47b8-ebdd-08d832f30e43
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 12:37:57.1983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5Ci/423SRuZJ5Yg2AC/Tm6uoffgIcyNpXtxPLat2A3j3LHMwhEDubB7sbgDwfy5MVMUlVi7bBoPM7ppbSAQUaSeLXPhOokjtqolpH+U3qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3894
Received-SPF: pass client-ip=40.107.14.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 08:37:58
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.07.2020 11:14, Andrey Shinkevich wrote:
> Implementation of dumping QCOW2 image metadata.
> The sample output:
> {
>      "Header_extensions": [
>          {
>              "name": "Feature table",
>              "magic": 1745090647,
>              "length": 192,
>              "data_str": "<binary>"
>          },
>          {
>              "name": "Bitmaps",
>              "magic": 595929205,
>              "length": 24,
>              "data": {
>                  "nb_bitmaps": 2,
>                  "reserved32": 0,
>                  "bitmap_directory_size": 64,
>                  "bitmap_directory_offset": 1048576,
>                  "bitmap_directory": [

bitmap_directy is just a list of dicts..

>                      {
>                          "name": "bitmap-1",
>                          "bitmap_table_offset": 589824,
>                          "bitmap_table_size": 1,
>                          "flags": 2,
>                          "type": 1,
>                          "granularity_bits": 15,
>                          "name_size": 8,
>                          "extra_data_size": 0,
>                          "bitmap_table": {

.. can bitmap_table be just a list of dicts as well, not {entries: <list of dicts>} ?
>                              "entries": [
>                                  {
>                                      "type": "serialized",
>                                      "offset": 655360
>                                  },
>                                  ...
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2_format.py | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index d2a8659..d40eb49 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -19,6 +19,15 @@
>   
>   import struct
>   import string
> +import json
> +
> +
> +class ComplexEncoder(json.JSONEncoder):
> +    def default(self, obj):
> +        if hasattr(obj, 'to_dict'):
> +            return obj.to_dict()
> +        else:
> +            return json.JSONEncoder.default(self, obj)
>   
>   
>   class Qcow2Field:
> @@ -110,6 +119,11 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
>                                for i, field in enumerate(self.fields))
>   
>       def dump(self, is_json=False):
> +        if is_json:
> +            print(json.dumps(self.to_dict(), indent=4,
> +                             cls=ComplexEncoder))
> +            return
> +
>           for f in self.fields:
>               value = self.__dict__[f[2]]
>               if isinstance(f[1], str):
> @@ -445,6 +459,12 @@ class QcowHeader(Qcow2Struct):
>           fd.write(buf)
>   
>       def dump_extensions(self, is_json=False):
> +        if is_json:
> +            ext_doc = Qcow2HeaderExtensionsDoc(self.extensions)
> +            print(json.dumps(ext_doc.to_dict(), indent=4,
> +                             cls=ComplexEncoder))
> +            return

I'd prefer to get rid of Qcow2HeaderExtensionsDoc.

Could we just do something like json.dumps(self.extensions, indent=4, cls=ComplexEncoder) ?


> +
>           for ex in self.extensions:
>               print('Header extension:')
>               ex.dump()
> 


-- 
Best regards,
Vladimir

