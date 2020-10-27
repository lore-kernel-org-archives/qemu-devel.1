Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37D3C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49F120829
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rECqEkK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49F120829
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNYt-0001n3-NF
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXMc3-0002Af-Ap; Tue, 27 Oct 2020 06:53:59 -0400
Received: from mail-db8eur05on2105.outbound.protection.outlook.com
 ([40.107.20.105]:16096 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXMc0-0003Pi-EA; Tue, 27 Oct 2020 06:53:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4DfRNkNJGKWOjuePOtEp03fZzv7wGShCOv7I6GK/bpE95s3pI8PbwCtugGSK/jq8zdy47rxSkMqseEI5Pqscc0Xx1kHYB8rkTZJBv5ZRkL9xaodhMclE2hIEoOo5kcaZGBEDroJbOy/OiYy32s/BAqi65BG5lgv7vjOJ2QlhhBdrRqPRhr1k7AppKbMjKrA/Dc+butA4s0kEEtelZGAp/hOo3ymK+Up0tW6x6lnIPFHwz2Cz0AIcplqseQCwykv+o+Fkv2MIJ0/ckPzyJXrpFkUHVN93606wpY3qDCU4cJb0h8aUBqanBN7WrztqK9k1KdRww/RnKxDJNQD/ijM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfwluHKh5P1jESVR4zYad+7DjbL3bWN8De2mJQP/ia0=;
 b=lLgfSKAyHOoLn9wRN20PXlgBks7d4qD50IqHEr4m2vRqdtG7dh/vpuGS8HbTJpKLCJCUv5vt9wqw1EKNs7+cqHYUWy8BnWvObRZp3VyTB8goIrPh50bcWbzBEexq2pl+P3YZ9V6t40F0ipgsi8+xABzpyMxijQ2qAcjn9XgEprZ9Lz9bMc5OCGT/q6vNHomtKcU9SCArSKjFlRV66LXf1WMkIobxqVKiBS+FN+17uPLAzJseYSZwREJ5W+E+ToOqMHeguUOAE/d9VE92Yd3OkQ3EfMfcjXCU8vVcIOC64ZHSYhkteala7khtLhYCHPhhl9giJhQC0UPs/NpDVAR9Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfwluHKh5P1jESVR4zYad+7DjbL3bWN8De2mJQP/ia0=;
 b=rECqEkK/t/WSNPLlhU/huc0K9zOxfq1UbvKXFgUekA6ytLDA+9ayme9pgGn0wZYV+vJ1uJzcbOJau6oYbIuRutDawNEEIF6Bn9Jd1TmXEFSM2T8MqU5ENEMNpeYYFk/U4AuZoqT5yVlU5txefTXjvNQQp4duoCDlLKjWwnzVWgs=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VE1PR08MB5695.eurprd08.prod.outlook.com (2603:10a6:800:1b3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 27 Oct
 2020 10:53:53 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%9]) with mapi id 15.20.3455.037; Tue, 27 Oct 2020
 10:53:52 +0000
Subject: Re: [PATCH v6 09/11] nbd: Add new qemu:allocation-depth metadata
 context
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, armbru@redhat.com,
 rjones@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
References: <20201027050556.269064-1-eblake@redhat.com>
 <20201027050556.269064-10-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0de8622e-3f5d-5f3b-3560-2c9c737174e8@virtuozzo.com>
Date: Tue, 27 Oct 2020 13:53:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201027050556.269064-10-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.93]
X-ClientProxiedBy: AM3PR07CA0083.eurprd07.prod.outlook.com
 (2603:10a6:207:6::17) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.93) by
 AM3PR07CA0083.eurprd07.prod.outlook.com (2603:10a6:207:6::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.11 via Frontend Transport; Tue, 27 Oct 2020 10:53:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3461e9a9-e130-4370-484b-08d87a6697f7
X-MS-TrafficTypeDiagnostic: VE1PR08MB5695:
X-Microsoft-Antispam-PRVS: <VE1PR08MB56951D56BCCD7CC1E766D271C1160@VE1PR08MB5695.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihq6SVcD+v4iNZ7Bw4oGjHfbWLhVP98BzZM8MkPTmyKiLFTMaAV8XyaZbbkwjnQyw+A4OZIWY9qfhoHNWZaZW8VoceI7UhjNpPQjTK+tZBZBUg6TKHPnsIglY+q1EJqqvqCPXRflhz14EhS2rZJROXnG1G0F4XZ4HLn2mqdfXN6stigIk/6OVUQ6tnmjnveGuRRA6StZYnr0Ulryw+CjgAj4XzcpX0HXsgZDiViikxKiGe1K4O+e1ujTUcosmH/YLPoDgAc4JpaYKei5EnZkqxFjY9YCGgR0PUWFOqH+S4BRsugWtE2qASlez9jmbXmtkOmtaUo/xxgMRUZR4e6A1O2+WH2bwZviNZoeYcI5ckvVbXzC2wAg5A+ID4gZQN8X
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39830400003)(396003)(136003)(366004)(376002)(346002)(16526019)(16576012)(186003)(316002)(83380400001)(52116002)(31686004)(478600001)(8936002)(8676002)(36756003)(956004)(66476007)(2906002)(66946007)(66556008)(26005)(4326008)(86362001)(6486002)(31696002)(2616005)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WDas3KiTJFIthcPffc6c9d26ViDwxWtUGPwSSJSqiw2/NcAWU6ofBSMGmMjxDCB0IjO7MVrAE7a3A/vrndK1eREcIWFDTOtx4ABQqWnnIho1mfCNcN+n6ADLl6gBlQk7GsLuu/B+uPEVQexaWSF7vz59RByxyjWln/RA2Kopo+ZPmQvn/w5TTZFDOPKZ472aIL3wuwwEb/S9LoPw4RpCM3TITPqJmdJftTWJFN42pdDCc2t2KUGUMT3i01XV24drSDnEN8OIv7p0Wcih54tqZg/i0jGx/e7alVo2KxQf9TcykFSqijtAhBdQ5FwO3IQSPgmmoDoN2kDL/zF0eXB6dTgmhlOmAMvj87+ezVLWhQOYNgl2L6MmwgICS+wrqStmitoTZqGG31TuY/FAZ4FpPOY9ONTUurQso+qGhD9ptpD7Jkw6D/g4qRq1ILVcHfi0zCIbd9szbZXxj06AN9nYQESlHvfVGy+/I8MEqGr5IKKfa1nmey2V3wPCXTNRDHU2LHrRONUZqzWhLQuQXIPJoHP9S4WXA8qmV1wFbr0YkI2FqDL2CSnn3oxj8OIiNLfKiEqGDm5gwnC5w/TaskgtLoZLMEsKdn2JRDvz8fDx8/qZORdC0gltt/iKXlYvtdhhuqYqavE0uzpL6IUsugWQFQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3461e9a9-e130-4370-484b-08d87a6697f7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 10:53:52.8669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+gjBPgJ5V9xnbIn5rdLtmW/uhSZOo0P577GGuaEMb0fmeWbd3CYFSWKmx3FSOvMWa7C172yysAkk3wTUkmxhK0iPtZzy1hR9tmYycpmMlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5695
Received-SPF: pass client-ip=40.107.20.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 06:53:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001,
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

27.10.2020 08:05, Eric Blake wrote:
> 'qemu-img map' provides a way to determine which extents of an image
> come from the top layer vs. inherited from a backing chain.  This is
> useful information worth exposing over NBD.  There is a proposal to
> add a QMP command block-dirty-bitmap-populate which can create a dirty
> bitmap that reflects allocation information, at which point the
> qemu:dirty-bitmap:NAME metadata context can expose that information
> via the creation of a temporary bitmap, but we can shorten the effort
> by adding a new qemu:allocation-depth metadata context that does the
> same thing without an intermediate bitmap (this patch does not
> eliminate the need for that proposal, as it will have other uses as
> well).
> 
> While documenting things, remember that although the NBD protocol has
> NBD_OPT_SET_META_CONTEXT, the rest of its documentation refers to
> 'metadata context', which is a more apt description of what is
> actually being used by NBD_CMD_BLOCK_STATUS: the user is requesting
> metadata by passing one or more context names.  So I also touched up
> some existing wording to prefer the term 'metadata context' where it
> makes sense.
> 
> Note that this patch does not actually enable any way to request a
> server to enable this context; that will come in the next patch.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

