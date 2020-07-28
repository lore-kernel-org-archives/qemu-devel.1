Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E4AC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FDD20714
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Vv7Fx5Ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FDD20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0MWY-00040B-CO
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0MVy-0003Ur-FZ; Tue, 28 Jul 2020 06:07:18 -0400
Received: from mail-eopbgr60113.outbound.protection.outlook.com
 ([40.107.6.113]:7604 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0MVw-0006cz-Kj; Tue, 28 Jul 2020 06:07:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbxY7odcm91QVhjPQ1lhe7dly8ggw3uCjaIYCTbiYiqepNOgEeCkywo4uKiwufL4d1EBbIiw+LcNyrJhv/AOXs4rvZ2WP2upNLJJfd/b3ZxElbBYU4DQNvQA54dcc2KefuZSv5BD9Mvk6BFgvc3NiADnADH4yzkMdBH+mh9Dr07x68SylL0nRoVXlpUbC1VH9sal/ZhB+BtWU4OXkCx43qMmwKfoawLUp8qlLBBDftYPEjhm4xr8gCrU+LLO8qJUx2V4TdMwWM2WfJgZs6DU0Szv7ktP79NZC+bkFEidk4uFwUn069SlliPmDOoWsLDlz5xpGvCMAQh6Hwyk/m6z2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afKh6gHIZ4FOkWyhl4+lXreTfUHlCFBcflzx/SFZgo0=;
 b=I9/LUUWc5sCRdxBCYLZe5peti+UeHWMJIwEaIL26RRowU+bM1O6SLNn1qSfEk+0r4oGWQxINKYJ8ow8qa74TgG424aNP0HgB534BTdoACjtEKs1H/8/CrTOdW1WsMkFcK9D1J4IkCBpiOVcI7dqRY+imZouyKEhMhpLIuGvx5L5zqLGP+xS4PLIiV0qOjqcP25E0e2hjuFsw6YpINEEKmOn+gu/xpGoRJcE4LAXyxmW504GdobgHvsHBwAHtOID7AGHyiGAqFEplE22iNzB1s2CJrBk6/RN9uaq9Hazw118KVzTbqV67xriqsPg8OPZRW5PCFWpHGjXW34PtdYgh1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afKh6gHIZ4FOkWyhl4+lXreTfUHlCFBcflzx/SFZgo0=;
 b=Vv7Fx5Bave1XyZjyr+VhguAiReKUNBdCROT0NtJuV6nRDKqNWgR8sZZMdTFfQ7Fe5HOFxXu0AWcE/yN/Xy+TgONOcC8Rb10bQQvP6krMBdoaLnCZxG4Qc/alZJJwfYNHfuaJZXmAFJHfA4VM//yvotuM4CwOAPO1qkI89ySaJg4=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3383.eurprd08.prod.outlook.com (2603:10a6:20b:50::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 10:07:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 10:07:13 +0000
Subject: Re: [PATCH v11 08/11] qcow2.py: Introduce '-j' key to dump in JSON
 format
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594973699-781898-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594973699-781898-9-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7a776fc5-707c-4750-074c-d8a4a58a1871@virtuozzo.com>
Date: Tue, 28 Jul 2020 13:07:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594973699-781898-9-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.9 via Frontend Transport; Tue, 28 Jul 2020 10:07:12 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d61f07d-1bfa-4fdb-13b3-08d832ddffbe
X-MS-TrafficTypeDiagnostic: AM6PR08MB3383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB33839CD5D051D8521488D4EEC1730@AM6PR08MB3383.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1D1VkUI9rhWWmBnxWP+yN12xAyJzbjZUtk3qqAqe4d4iZBvijI2oO12oqiARO4FUJAFcfIVBOOIi4kheVQEHekkuBjvzOAXU8AvAcf5gw8JxxQ3n/8pb8b9zK/ScG1bG4+pXhjZVYUyYf9eky/5bo0Psrf911xBVJHkuOz4hhbqhvuVYolOr8RIdKDGUz2gLtDOpEUF3oLYlU5xCaK/Zx7LNYMS/lpN0fXp9wyS8c/Bz37gc7SFosHCoDuF6Tr2OcuanK6rMRpQlz9JBS/1pp65S00PC966Fx8ZQqyoWypqn8frRyNiyQwQ2sI8/yDWKu6x3bQG0/t0hu9wl0kmGeTNfS7pY3wnKOm1eX3Sw+IbDK5nTDJ7Yq4/zPdh+LoF3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39850400004)(52116002)(31696002)(16576012)(2906002)(316002)(6486002)(8936002)(5660300002)(8676002)(66556008)(478600001)(66476007)(26005)(186003)(66946007)(86362001)(16526019)(2616005)(956004)(107886003)(31686004)(4326008)(83380400001)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: t/bm/26j9duk6703HMwzz3h4g4ahJA2p7XNKBnpVLg1918P8dbPAirZVh1VfuvYMWfLBL7yOKcUUoO9/9NGRxPFa5RoKvOEbB7yCb3+8JeYtPuo3eEDi3JdbRwGhew0G2Kc9o3J44+Yx84fArUj3KiSplfqnodw3qw52NSXLUk9BIagN0ixBUNL8Dvih7279pIw5PJboFsEX5JB6Lcn8ZBW1FJSwgZGoWJepW9bO9UVfl+CjnEvRAIWuVSRu2Xrfu0oN/1/6uDwLEzXrJ6lLLvrvGT7yBuU6jd49HJldesrBLFkcjNa0ED2X9XO544dICzh0xlHAgZtwAUKfoYWcF+m2cnTiilZ02YahyBpqjmQs59o9mp/TdVhcgfcYebWvJXj6BSmvNFap+2IvB5JXN00QKXbONnWVOH9qmtMiUxb/abY31tq7dUMzZgzptGrQw+z27yPZ6xqZsaTN8pnE6J+clt4qzrPqpstEMTT9kG79cS9OWydae0BYwn0FNmmU
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d61f07d-1bfa-4fdb-13b3-08d832ddffbe
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 10:07:13.3908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBEQGjxeLS0hGKjd6piZ4vVgMkWgFfIZtMcd3o2uvOIsDPlhK2uzXOgz8e3vfKcI0/BuolETw5NjRjzBymMCMk+C+NYNWSjYi97n8zp8eA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3383
Received-SPF: pass client-ip=40.107.6.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 06:07:14
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
> Add the command key to the qcow2.py arguments list to dump QCOW2
> metadata in JSON format. Here is the suggested way to do that. The
> implementation of the dump in JSON format is in the patch that follows.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2.py        | 18 ++++++++++++++----
>   tests/qemu-iotests/qcow2_format.py |  5 +++--
>   2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
> index 0910e6a..77ca59c 100755
> --- a/tests/qemu-iotests/qcow2.py
> +++ b/tests/qemu-iotests/qcow2.py
> @@ -26,16 +26,19 @@ from qcow2_format import (
>   )
>   
>   
> +is_json = False
> +
> +
>   def cmd_dump_header(fd):
>       h = QcowHeader(fd)
> -    h.dump()
> +    h.dump(is_json)
>       print()
> -    h.dump_extensions()
> +    h.dump_extensions(is_json)
>   
>   
>   def cmd_dump_header_exts(fd):
>       h = QcowHeader(fd)
> -    h.dump_extensions()
> +    h.dump_extensions(is_json)
>   
>   
>   def cmd_set_header(fd, name, value):
> @@ -151,11 +154,14 @@ def main(filename, cmd, args):
>   
>   
>   def usage():
> -    print("Usage: %s <file> <cmd> [<arg>, ...]" % sys.argv[0])
> +    print("Usage: %s <file> <cmd> [<arg>, ...] [<key>, ...]" % sys.argv[0])
>       print("")
>       print("Supported commands:")
>       for name, handler, num_args, desc in cmds:
>           print("    %-20s - %s" % (name, desc))
> +    print("")
> +    print("Supported keys:")
> +    print("    %-20s - %s" % ('-j', 'Dump in JSON format'))
>   
>   
>   if __name__ == '__main__':
> @@ -163,4 +169,8 @@ if __name__ == '__main__':
>           usage()
>           sys.exit(1)
>   
> +    is_json = '-j' in sys.argv
> +    if is_json:
> +        sys.argv.remove('-j')
> +
>       main(sys.argv[1], sys.argv[2], sys.argv[3:])
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index ad1918c..2921a27 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -109,7 +109,7 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
>           self.__dict__ = dict((field[2], values[i])
>                                for i, field in enumerate(self.fields))
>   
> -    def dump(self):
> +    def dump(self, is_json=False):
>           for f in self.fields:
>               value = self.__dict__[f[2]]
>               if isinstance(f[1], str):
> @@ -147,6 +147,7 @@ class Qcow2BitmapExt(Qcow2Struct):
>   
>       def dump(self):
>           super().dump()
> +

Unrelated code-style. Please don't do so. With it dropped:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

>           for entry in self.bitmap_directory:
>               print()
>               entry.dump()
> @@ -399,7 +400,7 @@ class QcowHeader(Qcow2Struct):
>           buf = buf[0:header_bytes-1]
>           fd.write(buf)
>   
> -    def dump_extensions(self):
> +    def dump_extensions(self, is_json=False):
>           for ex in self.extensions:
>               print('Header extension:')
>               ex.dump()
> 


-- 
Best regards,
Vladimir

