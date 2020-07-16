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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70100C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2765C2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PBQeOeyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2765C2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw50n-0000Gx-FD
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jw505-0008Dx-3g; Thu, 16 Jul 2020 10:36:41 -0400
Received: from mail-eopbgr70135.outbound.protection.outlook.com
 ([40.107.7.135]:61646 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jw501-0007HX-OH; Thu, 16 Jul 2020 10:36:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lT7GrVgPqSNSPHWx/bJdxMm3/67UCyYpL95swMIJul43w/fUKAYJuA+9hHWRzbJb/G5Zao4fj0dQdzriTJad9eh60EwqYGPhLC2JVopCMTeJtB3EZp/mfWgULRtx2YHGAhazBH6kxte3wI6SKw8u7ECoQ6YAZL1r2nfAb4LBO6XjBe+2lmxur0K+NAAAaoH3hCKk4a3GPVxGMedPQ0rwKIr5pH7KOh8bhH2q77Tg9GS07lJuF6VvoENQx2UmoJhSM10PyQhwt07zcU7HMb1PaH4ikSfL0ErGNgW5eIX2JmgoXmFVwxioAZKGp2welX9WmhrkDnHTAXEVlKllYiNPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fALj+XFCT/TO1mOvpwq6g9XKahKvMUk2s3QewjG0tM0=;
 b=Q03yE7/emJK+TTGNZhy6f/wGDJrFuj6CQpl025WS5te0ELnUGIBzegwToVz052KFohv5eT/rZ3P9GxhIQPnjKqVW6mGBSoIIdwlSEyCHZoiUDD5smjx3GvM9FNR+Wqg4SgoXqcchK459CnmLpHnIdZ9zp5kI8EzlBBXWfV6M65F/4ftAIfDQcRg0mQX2SRkivPBEZYaN+OWHG7xUhm25K7hmMfvNLsiIPtskAON7vXPGLLV4mdIyPkQm8JP1nt0UrM7B7CzL70lhvtFarO4UEuHrJrZwd9CxV3dCxUNabAAZoMJbK7g05oo06z+9ebd6CY/RZXBa8BjRP7uy/a58Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fALj+XFCT/TO1mOvpwq6g9XKahKvMUk2s3QewjG0tM0=;
 b=PBQeOeyvpyJbEKnAJ4KyZ03wsy2/vQL7JVEFFp1cddtZQLCPfK1J2Fo/ztZRJ/KnRDXz3YjpmmCLKurZcDmHZFK0rA1XhUAxoYUfaucoYIz1OIsdWATEno2rYMG/aDLLzVfN0cj1TkSyr96hG8DTmVeltjAkhtPx13DifEqZA40=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3445.eurprd08.prod.outlook.com (2603:10a6:20b:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 14:36:34 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 14:36:34 +0000
Subject: Re: [PATCH v10 08/10] qcow2.py: Introduce '-j' key to dump in JSON
 format
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594676203-436999-9-git-send-email-andrey.shinkevich@virtuozzo.com>
 <761829e6-ba9c-c8c0-8f37-976e37fcb6d0@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <9377dc3f-002f-6761-bb81-17a17cfafb08@virtuozzo.com>
Date: Thu, 16 Jul 2020 17:36:30 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <761829e6-ba9c-c8c0-8f37-976e37fcb6d0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR07CA0057.eurprd07.prod.outlook.com
 (2603:10a6:207:4::15) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM3PR07CA0057.eurprd07.prod.outlook.com (2603:10a6:207:4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 14:36:32 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d404897-898d-48c5-2ded-08d82995a360
X-MS-TrafficTypeDiagnostic: AM6PR08MB3445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB34451A9AF6B08C1E772089CBF47F0@AM6PR08MB3445.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k7va2B9qAJrZUPuFFZv2IDhulAmC0YkPPnfs81UDfmlWWDc3NGDyXwyeCXlko5k00AivMQs+s7BJ39eAK2PZvPeaQFbyIKYhYHr96YChaz3Tux8li2qydzrplp664Kq0x0GcdNES9zUHtqpQLxJdx1kEzdozQAq9/rEv+dx1da/fUvYPzvLUO0+2S2P5OLMhPukPnIl4kx+yKbnmJ9Tul+avHEO3A5iFdvTLVLYkTJErs33YoH7gQnxEZMg29m9OXv1H2yqGgpTXx/Cg3cK8gbmx2XaHycAjXm7Khzbqk3Jz4VPQPHzt2Z4CzWLllSq5dZZoxFwcUGzE/ReH0dE0ZtQpitJC14H7O0uIU6Ysnngph59/UZuiuRUodBhBi4/M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(39840400004)(136003)(366004)(376002)(66476007)(86362001)(8936002)(5660300002)(8676002)(31686004)(44832011)(6486002)(956004)(83380400001)(36756003)(478600001)(2616005)(4326008)(26005)(2906002)(186003)(53546011)(66946007)(16526019)(66556008)(6506007)(316002)(6512007)(107886003)(52116002)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SzLlPb5ptNUwI6Ibw3cg2OK1AHhvx18AvUo7LaGMyvPJe8eJUXdxOUAZzh/brTvf6egaqweN5/PtSIsS+iS+HnfKWrW0wAwOunURZ6JFxtRBbtEd3hz5bChwJCrf5nrJmsYyc/XJR6bWu2jWIHLDh3ov46LsjRe0ONimoS0P9xgDnSz4xRG7zPIbSF0up4/uxxX3j+itSL4vMavWwNYUrJjI6UJ1f1Zsgkp/VsmOU+KjnMS0Y54o4rmy4P8cXyfFNUdTziXRperjrRtkIJgd5K8rlbD/z7DHsjamp8ARunNDsdQq2CRsAt9Jqxlyhjto2rYaTemL81CB7fT5A8O6TR/YSdy4zOhXI+uOBpWN2IZ2L/0sKxRBgE+ObNhm2zmgh0ksUD1mPY6NUE9RdFLR9PEfHM39rdYSP7cAtmRZLUIjtJpqFyLMclTeT/OnNQ7VhW0yfBuKGxPJdcxRrvYn5YDVczeX9brP6NxGlIapE09TQAwAWT/9wiDnyWDUWsN1
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d404897-898d-48c5-2ded-08d82995a360
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 14:36:34.2469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvYbjO6GlLJkUB9jsFiaN81Od0+i7OjUYnXvCBNFAwjLE7ZyhCvIHeHPPB6rxV+2kgWm7J+9POZBUx4uA2bMr6GInw0hX2I1gDjou5FjuPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3445
Received-SPF: pass client-ip=40.107.7.135;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 10:36:35
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

On 16.07.2020 13:20, Vladimir Sementsov-Ogievskiy wrote:
> 14.07.2020 00:36, Andrey Shinkevich wrote:
>> Add the command key to the qcow2.py arguments list to dump QCOW2
>> metadata in JSON format. Here is the suggested way to do that. The
>> implementation of the dump in JSON format is in the patch that follows.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/qcow2.py        | 19 +++++++++++++++----
>>   tests/qemu-iotests/qcow2_format.py | 16 ++++++++--------
>>   2 files changed, 23 insertions(+), 12 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
>> index 0910e6a..7402279 100755
...
>> @@ -134,6 +137,11 @@ cmds = [
>>       def main(filename, cmd, args):
>> +    global dump_json
>> +    dump_json = '-j' in sys.argv
>> +    if dump_json:
>> +        sys.argv.remove('-j')
>> +        args.remove('-j')
>
> I'd prefer to access sys.argv in one place (in "if __name__ ...").
>

In case we move the block

     global dump_json
     dump_json = '-j' in sys.argv

         if dump_json:
             sys.argv.remove('-j')

from main() to the body of "if __name__ == '__main__'"

we get the following error -

"SyntaxError: name 'dump_json' is assigned to before global declaration"


Andrey


>>       fd = open(filename, "r+b")
>>       try:
>>           for name, handler, num_args, desc in cmds:
>> @@ -151,11 +159,14 @@ def main(filename, cmd, args):
>>       def usage():
>> -    print("Usage: %s <file> <cmd> [<arg>, ...]" % sys.argv[0])
>> +    print("Usage: %s <file> <cmd> [<arg>, ...] [<key>, ...]" % 
>> sys.argv[0])
>>       print("")
>>       print("Supported commands:")
>>       for name, handler, num_args, desc in cmds:
>>           print("    %-20s - %s" % (name, desc))
>> +    print("")
>> +    print("Supported keys:")
>> +    print("    %-20s - %s" % ('-j', 'Dump in JSON format'))
>>       if __name__ == '__main__':
>> diff --git a/tests/qemu-iotests/qcow2_format.py 
>> b/tests/qemu-iotests/qcow2_format.py
>> index 2c78d46..e0e14b5 100644
>> --- a/tests/qemu-iotests/qcow2_format.py
>> +++ b/tests/qemu-iotests/qcow2_format.py
>> @@ -109,7 +109,7 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
>>           self.__dict__ = dict((field[2], values[i])
>>                                for i, field in enumerate(self.fields))
>>   -    def dump(self):
>> +    def dump(self, dump_json=None):
>>           for f in self.fields:
>>               value = self.__dict__[f[2]]
>>               if isinstance(f[1], str):
>> @@ -145,8 +145,8 @@ class Qcow2BitmapExt(Qcow2Struct):
>>               [Qcow2BitmapDirEntry(fd, cluster_size=self.cluster_size)
>>                for _ in range(self.nb_bitmaps)]
>>   -    def dump(self):
>> -        super().dump()
>> +    def dump(self, dump_json=None):
>
> strange to make None the default value for boolean. Why not just False?
>
> Also, why not call it just "json"? We are already in "dump" context, 
> no needs to add prefix to the name.
>
>> +        super().dump(dump_json)
>>           for entry in self.bitmap_directory:
>>               print()
>>               entry.dump()
>
> How will it work? You are interleaving json dump and non-json?
>
> Looking at this, I think that json and non-json dumps has more 
> differences than similarities, and it probably simpler to make a 
> separate function dump_json.. But I'm absolutely against an option, if 
> it will be done consistently.
>
>> @@ -190,7 +190,7 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>>           self.bitmap_table = Qcow2BitmapTable(raw_table=table,
>> cluster_size=self.cluster_size)
>>   -    def dump(self):
>> +    def dump(self, dump_json=None):
>>           print(f'{"Bitmap name":<25} {self.name}')
>>           super(Qcow2BitmapDirEntry, self).dump()
>>           self.bitmap_table.dump()
>
> Here the new option just not passed to the nested dump() calls..
>
>> @@ -291,13 +291,13 @@ class QcowHeaderExtension(Qcow2Struct):
>>                       data_str = '<binary>'
>>                   self.data_str = data_str
>>   -    def dump(self):
>> +    def dump(self, dump_json=None):
>>           super().dump()
>>             if self.obj is None:
>>               print(f'{"data":<25} {self.data_str}')
>>           else:
>> -            self.obj.dump()
>> +            self.obj.dump(dump_json)
>>         @classmethod
>>       def create(cls, magic, data):
>> @@ -396,8 +396,8 @@ class QcowHeader(Qcow2Struct):
>>           buf = buf[0:header_bytes-1]
>>           fd.write(buf)
>>   -    def dump_extensions(self):
>> +    def dump_extensions(self, dump_json=None):
>>           for ex in self.extensions:
>>               print('Header extension:')
>> -            ex.dump()
>> +            ex.dump(dump_json)
>>               print()
>>
>
>

