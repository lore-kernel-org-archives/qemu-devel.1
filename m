Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BA6C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:00:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB42E24656
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZhpkNUeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB42E24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfpH-0003Xf-QM
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 15:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVflY-0000db-Iz; Thu, 22 Oct 2020 14:56:49 -0400
Received: from mail-am6eur05on2108.outbound.protection.outlook.com
 ([40.107.22.108]:5089 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVflU-0007Y8-UX; Thu, 22 Oct 2020 14:56:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYPvpGoxHeaSrfoHSEis+34Lt0z64ZQs0bsSRSvbcz0KqvSJXuklsqe8SF1gFAqRbyUS9f0Fz9wn5SjHIEt7pd/eDUzoYW+ye2hsmSsROVUvsdsvN2PIlcrzbxX4/5gvYYELOvTw/6sHsB6n3xu9VWte9bJCu7G/IM0GjFUecux6aCk7Utg8Opjv3a7htVWzKurWyO0ewGDVu9/MmDRCW4pRcmbE3nq43y5S/tRXT1MFr9fcFlRo+mpYt82UlrKgt08fAo+jrJgUChgsPhVKnBkiyPaKWKbAr/W1z6oOaeHxY70Z+M6wFLsZDCPtVAxwaUs3v1/06XW8rkBkcgTDzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiVdsW39ZGNkxIaML+6TbBkC7PpwTYOBSQRFGWyjQ5g=;
 b=Ll5/R1DJtRdpb/6/XNS0pZRyojYn5xD2mBh9PX1dOXLbBgUV3oEQiDp2F+EaDQKpCBjsQWCjdMI0NjOkR7IBZXXzBrEe1RCnljL9NPIa/Vpe/S4x4GaRT1ObFgS4aE5dPLnhEhYK8tyJQiIKQVSkbBmlgc2K8Gz49NG2mR65ATUw9WpTkxADwNa2FFwrTvSwjy5ZFvmP3DZ5h9MN2Qj/LEsdmLcYfn8s0cihLdV76GoaNbY/ivaTsrLs3BONyu0XlW5WX9tZuaNTamPgBdZAaQ6lBX3ThXocPBXUqb46FV8s+OxMVurQgh6GpAoROEQK/8bPqz4OKqMyKKNU6C47ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiVdsW39ZGNkxIaML+6TbBkC7PpwTYOBSQRFGWyjQ5g=;
 b=ZhpkNUehM9rv/KQeUkHhZMEe+mET3sT5cUoDwDUBwr2bTi33i381Z9PgVKn7M0PBTE+Hf/hBXpvxexDlhoWA1vfV5nCxfRV48h9NgG3W/3b/UVUvemdqsUm9ecV5pceNapNespN66ceiMNQ2U0s0c+Dkwrcj7WAKwhu9QyF7Jdg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6309.eurprd08.prod.outlook.com (2603:10a6:20b:29f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 22 Oct
 2020 18:56:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 18:56:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com,
 jsnow@redhat.com
Subject: [PATCH v5 00/12] Rework iotests/check
Date: Thu, 22 Oct 2020 21:56:15 +0300
Message-Id: <20201022185627.16987-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR01CA0089.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend
 Transport; Thu, 22 Oct 2020 18:56:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4338643-2663-4976-0b62-08d876bc35cb
X-MS-TrafficTypeDiagnostic: AS8PR08MB6309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB6309A056C838B21E2238405FC11D0@AS8PR08MB6309.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQmWoVNzV8KDL0SeYJ1Gd3Sml5/ddDTIjUxrpBm6EAxPOMnxQLIQx1oC23j83BI1hmTQ/y2egYXdt/xACLNYTNzkdXhK95S0bKiwh3LOqB3io/cpqKeuDLO+2/5skpeBXwKXwLBDtJKF1+7ovRJxtPCaxdcqI6fvgg50Q1NjhHnuQMO7IGjRmRIzBBC1iTcYl6iqqQB4evZhVOARsWvjPLr9MlJIvfHrleQ0VfBngvoidE0TPnVIreAGRqis11zKSPdAFzAI3o2JPc65/r/Iu5WaXk12eTQHf/iYbqmDR0DTLiU9wypsBOIehz6aCjyj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(346002)(396003)(136003)(376002)(478600001)(6512007)(36756003)(2906002)(30864003)(52116002)(4326008)(5660300002)(26005)(16526019)(2616005)(956004)(186003)(6916009)(6666004)(8936002)(66476007)(83380400001)(316002)(66946007)(1076003)(6506007)(8676002)(86362001)(66556008)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +Cyu9h1yyHmRsuil6e/9w7BCYbS2zmYce9VOcHeJa0OH1kzHExXN6jhlYRjkjapMHcxZ/rf8QS83Iv8Mfk/YJJ69VSTb5w3PoKYrlQamFxEt73C2mkbv5pHnL8s/gDmM5A3iVsWSC9HZq6CFDee4VYdm3jbTDMTJiwxQU6vdFW8uu+XAy1nm/lre1Qj8n97X/aT6iGOVUb8lqpHtk7vAQnvqaaacdH9d/AliYF8Fv9aT5oq5rjBl5un2pOdPHHplE0d/t51g4KNK/JCRiDXMXc5TtBls/B3p2W5OJwhmzBRFws9N/L6ERcCYLUmNeoNK17Z7IAs3vcmGXjxK6opKovJeB9diX4lCng+QXDnh1OnvYc7toLQunOwIaT3mgHSO6mvsybaQcOoZlu7n/7YuWI6AVoGmmgKjxowvXac9Qy7a8zHRBGUQRd9r4sHObsgB1nz8zsgyXrv4EdmdMsfpKzHcRoXQbSPMRCjI5XSl3cnGllawnngL09KqeJ/twEIy/0O0dB1J+DjhJhpGMlks+q87XbbkMltYbmcnY5WVUHln0PdMe8J/rBGo1ybItvn/fDQJ6+KGYGVbMiqBN+SCxvyVC0dDXHI6naSTuvrxCkWWLaE7NroO/TYGjsVmHQpsuEy9TFw2S5eel14PSzs3gQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4338643-2663-4976-0b62-08d876bc35cb
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 18:56:40.3484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33m9hSwvzCDkJgxyvvZxOzwku1OEDQmogdPoy+Vw9WPZxJPPChkoK3Az01sOuDRXpgRoWvO2GorKUNbL9m5so/rcT42o3wxH/bc6rxQFvXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6309
Received-SPF: pass client-ip=40.107.22.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 14:56:41
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

These series has 3 goals:

 - get rid of group file
 - introduce human-readable names for tests
 - rewrite check into python

v5: [rebase on master]
02: new
03: updated
05,06: new
07: updated
09: rebased on master:
  vxhs removed
  qemu_prog path changed
  build_iotests path calculation changed
  handle mega2560 and gdbsim-r5f562n8 machines

Mark last patch as RFC: it's OK to postpone it for a while.
Also, patches 01-06 are simple cleanups and may be merged in separate.

Vladimir Sementsov-Ogievskiy (12):
  iotests/277: use dot slash for nbd-fault-injector.py running
  iotests/303: use dot slash for qcow2.py running
  iotests: fix some whitespaces in test output files
  iotests/283: make executable
  iotests/299: make executable
  iotests/294: add shebang line
  iotests: define group in each iotest
  iotests: add findtests.py
  iotests: add testenv.py
  iotests: add testrunner.py
  iotests: rewrite check into python
  iotests: rename and move 169 and 199 tests

 docs/devel/testing.rst                        |  50 +-
 tests/qemu-iotests/001                        |   1 +
 tests/qemu-iotests/002                        |   1 +
 tests/qemu-iotests/003                        |   1 +
 tests/qemu-iotests/004                        |   1 +
 tests/qemu-iotests/005                        |   1 +
 tests/qemu-iotests/007                        |   1 +
 tests/qemu-iotests/008                        |   1 +
 tests/qemu-iotests/009                        |   1 +
 tests/qemu-iotests/010                        |   1 +
 tests/qemu-iotests/011                        |   1 +
 tests/qemu-iotests/012                        |   1 +
 tests/qemu-iotests/013                        |   1 +
 tests/qemu-iotests/014                        |   1 +
 tests/qemu-iotests/015                        |   1 +
 tests/qemu-iotests/017                        |   1 +
 tests/qemu-iotests/018                        |   1 +
 tests/qemu-iotests/019                        |   1 +
 tests/qemu-iotests/020                        |   1 +
 tests/qemu-iotests/021                        |   1 +
 tests/qemu-iotests/022                        |   1 +
 tests/qemu-iotests/023                        |   1 +
 tests/qemu-iotests/024                        |   1 +
 tests/qemu-iotests/025                        |   1 +
 tests/qemu-iotests/026                        |   1 +
 tests/qemu-iotests/027                        |   1 +
 tests/qemu-iotests/028                        |   1 +
 tests/qemu-iotests/029                        |   1 +
 tests/qemu-iotests/030                        |   1 +
 tests/qemu-iotests/031                        |   1 +
 tests/qemu-iotests/032                        |   1 +
 tests/qemu-iotests/033                        |   1 +
 tests/qemu-iotests/034                        |   1 +
 tests/qemu-iotests/035                        |   1 +
 tests/qemu-iotests/036                        |   1 +
 tests/qemu-iotests/037                        |   1 +
 tests/qemu-iotests/038                        |   1 +
 tests/qemu-iotests/039                        |   1 +
 tests/qemu-iotests/040                        |   1 +
 tests/qemu-iotests/041                        |   1 +
 tests/qemu-iotests/042                        |   1 +
 tests/qemu-iotests/043                        |   1 +
 tests/qemu-iotests/044                        |   1 +
 tests/qemu-iotests/045                        |   1 +
 tests/qemu-iotests/046                        |   1 +
 tests/qemu-iotests/047                        |   1 +
 tests/qemu-iotests/048                        |   1 +
 tests/qemu-iotests/049                        |   1 +
 tests/qemu-iotests/050                        |   1 +
 tests/qemu-iotests/051                        |   1 +
 tests/qemu-iotests/052                        |   1 +
 tests/qemu-iotests/053                        |   1 +
 tests/qemu-iotests/054                        |   1 +
 tests/qemu-iotests/055                        |   1 +
 tests/qemu-iotests/056                        |   1 +
 tests/qemu-iotests/057                        |   1 +
 tests/qemu-iotests/058                        |   1 +
 tests/qemu-iotests/059                        |   1 +
 tests/qemu-iotests/060                        |   1 +
 tests/qemu-iotests/061                        |   1 +
 tests/qemu-iotests/062                        |   1 +
 tests/qemu-iotests/063                        |   1 +
 tests/qemu-iotests/064                        |   1 +
 tests/qemu-iotests/065                        |   1 +
 tests/qemu-iotests/066                        |   1 +
 tests/qemu-iotests/068                        |   1 +
 tests/qemu-iotests/069                        |   1 +
 tests/qemu-iotests/070                        |   1 +
 tests/qemu-iotests/071                        |   1 +
 tests/qemu-iotests/072                        |   1 +
 tests/qemu-iotests/073                        |   1 +
 tests/qemu-iotests/074                        |   1 +
 tests/qemu-iotests/075                        |   1 +
 tests/qemu-iotests/076                        |   1 +
 tests/qemu-iotests/077                        |   1 +
 tests/qemu-iotests/078                        |   1 +
 tests/qemu-iotests/079                        |   1 +
 tests/qemu-iotests/080                        |   1 +
 tests/qemu-iotests/081                        |   1 +
 tests/qemu-iotests/082                        |   1 +
 tests/qemu-iotests/083                        |   1 +
 tests/qemu-iotests/084                        |   1 +
 tests/qemu-iotests/085                        |   1 +
 tests/qemu-iotests/086                        |   1 +
 tests/qemu-iotests/087                        |   1 +
 tests/qemu-iotests/088                        |   1 +
 tests/qemu-iotests/089                        |   1 +
 tests/qemu-iotests/090                        |   1 +
 tests/qemu-iotests/091                        |   1 +
 tests/qemu-iotests/092                        |   1 +
 tests/qemu-iotests/093                        |   1 +
 tests/qemu-iotests/094                        |   1 +
 tests/qemu-iotests/095                        |   1 +
 tests/qemu-iotests/096                        |   1 +
 tests/qemu-iotests/097                        |   1 +
 tests/qemu-iotests/098                        |   1 +
 tests/qemu-iotests/099                        |   1 +
 tests/qemu-iotests/101                        |   1 +
 tests/qemu-iotests/102                        |   1 +
 tests/qemu-iotests/103                        |   1 +
 tests/qemu-iotests/104                        |   1 +
 tests/qemu-iotests/105                        |   1 +
 tests/qemu-iotests/106                        |   1 +
 tests/qemu-iotests/107                        |   1 +
 tests/qemu-iotests/108                        |   1 +
 tests/qemu-iotests/109                        |   1 +
 tests/qemu-iotests/110                        |   1 +
 tests/qemu-iotests/111                        |   1 +
 tests/qemu-iotests/112                        |   1 +
 tests/qemu-iotests/113                        |   1 +
 tests/qemu-iotests/114                        |   1 +
 tests/qemu-iotests/115                        |   1 +
 tests/qemu-iotests/116                        |   1 +
 tests/qemu-iotests/117                        |   1 +
 tests/qemu-iotests/118                        |   1 +
 tests/qemu-iotests/119                        |   1 +
 tests/qemu-iotests/120                        |   1 +
 tests/qemu-iotests/121                        |   1 +
 tests/qemu-iotests/122                        |   1 +
 tests/qemu-iotests/123                        |   1 +
 tests/qemu-iotests/124                        |   1 +
 tests/qemu-iotests/125                        |   1 +
 tests/qemu-iotests/126                        |   1 +
 tests/qemu-iotests/127                        |   1 +
 tests/qemu-iotests/128                        |   1 +
 tests/qemu-iotests/129                        |   1 +
 tests/qemu-iotests/130                        |   1 +
 tests/qemu-iotests/131                        |   1 +
 tests/qemu-iotests/132                        |   1 +
 tests/qemu-iotests/133                        |   1 +
 tests/qemu-iotests/134                        |   1 +
 tests/qemu-iotests/135                        |   1 +
 tests/qemu-iotests/136                        |   1 +
 tests/qemu-iotests/137                        |   1 +
 tests/qemu-iotests/138                        |   1 +
 tests/qemu-iotests/139                        |   1 +
 tests/qemu-iotests/140                        |   1 +
 tests/qemu-iotests/141                        |   1 +
 tests/qemu-iotests/143                        |   1 +
 tests/qemu-iotests/144                        |   1 +
 tests/qemu-iotests/145                        |   1 +
 tests/qemu-iotests/146                        |   1 +
 tests/qemu-iotests/147                        |   1 +
 tests/qemu-iotests/148                        |   1 +
 tests/qemu-iotests/149                        |   1 +
 tests/qemu-iotests/150                        |   1 +
 tests/qemu-iotests/151                        |   1 +
 tests/qemu-iotests/152                        |   1 +
 tests/qemu-iotests/153                        |   1 +
 tests/qemu-iotests/154                        |   1 +
 tests/qemu-iotests/155                        |   1 +
 tests/qemu-iotests/156                        |   1 +
 tests/qemu-iotests/157                        |   1 +
 tests/qemu-iotests/158                        |   1 +
 tests/qemu-iotests/159                        |   1 +
 tests/qemu-iotests/160                        |   1 +
 tests/qemu-iotests/161                        |   1 +
 tests/qemu-iotests/162                        |   1 +
 tests/qemu-iotests/163                        |   1 +
 tests/qemu-iotests/165                        |   1 +
 tests/qemu-iotests/170                        |   1 +
 tests/qemu-iotests/171                        |   1 +
 tests/qemu-iotests/172                        |   1 +
 tests/qemu-iotests/173                        |   1 +
 tests/qemu-iotests/174                        |   1 +
 tests/qemu-iotests/175                        |   1 +
 tests/qemu-iotests/175.out                    |   2 +-
 tests/qemu-iotests/176                        |   1 +
 tests/qemu-iotests/177                        |   1 +
 tests/qemu-iotests/178                        |   1 +
 tests/qemu-iotests/179                        |   1 +
 tests/qemu-iotests/181                        |   1 +
 tests/qemu-iotests/182                        |   1 +
 tests/qemu-iotests/183                        |   1 +
 tests/qemu-iotests/184                        |   1 +
 tests/qemu-iotests/185                        |   1 +
 tests/qemu-iotests/186                        |   1 +
 tests/qemu-iotests/187                        |   1 +
 tests/qemu-iotests/188                        |   1 +
 tests/qemu-iotests/189                        |   1 +
 tests/qemu-iotests/190                        |   1 +
 tests/qemu-iotests/191                        |   1 +
 tests/qemu-iotests/192                        |   1 +
 tests/qemu-iotests/194                        |   1 +
 tests/qemu-iotests/195                        |   1 +
 tests/qemu-iotests/196                        |   1 +
 tests/qemu-iotests/197                        |   1 +
 tests/qemu-iotests/198                        |   1 +
 tests/qemu-iotests/200                        |   1 +
 tests/qemu-iotests/201                        |   1 +
 tests/qemu-iotests/202                        |   1 +
 tests/qemu-iotests/203                        |   1 +
 tests/qemu-iotests/204                        |   1 +
 tests/qemu-iotests/205                        |   1 +
 tests/qemu-iotests/206                        |   1 +
 tests/qemu-iotests/207                        |   1 +
 tests/qemu-iotests/208                        |   1 +
 tests/qemu-iotests/209                        |   1 +
 tests/qemu-iotests/210                        |   1 +
 tests/qemu-iotests/211                        |   1 +
 tests/qemu-iotests/212                        |   1 +
 tests/qemu-iotests/213                        |   1 +
 tests/qemu-iotests/214                        |   1 +
 tests/qemu-iotests/215                        |   1 +
 tests/qemu-iotests/216                        |   1 +
 tests/qemu-iotests/217                        |   1 +
 tests/qemu-iotests/218                        |   1 +
 tests/qemu-iotests/219                        |   1 +
 tests/qemu-iotests/220                        |   1 +
 tests/qemu-iotests/221                        |   1 +
 tests/qemu-iotests/222                        |   1 +
 tests/qemu-iotests/223                        |   1 +
 tests/qemu-iotests/224                        |   1 +
 tests/qemu-iotests/225                        |   1 +
 tests/qemu-iotests/226                        |   1 +
 tests/qemu-iotests/227                        |   1 +
 tests/qemu-iotests/228                        |   1 +
 tests/qemu-iotests/229                        |   1 +
 tests/qemu-iotests/231                        |   1 +
 tests/qemu-iotests/232                        |   1 +
 tests/qemu-iotests/233                        |   1 +
 tests/qemu-iotests/234                        |   1 +
 tests/qemu-iotests/235                        |   1 +
 tests/qemu-iotests/236                        |   1 +
 tests/qemu-iotests/237                        |   1 +
 tests/qemu-iotests/238                        |   1 +
 tests/qemu-iotests/239                        |   1 +
 tests/qemu-iotests/240                        |   1 +
 tests/qemu-iotests/241                        |   1 +
 tests/qemu-iotests/242                        |   1 +
 tests/qemu-iotests/243                        |   1 +
 tests/qemu-iotests/244                        |   1 +
 tests/qemu-iotests/245                        |   1 +
 tests/qemu-iotests/246                        |   1 +
 tests/qemu-iotests/247                        |   1 +
 tests/qemu-iotests/248                        |   1 +
 tests/qemu-iotests/249                        |   1 +
 tests/qemu-iotests/250                        |   1 +
 tests/qemu-iotests/251                        |   1 +
 tests/qemu-iotests/252                        |   1 +
 tests/qemu-iotests/253                        |   1 +
 tests/qemu-iotests/254                        |   1 +
 tests/qemu-iotests/255                        |   1 +
 tests/qemu-iotests/256                        |   1 +
 tests/qemu-iotests/257                        |   1 +
 tests/qemu-iotests/258                        |   1 +
 tests/qemu-iotests/259                        |   1 +
 tests/qemu-iotests/260                        |   1 +
 tests/qemu-iotests/261                        |   1 +
 tests/qemu-iotests/262                        |   1 +
 tests/qemu-iotests/263                        |   1 +
 tests/qemu-iotests/264                        |   1 +
 tests/qemu-iotests/265                        |   1 +
 tests/qemu-iotests/266                        |   1 +
 tests/qemu-iotests/267                        |   1 +
 tests/qemu-iotests/268                        |   1 +
 tests/qemu-iotests/270                        |   1 +
 tests/qemu-iotests/271                        |   1 +
 tests/qemu-iotests/271.out                    |  12 +-
 tests/qemu-iotests/272                        |   1 +
 tests/qemu-iotests/273                        |   1 +
 tests/qemu-iotests/274                        |   1 +
 tests/qemu-iotests/277                        |   3 +-
 tests/qemu-iotests/279                        |   1 +
 tests/qemu-iotests/280                        |   1 +
 tests/qemu-iotests/281                        |   1 +
 tests/qemu-iotests/282                        |   1 +
 tests/qemu-iotests/283                        |   1 +
 tests/qemu-iotests/284                        |   1 +
 tests/qemu-iotests/286                        |   1 +
 tests/qemu-iotests/287                        |   1 +
 tests/qemu-iotests/287.out                    |  10 +-
 tests/qemu-iotests/288                        |   1 +
 tests/qemu-iotests/289                        |   1 +
 tests/qemu-iotests/290                        |   1 +
 tests/qemu-iotests/291                        |   1 +
 tests/qemu-iotests/292                        |   1 +
 tests/qemu-iotests/293                        |   1 +
 tests/qemu-iotests/294                        |   2 +
 tests/qemu-iotests/295                        |   1 +
 tests/qemu-iotests/296                        |   1 +
 tests/qemu-iotests/297                        |   1 +
 tests/qemu-iotests/299                        |   1 +
 tests/qemu-iotests/300                        |   1 +
 tests/qemu-iotests/301                        |   1 +
 tests/qemu-iotests/302                        |   1 +
 tests/qemu-iotests/303                        |   3 +-
 tests/qemu-iotests/304                        |   1 +
 tests/qemu-iotests/305                        |   1 +
 tests/qemu-iotests/307                        |   1 +
 tests/qemu-iotests/check                      | 977 +-----------------
 tests/qemu-iotests/findtests.py               | 229 ++++
 tests/qemu-iotests/group                      | 317 ------
 tests/qemu-iotests/testenv.py                 | 325 ++++++
 tests/qemu-iotests/testrunner.py              | 351 +++++++
 .../migrate-bitmaps-postcopy-test}            |   1 +
 .../migrate-bitmaps-postcopy-test.out}        |   0
 .../{169 => tests/migrate-bitmaps-test}       |   1 +
 .../migrate-bitmaps-test.out}                 |   0
 299 files changed, 1285 insertions(+), 1281 deletions(-)
 mode change 100644 => 100755 tests/qemu-iotests/283
 mode change 100644 => 100755 tests/qemu-iotests/299
 create mode 100755 tests/qemu-iotests/findtests.py
 delete mode 100644 tests/qemu-iotests/group
 create mode 100755 tests/qemu-iotests/testenv.py
 create mode 100644 tests/qemu-iotests/testrunner.py
 rename tests/qemu-iotests/{199 => tests/migrate-bitmaps-postcopy-test} (99%)
 rename tests/qemu-iotests/{199.out => tests/migrate-bitmaps-postcopy-test.out} (100%)
 rename tests/qemu-iotests/{169 => tests/migrate-bitmaps-test} (99%)
 rename tests/qemu-iotests/{169.out => tests/migrate-bitmaps-test.out} (100%)

-- 
2.21.3


