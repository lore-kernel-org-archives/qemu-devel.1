Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7370DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F463207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uuJGbXFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F463207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlui2-0006Ql-1f
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jluaW-0000Lr-FL; Thu, 18 Jun 2020 09:28:16 -0400
Received: from mail-vi1eur05on2104.outbound.protection.outlook.com
 ([40.107.21.104]:13640 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jluaT-0006uU-83; Thu, 18 Jun 2020 09:28:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GON2NoR8iwCMJ1cslWdS/qZa8t1r/0X5brWVtlclB9MjKsR2BkPorq76qoPrkY3iUDCb1lw8TgeCIi8yuCz7F03wpwtY2AQm9I/AHFNvYGQbQ2SMB6DIN2x/o5KRltY/ThcRxd4hiE5ahi2ni2kvmPNrvn0WJVzYHUxKtLY0HUps9etNMqo9F9VgI22vwU9viSck+/4aS+NsOcJxIQGj0Z+LQRqX+evjWM1eMF6xALfPus/LU6jlOZgovl3LEgkMPVM6tlT6osgI/Ev+V/Ax5cK42h9Y0LzdFdljLxJp+f7Kj/9EsB+LTvZsJhZP44QNECGUaJB4qrwiF6b2YedwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9oIVWCT4lRLUJ94tT1tqeSBKL8Q1M78n4l9MWIhd2k=;
 b=cgSeRko4qEmOpSHyr/U4o2SFktW0vHzLmJDSj4wYOsCk9rJP1+hd/DzB1rKFbKTkQHdylmvfKjj1YMm5lilPBDCQB5PjV92iqcTGCnPRL7Sx2pYBikbUVctGrk8BcZAadJgBpmlK5Wem7H/ONqljDxT/53EB39tZidNWOhYIvMni5KXj6jdw4dXDRBWeFCv+/3Xdg7TvgwsqobEghvqsc+X0aTJEkhhVJptiZFYdnYJpPMzjqIf+/cD9alX64NyrjtlNfOMBWSgW6V5epF7sTfdih0INmRkDxa/631S5OumtOerQE3xc5aftaxnxA+uE7D6YdofmrFx02wjHAzRqoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9oIVWCT4lRLUJ94tT1tqeSBKL8Q1M78n4l9MWIhd2k=;
 b=uuJGbXFdgHJRoDtwl+lxqsaoRLzzppldOwAoh26n3e3ooUFCsMgRGySPaqrPVF0xVaOC90T+TFe635dR3NExO+qzx2PMi0U/Gf9O5be60kBOES7gC9+nQFLPasTRPgAwjIIzXX5JKgjxK5jh8DXbjNoUbInjmiHQCBd5QOhphDA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5511.eurprd08.prod.outlook.com (2603:10a6:20b:10d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 13:28:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 13:28:10 +0000
Subject: Re: [PULL 14/15] qcow2_format.py: dump bitmaps header extension
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
References: <20200609205245.3548257-1-eblake@redhat.com>
 <20200609205245.3548257-15-eblake@redhat.com>
 <81ba0181-3dfc-1c1e-7c19-278569e65c60@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <64c3084a-8bda-14d9-907c-da0af67cf9c3@virtuozzo.com>
Date: Thu, 18 Jun 2020 16:28:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <81ba0181-3dfc-1c1e-7c19-278569e65c60@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0073.eurprd04.prod.outlook.com
 (2603:10a6:208:be::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.159) by
 AM0PR04CA0073.eurprd04.prod.outlook.com (2603:10a6:208:be::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Thu, 18 Jun 2020 13:28:09 +0000
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24ddf213-0c6c-4f57-6012-08d8138b719d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5511B1C2F2F9358666D60843C19B0@AM7PR08MB5511.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dz4ACl2o3jWDoxoo4ySoQ6OYtg2HUE91G1DSM/jUPaXpj9IzcLVHjOe383DlqD5sELIpq1xnnB7nZpFaPm6Bp6iDQYciGRA7YTxVMVQsdx9dJofen3xG8G8CD9UEgNZD9A8/Odd8/AetICEVaKgcXiY4TpX+jBoCSmijhMiTwbZloZHaod3XgJBH8GF8evF6oPXXpHoXRpUXMHB3ttV2Q7OWCUREU/U3mC8iLOe6c0ukCRvuR6ZryfzEZHBZjhLde6lS8mR5krtsHIQw27SeaXl8aaUqKKXXSc+G+zQlq9leyV0qHbdHkAPinLOLTa3iVAmmseAfvx1g130mzIzhNG+SQJkEIXxiD4TPTwYo7X2I1f5ftfcwcw0Xrb8hxxXn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39840400004)(366004)(31686004)(478600001)(66556008)(66476007)(66946007)(956004)(2616005)(8676002)(36756003)(86362001)(8936002)(31696002)(26005)(316002)(186003)(53546011)(2906002)(52116002)(5660300002)(16576012)(4326008)(54906003)(16526019)(6486002)(110136005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: KR+HsNddpyKsjOcss/LdlTbFNbXrNKUsV+hsyHQP2cOc7z0E3fBiSwKYgQ1n6sYxQYrqQ4sF0h7cG7FFCNu++Frpl50SumDYMQ6l7RWqCMVTMt2Qfn+3xuiTYv6WRMxNrT2uPCBKQ6sIU2sWVKLwVOlDYQeK/h7DmmlLbYDDntWjtlOStmTRlmT+592q3XUJo1ycpFf34nEZ9VgPIzRg6apVkCIJNu8etCZTyCCvZQujs80fXLtU9y0mNjcuIftm9HP5CwOO1cwf1j1VAU3bbHp44rH/FaqBigwR5Kc0V+rSqCDsnu3hvU/gmsVjgoWkZPXIPVAueSaK32PUUUGDV7Q1Wr2OggZUNyuYn14dAOlpXygUMx7kPPKJpGaMDTvluPGuuUiAaNjncTVCTm3yBdTSBiUJRbW1xc7wPshOvO45VT/XtKlIe/PB0fHl4dr/8CDKDOuvh+b4sSNyyQkoGGpjTHWl9KrTbHfxqTyA76iixQu/5XJmigy8oDKB32ye
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ddf213-0c6c-4f57-6012-08d8138b719d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 13:28:10.1770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tuog4spqjpWql6x6RukRORpsrt1e44aHdZ9pJrpqqh7SbO9jwbLjLwlg9ppdsKowe1lcqlJmsaVj/cEBM7Dv189Xor2dNpZYJ6b8SziRR7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5511
Received-SPF: pass client-ip=40.107.21.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 09:28:10
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

18.06.2020 16:13, Max Reitz wrote:
> On 09.06.20 22:52, Eric Blake wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Add class for bitmap extension and dump its fields. Further work is to
>> dump bitmap directory.
>>
>> Test new functionality inside 291 iotest.
> 
> Unfortunately, it also breaks 291 with an external data file, which
> worked before.  (The problems being that an external data file gives you
> an additional header extension, and that the bitmap directory offset
> changes.)
> 
> I think if we want to test testing tools, we have to do that in a
> controlled environment where we exactly know what the image is.  It
> looks to me now as if 291 is not such an environment.  Or phrased
> differently, we probably shouldn’t test some testing tool in normal
> tests that test qemu itself.
> 
> If we only test qcow2.py in normal tests, then I don’t think we have to
> explicitly test it at all.  (Because if you test qcow2.py in a normal
> test, and the test breaks, it’s unclear what’s broken.  So I think you
> might as well forego the qcow2.py test altogether, because if it breaks,
> that’ll probably show up in some other test case that uses it.)
> 
> In this case here, I can see three things we could do:
> 
> First, could just filter out the data file header extension and the
> bitmap_directory_offset.  But I’m not sure whether that’s the best thing
> to do, because it might break with some other obscure IMGOPTS that I
> personally never use for the iotests.
> 
> I think that if we want a real qcow2.py test somewhere, it should be its
> own test.  No custom IMGOPTS allowed.  So the second idea would be to
> move it there, and drop the qcow2.py usage from here.
> 
> Or, third, maybe we actually don’t care that much about a real qcow2.py
> test, and really want to just *use* (as opposed to “test”) qcow2.py
> here.  Then we should filter what we really need from its output instead
> of dropping what we don’t need.
> 
> 
> (We could also disable 291 for external data files, but I don’t really
> see why, if the only justification for this addition to it is to test
> qcow2.py – which 291 isn’t for.)
> 
I see your point, agree that the most correct thing is to drop qcow2.py testing from 291, reverting test chunks from this commit. I can send a patch.

I do think, that we'll need some testing for qcow2.py, as we are going to improve it a lot, to be used as separate debugging tool. And we just need a separate iotest for it. Andrey, could you please introduce one, as part of your series?

-- 
Best regards,
Vladimir

