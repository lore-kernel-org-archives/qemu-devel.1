Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85379C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B3AE2222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mJFfNfuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3AE2222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUoo8-00043y-Af
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 06:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nshirokovskiy@virtuozzo.com>)
 id 1kUonX-0003eE-Rj; Tue, 20 Oct 2020 06:23:19 -0400
Received: from mail-vi1eur05on2118.outbound.protection.outlook.com
 ([40.107.21.118]:16704 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nshirokovskiy@virtuozzo.com>)
 id 1kUonU-0001Kh-R0; Tue, 20 Oct 2020 06:23:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbS6sveZZPVQvJvZ/FAnXkHOCrjuWexfnbudOO6tGgyGRROdZjS7FGs9XlCWlPhwlV2DuF5rC+8LJ30Z3irjl7I7g+Ic7nwREr5+QCTLuFD5ebmo3FUh9rsVdfL/LCZ958RTktGhmo+QrL/QSWrpQhDBllRZtAB2ZpLmf4SgCu8lfVQ1RWZwnLqxRRZf7Fc8/TJbf/C8ACKkySO8yGMZ7Gg9FvfrJxd2lIcx6rhiaRd3zAIbSPH9N81DLUbiE8XS38O1zCr2Vv9M4GQ8hHqNjTUJc4i9G8EQa93BEb1/LFeoqYwk1HGIxYwMS79bcx2xIJe9nhqmv/VNI6hDQ7sf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66VODkx6RHSXpkYri5BGjvjTmCHvjBTMLgRAF/ZIgo0=;
 b=ErJ+jf1npG2mjzhrAwQtReDq0jl2jDdSpp81EXiRtD3/BkmfvWOUzY7Xwic+pSeoDx9LJYPYRSlXLZupu8xAUsHC2QSlP97EcWQnA45876HaJnm7LWzfNwEeHkM2Jh8mB+1vJZGJPwbix1scYDiEpMePau8+/8YlmQssW+zNfJPXB/tidjFUjMA81Rn/3tVNOBpUV49WgTFvUxtM0SuoKwo2PusBV8bWHxtaPlnX258l5RWdoXDvjqI6SNjoaBihIn6XofoikfjawEcV0Ep4XrXkXT+6fIQh6y3oHpAPRZ/5zqsrM88Yu0JyqmzRIB0MpWQYQM3dm7Cca8ypaERuVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66VODkx6RHSXpkYri5BGjvjTmCHvjBTMLgRAF/ZIgo0=;
 b=mJFfNfuMNj7XCZV2JxToNstWLGzR2lUbSlR0OGm5ENSVi9FKDG+ewjHWhgEgrIHSTtR566LCWYRX6ceHr3dpTf7q0AwjWyz+lW1a0XnNZI6x3rAnF/sMINCu0GXdoId3i/GBGfVXvbbjExS+uIZVsrILVdi75bOjdtnqWJrdn8I=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0802MB2298.eurprd08.prod.outlook.com (2603:10a6:3:c4::16)
 by HE1PR08MB2937.eurprd08.prod.outlook.com (2603:10a6:7:2d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 20 Oct
 2020 10:23:06 +0000
Received: from HE1PR0802MB2298.eurprd08.prod.outlook.com
 ([fe80::d12a:7bcb:c813:55c1]) by HE1PR0802MB2298.eurprd08.prod.outlook.com
 ([fe80::d12a:7bcb:c813:55c1%10]) with mapi id 15.20.3477.028; Tue, 20 Oct
 2020 10:23:06 +0000
Subject: Re: RFC: tracking valid backing chain issue
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <3b99657c-2016-78cb-4314-27aacb30ca3c@virtuozzo.com>
 <20201020085029.GC4452@merkur.fritz.box>
From: Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Message-ID: <a996a3cc-387a-8847-17b8-72a714d47776@virtuozzo.com>
Date: Tue, 20 Oct 2020 13:23:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20201020085029.GC4452@merkur.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.252.131.121]
X-ClientProxiedBy: AM0PR03CA0024.eurprd03.prod.outlook.com
 (2603:10a6:208:14::37) To HE1PR0802MB2298.eurprd08.prod.outlook.com
 (2603:10a6:3:c4::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.38] (109.252.131.121) by
 AM0PR03CA0024.eurprd03.prod.outlook.com (2603:10a6:208:14::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.23 via Frontend Transport; Tue, 20 Oct 2020 10:23:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b7f003e-20d4-42c0-d4aa-08d874e2228e
X-MS-TrafficTypeDiagnostic: HE1PR08MB2937:
X-Microsoft-Antispam-PRVS: <HE1PR08MB29371C91F3D2AF3C90F6505FA21F0@HE1PR08MB2937.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUGEQ54dvqPlcxjPbcolaLWEAYXEkKZLRcMhnEjP+bFnUZ3DkzThQrowhUAc52CMoyBMukZ7mQj8IWs1qtTJnDXe9v+Ea0RK2k6w0VvCsii3WSQ82SB5wNXIwMVmUQ87pLeCX9bZF1DFNqOUTXoi/4TLmH0ucWCtpHHO/C7/Yd1jQeTsA0qIefrn93Jf1oY0VS1mO3IuzIPYlZqb/Hxrf3+jSOlY6DmJcKYw21XnWF0WyegMgxUzYIzDKbyAh7MZKVtaDms8Vgn8tNEF2hYBx2vvJH1tyRZA52CedzAdoqdN7imD0TfPlRrxbI2wJ4se1SjUHIUso118SICkKmkTpdzjB5I47DSRunZ1Sle+O+jLEzM7IBYCZ85CiontWYHQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0802MB2298.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(346002)(396003)(136003)(5660300002)(16576012)(2906002)(31686004)(6486002)(956004)(2616005)(86362001)(66476007)(4326008)(8936002)(8676002)(66946007)(66556008)(36756003)(186003)(26005)(52116002)(6916009)(16526019)(478600001)(53546011)(316002)(31696002)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4PwMXiKYDBvdOtR2ztpELF3zM/QWx8jDyNBjFPYwwk+HsZFrtPb23mxGOVSmihq4CliKGEUuSpj1H1VnoGEhBxTmFAi3NDcHe78nl5v6cp2zyq12o/ZNS3yMubiEehG/DiVHBM/Z1WqI2DwiZnPL/soH4+HjxuT1bziN2ZLSj7sWZkgDdb1Hn/8bInXeoLOxJ1AVRjQKB8jqztewumnEIwwMLNK8qZLBoK7iPchmciecNd1J3Dk1UJ65rIc09xzX494RPQcy/Zn4wyTwJVlnGo7un+2JVn/p5l/83qjAn3/YKtAUQWULx+ZmMa5U1W9w0Uu9sOKbV9ypUk/jabGbr01alZwQPc2iZSV7xLdwidGoHr/Zesd9nARDn4Yv0OdA9tb8glPxiyslUZ/WLErRnqTb7Ll+obMrKbygFtZclR9A+k+oVlU6atlosRSZ4Ia2jg9HtEZ6DseiTEjZBEjJb0XqllCfE8Yny5s2pYABKZyWjfw0hTEVacupir/ks+ywp299d1Bv0bLpbBKLxrOKtveFgm36Q173kFEZ8rpepFM0WzMzQl6LoUcMnQQOLbmpKIjEUE9B2qYdnNNV3vZKlIK1Vb2c9JoFXP3trU0S2ZTun2ZD2suKKndbAisV6O0efTa4aAplksZTw90MZkTeOg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7f003e-20d4-42c0-d4aa-08d874e2228e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2298.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 10:23:06.6870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bC5jM2Dhvoditx4ZxZOLAbqLCSgOSRW7GRwrkqAcfYQIu7HWQElx5Jh7X8Z/In8OKTl8pENFuFU2Pw1hUnZSM08f3ZURJ3XP/Q5D1AlJiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2937
Received-SPF: pass client-ip=40.107.21.118;
 envelope-from=nshirokovskiy@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 06:23:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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



On 20.10.2020 11:50, Kevin Wolf wrote:
> Am 20.10.2020 um 10:21 hat Nikolay Shirokovskiy geschrieben:
>> Hi, all.
>>
>> I recently found a corner case when it is impossible AFAIK to find out valid
>> backing chain after block commit operation. Imagine committing top image. After
>> commit ready state pivot is sent and then mgmt crashed. So far so good. Upon
>> next start mgmt can either check block job status for non-autodissmised job or
>> inspect backing chain to infer was pivot was successful or not in case of older
>> qemu.
>>
>> But imagine after mgmt crash qemu process was destroyed too. In this case there
>> is no option to know now what is valid backing chain. Yeah libvirt starts qemu
>> process with -no-shutdown flags so process is not destroyed in case of shutdown
>> but still process can crash.
> 
> I don't think this is a problem.
> 
> Between completion of the job and finalising it, both the base node and
> the top node are equivalent. You can access either and you'll always get
> the same data.
> 
> So if libvirt didn't save that the job was already completed, it will
> use the old image file, and it's fine. And if libvirt already sent the
> job-finalize command, it will first have saved that the job was
> completed and therefore use the new image, and it's fine, too.

So finalizing can't fail? Otherwise libvirt can save that job is completed and
graph is changed while is was really wasn't

Nikolay

> 
> Kevin
> 
>> So corner case is very rare. Mgmt crash in a specific short moment and then
>> qemu crash before mgmt is up again.
>>
>> I guess some 'invalidated' flag for image would help. And also qemu itself
>> could check that mgmt is not trying to run on invalid backing chain based
>> on this flag.
>>
>> Nikolay
>>
> 

