Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B41EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C5320702
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="b2InCsWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C5320702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqvWW-0004Jw-2N
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 05:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqvVt-0003oP-Ar; Thu, 02 Jul 2020 05:28:13 -0400
Received: from mail-eopbgr70124.outbound.protection.outlook.com
 ([40.107.7.124]:28245 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqvVq-0006l9-Dl; Thu, 02 Jul 2020 05:28:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7k2n+jKBlpxaz8dv4PqB6sEAMfPGauVD3e2FJWwHF7b2fPDKWgy2L9lwJ1TKnZcfFaauA9usTnhw2tLTgSm/YPH46HVHffBUn7525vzvxIL/febRDhJGW3545AzCP4ag8w0PWpyszajr2ZG+vlZA60Q+vDyPipALADVkKIf6T/MJT+jqrVK5yozRfxOXFyk/ZOQzU6kQWtczydegMKqvfVOV377KeQCImw8qFPI5I+YTsmj+NMf8bZn/oeCxj4wtNvqbEgJQMPaoXxwB3ateSzjGOYOoz+yI4gvCJQIHPULLQZziPoo5UbKQTJdTAMmtL2932U2RoPnU4Pd4ZqW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnuObEZ2aOU4YaTik9D5TtUymFZ55XWoHnX7yXOFaNI=;
 b=LYYV3LD5Z51Hdkh8TRJyUGmHqKIWgxcGeIP1p9ox/JfbF+oKBjsnmhk0ni+eYkaHeGxjBI6/vy7Liej0Xf5s8TsB3lv50pxxkLExpG7AejOWCqRHJSABkf8zlx98pCGzzJXAWnyDGQJAuRHQ4EZMCCMMKR+vlGAaVjGrXSIN9rfcMRc6P9gAv4R87h+w8/cmHJxFRFwaw7rJFTi4P1gjNANJ2RDbfun6L6aPk+QkYDnj5fZAWFlf6sK1Po/+ftA+ewOOh5br0VLO9nDYVmolCNBk6lgStCA6bNjcEbr+Ti/RUSHkYyOZL6+9n8PE1yCcutgU9UzxDtQ6ahHlpc+Y0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnuObEZ2aOU4YaTik9D5TtUymFZ55XWoHnX7yXOFaNI=;
 b=b2InCsWSxPuTskN5Rs5xWoxCNxlWvwximS7Mk8XMJs4wn+uQ8rz13TESZqvaxJxXbmbN6Wztgdtbu+12lwib3HzWeNre+GLgWs0qj29IDz54118mrrGvHATlowLctiw8QFQgjjqI6wwFUPzbc2PSryZ1mcS5xCI8G8PhJzfHhMc=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3575.eurprd08.prod.outlook.com (2603:10a6:20b:48::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Thu, 2 Jul
 2020 09:28:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Thu, 2 Jul 2020
 09:28:06 +0000
Subject: Re: [PATCH 10/46] qemu-option: Check return value instead of @err
 where convenient
To: Markus Armbruster <armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-11-armbru@redhat.com>
 <f8e32618-ff39-d505-9d49-1eddf71d364e@virtuozzo.com>
 <87v9j7br45.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8abaa191-825d-2d4f-5688-6439b7747674@virtuozzo.com>
Date: Thu, 2 Jul 2020 12:28:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <87v9j7br45.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0077.eurprd07.prod.outlook.com
 (2603:10a6:207:6::11) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.54) by
 AM3PR07CA0077.eurprd07.prod.outlook.com (2603:10a6:207:6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.8 via Frontend Transport; Thu, 2 Jul 2020 09:28:06 +0000
X-Originating-IP: [185.215.60.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66bf72f2-3998-4f6a-10d0-08d81e6a3a43
X-MS-TrafficTypeDiagnostic: AM6PR08MB3575:
X-Microsoft-Antispam-PRVS: <AM6PR08MB35751EC96D076EA9A3E20FDDC16D0@AM6PR08MB3575.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OZiTKfSPnQoxP/KAY5qxKQe23GRyNY4BmsPqUO9ZT06dal+TiB7B90eKijWuPjXrIFuoI2fCl2Ur+kAeWtPw2b2hLgryeTNDXeaLweSBasaDKsNhxzYTlDIRj5rEVqgIHjSCeKk3yzJxXpKm7QxyLaAG80rUVDnXF2TX8DTiCxHAiDNYJ39Rm9+gqqP4rf0bBP7lfXLGDi11jnTfSfMeu5yGVI36pDbctJ9T63nKWMLniL7yb7pmI4vftadW8MjRxX9NCRlbUlIYICGi2JCKzgJ1AEOPeakmB9o3LBLldEAENNdWX+0l0QiclYoNXv5kBr20v4ByvE2Ax07BF1N/wTHEXRz77z8kg5lvFU9vpX9/eSXNU8VpELz7YCirAnh1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39830400003)(31686004)(186003)(956004)(2616005)(26005)(36756003)(16526019)(4326008)(8936002)(478600001)(8676002)(6916009)(2906002)(6486002)(16576012)(52116002)(5660300002)(86362001)(66946007)(316002)(83380400001)(31696002)(66476007)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xL4Xdtt4AMEGBxVPcPquDN0XQTbN6Edfkc9NntWUUMmTzkpLPSIHVApl5oSKiBS4fHMqbb1OsAF7uHHRzqz/G2UYsSuLmOMZb6qW0DTqlOOOEKMVpF2JqW9j76KRer0TXrSYDTbly3+RbLrrBWSJKNu1SpQ8NQ6vguk51rC8D2360XtlUt+BG8eXhh5WzwGeMa1nuY8lVJMF7+tpl8V8GKeeGo1txnF60N17cBBmjmQzsQgpGjvK9iz8AfGU9B4CkkFH6VvR0PJtEzHnIny0oQT66yN1Vk1XPCHX84BbuYFr1AOAcKNPLG1fi0tCO9+G51m+kS4yj2H/ZLVYZIfEhcKVm2+O4wGP4fZwBprBFE2+7wIZYw9WEyvls8SiuR6e2K2mLbmMZjcjEIgCZgHjintg/R+npcY7ZvcD10nA55tc7/KbUvrELcrv/fSqJP04u2GnAvLTC+RZ25Ec4MOlc7FeXfnmFFGBW/LqdNSrl3s1U7qMajkBitYsBH9UaPrB
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bf72f2-3998-4f6a-10d0-08d81e6a3a43
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 09:28:06.7497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mFVE2N0SV4qDC6KfMdrY0xMo0/fk7c94Q5TkGGSQ3yqowjn9laS/KimW9JopSkNWCum82Rh+l+Io8JCqDxQYOtKEpP+a/6GQCu6p4l8vnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3575
Received-SPF: pass client-ip=40.107.7.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 05:28:07
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.07.2020 11:02, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
>> 24.06.2020 19:43, Markus Armbruster wrote:
>>> Convert uses like
>>>
>>>       opts = qemu_opts_create(..., &err);
>>>       if (err) {
>>>           ...
>>>       }
>>>
>>> to
>>>
>>>       opts = qemu_opts_create(..., &err);
>>>       if (!opts) {
>>>           ...
>>>       }
>>>
>>> Eliminate error_propagate() that are now unnecessary.  Delete @err
>>> that are now unused.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>    block/parallels.c  |  4 ++--
>>>    blockdev.c         |  5 ++---
>>>    qdev-monitor.c     |  6 ++----
>>>    util/qemu-config.c | 10 ++++------
>>>    util/qemu-option.c | 12 ++++--------
>>>    5 files changed, 14 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/block/parallels.c b/block/parallels.c
>>> index 860dbb80a2..b15c9ac28d 100644
>>> --- a/block/parallels.c
>>> +++ b/block/parallels.c
>>> @@ -823,8 +823,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>>>            }
>>>        }
>>>    -    opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0,
>>> &local_err);
>>> -    if (local_err != NULL) {
>>> +    opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
>>> +    if (!opts) {
>>>            goto fail_options;
>>>        }
>>
>> Honestly, I don't like this hunk. as already complicated code (crossing gotos) becomes more
>> complicated (add one more pattern to fail_options path: no-op error_propagate).
>>
>> At least, we'll need a follow-up patch, refactoring parallels_open() to drop "fail_options"
>> label completely.
> 
> For what it's worth, this is how it looks at the end of the series:
> 
>      static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>                                Error **errp)
>      {
>          BDRVParallelsState *s = bs->opaque;
>          ParallelsHeader ph;
>          int ret, size, i;
>          QemuOpts *opts = NULL;
>          Error *local_err = NULL;
>          char *buf;
> 
>          bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
>                                     BDRV_CHILD_IMAGE, false, errp);
>          if (!bs->file) {
>              return -EINVAL;
>          }
> 
>          ret = bdrv_pread(bs->file, 0, &ph, sizeof(ph));
>          if (ret < 0) {
>              goto fail;
>          }
> 
>          bs->total_sectors = le64_to_cpu(ph.nb_sectors);
> 
>          if (le32_to_cpu(ph.version) != HEADER_VERSION) {
>              goto fail_format;
>          }
>          if (!memcmp(ph.magic, HEADER_MAGIC, 16)) {
>              s->off_multiplier = 1;
>              bs->total_sectors = 0xffffffff & bs->total_sectors;
>          } else if (!memcmp(ph.magic, HEADER_MAGIC2, 16)) {
>              s->off_multiplier = le32_to_cpu(ph.tracks);
>          } else {
>              goto fail_format;
>          }
> 
>          s->tracks = le32_to_cpu(ph.tracks);
>          if (s->tracks == 0) {
>              error_setg(errp, "Invalid image: Zero sectors per track");
>              ret = -EINVAL;
>              goto fail;
>          }
>          if (s->tracks > INT32_MAX/513) {
>              error_setg(errp, "Invalid image: Too big cluster");
>              ret = -EFBIG;
>              goto fail;
>          }
> 
>          s->bat_size = le32_to_cpu(ph.bat_entries);
>          if (s->bat_size > INT_MAX / sizeof(uint32_t)) {
>              error_setg(errp, "Catalog too large");
>              ret = -EFBIG;
>              goto fail;
>          }
> 
>          size = bat_entry_off(s->bat_size);
>          s->header_size = ROUND_UP(size, bdrv_opt_mem_align(bs->file->bs));
>          s->header = qemu_try_blockalign(bs->file->bs, s->header_size);
>          if (s->header == NULL) {
>              ret = -ENOMEM;
>              goto fail;
>          }
>          s->data_end = le32_to_cpu(ph.data_off);
>          if (s->data_end == 0) {
>              s->data_end = ROUND_UP(bat_entry_off(s->bat_size), BDRV_SECTOR_SIZE);
>          }
>          if (s->data_end < s->header_size) {
>              /* there is not enough unused space to fit to block align between BAT
>                 and actual data. We can't avoid read-modify-write... */
>              s->header_size = size;
>          }
> 
>          ret = bdrv_pread(bs->file, 0, s->header, s->header_size);
>          if (ret < 0) {
>              goto fail;
>          }
>          s->bat_bitmap = (uint32_t *)(s->header + 1);
> 
>          for (i = 0; i < s->bat_size; i++) {
>              int64_t off = bat2sect(s, i);
>              if (off >= s->data_end) {
>                  s->data_end = off + s->tracks;
>              }
>          }
> 
>          if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
>              /* Image was not closed correctly. The check is mandatory */
>              s->header_unclean = true;
>              if ((flags & BDRV_O_RDWR) && !(flags & BDRV_O_CHECK)) {
>                  error_setg(errp, "parallels: Image was not closed correctly; "
>                             "cannot be opened read/write");
>                  ret = -EACCES;
>                  goto fail;
>              }
>          }
> 
>          opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
>          if (!opts) {
>              goto fail_options;
>          }
> 
>          if (!qemu_opts_absorb_qdict(opts, options, errp)) {
>              goto fail_options;
>          }
> 
>          s->prealloc_size =
>              qemu_opt_get_size_del(opts, PARALLELS_OPT_PREALLOC_SIZE, 0);
>          s->prealloc_size = MAX(s->tracks, s->prealloc_size >> BDRV_SECTOR_BITS);
>          buf = qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
>          /* prealloc_mode can be downgraded later during allocate_clusters */
>          s->prealloc_mode = qapi_enum_parse(&prealloc_mode_lookup, buf,
>                                             PRL_PREALLOC_MODE_FALLOCATE,
>                                             &local_err);
>          g_free(buf);
>          if (local_err != NULL) {
>              error_propagate(errp, local_err);
>              goto fail_options;
>          }
> 
>          if ((flags & BDRV_O_RDWR) && !(flags & BDRV_O_INACTIVE)) {
>              s->header->inuse = cpu_to_le32(HEADER_INUSE_MAGIC);
>              ret = parallels_update_header(bs);
>              if (ret < 0) {
>                  goto fail;
>              }
>          }
> 
>          s->bat_dirty_block = 4 * qemu_real_host_page_size;
>          s->bat_dirty_bmap =
>              bitmap_new(DIV_ROUND_UP(s->header_size, s->bat_dirty_block));
> 
>          /* Disable migration until bdrv_invalidate_cache method is added */
>          error_setg(&s->migration_blocker, "The Parallels format used by node '%s' "
>                     "does not support live migration",
>                     bdrv_get_device_or_node_name(bs));
>          ret = migrate_add_blocker(s->migration_blocker, errp);
>          if (ret < 0) {
>              error_free(s->migration_blocker);
>              goto fail;
>          }
>          qemu_co_mutex_init(&s->lock);
>          return 0;
> 
>      fail_format:
>          error_setg(errp, "Image not in Parallels format");
>      fail_options:
>          ret = -EINVAL;
>      fail:
>          qemu_vfree(s->header);
>          return ret;
>      }
> 
> Care to suggest further improvements?

Looks good, no crossing gotos neither no-op error propagation, nothig to do then. Thanks!

> 
>> Still, it should work and the rest is fine, so:
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> Thanks!
> 


-- 
Best regards,
Vladimir

