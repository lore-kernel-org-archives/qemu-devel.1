Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5573C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 17:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706942070B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 17:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="G0Jc3Bbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706942070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj4O2-00010Q-M0
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 13:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj4Lx-0006x7-0T; Wed, 10 Jun 2020 13:17:29 -0400
Received: from mail-eopbgr80093.outbound.protection.outlook.com
 ([40.107.8.93]:5628 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj4Lu-0000Gk-42; Wed, 10 Jun 2020 13:17:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur/+l3foaW/EVs8AcsrYX+DUPzm4BcFywFdNP4GQZOuYdq3JxruxHhi+GGu95cxEInyL6qj2Ty3veKTk3nFaGVbb1DgvQg0kRd4pvOsxQBVz8yAeku75qCqaOYGgKMjVkaWGm7E5DlgmS7vvKJe3n7Hpks5Weg+K1zu+jQ8y5uxPHRSCOznL1ImIJiyh1P7iqZ267SQAvvsgaAaj9VMObBIVDcpNmjqL9B6SuZ2+5aop1PvJerVwq3ld9FSXnzlI591j/k+PgAjYMc6lUgdkMI6/etfAflWXCH/h8zDtONwbzCWtVg1876S+ZUE+wiU1bs/idD2d72HQ0oHcGPoHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ63oaUq7OZzlGiKG6fNiSiugzcH3P65jPo8hOPEQNo=;
 b=NCCnt+aKXIDdI549SimW28Iir0p2ZC/KTV1URwgGkGviX6XkmdJyaDoHbkf4O93HRQHdeL+K97NwH92QLQ/ZyPEHWGeS2JxPbvW6oK27L7q9D0jHd9pOp+B7IlPaUKuaEYXfGqNmuZI7RZYMuuCHrT770vnuJgYDKFjulNjCBYnYOk08jgrmcpn33UmlXpzE5LRf3pdR6nPDJt3d9gAvj6alZGqjbrzwV7UhtiStJGgET6f9qyPY9d28l2X4PgTsT2DkSFtVYkagIA4H7x7I49uAo6InnRgmmANk5g3Rc45TZZNRfYgYQphK8PUcMy4dKICahM/KlaZVFOa0HdO59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ63oaUq7OZzlGiKG6fNiSiugzcH3P65jPo8hOPEQNo=;
 b=G0Jc3BbxCa2cDr9BAkHHSTPrR21VzBBJ7xWbpHnr/D94iwMoEGiIeXLfY/nuIQpiiTBx8vSa2xJO9KTVfb10STjwrSSGLm16uuHjFj0Ff1E/y9NIusHYX6wpe+kRyGoUu54CvkqeRkVDPm6XhUxXqACNE9ZvKaAe6JPmvTu3zFE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5462.eurprd08.prod.outlook.com (2603:10a6:20b:10b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 10 Jun
 2020 17:17:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 17:17:21 +0000
Subject: Re: [PATCH v2 1/2] nbd/server: Avoid long error message assertions
 CVE-2020-10761
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200610163741.3745251-1-eblake@redhat.com>
 <20200610163741.3745251-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <89b366a9-a7e0-c2a9-d1a0-636a353c13ad@virtuozzo.com>
Date: Wed, 10 Jun 2020 20:17:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200610163741.3745251-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0009.eurprd05.prod.outlook.com (2603:10a6:205::22)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.166) by
 AM4PR05CA0009.eurprd05.prod.outlook.com (2603:10a6:205::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Wed, 10 Jun 2020 17:17:21 +0000
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92159703-1cb4-4205-4ccb-08d80d6222e1
X-MS-TrafficTypeDiagnostic: AM7PR08MB5462:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54623805F7BEB6525CAA4928C1830@AM7PR08MB5462.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2TGy69ANvJlI2OhwtQK60y8ArEyWI0o5Q4EWRabdmliwpn+ANleiruc/L9abYzRvGLZt2lyRoBNMQSumnfuVsRmp97tdzseDM0pkREqNi9VmZcxL3d+2/kkmU4ypdrY77YSruvtUy5I18cl/rnS8oyDeOekVg8rdxRMQZc4RQIsCGVkRjZ+fTQMdZhzENeDmHbRHnnSkABghZJ/9GV+vbCg2NM+vHFr2rFt/RBJ8GRv19uVvfGf1j0SgvqjnXw55dBds3wAcibwe5I4SkHa/ncgUCotdwymIxSYMCAGdwYnW8EXFkN6jpCgL3DCjX+4pK7YGdvH/w6TndTJjqnobE2r0SebilIr3CCuGSiusfsRPU5UlamWUQeClEBofH1SVZcBVI6zDvy5BMuWhElLjenIa6V8OP5x+yZrenJkMU1XKa9BJe7YHyCfDu84zt5mOZPXwVvALorq9Ldiv4DaCVO+koCeu1tw/bvriLrzdSE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39850400004)(136003)(366004)(396003)(376002)(186003)(2616005)(36756003)(66946007)(66476007)(66556008)(2906002)(966005)(478600001)(16576012)(8676002)(316002)(16526019)(31696002)(5660300002)(54906003)(26005)(86362001)(956004)(83380400001)(8936002)(31686004)(15650500001)(52116002)(4326008)(6486002)(21314003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bPuipApCT3DAeOeQhI0aSHRbhgdljtvQrkJXmRGQrr9YGw/bm4ho+hpMvLU9YA0yK5wMLkdr8dEfgTeEi5gcjpesgJePqKZM0MoZMbpAMRQf0IgmfwIKS9X68ZxbkgEVhcWbOkddC9rppp86Q/r4pm4lPPmkNWtnFO4fGHayBIGTS0MruFG1WpWNtTbQ7WjlVAHXGjYh6fup0IOvbEZ3rrQm+tcju7FJaL6+SopTOtfcVWYycHSg1nClA3/IMAm1iAm14iAdm/kdXX+Ehj8qMB0+XEsFQC6Oj8Fhp1eWSdzXNJlhxNGlW4puoNUMVFh53NidlwS2sd1ma25g29tP4mDsnfM8Ez0h6OvJMV5j0pYPNNPvhbJ5OUp9tK1rAexOxqcmhYZf6LQ993q8rj8mGU8QyW8sOPTJcd1nysOATxoVAXn8xflDOztBw5Z736E39w3SprmVyd1633UoRBL96MtEqQ2Mei+c9Xm8GfIAlrc3AsI93QodVB/UwhGRGstC
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92159703-1cb4-4205-4ccb-08d80d6222e1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 17:17:21.7306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGYt3KzJkxpaDu18o0otuzIge+5MjjxqAe9fPnzdHjvr/3bP2/QpMye0GXcnW2D053oeLsdmxmHxvLXTqPyTXQDss1WOLZBAX2puY4sAyv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5462
Received-SPF: pass client-ip=40.107.8.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 13:17:22
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, ppandit@redhat.com,
 xuwei@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.06.2020 19:37, Eric Blake wrote:
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
> We may later want to further sanitize the user-supplied strings we
> place into our error messages, such as scrubbing out control
> characters, but that is less important to the CVE fix, so it can be a
> later patch to the new nbd_sanitize_name.
> 
> Consideration was given to changing the assertion in
> nbd_negotiate_send_rep_verr to instead merely log a server error and
> truncate the message, to avoid leaving a latent path that could
> trigger a future CVE DoS on any new error message.  However, this
> merely complicates the code for something that is already (correctly)
> flagging coding errors, and now that we are aware of the long message
> pitfall, we are less likely to introduce such errors in the future,
> which would make such error handling dead code.
> 
> Reported-by: Xueqiang Wei <xuwei@redhat.com>
> CC: qemu-stable@nongnu.org
> Fixes: https://bugzilla.redhat.com/1843684 CVE-2020-10761
> Fixes: 93676c88d7
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   nbd/server.c               | 23 ++++++++++++++++++++---
>   tests/qemu-iotests/143     |  4 ++++
>   tests/qemu-iotests/143.out |  2 ++
>   3 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 02b1ed080145..20754e9ebc3c 100644
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
> @@ -231,6 +231,19 @@ nbd_negotiate_send_rep_verr(NBDClient *client, uint32_t type,
>       return 0;
>   }
> 
> +/*
> + * Return a malloc'd copy of @name suitable for use in an error reply.
> + */
> +static char *
> +nbd_sanitize_name(const char *name)
> +{
> +    if (strnlen(name, 80) < 80) {
> +        return g_strdup(name);
> +    }
> +    /* XXX Should we also try to sanitize any control characters? */
> +    return g_strdup_printf("%.80s...", name);
> +}
> +
>   /* Send an error reply.
>    * Return -errno on error, 0 on success. */
>   static int GCC_FMT_ATTR(4, 5)
> @@ -595,9 +608,11 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
> 
>       exp = nbd_export_find(name);
>       if (!exp) {
> +        g_autofree char *sane_name = nbd_sanitize_name(name);

Cool! Somehow I forget about this feature, when writing my answer on v1.

> +
>           return nbd_negotiate_send_rep_err(client, NBD_REP_ERR_UNKNOWN,
>                                             errp, "export '%s' not present",
> -                                          name);
> +                                          sane_name);
>       }
> 
>       /* Don't bother sending NBD_INFO_NAME unless client requested it */
> @@ -995,8 +1010,10 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
> 
>       meta->exp = nbd_export_find(export_name);
>       if (meta->exp == NULL) {
> +        g_autofree char *sane_name = nbd_sanitize_name(export_name);
> +
>           return nbd_opt_drop(client, NBD_REP_ERR_UNKNOWN, errp,
> -                            "export '%s' not present", export_name);
> +                            "export '%s' not present", sane_name);
>       }
> 
>       ret = nbd_opt_read(client, &nb_queries, sizeof(nb_queries), errp);
> diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
> index f649b3619501..b4acc4372542 100755
> --- a/tests/qemu-iotests/143
> +++ b/tests/qemu-iotests/143
> @@ -58,6 +58,10 @@ _send_qemu_cmd $QEMU_HANDLE \
>   $QEMU_IO_PROG -f raw -c quit \
>       "nbd+unix:///no_such_export?socket=$SOCK_DIR/nbd" 2>&1 \
>       | _filter_qemu_io | _filter_nbd
> +# Likewise, with longest possible name permitted in NBD protocol
> +$QEMU_IO_PROG -f raw -c quit \
> +    "nbd+unix:///$(printf %4096d 1 | tr ' ' a)?socket=$SOCK_DIR/nbd" 2>&1 \
> +    | _filter_qemu_io | _filter_nbd | sed 's/aa.*aa/aa--aa/'

A bit more precise regexp: 's/a\{5,\}/aa--aa/'

> 
>   _send_qemu_cmd $QEMU_HANDLE \
>       "{ 'execute': 'quit' }" \
> diff --git a/tests/qemu-iotests/143.out b/tests/qemu-iotests/143.out
> index 1f4001c60131..fc9c0a761fa1 100644
> --- a/tests/qemu-iotests/143.out
> +++ b/tests/qemu-iotests/143.out
> @@ -5,6 +5,8 @@ QA output created by 143
>   {"return": {}}
>   qemu-io: can't open device nbd+unix:///no_such_export?socket=SOCK_DIR/nbd: Requested export not available
>   server reported: export 'no_such_export' not present
> +qemu-io: can't open device nbd+unix:///aa--aa1?socket=SOCK_DIR/nbd: Requested export not available
> +server reported: export 'aa--aa...' not present
>   { 'execute': 'quit' }
>   {"return": {}}
>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
> 


-- 
Best regards,
Vladimir

