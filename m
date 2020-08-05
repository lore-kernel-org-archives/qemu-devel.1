Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49819C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 17:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F8E322CF7
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 17:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ylm4PQ/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8E322CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3MrG-0008MZ-8W
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 13:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3MqG-0007ZK-R3; Wed, 05 Aug 2020 13:04:41 -0400
Received: from mail-eopbgr70108.outbound.protection.outlook.com
 ([40.107.7.108]:18501 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3MqC-00066o-TK; Wed, 05 Aug 2020 13:04:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BK5hO3WbqWkVwToI798m5VR+leYgO8Hxl7fjl3cWiw7osEkzlCw8EpPAS72CchbR/rlLXi/Vnb7NicS2LrWv91U/VBL/MY/VTBZEKwCCOn1TACmNSY3I/jYEqkc8LkDIdnUNtnSXzz1UIyke9XCpDpsGcSO+j0NHR6esZlaSnRcDy+4QVrefLMWSlMiKka/m7juKTUF+X1q+PpATRYxbq5kzD1xqI4pka8IzRu+kIATf3U1sUvFkfud2rWo2L5m5zOXWL0T9IesdwTZPBo5kOy7onVHZM/XCwVgqhup52Yok29kCiGmnUGUe9+1qWkvwSFd9Bmf5Xvts066M7Och8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Dr6SUbIppU2aqiGJGzPLjGeaErwDwB/o7DepjfcfSA=;
 b=IzQ6dOTTBdooQVs0YUjvqBlOMfyl1smdRjiHIqeNAGxnXYF+pJ5fSW8ww+wSFxjoUJos1RX9cLq8U/jmd0G186IDIeMKRGE+m/7INuUl7xEHUJSwLzvE5UZXxiYejwIkSeQQ5+pFvAQuX8ln2KEJ0YaxgxISkD+R2+jEZ9XRPPCyhwUZL8ccmqz4V6/xMZ98wtmH1RYFsVYaIClCoO8I+I6kQc1qh+YmdlSPgXMcUzO4Kb55i1z1Rx7MKTAOkfASHlcGRcDLHLgFheC+EfnLKZTMFISzS6sfPf5fJiXcBntqeUGOW5+27OWE0okvtb0RTkMYapiOBDwos276iSL2TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Dr6SUbIppU2aqiGJGzPLjGeaErwDwB/o7DepjfcfSA=;
 b=Ylm4PQ/6QJfWu4jqyh805r9cKNdfl7SiJskSgOMB0K9wgBsRoPkRTgxYk6i8pfKF3gq2cYJwujd0I61qnKbGECPbEuP4tjJTw7jYtBRwS9YcbcWx9e0vnrJbe2S2ArM52SCuPxMNaxQyJzwDaa6KcFtPZ5B9pjSH16I8qbj6EY0=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2609.eurprd08.prod.outlook.com (2603:10a6:203:98::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Wed, 5 Aug
 2020 17:04:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.016; Wed, 5 Aug 2020
 17:04:34 +0000
Subject: Re: [PATCH v12 10/11] qcow2_format.py: support dumping metadata in
 JSON format
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1596118512-424960-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1596118512-424960-11-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <41652301-1c25-3454-ad77-3880d98a91f8@virtuozzo.com>
Date: Wed, 5 Aug 2020 20:04:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1596118512-424960-11-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0142.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::47) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.157) by
 AM0PR06CA0142.eurprd06.prod.outlook.com (2603:10a6:208:ab::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.17 via Frontend Transport; Wed, 5 Aug 2020 17:04:33 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95667193-fbc4-46b4-1f0e-08d83961a074
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2609:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2609FFBD3EE60FB5F4F21E39C14B0@AM5PR0802MB2609.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oOA23aP92KDdjaGmyUqqEIFask87eoq8sbYH5uSzYvbLOYdUDQz7ZMtZtzpxnVqnbLhP4w1se9/5hi8HMVRwvKvoBUz99BBuIt08aV7att5iSmNJ9VMypCoSRJzYvSbViHfwBphV4LNq2H0/Pxsp0+VocHUBE6KcoHPuxO+pgisB1LWYXL7c4ktRyWfTSnymRYO1fj40Te4Bnkzr+Ab6yuMMY4FcmS2fGRY5tHL4St/GhrSUXQYKYpIZAkLfdDPukqiD4EwJOit3lgDN5rDcsOMkiEGpHcD0rNKqw5fWQPIibANJjWlk+7U1qoHxbIAIHs9sAqooggiKkg233rECOlT7alpy11676tz2XTcYYkVyNOYJONuJsySaB8T82mm/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39840400004)(366004)(376002)(346002)(107886003)(86362001)(2906002)(31686004)(6486002)(8676002)(316002)(31696002)(16576012)(16526019)(36756003)(5660300002)(4326008)(956004)(186003)(66946007)(66476007)(26005)(2616005)(66556008)(52116002)(8936002)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cR/KB/m9iL+xKyBX/T6ETsNU6Y1vOx7xBL/zaQfv/oJLbapTKYE2Bl2/3G0ufhQjgNVNRFy0KB3+J/dNm+u/mmBNRZmH63ay0a+IEZOGzJZBZ5vEgMS0oiz3Hh5N07c8Cot5YIBzv0+PaTBmlKA3sGlqfx1mtsjUAU4ayR59Ju/Qv7KJB9E53f74Ssj/Ldzagyx5B+f5JmNCy8CsP+8fAw0aJJIxZAhUqCUjMh/jvfqh8RyRcl5nredR1p+7gYFCXZ/uhtZU0l1Beb0hwAdA6tazFeV9NqxO3AnbLhHwxq3R0Ggx1V+5To3QUFrBug+IilIjVYESA2qxoegYgBCF/33561j90fFgtPaaKj/rK+Xx+wmY5D7V6Rj4WlRD+VcHjSwXbwcBJFm7n/haZlhlXRuToUnqRGVaRAu/armgQhdLU/IUw1eyEMh2uyureSi9fO9hu9jH0b0t6WfR4KQJFC3c+TT2yOMPX/IQzH0ZFeKvmrGDrYjndX78iDVk962wP66YxIFaEhxP9HLLC45ioPh4aKSW3b9LW60sC2kP7tVMcs5EqIci0Vx1U6mJdWiWiJxIy8msDNFvR/ufzqfNpuaU/8ZNMyhrc1JQ4qL4q6pG9svc3isjFJIbzODNGDcPysMl5B5HEkdAgfm9h46J4A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95667193-fbc4-46b4-1f0e-08d83961a074
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 17:04:34.0994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SPb7BDKDp5Gk3jX15di1PSKtzZul7Qz9qAGnSWP076R80g1cppuwJjPB1NfaFyns/kvxFd9lGiiMzPmwcc7smszTxFPYC0E0EFo/ZAO1/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2609
Received-SPF: pass client-ip=40.107.7.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 13:04:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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

30.07.2020 17:15, Andrey Shinkevich wrote:
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
>                      {
>                          "name": "bitmap-1",
>                          "bitmap_table_offset": 589824,
>                          "bitmap_table_size": 1,
>                          "flags": 2,
>                          "type": 1,
>                          "granularity_bits": 15,
>                          "name_size": 8,
>                          "extra_data_size": 0,
>                          "bitmap_table": [
>                              {
>                                  "type": "serialized",
>                                  "offset": 655360
>                              },
>                              ...
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2_format.py | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index a4114cb..7487720 100644
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
> @@ -110,6 +119,10 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
>                                for i, field in enumerate(self.fields))
>   
>       def dump(self, is_json=False):
> +        if is_json:
> +            print(json.dumps(self.to_dict(), indent=4, cls=ComplexEncoder))
> +            return
> +
>           for f in self.fields:
>               value = self.__dict__[f[2]]
>               if isinstance(f[1], str):
> @@ -440,6 +453,10 @@ class QcowHeader(Qcow2Struct):
>           fd.write(buf)
>   
>       def dump_extensions(self, is_json=False):
> +        if is_json:
> +            print(json.dumps(self.extensions, indent=4, cls=ComplexEncoder))
> +            return
> +
>           for ex in self.extensions:
>               print('Header extension:')
>               ex.dump()
> 

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

