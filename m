Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4ACC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF089206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gVWPqkgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF089206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrQ6E-0000Gy-7G
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 14:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrQ51-0007gF-NM; Fri, 03 Jul 2020 14:06:31 -0400
Received: from mail-eopbgr00126.outbound.protection.outlook.com
 ([40.107.0.126]:10244 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrQ4z-0005j0-HE; Fri, 03 Jul 2020 14:06:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GapKc5LHxsYmPSTHSLP4EFgfWSOtpc9hyn2s0jbXJFGtk53lyufM1cSVJd0r+gwxpkiLmTaqXonzcOjqLu+SX8OoePTuSQRiTFglkefeJJWYa3Rs5uqZ4sU7OIukdG9I/LrIiU6B1D3P/JuTKFkeTHTYT1slW6uuALTUEns+IUnfu/JroCDZvygXkZzQw7txQAc9tG16POFQPqsAtpnj6iULQkZUsJFvUjOgII1bUXvn1uHwhcBp8EE+HDm7DZfuJCEwbMcdQUIzITh2iVUxOiC+7p7DRAwXlCejB4gmyr8cvjv0M22FONW7vckUHtb0HwboGhTEcEIm7WGiMpS2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qxal/2vZ7wDb3Me+dZ1djSuzocr0gIffSdpzAQ/59iY=;
 b=HX7Vsbu2EqK0vq5Fh7I0ToLoTSh6BENK11Yo+NrB76yHkhIhxXsEwDIdNZw9mAbi4ozQnJA0AfnvoWQNLRNGwFwKrhndIqk6OU7HwZIh4w2tU5PqrV8E/mRJC21A9kcpX83JGs6c2SW9YONo9CxCZO+2RZp8hCfwCD0Vsbyl9ZaagEJHcQHUDBFgHcqg7/pnGZPW4aaoLZOuJnURFzvmJo89IRgQRYpq6SiIHcagCTXA5wzeLfIZeQA4yL/5+NM5p7Zcd1GMDHgPggvWXivnuwtD4gxEi8j3InAWiDKbM8zPg6cR8/7tQ5Hx+MPGeY6I4R2evVd36isdKqe3YxFmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qxal/2vZ7wDb3Me+dZ1djSuzocr0gIffSdpzAQ/59iY=;
 b=gVWPqkgMkoX5JctNQ+c0cie9mpe/N6jnZK/dJiprkuKllGOTYZGMc6+uduKFByXcJ2xjw7Su5dIOduh0OWlhqSzjwURXRMdXdJi20UdTiJaIuE+hE/8gcHM4XMFRoowL1VLVnW8GndOh6a4FVDG0VG281zS30cKqykA3o51LcKs=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1652.eurprd08.prod.outlook.com (2603:10a6:203:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 18:06:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 18:06:26 +0000
Subject: Re: [PATCH v2 26/44] qom: Put name parameter before value / visitor
 parameter
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-27-armbru@redhat.com>
 <d0835559-57c1-d959-d048-df43cd0402af@virtuozzo.com>
Message-ID: <38a7fce2-462a-0165-b444-d4b14197380c@virtuozzo.com>
Date: Fri, 3 Jul 2020 21:06:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <d0835559-57c1-d959-d048-df43cd0402af@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::40) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 AM0PR01CA0099.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Fri, 3 Jul 2020 18:06:26 +0000
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b3dfd62-6af1-407f-ee8c-08d81f7bcdb3
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1652:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB16522DB6063FB69B415CEF63C16A0@AM5PR0801MB1652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTRhnTtJ/yonWxRUYZxZPhBXunvGIKhWzLRaRxZLx9iJNfAZY8Nfp5Aaa0goNYG+SANsmEmko1SLqQiy79hyCMhZxQEgJml9W1RaHiSHIzZYe+CBdhVGVwG39ZaC9wXnID3e+ucd4Ky5kz7MNsk+3niNYmB6Z2Yl63Yn/D3wvoRDz7oxpY3+MTw7XSXwe64vajD3DuYfI4bfZWqbNlqn9scBbwdyb5XGzs8C/dIlOGGjLvsyxsVRpvNgZQrBUO7+tnpdUalZ0xoLGXiU8OnuE+MJx0fM0YghutLwCq20Qu5IU765O1dY8vzu+xxO/pH3N+ALhj9Iivx1FLLecNEZUnghiG/rnq3XDILPwveA+n0+1VxU2BhcYyg7W+qmxfMF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(39850400004)(376002)(366004)(186003)(26005)(4326008)(52116002)(16576012)(316002)(2616005)(956004)(6486002)(16526019)(31696002)(5660300002)(8676002)(2906002)(86362001)(31686004)(66946007)(83380400001)(66556008)(66476007)(36756003)(478600001)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: w2ecdNco2hrraT9olRuk4T9omZrNRK/gDa5e8EWeN1HEs8JMbwmd6kk+bb7RxKmySxRQrKYYZRQbBxM17LkUC5xtClmmpYFPFVnIwHrnzeiqSL12KEFEQTk8qU/yWQ9mVuD/GRLKV4HL66pwPGh7WveU0Oo7zFTxSZ/1FgqycChJ54sXSx1fD75eCxz4B+ArSClhk5LkfizpKyA1MNkz6Fw26OlnOWH3gndPq4NVXlDjKxmnM9L7prq9nqfCVQWW39UsHKNFq452rTK/jt8r21Gcw0HaFE09sXMG4kXxPpADy5Lh3Fbv3BAAPQc7qokDbk8MRWRA+4SYCrbY/JhIaJg9uYFQW+5DUMKms47bb/1R2mE1URdz0Q+OV36J8Ut+8iIr4e03WIVvpBNjoE48+e16Z0SxrHZskO4CrVF0T3UXOhWc2W4eMyIKNCkaAqikn1CTz8y8j+/3CNcfAO/+09bEPaErOzWkOVjdcQTDbxnn1taFp1CHlDAe+ZIWjafV
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3dfd62-6af1-407f-ee8c-08d81f7bcdb3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 18:06:26.6510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/Tn9jvsNKuOPNSQkNsGEuauE9B+XuLSGnIGugwDEa0L/W7/q00DCBMHmr+UyBIGqf0tIBEgCt/+/TS5lFA7wsU9PfxdlFRtx5tRqHSQiP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1652
Received-SPF: pass client-ip=40.107.0.126;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 14:06:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.07.2020 21:05, Vladimir Sementsov-Ogievskiy wrote:
> 02.07.2020 18:49, Markus Armbruster wrote:
>> The object_property_set_FOO() setters take property name and value in
>> an unusual order:
>>
>>      void object_property_set_FOO(Object *obj, FOO_TYPE value,
>>                                   const char *name, Error **errp)
>>
>> Having to pass value before name feels grating.  Swap them.
>>
>> Same for object_property_set(), object_property_get(), and
>> object_property_parse().
>>
>> Convert callers with this Coccinelle script:
>>
>>      @@
>>      identifier fun = {object_property_get, object_property_parse, object_property_set_str, object_property_set_link, object_property_set_bool, object_property_set_int, object_property_set_uint, object_property_set, object_property_set_qobject};
>>      expression obj, v, name, errp;
>>      @@
>>      -    fun(obj, v, name, errp)
>>      +    fun(obj, name, v, errp)
> 
> I'd suggest
> 
> @@
> identifier fun = {object_property_get, object_property_parse, object_property_set_str, object_property_set_link, object_property_set_bool, object_property_set_int, object_property_set_uint, object_property_set, object_property_set_qobject};
> parameter obj, v, name, errp;
> @@
> -    fun(obj, v, name, errp)
> +    fun(obj, name, v, errp)
>       {...}
> 
> 
> in addition, to not

do it by hand I mean

> 
>>
>> Chokes on hw/arm/musicpal.c's lcd_refresh() with the unhelpful error
>> message "no position information".  Convert that one manually.
>>
>> Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
>> ARMSSE being used both as typedef and function-like macro there.
>> Convert manually.
>>
>> Fails to convert hw/rx/rx-gdbsim.c, because Coccinelle gets confused
>> by RXCPU being used both as typedef and function-like macro there.
>> Convert manually.  The other files using RXCPU that way don't need
>> conversion.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> The change should be safe, as compiler will complain if something is not updated correspondingly. The only exclusion are object_property_parse and object_property_set_str, where both key and value are strings. Check them presizely looking at
> 
>   vimdiff <(git grep object_property_parse HEAD^ | sed 's/HEAD\^://') <(git grep object_property_parse)
> 
> and
> 
>   vimdiff <(git grep -A 1 object_property_set_str HEAD^ | sed 's/HEAD\^://') <(git grep -A 1 object_property_set_str)
> 
> seems everything is updated.
> 
> Also, looked through manual changes for hw/arm/musicpal.c, hw/arm/armsse.c and hw/rx/rx-gdbsim.c. Seems correct..
> 
> 
>> ---
>>   include/hw/audio/pcspk.h                 |   2 +-
>>   include/qom/object.h                     |  45 ++++-----
>>   include/qom/qom-qobject.h                |   7 +-
>>   backends/cryptodev.c                     |   2 +-
> 
> [..]
> 
>>   static void property_release_tm(Object *obj, const char *name,
>> @@ -2384,10 +2375,8 @@ static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
>>   {
>>       uint8_t *field = opaque;
>>       uint8_t value;
>> -    Error *local_err = NULL;
> 
> This (and some more) chunks are obviously from some another patch..
> 
>> -    if (!visit_type_uint8(v, name, &value, &local_err)) {
>> -        error_propagate(errp, local_err);
>> +    if (!visit_type_uint8(v, name, &value, errp)) {
>>           return;
>>       }
> 
> 
> To find problems like this, I'm trying to rerun your cocci-script, but I don't know how exactly do you run it.
> 
> I've tried --use-gitgrep, but it doesn't find some files.
> 
> I've tried
> git grep -l 'object_property_get\|object_property_parse\|object_property_set_str\|object_property_set_link\|object_property_set_bool\|object_property_set_int\|object_property_set_uint\|object_property_set\|object_property_set_qobject' | xargs spatch script.cocci --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff
> 
> Still, have not updated target/arm/monitor.c, strange..
> 
> Another fact, which makes it hard to check the patch is a lot of manual wrapping/indenting updates.. Hmm, I need some tool or script to make it simple to compare commits ignoring wrapping and indentation differences.
> 


-- 
Best regards,
Vladimir

