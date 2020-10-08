Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ECBC4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60997206E5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NdWfWX4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60997206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVgh-0001y1-AW
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQVaw-0002V1-Q2; Thu, 08 Oct 2020 09:04:32 -0400
Received: from mail-eopbgr20135.outbound.protection.outlook.com
 ([40.107.2.135]:34078 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQVao-0002vq-Mn; Thu, 08 Oct 2020 09:04:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFwr8qa5JTk6+IdZ1o9/WAK4TouReV1EksMy9rF6Yaa5fLbEB00RkynOQWlQPFZ4vitrT+/SQ60sJrkTkmn6f/JCwcdqbk7tTYhaShk3fqqAVG5ABJewTpiqMwnfhcQT4IjVVto7sghBWnnsqtK3ahkk4JgShLFYMeqdC86EIYsD0PM0rg0XYi9MN56Xv5y+1p0S7U+dlESDcdeE3MljUzwXAfEiIQ88AwX2zoZVZWYgjV+k6OwKrHgUTeXQEI2BZ+gCSYBeF+mCau/6ACIiQYUPy7YWxPoZxCPwoZULJFFoylS+bJmDU+8zX8Bj64/OMKUw45oM5K5e0cUooF27+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGDDCc5yOEXAib7rnc5+YA0/NeNx/pKobtmCky3GCUs=;
 b=RCldfXn2TuHnrUT7EqClxbSm5dnFX7+zPUzHm8Bny1rfr3OENZ2Q/pn87J4ps9ao251RRAF7AcIwKFCM0i1/bWfqE87kuyTH7ZSGWC1iWUx4OyJmmHkeYaqZ8mOgGLrmlh0RCia+8etFyDHZEk2SIVaXgAib2Q5sBrerTKU24Wtwwe7GLPJlkGfVG1JptJPxl0uGkQx140hp7g9aRowoZ4SbA3dSyYO3FwG9D3g0ucTaeNNaFaNQR4nVqn7VQ7/kidMPtJHNliG/8L+ygTf3zwaVlK/MoGevyDczpQfczwSNZ7r+G3WU9atVChPVxMvrmTgolto98JMQlYywxTUiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGDDCc5yOEXAib7rnc5+YA0/NeNx/pKobtmCky3GCUs=;
 b=NdWfWX4ENi8/xfYr9KrsDXNtRQWx16QWsKwMHDLg/3udlkO4EKwp7cFg2nTCb+YmqoeOCHnXDbOfiOwEeqPWuiWtyeEDInPGMQY6KC+53ABpBhBRL5Q6POINj6xQqXFYLtjo5YbOpWqK6csNqgGXxYw9PSDbjsgc0VyGCn6gd6Y=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5335.eurprd08.prod.outlook.com (2603:10a6:20b:101::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Thu, 8 Oct
 2020 13:04:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.045; Thu, 8 Oct 2020
 13:04:17 +0000
Subject: Re: [PATCH v2 4/5] nbd: Add new qemu:allocation-depth metacontext
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, pkrempa@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
References: <20200930121105.667049-1-eblake@redhat.com>
 <20200930121105.667049-5-eblake@redhat.com>
 <1425ef36-614e-f6eb-ff41-90693d017fbb@virtuozzo.com>
 <f839054c-70e6-cfe5-0c44-e9a519389d65@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b1d3536f-0fcc-11e9-13a6-db144b8a4368@virtuozzo.com>
Date: Thu, 8 Oct 2020 16:04:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <f839054c-70e6-cfe5-0c44-e9a519389d65@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.87]
X-ClientProxiedBy: AM0PR04CA0096.eurprd04.prod.outlook.com
 (2603:10a6:208:be::37) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.87) by
 AM0PR04CA0096.eurprd04.prod.outlook.com (2603:10a6:208:be::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23 via Frontend Transport; Thu, 8 Oct 2020 13:04:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9cf568b-fd3e-4e2e-b94d-08d86b8aa9f0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5335:
X-Microsoft-Antispam-PRVS: <AM7PR08MB533587E5FB598061CC422ACAC10B0@AM7PR08MB5335.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eCzo1Lc0hErnJQDvdFxNV22rtJ3RAsCk2Fb/6qJc6wNDCo1iEp87yS9D72rFL0ttoAZCLYKjmxdbutWX6a58idVGnsFzdbFHLIWc3Einx8PbwqnRMTAJHSWQGAXK0I/q7tTQJ5R3khsCtEtr6qzbZhfNlXP4A1m3zhyE27QafnEIpit1xhu1byI0y2yoqBrvEwPB3sHqzjrsz/NOEqG3OCEhuZj65+1wGDRMV2PGQKoGBqOk8sHYdN9DcSl2Q86qBp7VJvlsRGvs5i+4WbTjGk4asXvr0lBYbD5i6LOm2fqKttfrZSjauZWITFvbKUDOEn6Z/bp4J6fZDOjhrHNa93kftiema9tsYvq/5EkvQllwgQ0CjhGPufzKXJnD1saXVOmrLn9WysOvxI78OZsUz1tC2hMicj1W/S3VAmfMmytIJ6Jeo6PDjcwT1QZvGPFL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39840400004)(346002)(136003)(376002)(83380400001)(86362001)(316002)(2906002)(2616005)(4326008)(956004)(16576012)(5660300002)(8936002)(8676002)(66476007)(52116002)(36756003)(66556008)(31696002)(16526019)(478600001)(6486002)(66946007)(31686004)(26005)(186003)(53546011)(21314003)(43740500002)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Q9foD2/FTHVsPhGPcfTQEBwS2jotc93Wrpep2qo/c1JuzjVQwhK4jJFv2Vt9d37NZQurAZEfZTUCydIeFIaMe9nQJ0uFUX4q/KWqaS1r97XbPRT2rmtaCrn4v6W3MHyM+2XsZFmnzWYEzrFmtPU7boC1RD5VrnWZu4GGN/M6KOoJarPE3yGeCW/nICF355ho+vLIitkTMo2exjhXmSSVFmeXvDFJVO1UZzKDE0PfhAN7B+RkGJG//saoUMYrHzXV/xUgS1oOaQ4vnUNeC5R/XiAhXOGhLzJJ9m5c4/krWJ/mEjD7eqDHA2oGk51MUDXhstWJ87SkW4/MWmE4KnSj/22swa3xsyuJ1E8amGAi4bEU2vD2dE/9C7ITI6E7eTVgHNf1cZpjFid+1u+f5awp5wJXoqcASqE0UqUvvSyUJCGDYe8+6Z/T+qLqbUo3+8lO1eGV7sQeyd34lxAYBKz18D8vEtBoUux4lwHOPOWzqa1KEgLihHYDux48rRzAG6IOf6U8lERD9IHSc0LsuOaOSyYq5C9zF7LHal6UFvLPl1L/G0v0imHZw4Fv1lb0xH4StC8RmE2DljCjGm3KGR4Hp0oGi9T/U5nb9OOsLm6Zi3O1cESZA35VQ5ZC96mei0/m/KIgPnPwv+im8LigTB0T4g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cf568b-fd3e-4e2e-b94d-08d86b8aa9f0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 13:04:17.5780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GItiamP9GvAMg4hV+FTrjeiQ0PZ2sUZFFMbILsIIFyUUffH7UHy41eR4hdV9GxizZvX0/+D1/GD+1ziqUqwFLsNZqgMpbOaUBVAC+GsLs1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5335
Received-SPF: pass client-ip=40.107.2.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 09:04:19
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

08.10.2020 00:54, Eric Blake wrote:
> On 10/7/20 8:40 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 30.09.2020 15:11, Eric Blake wrote:
>>> 'qemu-img map' provides a way to determine which extents of an image
>>> come from the top layer vs. inherited from a backing chain.  This is
>>> useful information worth exposing over NBD.  There is a proposal to
>>> add a QMP command block-dirty-bitmap-populate which can create a dirty
>>> bitmap that reflects allocation information, at which point
>>> qemu:dirty-bitmap:NAME can expose that information via the creation of
>>> a temporary bitmap, but we can shorten the effort by adding a new
>>> qemu:allocation-depth context that does the same thing without an
>>> intermediate bitmap (this patch does not eliminate the need for that
>>> proposal, as it will have other uses as well).
>>>
>>> For this patch, I just encoded a tri-state value (unallocated, from
>>> this layer, from any of the backing layers); an obvious extension
>>> would be to provide the actual depth in bits 31-4 while keeping bits
>>> 1-0 as a tri-state (leaving bits 3-2 unused, for ease of reading depth
>>> from a hex number).  But this extension would require
>>> bdrv_is_allocated_above to return a depth number.
>>>
>>> Note that this patch does not actually enable any way to request a
>>> server to enable this context; that will come in the next patch.
>>>
> 
>>> +In the allocation depth context, bits 0 and 1 form a tri-state value:
>>> +
>>> +    bits 0-1 clear: NBD_STATE_DEPTH_UNALLOC, means the extent is
>>> unallocated
>>> +    bit 0 set: NBD_STATE_DEPTH_LOCAL, the extent is allocated in this
>>> image
>>
>> Maybe, s/this/the top level/, as, what is "this" for NBD client?
> 
> Sure.
> 
> 
>>> @@ -864,12 +867,21 @@ static bool nbd_meta_qemu_query(NBDClient
>>> *client, NBDExportMetaContexts *meta,
>>>
>>>        if (!*query) {
> 
> We get here for "qemu:".
> 
>>>            if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
>>> +            meta->allocation_depth = meta->exp->alloc_context;
>>>                meta->bitmap = !!meta->exp->export_bitmap;
>>>            }
>>>            trace_nbd_negotiate_meta_query_parse("empty");
>>>            return true;
>>>        }
>>>
>>> +    if (nbd_strshift(&query, "allocation-depth")) {
> 
> We get here for "qemu:allocation-depth", and as you pointed out,
> "qemu:allocation-depth-extended".
> 
>>> +        trace_nbd_negotiate_meta_query_parse("allocation-depth");
>>> +        if (nbd_meta_empty_or_pattern(client, "", query)) {
>>
>> How much it differs from "if (!*query) {", I don't see...
> 
> The nbd_meta_empty_or_pattern returns false for
> "qemu:allocation-depth-extended"; it only returns true for
> "qemu:allocation-depth".  But, as you pointed out,
> 
>>
>>> +            meta->allocation_depth = meta->exp->alloc_context;
>>> +        }
>>> +        return true;
>>> +    }
>>
>> why not just
>>
>>   if (!strcmp(query, "allocation-depth")) {
>>      meta->allocation_depth = meta->exp->alloc_context;
>>      return true;
>>   }
>>
>> ?
> 
> that does seem shorter.
> 
>>
>> With your code you also parse something like
>> "allocation-depth-extended".. Is it on purpose?
> 
> The string is parsed, but does not affect meta->XXX, which means nothing
> gets advertised to the client.  The trace messages might differ, but
> behavior is correct.
> 
>>
>>> +
>>>        if (nbd_strshift(&query, "dirty-bitmap:")) {
>>>            trace_nbd_negotiate_meta_query_parse("dirty-bitmap:");
>>>            if (!meta->exp->export_bitmap) {
>>
>>
>> Also, "trace_nbd_negotiate_meta_query_skip("not dirty-bitmap"); " at
>> function end should
>> now be something like trace_nbd_negotiate_meta_query_skip("unknown
>> context in qemu: namespace");
> 
> Good idea.
> 
> 
>>> +/* Get allocation depth from the exported device and send it to the
>>> client */
>>> +static int nbd_co_send_block_alloc(NBDClient *client, uint64_t handle,
>>> +                                   BlockDriverState *bs, uint64_t
>>> offset,
>>> +                                   uint32_t length, bool dont_fragment,
>>> +                                   bool last, uint32_t context_id,
>>> +                                   Error **errp)
>>> +{
>>> +    int ret;
>>> +    unsigned int nb_extents = dont_fragment ? 1 :
>>> NBD_MAX_BLOCK_STATUS_EXTENTS;
>>> +    g_autoptr(NBDExtentArray) ea = nbd_extent_array_new(nb_extents);
>>> +
>>> +    ret = blockalloc_to_extents(bs, offset, length, ea);
>>> +    if (ret < 0) {
>>> +        return nbd_co_send_structured_error(
>>> +                client, handle, -ret, "can't get block status", errp);
>>> +    }
>>> +
>>> +    return nbd_co_send_extents(client, handle, ea, last, context_id,
>>> errp);
>>> +}
>>
>>
>> The function is a copy of nbd_co_send_block_status()..
>>
>> Probably, we can reuse nbd_co_send_block_status(), and just call
>> blockstatus_to_extents()
>> or blockalloc_to_extents() depending on context_id parameter.
> 
> Nice idea to reduce the duplication.
> 
>>
>> Still, I'm OK with it as is.
>>

it was only about the duplicated function

> 
> So is that Reviewed-by:, or do I need to post v3 with my tweaks in
> response to your comments?
> 

Honestly it wasn't.. So, I found some things to discuss, and it's possible that I've looked through with less attention. Hm. So, with v3 or without, I've have to lookthrough it again..

My suggested diff:

diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
index 56efec7aee..a0d91ff08b 100644
--- a/docs/interop/nbd.txt
+++ b/docs/interop/nbd.txt
@@ -36,7 +36,8 @@ the image, with a single context named:
  In the allocation depth context, bits 0 and 1 form a tri-state value:
  
      bits 0-1 clear: NBD_STATE_DEPTH_UNALLOC, means the extent is unallocated
-    bit 0 set: NBD_STATE_DEPTH_LOCAL, the extent is allocated in this image
+    bit 0 set: NBD_STATE_DEPTH_LOCAL, the extent is allocated in the top
+               level image
      bit 1 set: NBD_STATE_DEPTH_BACKING, the extent is inherited from a
                 backing layer
  
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 06208bc250..2d7165960d 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -262,7 +262,7 @@ enum {
  /* Extent flags for qemu:allocation-depth in NBD_REPLY_TYPE_BLOCK_STATUS */
  #define NBD_STATE_DEPTH_UNALLOC (0 << 0)
  #define NBD_STATE_DEPTH_LOCAL   (1 << 0)
-#define NBD_STATE_DEPTH_BACKING (2 << 0)
+#define NBD_STATE_DEPTH_BACKING (1 << 1)
  #define NBD_STATE_DEPTH_MASK    (0x3)
  
  static inline bool nbd_reply_type_is_error(int type)
diff --git a/nbd/server.c b/nbd/server.c
index 830b21000b..3761ac180f 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -809,7 +809,7 @@ static bool nbd_meta_empty_or_pattern(NBDClient *client, const char *pattern,
  {
      if (!*query) {
          trace_nbd_negotiate_meta_query_parse("empty");
-        return !*pattern || client->opt == NBD_OPT_LIST_META_CONTEXT;
+        return client->opt == NBD_OPT_LIST_META_CONTEXT;
      }
      if (strcmp(query, pattern) == 0) {
          trace_nbd_negotiate_meta_query_parse(pattern);
@@ -874,11 +874,9 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
          return true;
      }
  
-    if (nbd_strshift(&query, "allocation-depth")) {
+    if (!strcmp(query, "allocation-depth")) {
          trace_nbd_negotiate_meta_query_parse("allocation-depth");
-        if (nbd_meta_empty_or_pattern(client, "", query)) {
-            meta->allocation_depth = meta->exp->alloc_context;
-        }
+        meta->allocation_depth = meta->exp->alloc_context;
          return true;
      }
  
@@ -896,7 +894,7 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
          return true;
      }
  
-    trace_nbd_negotiate_meta_query_skip("not dirty-bitmap");
+    trace_nbd_negotiate_meta_query_skip("unknown context in qemu: namespace");
      return true;
  }
  
@@ -2045,7 +2043,11 @@ static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
      return nbd_co_send_iov(client, iov, 2, errp);
  }
  
-/* Get block status from the exported device and send it to the client */
+/*
+ * Get block status from the exported device and send it to the client,
+ * handling base:allocation or qemu:allocation-depth meta-context, based
+ * on @context_id value.
+ */
  static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
                                      BlockDriverState *bs, uint64_t offset,
                                      uint32_t length, bool dont_fragment,
@@ -2056,27 +2058,12 @@ static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
      unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS_EXTENTS;
      g_autoptr(NBDExtentArray) ea = nbd_extent_array_new(nb_extents);
  
-    ret = blockstatus_to_extents(bs, offset, length, ea);
-    if (ret < 0) {
-        return nbd_co_send_structured_error(
-                client, handle, -ret, "can't get block status", errp);
+    if (context_id == NBD_META_ID_BASE_ALLOCATION) {
+        ret = blockstatus_to_extents(bs, offset, length, ea);
+    } else {
+        assert(context_id == NBD_META_ID_ALLOCATION_DEPTH);
+        ret = blockalloc_to_extents(bs, offset, length, ea);
      }
-
-    return nbd_co_send_extents(client, handle, ea, last, context_id, errp);
-}
-
-/* Get allocation depth from the exported device and send it to the client */
-static int nbd_co_send_block_alloc(NBDClient *client, uint64_t handle,
-                                   BlockDriverState *bs, uint64_t offset,
-                                   uint32_t length, bool dont_fragment,
-                                   bool last, uint32_t context_id,
-                                   Error **errp)
-{
-    int ret;
-    unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS_EXTENTS;
-    g_autoptr(NBDExtentArray) ea = nbd_extent_array_new(nb_extents);
-
-    ret = blockalloc_to_extents(bs, offset, length, ea);
      if (ret < 0) {
          return nbd_co_send_structured_error(
                  client, handle, -ret, "can't get block status", errp);
@@ -2433,13 +2420,13 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
              }
  
              if (client->export_meta.allocation_depth) {
-                ret = nbd_co_send_block_alloc(client, request->handle,
-                                              blk_bs(exp->common.blk),
-                                              request->from, request->len,
-                                              dont_fragment,
-                                              !--contexts_remaining,
-                                              NBD_META_ID_ALLOCATION_DEPTH,
-                                              errp);
+                ret = nbd_co_send_block_status(client, request->handle,
+                                               blk_bs(exp->common.blk),
+                                               request->from, request->len,
+                                               dont_fragment,
+                                               !--contexts_remaining,
+                                               NBD_META_ID_ALLOCATION_DEPTH,
+                                               errp);
                  if (ret < 0) {
                      return ret;
                  }



with it:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

