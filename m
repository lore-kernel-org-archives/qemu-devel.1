Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6068BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108EE2074B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cQqKRigB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108EE2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgEbN-0002RR-9L
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 17:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgEaX-0001XL-9w; Tue, 02 Jun 2020 17:36:49 -0400
Received: from mail-eopbgr20105.outbound.protection.outlook.com
 ([40.107.2.105]:3022 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgEaU-0004zc-Ab; Tue, 02 Jun 2020 17:36:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zwyqv81s4UmDrd2tR5BYnx2TYS/+uHMb0RECkmU2FiI7GgTiUg1MA/spQfE8TDnP0mGBxpuylqVn6IjyMeTVhEC2ls6/Op4yBrInSFnNquU3T05X8c5hvgnU9eoPWnotVz4ZHsc1RyLHA55bF/7mLuybGt6/4U1LxNg0IJUGWGGdE6/j2WPjpym+vdwV1VNAdTqA8B+nOYTIzMCdb4ZnjHBKsBlWix+NiVGWe6Vw4K6IVFPn70Tn7H0V7lkFv8i5412+knM/s4lUpW/c1y9AvpUKgE2wy2ESWyTo03woeWkdNQ0FIshRMQHVhzbUfqLqX1uYv3UESLqj1yphVQSsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APBfyNPCGRKR08wMg12Cw0K6oTRYS5WAfLqVorrIiiM=;
 b=F02fGoX2z50SSR4vKGw5Szulz7ueKZGrPn/rbNFKXyqFFmqhOXi6qK8LC8T69GAKWSaYNCGiLR/rhcr9mXDGvmrXAPflWSMqP4w2RGVkWPU1cWhbNtb1TsadkFfdWavIbxj8q9P5C4dY3nAS5kcFlx1+WR7ZZ6RArvSAQTDHlGFpLUyvCOtP8ShnvpmcHHgpozggHAZRkU4SU5kFjNukWIcAjXZq6j0GnHXkmc38LwPxC9eNwxnOU6qFZgYJF9oHi0kFD3hAhA3Rjp3bTPlWukwNDvQ9hUCdA+kqW7MeicKWoxTSiqzz1DZFuvBrU9ptHQ1eARYdS9DjsbjXaza9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APBfyNPCGRKR08wMg12Cw0K6oTRYS5WAfLqVorrIiiM=;
 b=cQqKRigBfCalPutlgo3yOe6o+T6WBv1x0mbXmdnM7Fdvcg5ObNATP06q3wdOHmKzl+G2QAmwGoI+aWlj4aVOky3J3mChmkPa7niDR7HMmD5z6JKDlk9jwkOzH92bs1muVHZwHa8BNHKROhWt3G6JXrFqlX+XzR+yB0PYAELgKE8=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5382.eurprd08.prod.outlook.com (2603:10a6:20b:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 21:36:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 21:36:42 +0000
Subject: Re: [PATCH v3 6/6] iotests: Dump QCOW2 image metadata in JSON format
 with qcow2.py
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1591019293-211155-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1591019293-211155-7-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6849a31d-2932-6045-3282-11bb27bf41fb@virtuozzo.com>
Date: Wed, 3 Jun 2020 00:36:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <1591019293-211155-7-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0106.eurprd02.prod.outlook.com
 (2603:10a6:208:154::47) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.153) by
 AM0PR02CA0106.eurprd02.prod.outlook.com (2603:10a6:208:154::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22 via Frontend
 Transport; Tue, 2 Jun 2020 21:36:42 +0000
X-Originating-IP: [185.215.60.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b000046c-64ec-4a77-acc8-08d8073d0aa6
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53827607BBCD48D502725D0FC18B0@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GhNSuwvuuHxLkTnXkjGCBxHnyVrpiLusZrNJVkVrdLJ/N3LvMoFa+5Ocw+YdOaWhtqlBaWA850JL9pQRfmetfCHHxeM+Z5OQJG33qGzzADmFHb/RhgcW/T0FgNucEHwntbGfEBGdwmpsy7W0gXDPffcQWBAG3vm5g35uv/K2yJbCyM0G7ePcgFaK7E8Lf1V2v0Wqb5P4TlDk1wMkflXaMwx8CPI6+vk2FFAHm6hpfRe/l8QEcxNBQ3zTORbrgOVW8q8qpGskcHb0nVJkWAdEM7fD6GtkVbrH2phsJfqFbicCXwfFM5rWsiqkSh98NemwsQ3yBqB1DXTg4HiLHd4UXhTUHH6/dyUFoWQDzRu89e63p3P8hFxpnVKMqIub27gf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39850400004)(52116002)(8676002)(16576012)(186003)(316002)(6486002)(26005)(16526019)(8936002)(4326008)(2906002)(107886003)(2616005)(86362001)(31686004)(83380400001)(478600001)(31696002)(36756003)(66946007)(66476007)(5660300002)(956004)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ciKtiL+QHf7wFDkSQnirHG1vtoEPLKs8LZmzEjYOoyOGxZa0GOhB7EY9tX+9LgxsaJDw8tiPy/+WgRDYoMeV2LgD3/UV2Kk3buAwbvvTI+IWi8eJEZlxyb6d8SX2hCkBR8Yt6VqigCNIr3frJlS9GWnvC6eOf8SWHPz/pVPyyfGBOdBE9kOjOVExgGaEtDyKkSMbXpRi78QTv9lgN8aTaPWeGFOB/lq8a8iPp+pucZCABsIyZQ+51Ol6/utQk9VkUP9XWZmuo9bWKKBT+UAp19f9XPya6UD9pP9pxTPqnRfbgiW+ICQDzkcUeNhTf0Bb3cCX9jfX3/j9KYz412vvgljTqEcdkejUxnQ6OagoC6joKPKvDyiBp1nLFxI3iHQM7/hvdU70rGBfDMjSXarFlmUKdC0mF31vBlmlOKJdT68Sdqmk9+FFin9GRffQBrMXm20gsyOj9NCjzZc46VZIKJx60YU8D4EizYCffVGGWqbIqkou+oUSL+UNXeY+jL3I
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b000046c-64ec-4a77-acc8-08d8073d0aa6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 21:36:42.7035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vNkMXcD3OsW1O6EGBGUHp22/7my2eoBHlSVBCsDMxiN/7IQ19VLePRfuA7yhWzE6Q+/R5KA/VO45M+VzIFXL7NOzeHFMZOvPzB6bYL5/XA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
Received-SPF: pass client-ip=40.107.2.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 17:36:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

01.06.2020 16:48, Andrey Shinkevich wrote:
> Represent QCOW2 metadata dumping with qcow2.py script in JSON format
> 
> {
>      "QCOW2_header_extensions": [
>          {
>              "Header_extension": "Feature table",
>              "magic": "0x6803f857",
>              "length": 192,
>              "data_str": "<binary>"
>          },
>          {
>              "Header_extension": "Bitmaps",
>              "magic": "0x23852875",
>              "length": 24,
>              "data": {
>                  "nb_bitmaps": 2,
>                  "reserved32": 0,
>                  "bitmap_directory_size": 64,
>                  "bitmap_directory_offset": 1048576,
>                  "entries": [
>                      {
>                          "name": "bitmap-1",
>                          "flags": [],
>                          "flag_bits": 0,
>                          "bitmap_table_offset": 589824,
>                          "bitmap_table_size": 8,
>                          "type": 1,
>                          "granularity": 16,
>                          "name_size": 8,
>                          "extra_data_size": 0,
>                          "bitmap_table": {
>                              "table_entries": [
>                                  {
>                                      "type": "serialized",
>                                      "offset": 655360,
>                                      "size": 65536
>                                  },
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2.py | 108 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 105 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
> index 76e0c69..fd1ef4f 100755
> --- a/tests/qemu-iotests/qcow2.py
> +++ b/tests/qemu-iotests/qcow2.py
> @@ -3,11 +3,21 @@
>   import sys
>   import struct
>   import string
> +import json
>   
>   
> +dump_json = False
>   cluster_size = 0
>   
>   
> +class ComplexEncoder(json.JSONEncoder):
> +    def default(self, obj):
> +        if hasattr(obj, 'get_info_dict'):
> +            return obj.get_info_dict()
> +        else:
> +            return json.JSONEncoder.default(self, obj)
> +
> +
>   class Qcow2BitmapTableEntry:
>   
>       BME_TABLE_ENTRY_OFFSET_MASK = 0x00fffffffffffe00
> @@ -23,6 +33,9 @@ class Qcow2BitmapTableEntry:
>               index = entry & self.BME_TABLE_ENTRY_FLAG_ALL_ONES
>           self.type = self.bmte_type[index]
>   
> +    def get_info_dict(self):
> +        return dict(type=self.type, offset=self.offset, size=self.cluster_size)
> +
>   
>   class Qcow2BitmapTable:
>   
> @@ -39,6 +52,9 @@ class Qcow2BitmapTable:
>                                                entry.cluster_size))
>           print("")
>   
> +    def get_info_dict(self):
> +        return dict(table_entries=self.entries)
> +
>   
>   class Qcow2BitmapDirEntry:
>   
> @@ -102,6 +118,18 @@ class Qcow2BitmapDirEntry:
>   
>           self.bitmap_table.print_bitmap_table()
>   
> +    def get_info_dict(self):
> +        return dict(name=self.name,
> +                    flags=self.bitmap_flags,
> +                    flag_bits=self.flag_bits,
> +                    bitmap_table_offset=self.bitmap_table_offset,
> +                    bitmap_table_size=self.bitmap_table_size,
> +                    type=self.type,
> +                    granularity=self.granularity_bits,
> +                    name_size=self.name_size,
> +                    extra_data_size=self.extra_data_size,
> +                    bitmap_table=self.bitmap_table)
> +
>   
>   class Qcow2BitmapDirectory:
>   
> @@ -177,6 +205,31 @@ class Qcow2BitmapExt:
>           self.dump_bitmap_ext()
>           self.dump_bitmap_directory()
>   
> +    def get_info_dict(self):
> +        return dict(nb_bitmaps=self.nb_bitmaps,
> +                    reserved32=self.reserved32,
> +                    bitmap_directory_size=self.bitmap_directory_size,
> +                    bitmap_directory_offset=self.bitmap_directory_offset,
> +                    entries=self.bitmaps)
> +
> +
> +class Qcow2HeaderDoc:
> +
> +    def __init__(self, h):
> +        self.header = h
> +
> +    def get_info_dict(self):
> +        return dict(QCOW2_header=self.header)
> +
> +
> +class Qcow2HeaderExtensionsDoc:
> +
> +    def __init__(self, extensions):
> +        self.extensions = extensions
> +
> +    def get_info_dict(self):
> +        return dict(QCOW2_header_extensions=self.extensions)
> +
>   
>   class QcowHeaderExtension:
>   
> @@ -224,6 +277,17 @@ class QcowHeaderExtension:
>           if self.obj is not None:
>               self.obj.load(fd)
>   
> +    def get_info_dict(self):
> +        he_dict = dict(Header_extension=self.name,
> +                       magic=hex(self.magic),
> +                       length=self.length)
> +        if self.obj is not None:
> +            he_dict.update(data=self.obj)
> +        else:
> +            he_dict.update(data_str=self.data_str)
> +
> +        return he_dict
> +
>   
>   class QcowHeader:
>   
> @@ -353,9 +417,34 @@ class QcowHeader:
>               print("%-25s" % f[2], value_str)
>           print("")
>   
> +    def get_info_dict(self):
> +        return dict(magic=hex(self.magic),
> +                    version=self.version,
> +                    backing_file_offset=hex(self.backing_file_offset),
> +                    backing_file_size=self.backing_file_size,
> +                    cluster_bits=self.cluster_bits,
> +                    size=self.size,
> +                    crypt_method=self.crypt_method,
> +                    l1_size=self.l1_size,
> +                    l1_table_offset=hex(self.l1_table_offset),

Why to store string instead of int in qcow2? Better store numbers as numbers.

> +                    refcount_table_offset=hex(self.refcount_table_offset),
> +                    refcount_table_clusters=self.refcount_table_clusters,
> +                    nb_snapshots=self.nb_snapshots,
> +                    snapshot_offset=hex(self.snapshot_offset),
> +                    incompatible_features=self.incompatible_features,
> +                    compatible_features=self.compatible_features,
> +                    autoclear_features=self.autoclear_features,
> +                    refcount_order=self.refcount_order,
> +                    header_length=self.header_length)

isn't it mostly __dict__? We definitely want to automate this in base class.

> +
>       def dump_extensions(self):
> -        for ex in self.extensions:
> +        if dump_json:
> +            ext_doc = Qcow2HeaderExtensionsDoc(self.extensions)
> +            print(json.dumps(ext_doc.get_info_dict(), indent=4,
> +                             cls=ComplexEncoder))
> +            return
>   
> +        for ex in self.extensions:
>               print("%-25s %s" % ("Header extension:", ex.name))
>               print("%-25s %#x" % ("magic", ex.magic))
>               print("%-25s %d" % ("length", ex.length))
> @@ -368,7 +457,11 @@ class QcowHeader:
>   
>   def cmd_dump_header(fd):
>       h = QcowHeader(fd)
> -    h.dump()
> +    if dump_json:
> +        h_doc = Qcow2HeaderDoc(h)
> +        print(json.dumps(h_doc.get_info_dict(), indent=4, cls=ComplexEncoder))
> +    else:
> +        h.dump()
>       h.dump_extensions()
>   
>   def cmd_dump_header_exts(fd):
> @@ -460,6 +553,12 @@ cmds = [
>   ]
>   
>   def main(filename, cmd, args):
> +    global dump_json
> +    dump_json = '-j' in sys.argv
> +    if dump_json:
> +        sys.argv.remove('-j')
> +        args.remove('-j')
> +
>       fd = open(filename, "r+b")
>       try:
>           for name, handler, num_args, desc in cmds:
> @@ -476,11 +575,14 @@ def main(filename, cmd, args):
>           fd.close()
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
>   if __name__ == '__main__':
>       if len(sys.argv) < 3:
> 


-- 
Best regards,
Vladimir

