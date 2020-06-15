Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA6CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 20:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E85E20714
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 20:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nonterra01.onmicrosoft.com header.i=@nonterra01.onmicrosoft.com header.b="skCPS/z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E85E20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nonterra.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkvj3-0007Te-EY
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 16:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobias.koch@nonterra.com>)
 id 1jkviM-00070B-Jk
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:28:18 -0400
Received: from mail-eopbgr150072.outbound.protection.outlook.com
 ([40.107.15.72]:44507 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobias.koch@nonterra.com>)
 id 1jkviK-0006vg-PF
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:28:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOYGXpls1mebX9Zl/esykGxUtf8o6CxmQZdwEpqHKP5cnOuxgMw9gr2cplFfF6ZBCBg1wh7THVNkGRlsBSpQVKmiAqRXvM7TkIBcwTDH3U3dGtF/jftgqgwFkA3IhYSk5FbFnqfmbQen2YnKylr9lRbul6l5LsivXnIK2B3F857+x6XVf3rsrgaSHrcJGiPEamyW1u5UBnwvqzZml0/yvVEEX3QGsTSLb6+JNOTSiH1kXshjH2HRcLxymGZgunQ1B99W3aqD+iLZqcmrFMr4PC8umv2gu51pTb2gu5W/oA+Gu71/3ssHb506eNJqaXvgFgY2BGKF+7RNj8nb6+44Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14vxcH6dKhZ2Ng3IqcSL6HvR9R8X7EHfkGbbem1A5WU=;
 b=oE+khlVL39GA3ln1oIvfjGI3NYyJjsjPdLJeaGmcNHw5w/0WnUm8OxNqNfn+I7y7bOim/dclnE5p74JgVdbYCWC9kHFavg8Mj2tVGKENnjGh5ySXu3K8ODmUViNO+aEOkpUO38D0kB7Etwv2CgGhQuWD0VXvH3KnLu3bJ5SFfjE6gmwlKw0ksR7hJvTmdQF+wmw9ZqhSYMr6eQRzF48ViYXmwC+Wir3go2Ec9OdxU9LxTGjcBLETHFRgC7YORunUHI+TpcDvCSAXHlK+NbXoBxe0cpeV4/lc3TKUJPCXYASUYHZHyBPdj+4irls7PEW9gulhEImBIdPs5OGigsTibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nonterra.com; dmarc=pass action=none header.from=nonterra.com;
 dkim=pass header.d=nonterra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nonterra01.onmicrosoft.com; s=selector2-nonterra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14vxcH6dKhZ2Ng3IqcSL6HvR9R8X7EHfkGbbem1A5WU=;
 b=skCPS/z6NEMFTH+K2almgvP1P/1HxwHpF3D06vxkhZK8Lo27kt9Mqt+f/mSK+5xXuVsqElnrOSfCsjFM1Bwcn+RFu3qTH2uwMNvEQaXjzhZYCPFu1EB5oa/lQc52IDFkYj9XAEPXywFEJCqXNye9raoFRhDaivfxOBpEGl2S7nc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=nonterra.com;
Received: from AM6PR08MB3302.eurprd08.prod.outlook.com (2603:10a6:209:41::10)
 by AM6PR08MB5192.eurprd08.prod.outlook.com (2603:10a6:20b:d6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Mon, 15 Jun
 2020 20:28:05 +0000
Received: from AM6PR08MB3302.eurprd08.prod.outlook.com
 ([fe80::c484:b59d:1164:8055]) by AM6PR08MB3302.eurprd08.prod.outlook.com
 ([fe80::c484:b59d:1164:8055%7]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 20:28:05 +0000
Subject: Re: [PATCH] linux-user: mremap fails with EFAULT if address range
 overlaps with stack guard
From: Tobias Koch <tobias.koch@nonterra.com>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200305210534.28392-1-tobias.koch@nonterra.com>
 <d643f0d0-d5e7-d1f3-d3e2-7d62661774e8@vivier.eu>
 <3c9dffdf-b4be-d17c-730d-5a65665b3eac@nonterra.com>
Message-ID: <d58a375c-42a0-a1a6-8970-e4aefa5a646b@nonterra.com>
Date: Mon, 15 Jun 2020 23:28:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <3c9dffdf-b4be-d17c-730d-5a65665b3eac@nonterra.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::16) To AM6PR08MB3302.eurprd08.prod.outlook.com
 (2603:10a6:209:41::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.181.119] (85.203.15.71) by
 ZR0P278CA0047.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Mon, 15 Jun 2020 20:28:04 +0000
X-Originating-IP: [85.203.15.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 911d3471-b918-4106-53ee-08d8116a9bd0
X-MS-TrafficTypeDiagnostic: AM6PR08MB5192:
X-Microsoft-Antispam-PRVS: <AM6PR08MB5192BD2A3166EC54ACB0203E899C0@AM6PR08MB5192.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h7yuu9DD8VGrDziS4Cc5ZQ18eU2UiVDzmBcl5COZfK7rB+Sdq2VB4CA8slHlaYLUhOHGKnCVzjqqkb9UHyyVwSD2CJaiXL0NxkN7hRoTvDvfepVXEqZ0u/dHhaDi4Je4Chyek0gk4Joj1SEAh/EQPxeKA7HrQYHyv8PFwK+cGnkLhxDvTmmXuSibKsmtkN+jZPN5z0Mh38nMPWcaEUhSSmOCt7KRc9WXYSbYy2AMAxj+hcmxJL5DIoFWDsk3xtCPTI+d9/argDHuo92xub3L77UfByAttjIo78z94EWQu7DjNleGYRpMwQqstPxCeYHZNUotdo2y8Hv/CtPNvJpAUQqWDZJwnBo/W/aRsoQ4jrxr7Vu6DuoZUuMM+/4jwT+hF9pfUwG0M/TrHuGrjphN/a3AlUezB2f2+7VYronuRJAG/C+lZnbjquVsKVtMujD9GtaeX61VYT1Dez6oMnc+ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB3302.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(366004)(396003)(136003)(346002)(66574014)(36756003)(508600001)(16576012)(966005)(83380400001)(8676002)(316002)(8936002)(86362001)(956004)(2616005)(66946007)(66476007)(66556008)(6486002)(16526019)(53546011)(52116002)(55236004)(31686004)(26005)(5660300002)(31696002)(2906002)(186003)(44832011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: N2Yz5x0iJlTuzEtvYooSYIQR52RhiO/RAUag1BCwPEE+/sMpZoXmVcRnRHtx50srztXGyP1QNuOSUMlUsQNz/GLaB/bc2tcZOQ2lP9B5tFE5+gI1rSlxXRyAlOzvOwt/msOi/eSeTtG5ejpVXChgJhVLPi0PoUZo15Raw2ooEafUiSmRBTIHkxhk3esxwOc1TDNYASwXycpEHMllGVdRfv4FiT7rwzo2HJQCzLibzxk0YVGUHYN1opCzLomkURMd/BxRVoczFa51ss9i7kKZ67DrI+mdsc0jDTlHJpCck3B6jyYM6A0hwXPsT4TubrNBQUdiBdR22H41QSd4lwKwQgR+uC63Jyu7pCw4CE11erwUf39mHD4ZjtvSqEJ4aS128KlHgAUTFU/k+00TrlJt0GThprNAINZT7lKMgHiFG47zWdpExvPeCgDFkNsV1jyi/CK0acugoLSkiVr84Jv5kVRMg8SKYVobKXN9FB2BwtQ=
X-OriginatorOrg: nonterra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911d3471-b918-4106-53ee-08d8116a9bd0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 20:28:05.2821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 76ec9478-ab84-4eac-917c-c1a3242376a3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzfEp1pkxMSiPj/yJvN/rVm3csWAS1b/4vP2Rkbz9mP4L+4vS8GoBxhEoxuF9JhD5YTDkgb1tO+VwH0a0mkdDsFahpfWB0j9SouG/AdYsx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5192
Received-SPF: pass client-ip=40.107.15.72;
 envelope-from=tobias.koch@nonterra.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 16:28:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hm, I see I need to have another look at this :)

On 6/15/20 10:17 AM, Tobias Koch wrote:
> Hi Laurent,
>
> the code in musl libc probing the stack is in
>
>     https://git.musl-libc.org/cgit/musl/plain/src/thread/pthread_getattr_np.c
>
> The setup in elfload.c does work, but only when reserved_va is not set. In that case, any stack guard violation is
> handled by the host kernel and thus results in the expected EFAULT.
>
> However, in case of e.g. a 32bit target being emulated on a 64bit host, reserved_va is set and the current code in
> mmap.c will only produce a more generic ENOMEM, deviating from the kernel's behavior.
>
>
> On 5/7/20 5:35 PM, Laurent Vivier wrote:
>> Le 05/03/2020 à 22:05, Tobias Koch a écrit :
>>> If the address range starting at old_address overlaps with the stack guard it
>>> is invalid and mremap must fail with EFAULT. The musl c library relies on this
>>> behavior to detect the stack size, which it does by doing consecutive mremaps
>>> until it hits the stack guard. Without this patch, software (such as the Ruby
>>> interpreter) that calls pthread_getattr_np under musl will crash on 32 bit
>>> targets emulated on a 64 bit host.
>> Could you share some pointers to the code that is doing this?
>>
>> We have already this kind of code in linux-user/elfload.c,
>> setup_arg_pages(): could you check why it doesn't work?
>>
>> Thanks,
>> Laurent

