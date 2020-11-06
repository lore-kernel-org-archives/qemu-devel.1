Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E78C55178
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE1F20639
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jqpQt4eE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE1F20639
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb16T-0004da-Bo
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 07:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kb157-0002p7-EV; Fri, 06 Nov 2020 07:43:05 -0500
Received: from mail-eopbgr130093.outbound.protection.outlook.com
 ([40.107.13.93]:31364 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kb153-0001NI-Ij; Fri, 06 Nov 2020 07:43:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nxon2Zj4fhVX3C3Ymo8mInKab+ENEkcOQWVXVal+XBNB428L6+0Ih/KnSuMhLQiK12IPq5w+mMDPM96xwtXimFjdtEcimH+Gr1/NDcEUHrcQ9qKE9cqIxeipWdR6YVZ4Y81CKyrPxv3Zo9b0fMZ6iRu4V+muVUVtmoHeOqjFOqRpESsUZa1IX4SAgk11BqlrXFt2t1rNNefxwNDHKvNoqXGrtyhRH38nVg25M1H/jreodCD+MgBl9P5cavZdt0ODFpr5m+oamXoxcE4aPnLr8yUosdAD0Z1phpYMcss3wBwpTJAyGdtumqawD63ZAoAKBdLlE9GWQ22b1DEOz3vtyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqgRlEpO8pc0gIn++SvBpnJ38xL6IYIPpodKe80tdr8=;
 b=JzxGlwO6TNS7XzZIa+Zg4lgsXDKJSdtdQB7TYdEc1rN/j034n7r9Zz+3Xl3N9RatG8cj7x8k97ft+B+sOUHvawmYSc6sy/yMNEmNI44kG7DrSNurOBq+tbBc1TKthxmgUe6SUfmXU8px+/2uAoKZsL12xa5mbDLTkrL8Kt99dK1t1Bh5Ws9LF6dyTIDEsJ8gjFG2QpS+ltTJ1ub9CXj2CL7XcKpWhjiMwHiiWfHVjYDGtLmBOsf4epGgzoRS/8LeWKUv+gEp5HPZ50cjJxwhab9yGfO/cUF4HiAFKjnflbEk6RzGLxtIXHJ+/cbCfjlf0aRf/ta+mXjlC3YjCFydlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqgRlEpO8pc0gIn++SvBpnJ38xL6IYIPpodKe80tdr8=;
 b=jqpQt4eEeLiEIIvtWVW014uQv9Gi7HJK1fcte2vShztAYwzGhQUOZFDa/pMYRFt4Jp7S5Hho6bBAcLQjcLAlKyd6HUzjTfuHhl+2zMTfdR9B7BYFWi0slL/fLKcOuGTUuBvagFLpzCWE9qeasFHryzJTS54GRuXkYJ39D3MdG6Y=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1841.eurprd08.prod.outlook.com (2603:10a6:203:2e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 6 Nov
 2020 12:42:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 12:42:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org
Subject: [PATCH v2 0/7] block: permission update fix & refactor
Date: Fri,  6 Nov 2020 15:42:34 +0300
Message-Id: <20201106124241.16950-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: AM3PR07CA0104.eurprd07.prod.outlook.com
 (2603:10a6:207:7::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.66) by
 AM3PR07CA0104.eurprd07.prod.outlook.com (2603:10a6:207:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.13 via Frontend Transport; Fri, 6 Nov 2020 12:42:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aed2e02d-f737-4961-6581-08d882517c4f
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1841:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1841CD7FBF5B130354C0096DC1ED0@AM5PR0801MB1841.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ohtvXO2lr+TnjMYAPz4xFzlji8FU7QYnkE0KiNryai89rBOMLabrYJD4r5zss50SgMGi77HJW3GAhbe7t/LHjK1nTCI776dOus1noY1DctzVB4cOkvJGHhkw8hJ7uj3Bv6zxmxVaKHRYoTUPLBvmksdh4VBw1PQ/xBbQNHG5Ta+hvyoGGZkvyymHgMX0peTKH3bTVEtBqDIckV0AiXpUhbpnnDnXA+/FhUaU/HsAEJeu+IU+BkW19kYzNB83nVxw6KeJcRKqfxKEGCrpfFdlmLcCmbL7owwEwynrTrKQ+4ftNQR2gWLttSrzcZMhlvHd0FhoiXOsNAVl58vw9oNl1S5qvTExv8pUmtpL6Lw6jGNrVopLNUioHS41Spk0diOyIDB6UC69Ri0/U5tmXWnb6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(39840400004)(346002)(6916009)(86362001)(66476007)(66946007)(6666004)(2906002)(8936002)(8676002)(1076003)(66556008)(5660300002)(52116002)(83380400001)(4326008)(36756003)(6486002)(2616005)(316002)(16526019)(6506007)(26005)(186003)(6512007)(478600001)(966005)(107886003)(956004)(15650500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4kEl64Aik9DV7uFOdTXXhN5BRwR6mp9/DKNDw7kTI40hhBbmRoIR1wphpMDGTxm5bEvJWQlh9b3Zs1FEMsuJWuIPmHy0EOebINcD6JDj3HZWK6tuP0hP1v/pBE1GXPBp1OoLSM2Ov6m8F3Lor11BUumJ83Cef1OGz+q1TfKwxhsjEXFjg3J4KvZoCgN6UnMDTULs/BUv6FDNpMK58t9zkIe28DoiOM2/FBkuK8aS+UEmephmYLe7Gm/KGo3ZZfBP5EZkb7vBczM17pCw+T0aclnOPPk1uQfvEMqdxQ7GiRl4IsPNNlhFgMYopN5fn5tRCYAsR16A7ZzXs00xR1kCPMxREXEV6w5yHvXznbh5GqKoTzpDemHbLrg12w+6pk04DX/U3OQCDnF1YzNXywfU0SQ4/9Fr4+d0JH5G1GXsL/Gg+Y4J+SbEvI5rYzxl0v6/ruG42o5f4yNDBUKV3fdzEjT2U6A18SmEb86TG2EYxbIVQi2g/5a6S0S07upY9zdvUyatclSAo2xyABECDaGqqPqZ5O8SmLe0FouQXoC60ORBVc17O+z7sNX/FMa1Y+bE7W5DdxcvjZrA6+ABYui+JytiCg8WWCTMh0MmJ397WfDSGWhB0hLqDv5jsnqqSYc/IU99YAjt8w6ukUSh5DqurQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed2e02d-f737-4961-6581-08d882517c4f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 12:42:56.5043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfVKx3wkbOvtm3ZAXAMovYIYWlO9sU8LD9gsKCuDTqowUi/jk+lTFZlfQe+n8MQpoZLJY9uRLLZCvQhNx7Xj6DzHMhwWGJsWAt1h5kZmbbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1841
Received-SPF: pass client-ip=40.107.13.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:42:57
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These series supersedes "Fix nested permission update" and includes one
more fix (patch 01) and more improvements.

I think patch 01 is good to have in 5.2, 02 is probably OK for 5.2 and
the others are OK for next release. Still all may be taken to 5.2, up to
block maintainers.

Actually the series is a first part of my work announced in
https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg08386.html
to bring correct order to permission update (topological sort),
update permission only on updated graph (and rollback graph changes),
get rid of .active fields in block jobs.

Supersedes: <20201031123502.4558-1-vsementsov@virtuozzo.com>

v2: all new except for 03:, which uses suggestions by Albert and more
strict version of bdrv_replace_node.

Vladimir Sementsov-Ogievskiy (7):
  block: add forgotten bdrv_abort_perm_update() to
    bdrv_co_invalidate_cache()
  block: add bdrv_replace_node_common()
  block: make bdrv_drop_intermediate() less wrong
  block: add bdrv_refresh_perms() helper
  block: bdrv_set_perm() drop redundant parameters.
  block: bdrv_child_set_perm() drop redundant parameters.
  block: drop tighten_restrictions

 block.c | 256 +++++++++++++++++++++++---------------------------------
 1 file changed, 105 insertions(+), 151 deletions(-)

-- 
2.21.3


