Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4247C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2096F206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="k2m+6X1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2096F206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwVI-0000id-3K
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kIwTY-0007eE-Iw; Thu, 17 Sep 2020 12:09:36 -0400
Received: from mail-db8eur05on2118.outbound.protection.outlook.com
 ([40.107.20.118]:51201 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kIwTT-0005h6-4o; Thu, 17 Sep 2020 12:09:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzY0ECPJmx1d/XVXZtlG6cdFb4sz+IBmvpxEHvjLWIWBL65pSw2zDAa0rfGw1hFkv1cHOsrk/IWjy4z6ENEKOsF7xPnRdb5fz19dH05IIgTEoozJfgUCmfk69uxUNaZLufb8p59MDNhV8BvTgIDlQqgzZlYfMUr762JKux6wC6sIhhYTJ7P6oKmBi9DxPeTz6UPeaciAf33lhJcJHt8DAUUt+EMjg7sc5c/SsC///SxQefFrVe+ZBDSkmG+jL2FO2E3cL6SH5zcdObxmhTu3N9jXDOFhYhDguBUjnE5HaH5yEKHA6h6Sxj2KANWePYF4F9TAiAEWiz7dcT3fmbqpEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFmrRlDRG9k2qDhVB5xsr9GjzmfA35jCtROeJwWNhGA=;
 b=eNUh3FTznYGhWeWa6lOwVRdTZuTWKO+J9fk2XAZeiJMMzFmhus172fDpqKrsgxRsi/PdDQyAy33U6D3wjA626f0TPhW/q1+hjz6DnLNuRaB5VlWTf463OFctj1Colyweq0cKmbTfsLCxEaworqoZjjjTu9bTI5zR+mZNd+u9Ll+g7GLjT1wfRMfEvcWtwPW2scx2xnjNnj50efJyGRNY0TEBgSUc8n6fArWbEA4yY2kwP7K9DBojpsYcs/1yMk+1nXS342jsjHG0rjgUM36ouBYrkfczSvsEZhzBarxowN+Q1NKAz1UJGBrAlxddEXmcoxkLlGMD6luucleMtypqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFmrRlDRG9k2qDhVB5xsr9GjzmfA35jCtROeJwWNhGA=;
 b=k2m+6X1lNA6IoHxsjpbvt7GL9j5p5/bLNSVZbd9ThnDp6CS7+1BsA3pWVUY/L2UCTKyyxo0KYw+LvlEYUi+Pngo7LLRcjS44R24zRA8hvxJFH8hxh1iEQeXt2ZxU8DBDwb/w7iftUz4uRZU1sEcEtJfr71ITx1pdmbb2eu4htUs=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0801MB1771.eurprd08.prod.outlook.com (2603:10a6:3:88::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Thu, 17 Sep
 2020 16:09:25 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 16:09:25 +0000
Subject: Re: [PATCH v8 2/7] copy-on-read: add filter append/drop functions
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com,
 jsnow@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598633579-221780-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <9733a257-b864-e8db-7379-f94fbd21045a@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <25a087d0-0306-574d-432b-0b5635ee7873@virtuozzo.com>
Date: Thu, 17 Sep 2020 19:09:22 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <9733a257-b864-e8db-7379-f94fbd21045a@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------257BC0BB94D4F90ABDEC7C35"
Content-Language: en-GB
X-ClientProxiedBy: FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::20) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.4 via Frontend Transport; Thu, 17 Sep 2020 16:09:24 +0000
X-Originating-IP: [109.252.114.22]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb124550-c1ab-44fb-2e63-08d85b240bf7
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1771:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB17711E0E5156A3BC6644B8F2F43E0@HE1PR0801MB1771.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KgzcWc12RATY4rex8LIUMxcBuQ1YfwYLhs5pBQ/r4leideDERuQxSrjxyGCQ7arNMIpPtoVUP7aMdj5uos2nFNNLsSBkxUK6MhjzAaiuMZc7Xx60Cn458+gyHocJkQYJf5DkBiWcHE7GjOHtn8OXM2DE8ArM0E3N4o1gNnUD0gV0MVLFiAxcEZQ0a8Big22n9mEbMiTOGVdFxd4hSUiNrgVxp7orldB+Y7EZfRGy3CjBm29jiB5gHfRlqjbKIhq5TUsY9EVb7tR5pA3F3Bp3I9Sq/u87QGINDAhvQDggUsKN2FncPpaWKtI8ZXqrDYV7jTjRYpzni0JZU8RhRyJlEp3HT7XWhFAmOXVD9X9mKUobo/5oUrZpquH5qr4LDIE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39840400004)(396003)(366004)(956004)(66946007)(66556008)(31696002)(44832011)(66476007)(16526019)(36756003)(86362001)(4326008)(6486002)(186003)(5660300002)(26005)(52116002)(8676002)(33964004)(2906002)(53546011)(2616005)(6512007)(107886003)(31686004)(478600001)(8936002)(83380400001)(6506007)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SgS7Xr6TZiIqfN5rKwfCpAxUz8zgXtcUALmwJoif6BlCVX5dV02+RdAXRvjsvUJOEq3/8JFa8l4zJmttEU15LGuSmAvxE38DbK4xAPdN0uGHYRYvbJ2pyvHTK1wM4cwvMD++BCUynF1TKRmMD8xFTNlcMRCMK2VPUBkxS5MTqWqwPfkGZt10C681PqeIAqqdxjAxDKUXxXAfneFU7/3B1mQEWOSHcoo2KNMwXSiCR98KesQ2LSzx4xL85K/1AVNK9QzR6q1Qr8AitSkdp1g3nljqkT9Js1TBqUrzuEcvvVOTRISldBO7+gxxRJm9MP747b45Cf0KJ2sroqo9wWVnBOFzdBapKY5GQLc/Plyu9XHYLCBZqZzP+jGIrbNgK3JGCDHBO1Mo8/LlKfByGqROGANepndAQRmzWOipoDC7FjFFz6c0uDtGM7fbGLJaKEgGLDHULbMDSSjoekaOLjjScpqscWREYxgG9/NqB4aYuiYTRrK+MZTEs4lIe9/A7/T5xxg0OlDljAzURQ/Cl5e3ewiGAMDPCMqly1aV1ejMOzmC4AHK6Pm7u+PjeJgo5cXn35HY6DWuDvktF/rudGVWCFTnDjE/aZquEYTYZ7OTaKkIxptKR/2kVmoExPPch4ZzSwVjMVOfidEjf1MoQsiwjg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb124550-c1ab-44fb-2e63-08d85b240bf7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 16:09:25.3172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gShj+kjpp390yHcCRWlltt20VrcnQWszex2NavLVAsWImEiQMZlR+aoLaJsyarjQSYr0lD92b2B8y5Uiuma0A2RQB+YzhsPHQYamfKOyo8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1771
Received-SPF: pass client-ip=40.107.20.118;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 12:09:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

--------------257BC0BB94D4F90ABDEC7C35
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.09.2020 14:22, Max Reitz wrote:
> On 28.08.20 18:52, Andrey Shinkevich wrote:
>> Provide API for the COR-filter insertion/removal.
...
>
>> Also, drop the filter child permissions for an inactive state when the
>> filter node is being removed.
> Do we need .active for that?  Shouldn’t it be sufficient to just not
> require BLK_PERM_WRITE_UNCHANGED when no permissions are taken on the
> node (i.e. perm == 0 in cor_child_perm())?
>
> Of course, using an .active field works, too.  But Vladimir wanted a
> similar field in the preallocate filter, and there already is in
> backup-top.  I feel like there shouldn’t be a need for this.
>
> .bdrv_child_perm() should generally be able to decide what permissions
> it needs based on the information it gets.  If every driver needs to
> keep track of whether it has any parents and feed that information into
> .bdrv_child_perm() as external state, then something feels wrong.
>
> If perm == 0 is not sufficient to rule out any parents, we should just
> explicitly add a boolean that tells .bdrv_child_perm() whether there are
> any parents or not – shouldn’t be too difficult.


The issue is that we fail in the bdrv_check_update_perm() with 
""Conflicts with use by..." if the *nperm = 0 and the *nshared = 
BLK_PERM_ALL are not set before the call to the bdrv_replace_node(). The 
filter is still in the backing chain by that moment and has a parent 
with child->perm != 0.

The implementation of  the .bdrv_child_perm()in the given patch is 
similar to one in the block/mirror.c.

How could we resolve the issue at the generic layer?


Andrey


>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/copy-on-read.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   block/copy-on-read.h |  35 +++++++++++++++++
>>   2 files changed, 139 insertions(+)
>>   create mode 100644 block/copy-on-read.h
> [...]

--------------257BC0BB94D4F90ABDEC7C35
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 04.09.2020 14:22, Max Reitz wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:9733a257-b864-e8db-7379-f94fbd21045a@redhat.com">
      <pre class="moz-quote-pre" wrap="">On 28.08.20 18:52, Andrey Shinkevich wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Provide API for the COR-filter insertion/removal.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    ...<br>
    <blockquote type="cite" cite="mid:9733a257-b864-e8db-7379-f94fbd21045a@redhat.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Also, drop the filter child permissions for an inactive state when the
filter node is being removed.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Do we need .active for that?  Shouldn’t it be sufficient to just not
require BLK_PERM_WRITE_UNCHANGED when no permissions are taken on the
node (i.e. perm == 0 in cor_child_perm())?

Of course, using an .active field works, too.  But Vladimir wanted a
similar field in the preallocate filter, and there already is in
backup-top.  I feel like there shouldn’t be a need for this.

.bdrv_child_perm() should generally be able to decide what permissions
it needs based on the information it gets.  If every driver needs to
keep track of whether it has any parents and feed that information into
.bdrv_child_perm() as external state, then something feels wrong.

If perm == 0 is not sufficient to rule out any parents, we should just
explicitly add a boolean that tells .bdrv_child_perm() whether there are
any parents or not – shouldn’t be too difficult.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>The issue is that we fail in the <span style="color: rgb(29, 28,
        29); font-family: Slack-Lato, appleLogo, sans-serif; font-size:
        15px; font-style: normal; font-variant-ligatures:
        common-ligatures; font-variant-caps: normal; font-weight: 400;
        letter-spacing: normal; orphans: 2; text-align: left;
        text-indent: 0px; text-transform: none; white-space: normal;
        widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(248, 248, 248); text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;"><span></span>bdrv_check_update_perm()</span>
      with &quot;&quot;Conflicts with use by...&quot; if <span style="color: rgb(29,
        28, 29); font-family: Slack-Lato, appleLogo, sans-serif;
        font-size: 15px; font-style: normal; font-variant-ligatures:
        common-ligatures; font-variant-caps: normal; font-weight: 400;
        letter-spacing: normal; orphans: 2; text-align: left;
        text-indent: 0px; text-transform: none; white-space: normal;
        widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(248, 248, 248); text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;">the *nperm = 0 and the *nshared =
        BLK_PERM_ALL are not set before the call to the
        bdrv_replace_node(). The filter is still in the backing chain by
        that moment and has a parent with child-&gt;perm != 0.</span></p>
    <p><span style="color: rgb(29, 28, 29); font-family: Slack-Lato,
        appleLogo, sans-serif; font-size: 15px; font-style: normal;
        font-variant-ligatures: common-ligatures; font-variant-caps:
        normal; font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: left; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(248, 248,
        248); text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">The
        implementation of&nbsp; the </span>.bdrv_child_perm()<span style="color: rgb(29, 28, 29); font-family: Slack-Lato,
        appleLogo, sans-serif; font-size: 15px; font-style: normal;
        font-variant-ligatures: common-ligatures; font-variant-caps:
        normal; font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: left; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(248, 248,
        248); text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"> in the given
        patch is similar to one in the block/mirror.c.</span></p>
    <p><span style="color: rgb(29, 28, 29); font-family: Slack-Lato,
        appleLogo, sans-serif; font-size: 15px; font-style: normal;
        font-variant-ligatures: common-ligatures; font-variant-caps:
        normal; font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: left; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(248, 248,
        248); text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">How could we
        resolve the issue at the generic layer?<br>
      </span></p>
    <p><span style="color: rgb(29, 28, 29); font-family: Slack-Lato,
        appleLogo, sans-serif; font-size: 15px; font-style: normal;
        font-variant-ligatures: common-ligatures; font-variant-caps:
        normal; font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: left; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(248, 248,
        248); text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><br>
      </span></p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:9733a257-b864-e8db-7379-f94fbd21045a@redhat.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Signed-off-by: Andrey Shinkevich <a class="moz-txt-link-rfc2396E" href="mailto:andrey.shinkevich@virtuozzo.com">&lt;andrey.shinkevich@virtuozzo.com&gt;</a>
Reviewed-by: Vladimir Sementsov-Ogievskiy <a class="moz-txt-link-rfc2396E" href="mailto:vsementsov@virtuozzo.com">&lt;vsementsov@virtuozzo.com&gt;</a>
---
 block/copy-on-read.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++
 block/copy-on-read.h |  35 +++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100644 block/copy-on-read.h
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
[...]
</pre>
    </blockquote>
  </body>
</html>

--------------257BC0BB94D4F90ABDEC7C35--

