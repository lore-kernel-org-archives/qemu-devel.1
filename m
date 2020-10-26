Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D039C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC512224A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ln+0LCwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC512224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5Pe-0003J9-CK
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kX5Lw-0007S7-TX
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:28:13 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:34507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kX5Lr-0001Lu-HC
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1603729683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hy2oee6mtRO3xpByolXKlTHDlPOGbLU80jg6eNqjdo8=;
 b=ln+0LCwOSUxtl8q/u9zBmdOjdbXfjSqk748K2fMvQiz9yzIUr4pdb+H9rYanSQcHUcBzCW
 hp9NXQGEvJ7Uqkgsnyw2cx0nc1YdbDGBvcD2lWb20s/gwnFogc3D5bA80oHlspO2u2UtEd
 Z3rWzWv1cTpzo3y3hDqMPJEyt7fUC+o=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-3-aEZjsAEnMpKMqjLyckmggA-1; Mon, 26 Oct 2020 17:28:01 +0100
X-MC-Unique: aEZjsAEnMpKMqjLyckmggA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKd69ppJ2BcIT6jLDFCs06UJhp79Q731wr2jhHNvrdf4lBD7BEjuTMpaeRBBM0cJEYdXXLcKD1RwofIK2+8YvEElYbtv94Jh5QmVRgg5U9c/y2MzkibcMq2bNaAQkgSmVQS9Hyys5EztIpQIed2boKlirm5GnqDGeCEfdC45x/jhgKYGTq4qYdNcNrFIH3m5VlKtbqSqnbzQ3X8FRA1SLIbvGGFm4gvO4uPjlDd+ljK6heN6+zS8FU6NcByRy9kV+mCVwyCAf6ldnlp6OudK25BsH7tDDEdG3EY+RT+y/BJA4Ytiec2rae8RSIs96cx08NphPlYwJM4wnZOx0Oofqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hy2oee6mtRO3xpByolXKlTHDlPOGbLU80jg6eNqjdo8=;
 b=KRaaufTmy6GomspzJRtAX8emKiraxQ9v9H4YcODWV7UB9K2Rle1UiSw5DQESTthSOGzABl1BiChqP3cnHxYqwgv97OXLWVzk5PngrSBSvNAc60ZEKJhIwqA+FH9UUDDskeknNWeUOc3CotQ39w/oD4KZkjm/CXKpv8p8/O1VKmhCZ8fT6eVsAw4VD9FMO4rV8Z3uAB+OM99ToTBpBLdXwO+vnHBykSTnLZWQZDV1u1h9PPP5+4ORUzUS+//eyFYoo0a3Lfquw3j1mWibBQkyEbf308Lr2IDV7oNQKr/DfIkIfhdn4gc4h5kuozFG6tQ7v6PUmq5eazL0+rvyBUxWMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=suse.com;
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21) by AM0PR04MB6068.eurprd04.prod.outlook.com
 (2603:10a6:208:140::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 26 Oct
 2020 16:28:00 +0000
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::9891:ed4f:b5a2:6441]) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::9891:ed4f:b5a2:6441%6]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 16:28:00 +0000
Message-ID: <af8fc74d3c228fbb51933089dc5bce15524a009b.camel@suse.com>
Subject: Re: [PATCH 00/14] ui: build spice and opengl as module.
From: Bruce Rogers <brogers@suse.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Date: Mon, 26 Oct 2020 10:27:54 -0600
In-Reply-To: <20201019075224.14803-1-kraxel@redhat.com>
References: <20201019075224.14803-1-kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
Content-Transfer-Encoding: 7bit
X-Originating-IP: [63.248.145.198]
X-ClientProxiedBy: AM0PR03CA0108.eurprd03.prod.outlook.com
 (2603:10a6:208:69::49) To AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.5] (63.248.145.198) by
 AM0PR03CA0108.eurprd03.prod.outlook.com (2603:10a6:208:69::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.23 via Frontend Transport; Mon, 26 Oct 2020 16:27:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39910bb3-b1bc-4e08-5eab-08d879cc1a77
X-MS-TrafficTypeDiagnostic: AM0PR04MB6068:
X-Microsoft-Antispam-PRVS: <AM0PR04MB60684FDEC0F9C0F65CB41F41D9190@AM0PR04MB6068.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVPTW3zAHbQ+/3mQNVTVo07F/NsW2zcGAsVoFixXaR3PqT+T5hzblEL6my1eKbKmg6saJ4nMwC+mgwbvX91yjxqIRPf4FRcDPmpTDSC9Vcok7B8eoyE8UceBppW5uOZmws9ER1JRAzP2sXY7/IUWYDRpMV2j0hy1n3jCdbIVmNvH6Fp7VaBbEp5pmflyiElr2w+t4iXObiiFTKYqaq0ZL8BSsd5wPp713Gy9I6WYnOVce9bfTYPzNCGhie1esD9yVrKBxhwfg5ZDBWiO/u3Fddht79+WzjIxIirt88YXaAB7ZTcw1RVsQ13wqJmLWSGEonJStVCpLMXeBjSIqb+1vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR0401MB2354.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(346002)(366004)(376002)(39860400002)(136003)(36756003)(6486002)(2906002)(8936002)(66476007)(26005)(66556008)(478600001)(66946007)(86362001)(5660300002)(8676002)(4001150100001)(4326008)(54906003)(316002)(52116002)(83380400001)(16526019)(2616005)(6666004)(16576012)(956004)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JmEuDLcp3JzcOiCVHrw4jelrPy09jeud+YSRlSKf3w/jligJ3GJ7YtENz4ZWHWXDMcEwH2LseGRW/t2zda7VBgx3/32t4onVJ53BjpY24lFtQpghzEW/4CSwdvUhTkJd6VmHR2TzE2lzRanKvPcIYZtKybVwdwOcz89Yv5zQuG3AjGCkilJEJRLU57wFPaSCrvR67AqX16zcVZ7jyQmmxoxmMwrY+61urz2Y0hH/fqM8HtDnaxxTJ5Jcqoko/i/lBGpgq4mTVr5KEvqcOfrbiHd0RF1B0eoGoVaq/ZOmG7/eDZJhUEeaOOyTCByxIoHyo9RO1EBJ/03VS2nKrB+Q88IWCb+DK4IHCyTv58DH24198dS13J0kl3AojN0EXCfGEqnIYLaaca5XPpbbaF5hw/Ig6B3b3Zy8nHjyEU72Nzl27V/xhXMnmBbaEAsrEYq1rfdQkZKKz1aWpQigaWg+98D3x3tdKk1ndzRHtnILcgi+bBdlCvJyrB3siSs0dQqqbN+spkUHptUv+VNP8sH1N2EtWLhZk9l+gXhMcJ/wPMsu46C/DPqgMj0U7Ai+XsZO9Ex7QVzEnBDxfcVs2eOKSvtHAbyFY9u8XkNu6twmr6z0sU83RChv5J9Q89QACjBI5e00Nxu3wTeR/DyUGDr5EQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39910bb3-b1bc-4e08-5eab-08d879cc1a77
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 16:28:00.1663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4oUXQghRoXIKUIduWwkaLFJZsGDorFHpQAc1/AMzSiKHfcwPTxdTQ6e+c+sZONn3eCnlbM4j/tnTIMLInH1Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6068
Received-SPF: pass client-ip=51.163.158.102; envelope-from=brogers@suse.com;
 helo=de-smtp-delivery-102.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 12:28:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-10-19 at 09:52 +0200, Gerd Hoffmann wrote:
> - Add QemuSpiceOps, reorganize spice stubs.
> - Add support for module dependencies.
> - Build spice-core modular, and make the existing spice
>   modules (audio, chardev, qxl) depend on spice-core.
> - Build egl-headless display and opengl helpers modular
>   (pretty easy thanks to module dependencies).
> 

Hi Gerd, others,

I am happy to see the work you are doing with modularizing
qemu, but I think there also needs to be corresponding work
with libvirt's ability to properly detect qemu functionality
in light of this modularization.

Right now the QMP interface for probing "spice support" is
quite a big hammer, and doesn't allow for any nuance.

As I've looked into other aspects of how libvirt detects qemu
functionality, it seems there is a lot of room for improvement in how
qemu advertises it's functionality - which goes well beyond the issues
of modularization.

If you have any pointers to and discussion or plans in this regard, I'd
appreciate it. Otherwise I'll look into doing something in this space
myself.

Thanks,

Bruce


