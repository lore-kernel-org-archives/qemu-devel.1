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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABED2C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D112074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nejmOUgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D112074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw1Gy-0004lx-Ml
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw1GJ-0004Il-De; Thu, 16 Jul 2020 06:37:11 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:32002 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw1GG-0002W6-9A; Thu, 16 Jul 2020 06:37:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIwa9LJ+F+f1ljBgtjCN+FAcmmKHYcLWF7W99wI2SKrQtdpGMBVq4sRmeIUaacIWZrkYlakoWrir1PqMiB8vsCpIyvSE7bQKeFhaBGlNUqDuRYc336PbBzwVYz+u3Q6ll6ztGJEPq1dwEECC2nOgGZBxJtZScjsaKON6GYQhtJDgagv5HZLXzLODnSOxNGXqo7MSgTmdbyu04VVRoq8ePe9SHdCeTAM8O5T6NdF8L2WrUvzNhGoLbDhCmWXD8ZWhk5leyoDPF5bkiUxOicHSvHstjwqKEP1yvqNcBfbRgKeXqofRR5/gsAe7nuJlv38b2yjm6WjPVhzx5U4Yw/T9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pertb7rlqjMpCiL5pJZNgA49q5bjdJtpYN41MbMX9nI=;
 b=VjYMLPzSmEMYTTUerhCI4CAfTElLGhpg6+pXoKARAgoJUrqwek6UQqjWrX4gCY1idW0Jw2ptrITWbrOC5/q9Q8wWYbLCmJoN7fjmumVaXV7Grd0vq4PTPESxSJgseu7TjlM91UBad61v+s90eBROiFSGt3NAWKckuOdClZhdOY2qyah/eLLTJkgbgo8+lZhwbfX1+tCC4QQppdTMbmSzuK26rR90UfCn4bmdwSG5r3z0imoMfLWcPjEgGj5Rxs1au0RNFi1qg1GDtzaoqPAQSFyztaDGdGq5o/XKgKQQHX9axGN3wyP6v97PsCExO0Bwwo9+6bgYKp/ISzFAzD5yqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pertb7rlqjMpCiL5pJZNgA49q5bjdJtpYN41MbMX9nI=;
 b=nejmOUgnm293fsTLNKMzg4nIHqzV2Ct+zSuaz6C0E5axP4ZJFaRg3t/7/ZHnuW6DJnTG4qKHsc6PTBDVDkbT2SB6oWnlqDbnm1mXhiRS9L4dq6jnDdnUEW4S0ydwihzrt8JuMxBoGjkiWTsb07u+2/GNc/i4TW3b3ewSK+s6sjc=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Thu, 16 Jul
 2020 10:37:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 10:37:04 +0000
Subject: Re: [PATCH v10 10/10] qcow2_format.py: support dumping metadata in
 JSON format
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594676203-436999-11-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e8a788a1-2a82-104e-a7d4-d924d0f66972@virtuozzo.com>
Date: Thu, 16 Jul 2020 13:37:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594676203-436999-11-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0023.eurprd05.prod.outlook.com (2603:10a6:205::36)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM4PR05CA0023.eurprd05.prod.outlook.com (2603:10a6:205::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 10:37:04 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34b0b42c-9098-473e-4d57-08d829742e77
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2610C7B1A86648E103820328C17F0@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vnjaBbvsSiGrnq6dKnDxBSkncwrAN7+7nCxYuTJ5JCQt0J55alS3kBYAgtMiAB7SNgYlzRavdyukuOk+Du6YD/MDF4oKa4nmnWo5A6zX7tjw5bzo2YYnzv5bB9UJ+1ojnAlmTN5q9hglDLmJQxH2StQOalZUhk1cMpaJ2C9MAO8y5i/fVhGtrYgU6aFrdw41o7EWEylkYDqpod7GgCTaYgs/OMQ2X7zpxG/IR7IBtckFHbwr46uerE5T7G5c2wpaz1NRkoZQ8vcBOs8ySeUvHsnryA4JXJzdKcRHmcW6kF0x7IkFbn7jNjnaMAgkpd2TEWXWIeoXx1n1rftLJ+/6pW2Ja6+iKwnJ+FUNYu+vhuGhEheov9dgR1wa7sadh22j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(136003)(39840400004)(396003)(376002)(107886003)(66556008)(66946007)(66476007)(16526019)(478600001)(8676002)(8936002)(6486002)(83380400001)(186003)(2906002)(52116002)(4326008)(26005)(86362001)(31686004)(36756003)(2616005)(956004)(31696002)(5660300002)(316002)(16576012)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ODdTrWjoc0kNDrOCZZoUoKXmjt4EhoumrLwXFEdY4ZTjKQJ7L3tOBmbtmhs+azn0Y2UKRwg1Cxy6N95PHUABGFLD/MJHQSf1TkppRdZljGGTosMvoW5fWqOUH573Y9sZ8o30GolwVpDCalVko1mSWrr9ICkUOorRcGJIx0xDs5fTqwWXExgK3Dkml190NmJB8lDCOOtAJHS9Lci0gmZIllc10CuRwOeRc2Hpw5Cb6y9Sloew1HDtxFF0S59zWV2imJMOL8vCJp00WvWAjbwBweFOVBtx+QOgVtcyiL/bDxJCfEpK8odlYVXjUJeJsSJjZSzBdxj+wVlum1bc/vr+Dz097cVp75ibsp/uBIjzfnPCohauWRudD+Md1pE2JAdMZKjhAPY6rXuU03BrYcFlAjjCCWwDILo4I/tYkChKKuB1GDuvlMycEn00hKJZdX48rAJTcHuaRVeMlmzQXgHXSQfdQQH3J24226GKmkD7+b9SrQAcWeahTRfzJE2S7Ddc
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b0b42c-9098-473e-4d57-08d829742e77
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 10:37:04.6994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSyx6gb2H3FYtPNdhm1o2rkf/REjbO+2CGnoVulT3wptl06qQs1wTISDl4tdvwquHmO3zlxsPptjY72kEHjo+EKurtsGn6Ov/H5QEXRI+90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.7.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 06:37:05
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
>                          "bitmap_table": {
>                              "entries": [
>                                  {
>                                      "type": "serialized",
>                                      "offset": 655360
>                                  },
>                                  ...
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Aha, so you actually do what I imagine in a previous patch, add a method returning dict (I'd call it just "to_dict", but that doesn't really matter). (Stil, I'm against keeping self.fields_dict attribute. Just make correct .to_dict() method for base class (which will utilize .fields), and call super().to_dict() and add some another fields in children classes (like it is done for dump() method)


> ---
>   tests/qemu-iotests/qcow2_format.py | 59 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
> 
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index 83c3482..a263858 100644
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
> +        if hasattr(obj, 'get_fields_dict'):
> +            return obj.get_fields_dict()
> +        else:
> +            return json.JSONEncoder.default(self, obj)
>   
>   
>   class Qcow2Field:
> @@ -112,6 +121,11 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
>           self.fields_dict = self.__dict__.copy()
>   
>       def dump(self, dump_json=None):
> +        if dump_json:
> +            print(json.dumps(self.get_fields_dict(), indent=4,
> +                             cls=ComplexEncoder))
> +            return

Now it is obvious, that this is enough: we can just make it a seprate method dump_json in Qcow2Struct and we'll never need to implement dump_json in other classes (only .to_dict). But really, with dump_json parameter other classes are wrong now: they call super().dump(dump_json) which dumps json, and they they print additional things in a non-json format.

> +
>           for f in self.fields:
>               value = self.__dict__[f[2]]
>               if isinstance(f[1], str):
> @@ -154,6 +168,9 @@ class Qcow2BitmapExt(Qcow2Struct):
>               print()
>               entry.dump()
>   
> +    def get_fields_dict(self):
> +        return self.fields_dict
> +
>   
>   class Qcow2BitmapDirEntry(Qcow2Struct):
>   
> @@ -199,6 +216,11 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>           super(Qcow2BitmapDirEntry, self).dump()
>           self.bitmap_table.dump()
>   
> +    def get_fields_dict(self):
> +        bmp_name = dict(name=self.name)
> +        bme_dict = {**bmp_name, **self.fields_dict}
> +        return bme_dict
> +
>   
>   class Qcow2BitmapTableEntry:
>   
> @@ -214,6 +236,9 @@ class Qcow2BitmapTableEntry:
>           else:
>               self.type = 'all-zeroes'
>   
> +    def get_fields_dict(self):
> +        return dict(type=self.type, offset=self.offset)
> +
>   
>   class Qcow2BitmapTable:
>   
> @@ -230,6 +255,18 @@ class Qcow2BitmapTable:
>           for i, entry in bitmap_table:
>               print(f'{i:<14} {entry.type:<15} {entry.offset:<24} {size}')
>   
> +    def get_fields_dict(self):
> +        return dict(entries=self.entries)
> +
> +
> +class Qcow2HeaderExtensionsDoc:
> +
> +    def __init__(self, extensions):
> +        self.extensions = extensions
> +
> +    def get_fields_dict(self):
> +        return dict(Header_extensions=self.extensions)
> +
>   
>   QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
>   
> @@ -245,6 +282,9 @@ class QcowHeaderExtension(Qcow2Struct):
>               0x44415441: 'Data file'
>           }
>   
> +        def get_fields_dict(self):
> +            return self.mapping.get(self.value, "<unknown>")
> +
>       fields = (
>           ('u32', Magic, 'magic'),
>           ('u32', '{}', 'length')
> @@ -303,6 +343,16 @@ class QcowHeaderExtension(Qcow2Struct):
>           else:
>               self.obj.dump(dump_json)
>   
> +    def get_fields_dict(self):
> +        ext_name = dict(name=self.Magic(self.magic))
> +        he_dict = {**ext_name, **self.fields_dict}
> +        if self.obj is not None:
> +            he_dict.update(data=self.obj)
> +        else:
> +            he_dict.update(data_str=self.data_str)
> +
> +        return he_dict
> +
>       @classmethod
>       def create(cls, magic, data):
>           return QcowHeaderExtension(magic, len(data), data)
> @@ -401,7 +451,16 @@ class QcowHeader(Qcow2Struct):
>           fd.write(buf)
>   
>       def dump_extensions(self, dump_json=None):
> +        if dump_json:
> +            ext_doc = Qcow2HeaderExtensionsDoc(self.extensions)
> +            print(json.dumps(ext_doc.get_fields_dict(), indent=4,
> +                             cls=ComplexEncoder))
> +            return
> +
>           for ex in self.extensions:
>               print('Header extension:')
>               ex.dump(dump_json)
>               print()
> +
> +    def get_fields_dict(self):
> +        return self.fields_dict
> 


-- 
Best regards,
Vladimir

