Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC276C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F8C204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Apkfu6A/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F8C204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw10g-0003b7-Ks
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw0zu-00032k-MU; Thu, 16 Jul 2020 06:20:14 -0400
Received: from mail-db8eur05on2136.outbound.protection.outlook.com
 ([40.107.20.136]:57377 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw0zr-0005si-DX; Thu, 16 Jul 2020 06:20:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXI05gXADXUuwWMLtq31jDsdcegNsTvfxOWCGOWXSD4oUKXQElDR0UNZqJOIcGFtXuUaZKujPJuvm2xTtSHc8qJv9z3B9CM4oy/W5sVXiRSFUngJlOmYKmBLHmMECWQcMtqpuf4rfhfHN71HkDD3GtfVfPnWb1swkdPTu1v9pn+UjzVj55PcZpgAdDlBZUN27Hz5LjW48wy4P/KgeKgyq0kJE1vtnIa5spHgEb0nuVGBcv9V+Eg4SRzkc7RCUP5wSz3df5+pv7z/lPQeGFadJ3NVaTW7dzy7FLyzFx+1Kbmo8vOa/rrjApj9GEc/cXzIOm0zwCWX8npc2URO3g40LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ttzd2bnfectXNzvMGAL1BlRg5739IRJt4EmIJ2g9NI=;
 b=Xl37Qfny0b3fse+aAjZTj8hVJ9Ng1k+bIJgF5jKWTqEMHPt/t3XZNW00RqlXXd6BfyMaXtGkkaFki9H6fmhuPJD7FBecFCsbpg5j3uvm13x+NtaNNYmwwzWFPJbJzg3dEkCqkHlmsVxBtloPcaYgUxjWWwqWeuUYF/QOKOH/blMqJC+ZolO85aEw/CBNUYofVUKS/ngVGlC49M0GZJmHXp9EOoF8sRlrOXxRP3akjUDDsM4oIkDYj2r2zflglrRRQF2rUUmx5xpwx5vatYr0NFOzREIMq7+Dr5ooFRuvz7rwP6FkAW6R3+kIuZCgOE5MOOTB6yKWRN80TSEw++9TDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ttzd2bnfectXNzvMGAL1BlRg5739IRJt4EmIJ2g9NI=;
 b=Apkfu6A/3+j+wJODeOuJrFDkjLo61/YSynTTc7t+xNO/zIsomw6Y/T+d+GWqsSVwRMzwvevnpwTjpfb674K/HTt6Y8TjzXnXgLkFN9HT+9ztDk4hLlompTLMNN0Haoik5swhosdYCJKYSa8lA2phBMpmAYyRz1J5r1FFYJ4AuGE=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4851.eurprd08.prod.outlook.com (2603:10a6:20b:c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 10:20:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 10:20:08 +0000
Subject: Re: [PATCH v10 08/10] qcow2.py: Introduce '-j' key to dump in JSON
 format
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594676203-436999-9-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <761829e6-ba9c-c8c0-8f37-976e37fcb6d0@virtuozzo.com>
Date: Thu, 16 Jul 2020 13:20:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594676203-436999-9-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR04CA0139.eurprd04.prod.outlook.com (2603:10a6:207::23)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM3PR04CA0139.eurprd04.prod.outlook.com (2603:10a6:207::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 10:20:07 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5971fde9-4beb-40f9-359e-08d82971d0bb
X-MS-TrafficTypeDiagnostic: AM6PR08MB4851:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB48516FA5AABDDD67C4BB926CC17F0@AM6PR08MB4851.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ByNyN0DAE7y0haAVAJNsEqjI99fH9kpbuyF8Phv7NKEwf4l/ZkQkrtdacxN7dhMpD3aEjOUNofeJv+vOQQJTOPdNuFts8S8n5O0ihXxYn5KPaGMJkk+qqNIVJZUoGUa79GHozUbKRPx9L36WJgjmEjBEpbYJxpj2A+Lv9lWAJEEpWYA0urVPNb71uj+Xp3KFKdvF/38o+zuZ5hOz/k06PVzhgGtHjZnMcBK24Ga3drVenTWSFO3daJbPblDwe+gJz3lYf/l/d2Invv7QPt8UJHlkwDz5mKT/ZNsoTG6rnbBogRrn6JWI6DPke0KR7UAvpHmFvxwF2Loyuyj56fd1/9JdwhlELG1KmFqjV0zllGoHf6REHJQXsdArquzA9kek
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(136003)(396003)(346002)(376002)(66476007)(16576012)(66946007)(2616005)(956004)(186003)(8936002)(31696002)(16526019)(26005)(86362001)(66556008)(83380400001)(4326008)(6486002)(36756003)(52116002)(107886003)(5660300002)(316002)(8676002)(478600001)(2906002)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: IaBniU5gbPmJmH8qHN1L3I/DzldtL07Z+Pfz/leJwcs2ZjDaKNUogs7rMymctD83Fqnud3XG6M4WW7inS49ikt5sip7fWEOTTkoyS2bovqmRgH84EIPOHlyHinCAA/2a8xNwddKTad9dySoOnjemW5tNVszx5jHGuP0lFoXZj5XOGEvoZoe1rMa5QFadtWs+c18/2aGIQEqpk1rfeajVospDH7SY1oGoBE/9MfQvwhmvuK5VdBckZhs+0MGf2etc1uRPqQzGge5VJo2BbFYAOUAg7QA2nO7aFHGCao0pIDDG1QESd12pROXm/fZFj7DO0TX1BFQcaXe437T7uJeFIKFMpR9F2AUo1NeHwAlKEPW/oY0NMYdbumBLppYN5ZPXIxWJKjf703Q+3x6zLsGu4PmZ8KQhhHACnCkSHTa2DcAwW91Scr6zwsZKlBod12pz/JVGcxIBqLkZ2VybYIZ58KCg6oZiBY8Bt9aft5KYyB/o7je3Ph/zWdwDGBR7Gr+a
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5971fde9-4beb-40f9-359e-08d82971d0bb
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 10:20:08.4879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5VCzkAMoH0fiQs0dby0qlNZMLr9L47M1ceAZ9oi0zqc6j20AAXD/0NdHxWV/UPEaOTnBw83HJIi/MgOSgK2OAs6hbdZaZjGU49Gm9YD0pQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4851
Received-SPF: pass client-ip=40.107.20.136;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 06:20:09
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

14.07.2020 00:36, Andrey Shinkevich wrote:
> Add the command key to the qcow2.py arguments list to dump QCOW2
> metadata in JSON format. Here is the suggested way to do that. The
> implementation of the dump in JSON format is in the patch that follows.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2.py        | 19 +++++++++++++++----
>   tests/qemu-iotests/qcow2_format.py | 16 ++++++++--------
>   2 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
> index 0910e6a..7402279 100755
> --- a/tests/qemu-iotests/qcow2.py
> +++ b/tests/qemu-iotests/qcow2.py
> @@ -26,16 +26,19 @@ from qcow2_format import (
>   )
>   
>   
> +dump_json = False
> +
> +
>   def cmd_dump_header(fd):
>       h = QcowHeader(fd)
> -    h.dump()
> +    h.dump(dump_json)
>       print()
> -    h.dump_extensions()
> +    h.dump_extensions(dump_json)
>   
>   
>   def cmd_dump_header_exts(fd):
>       h = QcowHeader(fd)
> -    h.dump_extensions()
> +    h.dump_extensions(dump_json)
>   
>   
>   def cmd_set_header(fd, name, value):
> @@ -134,6 +137,11 @@ cmds = [
>   
>   
>   def main(filename, cmd, args):
> +    global dump_json
> +    dump_json = '-j' in sys.argv
> +    if dump_json:
> +        sys.argv.remove('-j')
> +        args.remove('-j')

I'd prefer to access sys.argv in one place (in "if __name__ ...").

>       fd = open(filename, "r+b")
>       try:
>           for name, handler, num_args, desc in cmds:
> @@ -151,11 +159,14 @@ def main(filename, cmd, args):
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
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index 2c78d46..e0e14b5 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -109,7 +109,7 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
>           self.__dict__ = dict((field[2], values[i])
>                                for i, field in enumerate(self.fields))
>   
> -    def dump(self):
> +    def dump(self, dump_json=None):
>           for f in self.fields:
>               value = self.__dict__[f[2]]
>               if isinstance(f[1], str):
> @@ -145,8 +145,8 @@ class Qcow2BitmapExt(Qcow2Struct):
>               [Qcow2BitmapDirEntry(fd, cluster_size=self.cluster_size)
>                for _ in range(self.nb_bitmaps)]
>   
> -    def dump(self):
> -        super().dump()
> +    def dump(self, dump_json=None):

strange to make None the default value for boolean. Why not just False?

Also, why not call it just "json"? We are already in "dump" context, no needs to add prefix to the name.

> +        super().dump(dump_json)
>           for entry in self.bitmap_directory:
>               print()
>               entry.dump()

How will it work? You are interleaving json dump and non-json?

Looking at this, I think that json and non-json dumps has more differences than similarities, and it probably simpler to make a separate function dump_json.. But I'm absolutely against an option, if it will be done consistently.

> @@ -190,7 +190,7 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>           self.bitmap_table = Qcow2BitmapTable(raw_table=table,
>                                                cluster_size=self.cluster_size)
>   
> -    def dump(self):
> +    def dump(self, dump_json=None):
>           print(f'{"Bitmap name":<25} {self.name}')
>           super(Qcow2BitmapDirEntry, self).dump()
>           self.bitmap_table.dump()

Here the new option just not passed to the nested dump() calls..

> @@ -291,13 +291,13 @@ class QcowHeaderExtension(Qcow2Struct):
>                       data_str = '<binary>'
>                   self.data_str = data_str
>   
> -    def dump(self):
> +    def dump(self, dump_json=None):
>           super().dump()
>   
>           if self.obj is None:
>               print(f'{"data":<25} {self.data_str}')
>           else:
> -            self.obj.dump()
> +            self.obj.dump(dump_json)
>   
>       @classmethod
>       def create(cls, magic, data):
> @@ -396,8 +396,8 @@ class QcowHeader(Qcow2Struct):
>           buf = buf[0:header_bytes-1]
>           fd.write(buf)
>   
> -    def dump_extensions(self):
> +    def dump_extensions(self, dump_json=None):
>           for ex in self.extensions:
>               print('Header extension:')
> -            ex.dump()
> +            ex.dump(dump_json)
>               print()
> 


-- 
Best regards,
Vladimir

