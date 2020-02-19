Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839DFC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A4D2464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wkWaNO7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A4D2464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Ski-0001RW-Fw
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 12:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4Si0-0005ZK-AA
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:00:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4Shy-00028W-5s
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:00:23 -0500
Received: from mail-vi1eur05on2106.outbound.protection.outlook.com
 ([40.107.21.106]:64480 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j4Shx-000285-Tk
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:00:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaOgq3VZei/RTqvk17Jb67A8+3SuVF5VAwrTM7Y9BLb9bx4S+McGDiXwS7pON/FpgGgaxw0axv2OhGP4B/z+Hi0Eb/Z7z6dbFAYn8E0dQXskNrIuHillWo/vsmxD2Jhkw4cQK9jhOOzm/kPxIgWwWiimar3baclOk2gTF1yMPw+w7ZtND0XTcI/eRQBNVN1J6aB1ltKAQnWHLyDihVneqg2aYZmNEYQEnBoon/sl6JmuukfDI7ozRtGukdUwLYP06OoOGnSVusrTLe3E6zvf1l3AYXtwKTl/2xZtn9OYqHUWYwuemueF58RUK552eDD5OCudzg8hB5i8KcmgmrCGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ugnt9fX/7BVqJ4+MzPg2CAhkTGWW9aXGJSbBT4YOdM=;
 b=G3A3AZ8VmlU+tQTG9QrDlSx6eJjeKOD/fxMK7ICICkMV2Mko5ErG51Ifiw70GCayc+r6aMCnnzQm0KjHb+yca8HvStaf1auledUpbwA2qiw6a4ymnuharmODhPslk71ZULWGjq5eJdIHU8OhAOC64XAlG17coXV6D92ln9E4Fgi2lCghIYDear7oqPCFTafTCgN7HTaOUxbbaBBiC8OYcOmY7Tb6qonMC8jDumCj62jr//hVVsmIJlzDuBf2BQ7JCQ3ae7o7RW+mTH0p+yaiKro3aCnxBypWlNw+2gMQr1q0Jjh31hR2kbxFEWy0tTfk1VnQcVmVuzAME6s7HnmAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ugnt9fX/7BVqJ4+MzPg2CAhkTGWW9aXGJSbBT4YOdM=;
 b=wkWaNO7e+yZlvlUfp2kHJ50CX6oSHqzEiqDXmGh4R8Nz6F39MZUq/ihhGDeDs4m1Ee/J0eddxJtZwk3lJraaTDWkk7lzGahDKo1DLXT1xN06pY0RWHXCcFxWxycwDSU1f7T8vXOZE4/is9Uu4CzLwUJZGAEgLY/lbC8uIUkryLM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3287.eurprd08.prod.outlook.com (52.135.161.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Wed, 19 Feb 2020 17:00:19 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 17:00:19 +0000
Subject: Re: [PATCH v2 18/22] python/qemu/machine: add kill() method
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-19-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <b9d5d4c2-df8d-f6c2-a8a6-beac5b46d4f7@virtuozzo.com>
Date: Wed, 19 Feb 2020 20:00:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-19-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0301CA0007.eurprd03.prod.outlook.com
 (2603:10a6:3:76::17) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR0301CA0007.eurprd03.prod.outlook.com (2603:10a6:3:76::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 17:00:19 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1947aeb1-2db2-499e-5053-08d7b55d3355
X-MS-TrafficTypeDiagnostic: AM6PR08MB3287:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3287FB022187788578AB074CF4100@AM6PR08MB3287.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(396003)(376002)(366004)(346002)(189003)(199004)(36756003)(478600001)(16576012)(52116002)(31696002)(36916002)(5660300002)(316002)(8676002)(2906002)(81156014)(81166006)(66556008)(8936002)(54906003)(86362001)(66476007)(2616005)(26005)(4326008)(186003)(31686004)(44832011)(53546011)(956004)(66946007)(16526019)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3287;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FoMEaCRl1zjfHNeik0HTSehdAeX4QK7oRUbI31F1wAxkAUUdOkDTYG0DyqVT9He2jgug36ORyXSq0RN/ftUfIyl8YraNm585G2N+brB8NPL8PGM8HMrZuX44QuCns1UCwM+FHYT1C6j89P69lH3SJYQmYu/WfKgBauzfb1KFvS4CtKmSjtXi1AirwOZRlLXPBcrEHmQSZyS0qEujuGs6DR/c/jDyecbfz5NeMlNWFELmVOj0YPdklkyHMC3YQDJMlM63DKvvzFyzvotpTRmGtBxG7EEx+FcMqXiExqfXFdiQZCJQ5O1k2eSYNRfrZZni5cGvrN4YMFqehVrdD9bZotMYZb/XTGuNvBDkufqoCnxiOYxp3WBO+kXi9Nj+wJBTdrzbeFjvgxe/qgNFR+Q8NkpSPKWcz+6l82XguHxmLqpKFKf6T1XJ1PCqCpjXuc3
X-MS-Exchange-AntiSpam-MessageData: fwGjy41EzNyv+sdW7AL/Kn6XPnZ+hoQn+CEATYQwI+fjSJwfoCJdpn6NuK0YoYrXWqhoDOp5JeRxToIoVHDwZSNyFBCe3rUQgot//vvY5gQnBRQOzGu3SmJ9d3ihsJjXcm/ASC3NNPoxklWtcnqXZw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1947aeb1-2db2-499e-5053-08d7b55d3355
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 17:00:19.5158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TH2dsMdZw7JBAwwaWwLjQEKN21IQVjf3R0pUaPhuaILkjFmzsfJDButBV6nLgLnQNizsGPQnJ7y3N/iEebw2zbJ6dp2R6yoW2tbh1aP2zpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3287
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.21.106
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
Cc: Cleber Rosa <crosa@redhat.com>, dgilbert@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
> Add method to hard-kill vm, without any quit commands.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   python/qemu/machine.py | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 183d8f3d38..9918e0d8aa 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -341,7 +341,7 @@ class QEMUMachine(object):
>           self._load_io_log()
>           self._post_shutdown()
>   
> -    def shutdown(self, has_quit=False):
> +    def shutdown(self, has_quit=False, hard=False):
>           """
>           Terminate the VM and clean up
>           """
> @@ -353,7 +353,9 @@ class QEMUMachine(object):
>               self._console_socket = None
>   
>           if self.is_running():
> -            if self._qmp:
> +            if hard:
> +                self._popen.kill()
> +            elif self._qmp:
>                   try:
>                       if not has_quit:
>                           self._qmp.cmd('quit')
> @@ -366,7 +368,8 @@ class QEMUMachine(object):
>           self._post_shutdown()
>   
>           exitcode = self.exitcode()
> -        if exitcode is not None and exitcode < 0:
> +        if exitcode is not None and exitcode < 0 and \
> +                not (exitcode == -9 and hard):
>               msg = 'qemu received signal %i: %s'
>               if self._qemu_full_args:
>                   command = ' '.join(self._qemu_full_args)
> @@ -376,6 +379,9 @@ class QEMUMachine(object):
>   
>           self._launched = False
>   
> +    def kill(self):
> +        self.shutdown(hard=True)
> +
>       def set_qmp_monitor(self, enabled=True):
>           """
>           Set the QMP monitor.
> 

It would be reasonable to number this patch the last but one, that's 
right before a usage in the patch that follows.

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

