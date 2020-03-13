Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0468DC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A4B20724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="c7J6HBYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A4B20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCm9Z-0008Hc-QN
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 11:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCm8w-0007jv-9M
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCm8u-0001da-Qb
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:22:34 -0400
Received: from mail-eopbgr80102.outbound.protection.outlook.com
 ([40.107.8.102]:34131 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jCm8o-0001IQ-M6; Fri, 13 Mar 2020 11:22:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIey0oznz+qCprk4288EBt5tjDEfjePZSmy0+1p3DN8MOl6qiTaFtcbvUgOq8tdx8aAMDBsR+dr4clO2zcV/c6p4zhoQnN00kT21tyZzg90HCL911fE5/HX91R3VBvovTh3cRJGfeUJ0lr03Hx0T+wwOl/htYJZXaDUE0b8zumCkP4CjtlBpVUUtJ+tvHJRo4eorqGdCmKN8PI6yjTH5NLefZ+QxNu1jdpy29849agL3Xo+s7trBYriuDRO2GN/5YUUta+fG9JspgglBOkDLEa1E0uzY834zg/o+0+NaOYWPo2dl406NqepaggG9AxKkem9SmLJnQcQycyhe3UQaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ozPcNGfHBvybrytey+bcnSRpaYwzW3wTsBVuXKBqC8=;
 b=oAvTl/mPrU248ZzRwQCxrWibsSZICA5KTB++zbIdRwDHO5Eu/a91aMPCOrjIGZ0blT+36GW75mW7XxLjcnK6I0T2/QHih7sYS3dPXQ1OgAxTbGMyjnUl3Xx0kLUvRcZi+Vs0OdDDz07OHo/0aiKTJc6x5ul+uu2oFweVLiPehAxnlkrFWi4F9DRCxH4n+qf1FkDK9qKREVap7EDqdJNlKbEecH6W35Ji7/xxT42gynf6Ho+IwK0Nwv15/Hh+FIfTmaEIVh2oIyDR8m7UmalYpEuy08Pf6PSABSufSj2eyTMkgcnrN7uyOisrTq1p3i0AEizpfgA+5+FEUv1bRZp1gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ozPcNGfHBvybrytey+bcnSRpaYwzW3wTsBVuXKBqC8=;
 b=c7J6HBYnvMDXFVOBcjmQ8alBZicmkBxfM91BNd/BIIQ9cLtOv6A+0VvxkZioPUNpOtiDmZfOOElBuSEIeQ52Us8v8UmoF5DvvxAOrzb4PdVgdHcLfC0QoAA4BWX1yza8LcV0IF4vHiwLAxHsaHPpayK8tH7LDrOI9zalmrBlPsE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3174.eurprd08.prod.outlook.com (52.135.163.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Fri, 13 Mar 2020 15:22:24 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.016; Fri, 13 Mar 2020
 15:22:24 +0000
Subject: Re: [PATCH v9 02/10] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
To: Markus Armbruster <armbru@redhat.com>
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
 <20200312085936.9552-3-vsementsov@virtuozzo.com>
 <87imj8i9no.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200313182221096
Message-ID: <9b1d8ba0-4dd2-e0a6-ec82-cd0c0dd2a8ff@virtuozzo.com>
Date: Fri, 13 Mar 2020 18:22:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87imj8i9no.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0401CA0051.eurprd04.prod.outlook.com
 (2603:10a6:3:19::19) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0401CA0051.eurprd04.prod.outlook.com (2603:10a6:3:19::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18 via Frontend Transport; Fri, 13 Mar 2020 15:22:23 +0000
X-Tagtoolbar-Keys: D20200313182221096
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f1f120f-2202-4e38-693a-08d7c76254e0
X-MS-TrafficTypeDiagnostic: AM6PR08MB3174:
X-Microsoft-Antispam-PRVS: <AM6PR08MB31749908D7661289F7DE275BC1FA0@AM6PR08MB3174.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(396003)(376002)(136003)(366004)(199004)(86362001)(8676002)(31696002)(36756003)(66476007)(8936002)(66946007)(66556008)(52116002)(4326008)(16576012)(5660300002)(6486002)(54906003)(6916009)(81156014)(31686004)(316002)(81166006)(2616005)(186003)(7416002)(956004)(16526019)(478600001)(2906002)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3174;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayCf00+rbVgsj2PlzrCPTifkW9JPauNrUqqsBsQ4+cqU486woIvdiOcmEmow+/X6oaE2gBjfWLA9qWfeM3qVWxMIMA0ny/jcljFZIu9SXo1uwKs4kUePm64zgkreiLQYySc10HqPBzNReXk4bFvZPf6Eo/Of1Quw88bECOjih58EfKlUSvjXA0UcLY+qmgvFZ1TEGhGIliP2I2XL9OJhJVMLMlpWq2Qg48krNw2uhrATVPsZm3WL3sDoEWtuXcFUhrtO6Lp+sVLCVFh0psfjE2l9wx1l+ojxt5IRIwcQY0gSdJHei0auzYGHJ+ztBLl/KRjfu9UGYtTWVUhF3CloftcZoRLw33Sih/yp/BdWwW0cF3nP2LD++8Ym5N7KzwGkeYjNIpVhH42LKM8S7dEsZC9/K5bhNzcztB1Xcd56ADGb0y4dBCWDyQ4Q/CjIPuKO
X-MS-Exchange-AntiSpam-MessageData: 5inl1qr8b2140FMVWn7S2Fzh3kviQDuHoHrMLYfXbNue9H0O913hAm4W3o8QBJvVICz9+gE+CsxCXjLjnnU1uIa9uesQpyUkxy8mshdzfq6ayZQpTrN1aCxuNWk+nqmH5F+QRNmaTvfnevQO2Wl4VA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1f120f-2202-4e38-693a-08d7c76254e0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 15:22:24.3278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bY3Eu95RdWmemYdovQJ4Pj1BA26l26C2teLY7WsOvPa8+6/6V0UmsZFKADbU1SKZtn1GtIgKNkDxTbefkkHlJ6+cvJdP8h0XYgwLfUoJbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3174
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.102
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.03.2020 17:58, Markus Armbruster wrote:
> I tried this script on the whole tree.  Observations:
> 
> * $ git-diff --shortstat \*.[ch]
>     333 files changed, 3480 insertions(+), 4586 deletions(-)
> 
> * Twelve functions have "several definitions of Error * local variable".
> 
>    Eight declare such a variable within a loop.  Reported because
>    Coccinelle matches along control flow, not just along text.  Ignore.
> 
>    Remaining four:
> 
>    * ivshmem_common_realize()
> 
>      Two variables (messed up in commit fe44dc91807), should be replaced
>      by one.
> 
>    * qmp_query_cpu_model_expansion() two times
> 
>      Three declarations in separate blocks; two should be replaced by
>      &error_abort, one moved to the function block.
> 
>    * xen_block_device_destroy()
> 
>      Two declarations in seperate blocks; should be replaced by a single
>      one.
> 
>    Separate manual cleanup patches, ideally applied before running
>    Coccinelle to keep Coccinelle's changes as simple and safe as
>    possible.  I'll post patches.  Only the one for
>    xen_block_device_destroy() affects by this series.
> 
> * No function "propagates to errp several times"
> 
>    I tested the rule does detect this as advertized by feeding it an
>    obvious example.  We're good.
> 
> * ERRP_AUTO_PROPAGATE() inserted 744 times, always right at the
>    beginning of a function.
> 
> * As far as I can tell, all changed functions have ERRP_AUTO_PROPAGATE()
>    inserted.  Good.
> 
> * Almost 1100 error propagations dropped:error_propagate() removed,
>    error_propagate_prepend() replaced by just error_prepend().
> 
> * Four error_propagate() are transformed.  Two instances each in
>    aspeed_soc_ast2600_realize() and aspeed_soc_realize().  Pattern:
> 
>       {
>      +    ERRP_AUTO_PROPAGATE();
>           ...
>      -    Error *err = NULL, *local_err = NULL;
>      +    Error *local_err = NULL;
>           ...
> 
>               object_property_set_T(...,
>      -                              &err);
>      +                              errp);
>               object_property_set_T(...,
>                                     &local_err);
>      -        error_propagate(&err, local_err);
>      -        if (err) {
>      -            error_propagate(errp, err);
>      +        error_propagate(errp, local_err);
>      +        if (*errp) {
>                   return;
>               }
> 
>    This is what error.h calls "Receive and accumulate multiple errors
>    (first one wins)".
> 
>    Result:
> 
>          ERRP_AUTO_PROPAGATE();
>          ...
>          Error *local_err = NULL;
>          ...
> 
>              object_property_set_T(..., errp);
>              object_property_set_T(..., &local_err);
>              error_propagate(errp, local_err);
>              if (*errp) {
>                  return;
>              }
> 
>    Could be done without the accumulation:
> 
>          ERRP_AUTO_PROPAGATE();
>          ...
> 
>              object_property_set_T(..., errp);
>              if (*errp) {
>                  return;
>              }
>              object_property_set_T(..., errp);
>              if (*errp) {
>                  return;
>              }
> 
>    I find this a bit easier to understand.  Matter of taste.  If we want
>    to change to this, do it manually and separately.  I'd do it on top.
> 
> * Some 90 propagations remain.
> 
>    Some of them could use cleanup, e.g. file_memory_backend_set_pmem(),
>    css_clear_io_interrupt().  Out of scope for this series.
> 
>    Some move errors around in unusual ways, e.g. in block/nbd.c.  Could
>    use review.  Out of scope for this series.
> 
>    I spotted three that should be transformed, but aren't:
> 
>    - qcrypto_block_luks_store_key()
> 
>      I believe g_autoptr() confuses Coccinelle.  Undermines all our
>      Coccinelle use, not just this patch.  I think we need to update
>      scripts/cocci-macro-file.h for it.
> 
>    - armsse_realize()
> 
>      Something in this huge function confuses Coccinelle, but I don't
>      know what exactly.  If I delete most of it, the error_propagate()
>      transforms okay.  If I delete less, Coccinelle hangs.
> 
>    - apply_cpu_model()
> 
>      Gets transformed fine if I remove the #ifndef CONFIG_USER_ONLY.  I
>      have no idea why the #if spooks Coccinelle here, but not elsewhere.
> 
>    None of these three affects this series.  No need to hold it back for
>    further investigation.
> 
> * 30 error_free() and two warn_reportf_err() are transformed.  Patterns:
> 
>      -    error_free(local_err);
>      -    local_err = NULL;
>      +    error_free_errp(errp);
> 
>    and
> 
>      -    error_free(local_err);
>      +    error_free_errp(errp);
> 
>    and
> 
>      -    warn_report_err(local_err);
>      -    local_err = NULL;
>      +    warn_report_errp(errp);
> 
>    Good.
> 
> * Many error_free(), error_reportf_err() and warn_reportf_err() remain.
>    None of them have an argument of the form *errp.  Such arguments would
>    have to be reviewed for possible interference with
>    ERRP_AUTO_PROPAGATE().
> 
> * Almost 700 Error *err = NULL removed.  Almost 600 remain.
> 
> * Error usage in rdma.c is questionable / wrong.  Out of scope for this
>    series.
> 
> As far as I can tell, your Coccinelle script is working as intended,
> except for three missed error propagations noted above.  We can proceed
> with this series regardless, if we want.  I'd prefer to integrate my
> forthcoming cleanup to xen_block_device_destroy(), though.
> 

Great investigation!!!

I'm for proceeding as is, or with your cleanup for xen_block_device_destroy().
Still, script converts xen_block_device_destroy correctly anyway, resulting code
will be the same and we are OK without cleanup as well.

-- 
Best regards,
Vladimir

