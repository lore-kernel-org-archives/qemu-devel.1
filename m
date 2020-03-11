Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C51C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E8121655
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ocSoK+ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E8121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBy0g-0000iz-JU
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 05:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBy01-0000Bs-1h
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBxzy-0002c6-3g
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:50:00 -0400
Received: from mail-eopbgr30126.outbound.protection.outlook.com
 ([40.107.3.126]:57422 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jBxzv-0002Gb-T9; Wed, 11 Mar 2020 05:49:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk9hPfwwVlF6N2r3+DB5zD8AKO/kaH6z6tQUplBcB7i9t1Icd8tmmNR7jI0g/pWuIfnn71hTZwvSUgVb5i9yvJFimFab48xxUQAdeczmc/QX3EMvKkrE+BtkmnujTmHOt+qc5RUthlUqU9YfjZjVPueP9pKWcOsQHeEu65JS82+0fo0Y0HADwTHITfLtcNIWGxH/lPu9IdXHHeQGmVrE5s19RbM5pUP9LjwTZCxiZ2GY+HegyE4f2cS0IZKi7K9J8l6oCKoLJAgOB+CoL7udCyHgxNB1vmnZNdqlDrDsV7sMDwxf5slD/XBypfhnBRNWoP7SbKlFzXGASkLJdJAgAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofjt0ha8AfP+wvy64SB17mehHoXwEqc0n17Nmn4KwbE=;
 b=i3lBfujImRYkKW7xPRYtvnYgLKL/kKw94hn/RDV0SHSVmjxrQfv+DGcqP8vVOSaJSlr6MKSfKvSAartZDYeyrdgHEZObve2xPiKD8WUwy3fsdduGbd0KuA+CX+iMQPrigwxCcID0P3Ue+/somHd1dBZebn6Zww6w2gOR/kAYgO5zqzk78wd1fg/OVJ+eTA4GAneZmMTe7ok5W19muG807sLUmICvejkkZcXXbIJVUBApvWvB41L9Dh5ur7sGnco4nSSU46/XwCLgI8wOnnpDWDbZt0bdqh9m97EFqlyYgWSKzLX2mMo8z5feryasOae6nZ9BaGCFHyX+86UI0Xdgig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofjt0ha8AfP+wvy64SB17mehHoXwEqc0n17Nmn4KwbE=;
 b=ocSoK+qlxHhlOTE3XMX/I9GA9nOcTRM+y2ms+LVIpTl5CAgMzQDeqhzCkemfrLygaTnnkSDydp9jD37WukL0ICsxPP+znpnKcSjfv/zQIHI+aiVeYlm1L4TOrX+Aj+i+yVhnotAGijl7d1dcji1TzlRRFCw446yqCr9lgTdpJK8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3605.eurprd08.prod.outlook.com (20.177.114.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 11 Mar 2020 09:49:53 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 09:49:52 +0000
Subject: Re: [PATCH v8 02/10] scripts: add coccinelle script to use auto
 propagated errp
To: Markus Armbruster <armbru@redhat.com>
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-3-vsementsov@virtuozzo.com>
 <87lfo997hs.fsf@dusky.pond.sub.org>
 <83b327b0-34d9-ad71-ba3c-156bd7b82836@virtuozzo.com>
 <87h7yvgrrw.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200311124949631
Message-ID: <296bdada-d3e8-e518-48cd-61bd66fe264e@virtuozzo.com>
Date: Wed, 11 Mar 2020 12:49:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87h7yvgrrw.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0101CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::34) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0101CA0024.eurprd01.prod.exchangelabs.com (2603:10a6:3:77::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Wed, 11 Mar 2020 09:49:51 +0000
X-Tagtoolbar-Keys: D20200311124949631
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 711e65b9-6b7b-4c24-070b-08d7c5a18c29
X-MS-TrafficTypeDiagnostic: AM6PR08MB3605:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3605497C75B4233132488B35C1FC0@AM6PR08MB3605.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(39850400004)(396003)(376002)(346002)(199004)(81166006)(8676002)(7416002)(81156014)(478600001)(52116002)(26005)(956004)(2616005)(316002)(16576012)(16526019)(186003)(54906003)(86362001)(66946007)(66476007)(66556008)(6916009)(5660300002)(36756003)(2906002)(31696002)(8936002)(4744005)(31686004)(6486002)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3605;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSg0/IPVpYz7m4q6JkAp4omYf9B4mZku/Xe5KQmEISW58f9YH9c+/DTpSpQCTznNG5iUkPH/G049Pv0+IcL1QH1QXRZBs3VIOtjVafh8G2aVVdFS94nSV9W+sQTwmuK/kGkK9O17IVCGEeb1bmxVNPF114P4BQz1fsflK0V8vzSxJKY9HgH3+Nq4A1dP+oAox3KQoiN+Mvm38f9TNUF9X1UvukVOr3o/TUy0UCo8G2L2mHPK8lPZNQ5Q29lOAhVGnXGhRQAgntUIigCUad5NNF2bl4gUk7VV0MTKT9QB6atphkSj+8DkLeT2DqRh3frmfgaHR+uQtKPf567W3kqXerSjhIh9bFjE6y4r0gnmwXI2JAOA60HJtC95uOSInbNyxp0q6urHmhQLHPLsWUo2DXFED3Ua7MKgG7u3ebGpqQqqe75vbs0GQdGH8FBwjp+T
X-MS-Exchange-AntiSpam-MessageData: aq3dwAzrZ03q38GllHmfGB272onbPBlox9JlJebYggdunl34P+eGISS+lmIlX6nkyA2vOvBLH/SCsxjxh0xtoltgMWHa2sX4/pURRVXSuIOUV8ARRGG5MimDWmXqISt3CRwNbDPbN5N6raqZlfFCJA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711e65b9-6b7b-4c24-070b-08d7c5a18c29
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 09:49:52.9369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDe6GgLgarq157nZ4toDtsCkUGxlDtH54VDPaI/jC37tw+T03/GncZcOxCE3FDowUmAD5hYz4UWmtfKr2Frp8QPuf0uBZNFbKJAR5RB3pYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3605
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.126
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
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.03.2020 12:33, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
>> 09.03.2020 12:56, Markus Armbruster wrote:
>>>> +
>>>> +// Convert error clearing functions
>>> Suggest: Ensure @local_err is cleared on free
>>
>> But there is no local_err after conversion
> 
> True.  Hmm.  What about this:
> 
>       // Convert calls to error_free(), possibly indirect
>       // In addition to replacing @local_err by *errp, we have to clear *errp
>       // to avoid use-after-free in the automatic error propagation.
> 

OK

>>>> +(
>>>> +-    error_free(local_err);
>>>> ++    error_free_errp(errp);
>>>> +|
>>>> +-    error_report_err(local_err);
>>>> ++    error_report_errp(errp);
>>>> +|
>>>> +-    error_reportf_err(local_err, args);
>>>> ++    error_reportf_errp(errp, args);
>>>> +|
>>>> +-    warn_report_err(local_err);
>>>> ++    warn_report_errp(errp);
>>>> +|
>>>> +-    warn_reportf_err(local_err, args);
> 


-- 
Best regards,
Vladimir

