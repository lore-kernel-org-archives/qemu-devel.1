Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02000C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 08:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F8E2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 08:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Wdnz8ViQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F8E2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiwYv-000815-VM
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 04:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jiwXv-0006Xt-JE; Wed, 10 Jun 2020 04:57:20 -0400
Received: from mail-vi1eur05on2101.outbound.protection.outlook.com
 ([40.107.21.101]:12993 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jiwXs-00015v-NA; Wed, 10 Jun 2020 04:57:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fwr1yk5zXmUcWdwuKJe0cs5ltOMAocd80uM3qtr563qtkpuK+CrGu0KVmgvooz2SQAwfkR7stPprQBgzMkfR4ZY28qHn5OPQmMWWWh0eo0ApBtzH6HS+LuwqoAFIhVojPnroKrIix08fSOlvOKAFEgx8E5IshE+9f8xa+G7lyXQ86P3KZGbjv/ulisT7nE7QKDnv03YQZobUPYXcrw7C8o6k2P2I3SrgeRHxmLS+qJuqkCj8nQbfroNE6uoAeyurn+nVo08mZ7QTUUrIb5Bh0L6jZwEvuD2Cu/kKPZzbV0+lrrIGEjCpLWiBLr45K5p3uXoFe46FlrhYqo0NYHrzfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lcakvSja1iixC6QcrjO2CqtDd9DKXYhFLaaHbB06SA=;
 b=XuHGMjFWqb/d7W/AaDsAhlgCux2DZNDc0NZUiu00J2s3xXqmiIplp8JXyOx0wcGOhsroMu5RwnKzDT6RJzSe1B1s+MHaUbMiTH0bzp1FO8bLxlwLlgXLwHLD8GSvf5VLFOpmeX8qststXBE40vz568cYO2Nfc3fY3xH+lAbVs/APrqRLg/cyTz7L9mPhrs/phjjlVKA8wFp5eiKO0+2D8SFJC7l05H+D2pfEX1PFjyq0l8BLB41qTwE4yKQXQ5LJzTfr03OjC4yBF+CLZ/IPr1Lt6iDkKg4uYHkU7RVuQX9iRRCNKLJhltRWXEW89VObT7P4sPpOGQgNQYXzOSTOwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lcakvSja1iixC6QcrjO2CqtDd9DKXYhFLaaHbB06SA=;
 b=Wdnz8ViQ83fGDRWUxrLFVmL2dUdyRbOg4TXm/5sXE2PtAlfUs1Q+Al8Vu8rSn+hFvv2woRlBcGSeepaBA+KuOl+N/UICwgJb+w1fZjlYNeDn0WkvRUhp20SyvkGj/VkW+qIO6QcPl79Se9wQakvH/9d+kuCtpXRJBH0e4lw46a0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Wed, 10 Jun
 2020 08:57:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 08:57:11 +0000
Subject: Re: [PATCH 1/2] nbd/server: Avoid long error message assertions
 CVE-2020-10761
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200608182638.3256473-1-eblake@redhat.com>
 <20200608182638.3256473-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <678021fb-d34d-4067-31b3-f864efe13dbd@virtuozzo.com>
Date: Wed, 10 Jun 2020 11:57:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200608182638.3256473-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0024.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::37) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.166) by
 AM0PR07CA0024.eurprd07.prod.outlook.com (2603:10a6:208:ac::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.10 via Frontend Transport; Wed, 10 Jun 2020 08:57:10 +0000
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35a55914-9ac4-4948-4bf2-08d80d1c4370
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-Microsoft-Antispam-PRVS: <AM7PR08MB538185AE8A16F369A47D3AC2C1830@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WafBi4HOjvt3Bn461WOjLbSjEo7i2ku+ZVodcobIVqa5dMAqCZTp4rYUVbM1RmhK+WAeliLYeaVOQKA8GCewyefvmK9zRToqeyds58kndCcTo9R9462AMdjbTNb4WJ9bwfJfUK78+5atYXyLd/CqQ6aboZBwtpHohtm0H3AHF5MuBaXWxZ02IEWQ9S+EwN001frU7bL60m54NivXAL9MxUU5V0sZ4UI3m7Jylmj45r75hGWlRAOOMGh5wWp7FQmJhcMnw/lCjY3iwkjZtLB6zU0DtyoH1Tu+24846CfqvPYDPNilqzscCeBYcskAdJygmSpRTJMva9/bD9QftQpqBxjfxuRvxvMmyVaWo9NaDVzF7wAWOdKrHkMrSTAiMYjqt3epgsOBnJqGVZ4aDg0IbMok5/mpGKzYAWMBY6MZT66eI69Kydw9EvFTNq/UaFG9fsZzsSFRKlXM57jRTAKeAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(39850400004)(136003)(396003)(8676002)(16576012)(5660300002)(316002)(66946007)(31696002)(4326008)(36756003)(52116002)(66476007)(966005)(26005)(6486002)(15650500001)(8936002)(54906003)(186003)(86362001)(478600001)(31686004)(66556008)(956004)(83380400001)(16526019)(2906002)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: IhdFqeWa/VhT36KPZAMhl81by+ygs9fAIduLQWzFWYKymTw2zMzYW04fBq4fO2t8gHIe/8CQfHiWRnGMYTQwhq9aHI/OTtYOQN9tjPgjMe8Fm3HjUmCEOkcCdi08LqjIhloLlSYzWmD28Dm0KzIZlN082A0DXeZYQf6e3rzqXkNhqjqhq4R3tY95NklDBhapVsZCLuJ16KGZe7EZwX9tTXQl2mURbbKjaJyr7mUY/CmKepqj1iyroTX0pt8IZgS/dJHJb67eMQ4CELCYQsOvDHLEh7267hEZqYccp3MvI3SgDynYaW/qvBsAS9enjUSIHKBjYMqwzK2Ul9f89pD1NBOWnTHbrHX7k/7b3MZ0XmbVHWGoJ0ojcwX6EI9OevMrQZd0fypZJq2rLI7WMw0RJ8XcrN1dNQjTVJJmWIoLLqdHVV6UUI6g2nHalzKB0Oq4WT0uaIX/iu6fKXVSTbTMP6r5gD87CHCi3c/XCyKtnOxP3TMdTqGaDo+KzmnMWl9O
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a55914-9ac4-4948-4bf2-08d80d1c4370
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 08:57:11.6116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sMi135gNy7ZPNTv5YQE5ArtUA8j0JhAPS4tDyCok8mSzjesr7KolT+vd/6M7mWq1DhO50LZ1TKKqkf+lgJywG8D4l9695wnvnI160LUe7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.21.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 04:57:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, ppandit@redhat.com,
 xuwei@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

08.06.2020 21:26, Eric Blake wrote:
> Ever since commit 36683283 (v2.8), the server code asserts that error
> strings sent to the client are well-formed per the protocol by not
> exceeding the maximum string length of 4096.  At the time the server
> first started sending error messages, the assertion could not be
> triggered, because messages were completely under our control.
> However, over the years, we have added latent scenarios where a client
> could trigger the server to attempt an error message that would
> include the client's information if it passed other checks first:
> 
> - requesting NBD_OPT_INFO/GO on an export name that is not present
>    (commit 0cfae925 in v2.12 echoes the name)
> 
> - requesting NBD_OPT_LIST/SET_META_CONTEXT on an export name that is
>    not present (commit e7b1948d in v2.12 echoes the name)
> 
> At the time, those were still safe because we flagged names larger
> than 256 bytes with a different message; but that changed in commit
> 93676c88 (v4.2) when we raised the name limit to 4096 to match the NBD
> string limit.  (That commit also failed to change the magic number
> 4096 in nbd_negotiate_send_rep_err to the just-introduced named
> constant.)  So with that commit, long client names appended to server
> text can now trigger the assertion, and thus be used as a denial of
> service attack against a server.  As a mitigating factor, if the
> server requires TLS, the client cannot trigger the problematic paths
> unless it first supplies TLS credentials, and such trusted clients are
> less likely to try to intentionally crash the server.
> 
> Reported-by: Xueqiang Wei <xuwei@redhat.com>
> CC: qemu-stable@nongnu.org
> Fixes: https://bugzilla.redhat.com/1843684 CVE-2020-10761
> Fixes: 93676c88d7
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   nbd/server.c               | 28 +++++++++++++++++++++++++---
>   tests/qemu-iotests/143     |  4 ++++
>   tests/qemu-iotests/143.out |  2 ++
>   3 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 02b1ed080145..ec130303586d 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -217,7 +217,7 @@ nbd_negotiate_send_rep_verr(NBDClient *client, uint32_t type,
> 
>       msg = g_strdup_vprintf(fmt, va);
>       len = strlen(msg);
> -    assert(len < 4096);
> +    assert(len < NBD_MAX_STRING_SIZE);
>       trace_nbd_negotiate_send_rep_err(msg);
>       ret = nbd_negotiate_send_rep_len(client, type, len, errp);
>       if (ret < 0) {
> @@ -231,6 +231,27 @@ nbd_negotiate_send_rep_verr(NBDClient *client, uint32_t type,
>       return 0;
>   }
> 
> +/*
> + * Truncate a potentially-long user-supplied string into something
> + * more suitable for an error reply.
> + */
> +static const char *
> +nbd_truncate_name(const char *name)
> +{
> +#define SANE_LENGTH 80
> +    static char buf[SANE_LENGTH + 3 + 1]; /* Trailing '...', NUL */

s/NUL/NULL/

Hmm. It may break if we use it in parallel in two coroutines or threads.. Not sure, is it possible now, neither of course will it be possible in future.

I'd avoid creating functions returning  instead use g_strdup_printf(), like

char *tmp = g_strdup_printf("%.80s...", name);

   ( OR, if you want explicit constant: g_strdup_printf("%.*s...", SANE_LENGTH, name) )

... report error ...

g_free(tmp)

Using g_strdup_printf also is safer as we don't need to care about buf size.

> +
> +    if (strlen(name) < SANE_LENGTH) {
> +        return name;
> +    }
> +    memcpy(buf, name, SANE_LENGTH);
> +    buf[SANE_LENGTH] = '.';
> +    buf[SANE_LENGTH + 1] = '.';
> +    buf[SANE_LENGTH + 2] = '.';
> +    buf[SANE_LENGTH + 3] = '\0';

one-line suggestion:

   sprintf(buf, "%.80s...", name);

OR

   sprintf(buf, "%.*s...", SANE_LENGTH, name);

> +    return buf;
> +}
> +
>   /* Send an error reply.
>    * Return -errno on error, 0 on success. */
>   static int GCC_FMT_ATTR(4, 5)
> @@ -597,7 +618,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
>       if (!exp) {
>           return nbd_negotiate_send_rep_err(client, NBD_REP_ERR_UNKNOWN,
>                                             errp, "export '%s' not present",
> -                                          name);
> +                                          nbd_truncate_name(name));
>       }
> 
>       /* Don't bother sending NBD_INFO_NAME unless client requested it */
> @@ -996,7 +1017,8 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
>       meta->exp = nbd_export_find(export_name);
>       if (meta->exp == NULL) {
>           return nbd_opt_drop(client, NBD_REP_ERR_UNKNOWN, errp,
> -                            "export '%s' not present", export_name);
> +                            "export '%s' not present",
> +                            nbd_truncate_name(export_name));
>       }
> 

Hmm, maybe instead of assertion, shrink message in nbd_negotiate_send_rep_verr() too?
This will save us from forgotten (or future) uses of the function.

Shrinking name is better, as it provides better message on result. But generally shrink
all two long messages in nbd_negotiate_send_rep_verr() (maybe, together with error_report())
seems a good thing for me.

>       ret = nbd_opt_read(client, &nb_queries, sizeof(nb_queries), errp);
> diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
> index f649b3619501..b0b1cff86cb6 100755
> --- a/tests/qemu-iotests/143
> +++ b/tests/qemu-iotests/143
> @@ -58,6 +58,10 @@ _send_qemu_cmd $QEMU_HANDLE \
>   $QEMU_IO_PROG -f raw -c quit \
>       "nbd+unix:///no_such_export?socket=$SOCK_DIR/nbd" 2>&1 \
>       | _filter_qemu_io | _filter_nbd
> +# Likewise, with longest possible name permitted in NBD protocol
> +$QEMU_IO_PROG -f raw -c quit \
> +    "nbd+unix:///$(printf %4096d 1 | tr ' ' a)?socket=$SOCK_DIR/nbd" 2>&1 \
> +    | _filter_qemu_io | _filter_nbd | sed 's/aa.*aa/aa...aa/'
> 
>   _send_qemu_cmd $QEMU_HANDLE \
>       "{ 'execute': 'quit' }" \
> diff --git a/tests/qemu-iotests/143.out b/tests/qemu-iotests/143.out
> index 1f4001c60131..be1f3a625458 100644
> --- a/tests/qemu-iotests/143.out
> +++ b/tests/qemu-iotests/143.out
> @@ -5,6 +5,8 @@ QA output created by 143
>   {"return": {}}
>   qemu-io: can't open device nbd+unix:///no_such_export?socket=SOCK_DIR/nbd: Requested export not available
>   server reported: export 'no_such_export' not present
> +qemu-io: can't open device nbd+unix:///aa...aa1?socket=SOCK_DIR/nbd: Requested export not available
> +server reported: export 'aa...aa...' not present
>   { 'execute': 'quit' }
>   {"return": {}}
>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
> 


-- 
Best regards,
Vladimir

