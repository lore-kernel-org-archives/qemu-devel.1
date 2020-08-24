Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F15C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 19:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A74F206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 19:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="T6NBtfI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A74F206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAIJ7-0005Hz-BL
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 15:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAIIL-0004O8-VF
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 15:38:17 -0400
Received: from mail-eopbgr10113.outbound.protection.outlook.com
 ([40.107.1.113]:60643 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAIIK-0000YT-7l
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 15:38:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU3D4g1qWwS2RteV0OvU0gD4ZdPLwrZtsDB3sMsuiMEe1didCW089zsFrI+yePwMHv+c7kG2tLc2MOgqKH5MJOVq35i961fPv/H6ja0VlKGlV6pSNOxJ0EYOgmP7JzP9W4nqD61HA4x5dJw49ENnNOWxVNrkZoZs40qpVEHhJU5Ef5K4zeHgKjySjpJ3afa1OcNw9T0x2z30ahfcsl8PbtjkvZxV3OHQm367TVy6kFeicgwGTJgLSFDGdX58DKG2DM29HmC426tAWI+bdh48JBEAvSr3wUVukMn5w8KTdZxAs3de/48gI++4aF9rjQHlMRMsO4Ucd/7clLT4mVRL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzN00aksv++d+Uz333s5RLSVnbrFkRA8Oln9GXS3br8=;
 b=AW0qojEspwM6jqNTwKgYnC89sbRqbRhYgaIVMvi+02vWKTqEVUR3Pu40542kaTRJFgI3b+ea27p48l9dDhJOMi/RzUNk+Nq/0xnvIpLFr932oNTfTDOQ3bP2CNKCqL0jIGboUdseOvadqwMABEZGfF2It7IW8Krdh7OepdY8s5OQ36etVwzYU34nXgyL/OAZkUNlwyyFl6NXCHbOxNbtNZrFSECUmtm8UnsgMqv33YzU/IesGEL2cUbNz7PTyRAZ1e+LbkVABDdQVVGGe4n3wLWm1qS7PL3YXx7P9KS7dhvz8QYGHHqB0ZqMW0Srk/wgf2BB7kcP2iImePbpY1mImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzN00aksv++d+Uz333s5RLSVnbrFkRA8Oln9GXS3br8=;
 b=T6NBtfI5gg7SbIlKnxhTQ3DPVWetmLEDYfEotAV+awzBLO053+Z/zy1PaTiHc0vDYFAefbGTOst96fdXRmThkCaQLfDvEEIcer7zGZadVgj7ylpTwBuR3SmCHSwZt2FDRRGJ/4t5Il0xeVwnRSo9qN6cqmLaUPQsPr8iomMMbL8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VE1PR03MB6047.eurprd03.prod.outlook.com (2603:10a6:803:114::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 19:38:05 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Mon, 24 Aug 2020
 19:38:05 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] linux-user: Introducing functionality for two time64
 syscalls
Date: Mon, 24 Aug 2020 21:37:50 +0200
Message-Id: <20200824193752.67950-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0251.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::23) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.242) by
 LO2P265CA0251.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 19:38:05 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad5d5787-ec67-4fa7-628c-08d8486538d7
X-MS-TrafficTypeDiagnostic: VE1PR03MB6047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR03MB6047C57C56CEE62991390AA8EB560@VE1PR03MB6047.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXfWGal8taCL3dYXlMc4YANTZkBIrlLmtdQIoka4AGq358N8mACmiZbborAOIMJAxOyHCQXDvEk9f1oVwaJnRo0yLsQ4T2wF2YTOUCv+XBkYl7csas41jotn9Xnw0hvtHKUAtiWdjUxcgrpS/+B5c/2ad6heFrW/T/cctN1l5+7ofnJuNSR9+Xpg526emPwbyU9Kx54EVHWM14W2OfWPLOnGNaV0RTQIUo2zcg3SAlo0+QaxVa/pAzBlgnPPSrhs4NcdZ6wj+SwmcrTcHrO+h6Am0ds5j0VEKRa40FgllaGAT1REEsBxSP8+09qZWgPqDbX4ZUPJAG+G359yHMriHuY5hgDG/BDLr/nd9UVZ51p2TQXnw7y59aI/e8GU6ftc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(136003)(366004)(39830400003)(376002)(396003)(4744005)(16526019)(8936002)(66556008)(83380400001)(26005)(107886003)(2616005)(956004)(6916009)(86362001)(66476007)(5660300002)(1076003)(6512007)(186003)(6666004)(316002)(6506007)(66946007)(6486002)(8676002)(36756003)(69590400007)(4326008)(52116002)(2906002)(478600001)(54906003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: u12yTIpebnMIgfnYXGgHUU5uGTReWLWxYkyRZ1V8UHSthsj2BoGLQdDnIC8IVhxJBwg5GrYhtradqxkSRbsLGeHXxdl0AjP0Ln06AWfny+T4QB0qS6mg9sgiDdG6AUfJJa2qFGEvECWk252BKYI3w2X3whZdoRILOZuBeDSI5yNGSmNxj2eVLfI6Hjfb3PIOzrGtqMC7OCz/w1xWjqMkIYVcgFXrOGPTU+6831BgJEHgDa0iA2sYF9SqM5V5KkHlj8BCwSLqUenOgZFp6/IoFNEGX6My0OO27d/Gd91KJ2ETqcuYzNZZ2LVGa3u7yFWYXzTVinAlyTfHE+g+yUop+hBIa5llEwGj0mqpxhXYRJQXeSEm4520a/Wt8vg6B1ocls46fKjX/qVLnKQQeF/sXbFoKjQUB6rykXn36QbOwrGrzBZgJYCezVXqGQJO3IFulaxNtrmYI/J6m9SN1Xy7/SmVSKKYBrQ2w1RB1sBR4rsW3VNBJeBFDfN8KpefLOX8fi64gikWkHo6jjk2cWvdLRX3xrJPHLFglzPsWk1IrxG+LqqEoZ+zY9Ifry6A0bX6sTxEL+ot1sAPuWlSUZq+KD1XBEaYSNJmbKYnDfgbT81apJE67dvvQ4VGJJh0NAIqo0+e1P5gC6YmsK35GhO6SQ==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5d5787-ec67-4fa7-628c-08d8486538d7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 19:38:05.6860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Gv8UM1ZtJA9PQcZA7sNUaNfO/AGzLmiSetgwEvZFp6gOxCiMcgjUlqA3jHLZrZZBCbUjKHbtbimkS3kr7rdMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB6047
Received-SPF: pass client-ip=40.107.1.113;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 15:38:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This two patch series introduces functionality for two year
2038 safe syscalls.

The first patch introduces a little correction for already
implemented normal (32-bit) variants of implemented syscalls.

The second patch introduces the implementation of the
syscalls.

Testing method:

    The implementation of the implemented syscalls was tested
    using recently added time64 test in the LTP test suite.

v3:

    -Added an error check before converting back the value
     of 'struct timespec/timespec64' from host to target

Filip Bozuta (2):
  linux-user: Fix 'mq_timedsend()' and 'mq_timedreceive()'
  linux-user: Add support for 'mq_timedsend_time64()' and
    'mq_timedreceive_time64()'

 linux-user/syscall.c | 74 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 7 deletions(-)

-- 
2.25.1


