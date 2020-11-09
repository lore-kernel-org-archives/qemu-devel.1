Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0646CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 20:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5977220665
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 20:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s1MSaOFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5977220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcDrO-0004k3-EA
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 15:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kcDqf-00041A-Cz
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 15:33:09 -0500
Received: from mail-bgr052100138028.outbound.protection.outlook.com
 ([52.100.138.28]:5715 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kcDqb-0007ei-TB
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 15:33:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmmoeLgMQrFNbc9rpi0kpwQbgI8jNttaKmjC+BI9mbLWjIKjani/XrN5jpA0HY5nst5sBwHI/pc7vPwohiSXPvcGxickLjXh8k4PpVrHKgrcLBFnTTozFtFWfvIE3waZV5aIKXIWm55KJ/QPLa/37bwv+yYbmVzbp32snhfwNg6ixYZpiNykasW51Lu86C2svPDNAYZxXIKVjwdQG5OxYESs6gR7MFZXHQQf97wTwcDS0kDNMrmJj9dMO5FnedEyJAJBMCHV227t3Au+Kf81+c4hCmXUsp9dmvfdLPDQpYYFJb0syO72b3ok5BAxncbJHAHris9e4V6vuoH+723V7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf/fHPicZgZkO5thQSCE2ipeIXs29RxbH2rLc2NdaH0=;
 b=YAavWqnQNtDKFVjUYaTnE44+XDcWHMXtJm6HxQ2Q/buFwZHi1nmO8ec18pvZdGmOq6AQpc4bTKeIcFkACCTuYefkkWKoiaqimr7LcMq6JWaiHA0qZPhWRFfzNxV0oKdykN91bzgk1/7DJdieP8g3ZEBrvWTlGI6BgxMn83elps3PXKZbdYPtc+6Zol1cJolnRIwv1fseDs+FaFKNq7X6XaLDCVDYVq4Flz5Lfuh7KnkXtBcddMvsUCkpuzf4oy105WTWh8bqo2eNqE44Vg129M5SaOTrqf39KTDhXUHFb8WkecI97q6NnkkGz37xYlS901K8roKEj9LhClMq+4JtBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf/fHPicZgZkO5thQSCE2ipeIXs29RxbH2rLc2NdaH0=;
 b=s1MSaOFbFb6EBhuem0TuduG42q+6fGaqyQds9rE7BGFCFfG+deY84avUTSxYUDdt2pgv53Ljt1FHwnPhJiivIr8r4k/dlP64AtbPM1mCbCQc2Tap9c/XhonWaz+RB0XzVIVOXDBq91/HxjEuIN4pZOtVucm/OQvPo1iISryUHuk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 20:18:00 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 20:18:00 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.2 0/1] qemu-ga patch queue for hard-freeze
Date: Mon,  9 Nov 2020 14:17:21 -0600
Message-Id: <20201109201722.237150-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN6PR01CA0015.prod.exchangelabs.com (2603:10b6:805:b6::28)
 To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SN6PR01CA0015.prod.exchangelabs.com (2603:10b6:805:b6::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.25 via Frontend Transport; Mon, 9 Nov 2020 20:17:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8eb679f4-8016-49ec-4376-08d884ec8ddb
X-MS-TrafficTypeDiagnostic: CH2PR12MB4072:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4072946A2E3F55D011478E5795EA0@CH2PR12MB4072.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZddpH3Gsk9+EL7bizhR2OkWrvOQWbOFRgcuV8bv0+0w45RVcpnCwBnYu+sxXEUsRlUSkpXBoHhcT1w349RmbgoLhmSstPXX/1mQhE3NBYBOMBXSLwP/Vp+6CStHetXl2s9S++52A2ndH5d4tgwkL9PAcWNGdZltk81PRrYY/gIfPxztGg8365a6mPGQS3aUVD/QkcdI5aEE4Gq05EU/EsKF5Q/6ocXejldoM1ky3j/Pyi1t53z4fFw0J4O5Ygt+Qeqn39Fj7Fk4fI5CA/vjuMnu+fwc9rmrlkZnhMbXrWj0SfrUKzywS07OAwZnx8LXGxu68cuiCpn6QDndFvFWsveIpY5/SHCCem3QWDpxUCDgN7Fkzlxe1zuVYoVB3RN0dm1U4+rlI8iYINpKGVLOCMuNYO1DsubHsY8pc0U9xZ5wQxHDWq8r7F34OQ6LLm4ZfC2zdvPYDIkv1r/Sjp1nhMo6QTIn9uonRsGS9b91lt3D0Q1KL/pjZdada0fIGXNVxnI+7gjcNiqHomyO18jCOu6uxl/hzQxa5trRD6321+xkFqKIYCaHjJI6KVLlLIbyaYcd29mf7I9t5C7O8QVAxZ2tlmIycmU0FphqxtRl9flqt90JVAgtUz81ILhal3FzV1kayanFNMpte1eLqoZOFBC0IBpjuqo1rnTNU7282xMBL5H3Kqsx5hzlXfr/Rwr7z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:5; SRV:;
 IPV:NLI; SFV:SPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:OSPM;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(6486002)(6666004)(1076003)(5660300002)(66556008)(8676002)(8936002)(6496006)(6916009)(66476007)(316002)(36756003)(186003)(2906002)(66946007)(44832011)(26005)(52116002)(956004)(4744005)(2616005)(4326008)(16526019)(83380400001)(86362001)(478600001)(23200700001);
 DIR:OUT; SFP:1501; 
X-MS-Exchange-AntiSpam-MessageData: 3LIKUZcxUMqVuzTMHFe4/lwGlb014Yw/VRAxtYU7BLfEP+iSEMyUVBhuPND33OQTB6wewKyyNUVFLgodiden/dUSi+dMfNixkpGd/ntdBzIu5CIfjV72GYXEpkeP9N9jp624vkyz7ltIEGpvh3rWodFYpikBl7kOn+GyWD7FurBMgUZvnb+jSi/gjKcOA0TNahFbyd4/OTu5xW3xJQKDyllJwpkyqVcYd1dtSRgeoxGUpaOW2ykE4s8ReMleumw6y/qHfAlz97MYTIl55FsJek9TXh21B0kc5gOmPqdJdANNr9y4vFYwKrpaw+DaDt2uahVpUoTJiDV1b2qZmP30VKpE1a4OWZCz7m3a4bpQUeGYL6ezAYIhPqASzPfESvNcV3gUu8jicloh+/Kz5PQUocgaHie3d1bnLqiw+XeBOOuPMF3aFuBwrsxwl2eSGu6jYH4u54J3cOwT48NomLc+E+7nhtJTL8ffKc0J4yIBWwQ+VD9wrhamRxljXN8/ny2QHlfpAzmZ9JNxEXMgesev8sr1ZTeay0P8XlyoPDjxA2+xdh6bHG/9JznpWcYaONA8VbSLwNaW14kl4Da/ldSRqkzRfTdWua7LWmkYBRW/0SNZ26FzLYF7mf279TO8OVdMsM/1XZT0iF5s1VQqqvtpIjOJmCn3JRhK6OTIoNjmS1ch3hxQOVjWPHl9hj0JVQmRsqHZwrDClkoymFSJTRFtdc87IiI/8LjHbdg/MEQERUmOzXMIUPOk5TOlpH0cRHEVyXR8JBMcv72OK0WzB1tfZWM1afv82l0iljJFrocA18cAm/76ADI95ds0MBLbFqw00sJ5k4WXWHVTrJpwMW0BM7phdRolTmUmtz0BS4MYWKeqGCJOk+ksruEY68nNEOH/QHTtcV6x572KVwp1WgqHeA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb679f4-8016-49ec-4376-08d884ec8ddb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 20:18:00.3097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNnVnK7A4UXvqwx17eb6D2KqNm9e6v4oA3qBTqwuyZYV0gDfk0oX9it49rZvYdF2pkPI+6wS9J06d2/cHob4Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
Received-SPF: none client-ip=52.100.138.28; envelope-from=Michael.Roth@amd.com;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 15:33:03
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3493c36f0371777c62d1d72b205b0eb6117e2156:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20201106' into staging (2020-11-06 13:43:28 +0000)

are available in the Git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2020-11-09-tag

for you to fetch changes up to b1b9ab1c04d560f86d8da3dfca4d8b21de75fee6:

  qga: fix missing closedir() in qmp_guest_get_disks() (2020-11-09 14:07:14 -0600)

----------------------------------------------------------------
qemu-ga patch queue for hard-freeze

* fix leaked DIR* descriptor in guest-get-disks spotted by coverity

----------------------------------------------------------------
Michael Roth (1):
      qga: fix missing closedir() in qmp_guest_get_disks()

 qga/commands-posix.c | 3 +++
 1 file changed, 3 insertions(+)



