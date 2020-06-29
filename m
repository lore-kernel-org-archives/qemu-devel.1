Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4510FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1008D23770
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="snd7c04B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1008D23770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jprAn-0002Gq-CW
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpr9z-0001QD-HF; Mon, 29 Jun 2020 06:37:11 -0400
Received: from mail-eopbgr00108.outbound.protection.outlook.com
 ([40.107.0.108]:31366 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpr9w-0001wo-16; Mon, 29 Jun 2020 06:37:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GD7wUxAX4jbW9W49z+InQqADQQlSfu4+Uun9EZzycPxrlmGOdewBdfQma3lDZTeQ6LI5/KAFW86uJxXj8W4K9wLc5k6Soh9WunY8ED9XaDhVttNYqyq7UntPemiWbTGVlo94Tyd9fp2tj9soWbSc81S0X8sWKJrAHGQa44JblPALsdbcxqPnjI2GAb8fHrAlmLp1BQFSSFF1S7ON9dtB53wUsV3er0OcC9MbV3Bz4/XzMLdVjq5QvPPvwyYmzIARbIdAOK+1zwZ0Eq7ipskm+rURsFtKgOv6KpVBgqyJ226Cm0k5UIfo+TyNjNg48XjXba9LW0n0QH4OTipelBgOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2WRn9++syWkSKoRPxHoXn6yEi9uT1msgdnmg+0dA7Q=;
 b=BAKTXtYWtIvZAwUQC5slSrcUVn7rKbWVh5eKmz3nvSxg2xbhOGZMTq76kRftKr9N7mnIM9eClbI8L8fIN+w+Gp6LJbopw6vAJLq4XX8MX/1Gqeb+uVi97aIW/U+a7MmghZpB55ednhxaXLh1kbZuLgcpz9C9VKT8T4jf4kI8cdDDFtDGwq0L0vUCEcLrriwOoYqfkmGE961O5einv9yK7E6sUOenZfFu+uu8GtT0Q7gcsuhgP4nBg0c+XeZMet+oeyP9QV6PVP1H/B/vSFPn8nS/pvshZ3o+dAQKMQ6viRKM3G3/nq7Srf06w0uUoa04kRuCBPJkeVSQvZlWejbd5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2WRn9++syWkSKoRPxHoXn6yEi9uT1msgdnmg+0dA7Q=;
 b=snd7c04BBubLTN3jbxbasqVOpqW8qiPJbVY9uNiRIlkmcGc2Hon/gROPPQ0g7tD87SJ0bwJrPdKj/LqCQS9M6gOcmZPNx2y3QBncxgRTkdUQgoMJGxmk9hPrNFVGdILGxd3dyOtEDwhcjB2mu8DhfA2UnJsDUjBUudUU2bhKGJE=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5446.eurprd08.prod.outlook.com (2603:10a6:20b:107::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Mon, 29 Jun
 2020 10:37:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 10:37:04 +0000
Subject: Re: [PATCH 15/46] qemu-option: Tidy up opt_set() not to free
 arguments on failure
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-16-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f9545aa8-93d1-1b0c-9303-f8f8df6c2468@virtuozzo.com>
Date: Mon, 29 Jun 2020 13:37:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164344.3778251-16-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0115.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.28) by
 AM0PR06CA0115.eurprd06.prod.outlook.com (2603:10a6:208:ab::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Mon, 29 Jun 2020 10:37:04 +0000
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae26675d-3270-4356-df60-08d81c185da2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5446:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5446CEEDEFE356CA832C3B3AC16E0@AM7PR08MB5446.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uVatJ0I6cpZMmX5I3aWGqPYPC7pmdo01njHujSFqcibwMAbmzPYEpsVvuFzPIkVq9W1BiHfPX7emPRC6iW4+oqQxYMHiGT5IOw9GDvUJoMR6me67opLAhJ0mE8+Rvyg9sskRUprmtscP1A2ob8DlJHAnqI3682pCYPMcov9qfJ6xdge9QSg95s60zcHdIf46lj5zqw7ppOCJWGRWsUbB3xaeTO1IM3V4vqWdMKw5Kjx2yn0eDtnNj176KAMn4ATfuIA5sWxp37FYcYwH3fUYpkioAajBdWmx/zq0HeCxt9VAJmHB3syzNgZAPQ7kN7iAGR4fJzMUYKlsUqiaMvXuTsrF36eflnehxhNRy0uzEh/sEw4I+MALoOZzRIhSycJd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(136003)(39840400004)(366004)(376002)(16526019)(478600001)(66556008)(66476007)(66946007)(6486002)(52116002)(2906002)(316002)(16576012)(2616005)(26005)(4326008)(31686004)(186003)(8676002)(31696002)(8936002)(86362001)(956004)(5660300002)(36756003)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cZdDs59moWd8jorDerdAQ951tEDHI45UVIrxaZAelhzxDg+DbMLq3IH2vLLZEQCTfoV+QRCl2ziT/6BG2klWEF+URNE5iAOIrX/SBzes9PPS02FjzAAwM+9UGRiAG43PycxWhU70QGqW8tTIQ7vJ6Nica+f2avFapGhaBinxESf20iKA/ePtRnHLqjQ4jVkn4l8lV3sDG1Di0swJ3k9M4E3BWd513O16XpU/LjLlHGixqogvD6XaT7Gkizu+a9EKMHN82nug9ywdTZkA0OzZxKyrM8Yzhd27Eg/CpAqk3iLMXjEXsDgYV1gsyMG6y1wEOtgturqrm9jJdCzb8Xn2bNSttlwyeAnkcZk1gmGa3MhAjDmCk2sUaVOhb13pe+lds1nv8PpJPIPWPDcaDnR7Te/jSo87LJ76o735kEFscaL8rrePykOyXg5YMbSL30ToWBbYaDcHlh4EMRtREdxcdqex2ue4KkiAxRPsBQ0r54Q=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae26675d-3270-4356-df60-08d81c185da2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 10:37:04.9569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6U74M/KCCMZSiLwnePAe3jjB6e8usnXYskH005K7eod2xzGKGy0SxRI6zZByM3BWPOZDLBHWbB0zJBnCD4ktZ4nvoE7JhB8+Dm7f4E2Fho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5446
Received-SPF: pass client-ip=40.107.0.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 06:37:05
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.06.2020 19:43, Markus Armbruster wrote:
> opt_set() frees its argument @value on failure.  Slightly unclean;
> functions ideally do nothing on failure.
> 
> To tidy this up, move opt_create() from opt_set() into its callers,
> along with the cleanup.

Hmm, let me think a bit..

So, prior to this patch:

opt_set gets name/value pair and sets the option in opts object, it
seems absolutely obvious and standard behavior for Map-like object.

The fact that for setting an option we create a QemuOpt object, and
somehow register it inside opts object is an implementation detail.

after the patch:

opt_set gets opt object, which is already registered in opts. So,
it seems like option is "partly" set already, and opt_set only
finalize the processing.

And, as opt_set() only finalize the "set" operation, on opt_set
failure we need additional roll-back of "set" operation first step.

Additional fact, indirectly showing that something is unclear here
is that we pass "opts" to opt_set twice: as "opts" parameter and
inside opt: (opt->opts must be the same, assertion won't hurt if
you decide to keep the patch).

=====

Semantics before the patch seems clearer to me.

To improve the situation around "value", we can just g_strdup it
in opt_create as well as "name" argument (and use const char*
type for "value" argument as well)

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   util/qemu-option.c | 33 ++++++++++++++++++---------------
>   1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 3cdf0c0800..14946e81f2 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -519,36 +519,39 @@ static QemuOpt *opt_create(QemuOpts *opts, const char *name, char *value,
>       return opt;
>   }
>   
> -static void opt_set(QemuOpts *opts, const char *name, char *value,
> -                    bool prepend, bool *help_wanted, Error **errp)
> +static bool opt_set(QemuOpts *opts, QemuOpt *opt, bool *help_wanted,
> +                    Error **errp)
>   {
> -    QemuOpt *opt;
>       const QemuOptDesc *desc;
>       Error *local_err = NULL;
>   
> -    desc = find_desc_by_name(opts->list->desc, name);
> +    desc = find_desc_by_name(opts->list->desc, opt->name);
>       if (!desc && !opts_accepts_any(opts)) {
> -        g_free(value);
> -        error_setg(errp, QERR_INVALID_PARAMETER, name);
> -        if (help_wanted && is_help_option(name)) {
> +        error_setg(errp, QERR_INVALID_PARAMETER, opt->name);
> +        if (help_wanted && is_help_option(opt->name)) {
>               *help_wanted = true;
>           }
> -        return;
> +        return false;
>       }
>   
> -    opt = opt_create(opts, name, value, prepend);
>       opt->desc = desc;
>       qemu_opt_parse(opt, &local_err);
>       if (local_err) {
>           error_propagate(errp, local_err);
> -        qemu_opt_del(opt);
> +        return false;
>       }
> +
> +    return true;
>   }
>   
>   void qemu_opt_set(QemuOpts *opts, const char *name, const char *value,
>                     Error **errp)
>   {
> -    opt_set(opts, name, g_strdup(value), false, NULL, errp);
> +    QemuOpt *opt = opt_create(opts, name, g_strdup(value), false);
> +
> +    if (!opt_set(opts, opt, NULL, errp)) {
> +        qemu_opt_del(opt);
> +    }
>   }
>   
>   void qemu_opt_set_bool(QemuOpts *opts, const char *name, bool val,
> @@ -820,9 +823,9 @@ static void opts_do_parse(QemuOpts *opts, const char *params,
>                             const char *firstname, bool prepend,
>                             bool *help_wanted, Error **errp)
>   {
> -    Error *local_err = NULL;
>       char *option, *value;
>       const char *p;
> +    QemuOpt *opt;
>   
>       for (p = params; *p;) {
>           p = get_opt_name_value(p, firstname, &option, &value);
> @@ -834,10 +837,10 @@ static void opts_do_parse(QemuOpts *opts, const char *params,
>               continue;
>           }
>   
> -        opt_set(opts, option, value, prepend, help_wanted, &local_err);
> +        opt = opt_create(opts, option, value, prepend);
>           g_free(option);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> +        if (!opt_set(opts, opt, help_wanted, errp)) {
> +            qemu_opt_del(opt);
>               return;
>           }
>       }
> 


-- 
Best regards,
Vladimir

