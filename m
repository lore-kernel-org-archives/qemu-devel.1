Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5F6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 20:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0BC9206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 20:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y7NHqoBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BC9206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcDdw-00073a-GN
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 15:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kcDcA-0005zz-IE
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 15:18:10 -0500
Received: from mail-co1nam11on2086.outbound.protection.outlook.com
 ([40.107.220.86]:18273 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kcDc6-0005mf-MM
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 15:18:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1JNwbFJ8L+hfF5HxNilebnSZ3c+eGv/1cpYuCs6LZ0BZecmnRsiSnbJgfBoit/PejfNJkzRwlGcOf1UBe+DERmx0Wzof74A1ApjqNlj4NppizTX007j0R2PRA1nKN/DABO1IhPolbKvgRYi625D1nEPaWtcMZAktPCocb3uHPwM1j0ocAlQVoWSoOj3xMlTJKQsRYjZ8x76AZtjO2NFrDQCWZxtAzHmliBFdlvY6QG2XENTMORvknw1rb9OVnU517LQiuVuhwqE2hIInwgObEQQBPAlaS7QBJ08LsjNlgYdEWAlZ+7q4ugFVhzBT8LGPZ0IEtuePyGaEdcZepCCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNEZ8dNCtkW+5KwCYeY/p0U5RVA+c0f3ZZieeCyJF60=;
 b=YcDpV4/2fml0xYCq5lzd2IkybeEIIM46TC1ljbpHe0t7IWFaS9+Z7Kc8pNCvuneedIOOwp8LtoAVYELKF9lcu6kB3taDoFSG7wnh+eGRqbBZnyzAgcJZ19azFwLc/veDt31HWiUiS2KD/w7QYwv6x6B2kf16ymVSI2tG5LyDLU7l7lGvs+Yt0JbQkhPU2HevM5yD44xRQU1VAT8W34f0izHEMtyWR0Z1kCugXHEptKsCCWT0D5rNkvMmlQjkqawsD255i/k8F8Vm4mUurH8rbc331pajsOy3+MaU5Qh5gqzEqWOaCf3rppLtx5lhoywtjQmV4KUzcaC5TKZjuMtaVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNEZ8dNCtkW+5KwCYeY/p0U5RVA+c0f3ZZieeCyJF60=;
 b=y7NHqoBJMvFIbDuz1qR1Kg0xsvW4sMIpAatN8K/tCcurBdviE8d118KLO6oUgqTW6ZlVNn2PBxT8Qkrq/JAHSPegvWdkOyzLsV+KPagY5RMS/O/KmciQNbQpfJOxpfnB+bcZS9oijhPOsygKsxi2VTwmbfsES5byzRhvRSsrBus=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 20:18:03 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 20:18:03 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.2 1/1] qga: fix missing closedir() in
 qmp_guest_get_disks()
Date: Mon,  9 Nov 2020 14:17:22 -0600
Message-Id: <20201109201722.237150-2-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109201722.237150-1-michael.roth@amd.com>
References: <20201109201722.237150-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN6PR01CA0027.prod.exchangelabs.com (2603:10b6:805:b6::40)
 To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SN6PR01CA0027.prod.exchangelabs.com (2603:10b6:805:b6::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.33 via Frontend Transport; Mon, 9 Nov 2020 20:18:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b9bb351c-70b8-479d-fe85-08d884ec8f74
X-MS-TrafficTypeDiagnostic: CH2PR12MB4072:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4072F265EC42FBFED70434DD95EA0@CH2PR12MB4072.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0N4Nkawc7xxrQVPNE49aw43kRw7DetdHxDx5DojCVE2b32udVNlYSykMdWe6jOao92thMi+oTxwctpkxX6+B7RtcaWcFjPIg+aVzWCiVCoB7pokQTHx7C8unxXSYoonnCN4doCQG9qMJnsniAwPes0PMF77I41pEVhgY8hFdsGRUNnQX2gWBcFn0ibOQSBNXjNUyDWdhAiMmRyWn7pkdPDW7GZH+9uh0m1P6n7+uDHN6KprtUtbRSCBDVb5BEQbPoSFItFNuziPIzD/X3GHAzh/tYkimTQr3kTThlNl+q+nLYJon9pIVElz1ncliUW/PicauCJfmpSvWuoYqFw18w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(54906003)(6486002)(6666004)(1076003)(5660300002)(66556008)(8676002)(8936002)(6496006)(6916009)(66476007)(316002)(36756003)(186003)(2906002)(66946007)(44832011)(26005)(52116002)(956004)(4744005)(2616005)(4326008)(16526019)(83380400001)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: aCPaUEfvdIQxkWsn8/9lzWv5SrS4E94HnLMJ2aNXrg4CWbE8NmYgUCGOEnJ4ojg4Jj2Jl7vAd/kSn1XIke4XmGoqd+Es2e5+cW5QgeARJv/MzNZP8k+ofvRGc8BqqIAXRrJ04zkwlzfy1AzzfhRE/NunVp/pChL3q4sxQCe+8eFQ6Mmzl0o92Sk1zp+k+NCB3SvuDwM1z87USJZMpphY/06ZFUCPTF8LJ4uLj814lCuVE3/Jg2clge2+SqLEbnsFcjZu7znoyAUGaHE0ugetYZsb8q/4kZRN4lLUsdECagkD5ZU3hc6LUNpfoSI3f5RLunWIown+Q+w+ikrYPvt3w9Yhny/YsqMkSlLD95MBGp/b9Wlz1Hmxo6n/TCwgiNst4abYe+cxar1UunDrT1/kSxaxUYHelJ/pLSIIe6eQzxNqlcjqSyqnliX4rrc7K/pfZy2MKc6NCBf1axkfkRLl6MZrEc0Y/9bBPQF/qcpI67/hmz2XBOErp0YnUGM4Q4MdpRkK6xoSxhQcC+A8UJj9Q7QgJXikGmfSovd4Ll3HdAg5ipk3z+IxG/7k9erUylFKcnop6LYNkUePgr5dzul7teauEqgDkBWhg0kBVUWFk+UOBO7yEpX1q2W3z4E4yBVPkB4D6aRB8AWNC3XKWiqFAwTQFSnMqLRvF6fTnQ67z/cvr8IJcINTrb4RR6U8OzvfUkFMZjAK9LfmqLAZRzfLNKzCxFNY4sanuv5nGnrlMMKcLxbsgGr4vqyNHzNcz70Yz8v+ycr9//SaG7Km9UtfktnqCnwDGn/CdJRNsQ5/yduFNixlChzeY+ch0reMxHMDemEF7M0zs4Dfei9ySbsCxfaHXyRqlgv8oI5GyIbq/c1s52V6ru9jJhwdcf3yMQwuePNhPAaiKw8KtYOZqHglJQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bb351c-70b8-479d-fe85-08d884ec8f74
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 20:18:02.9431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xLTXtnthBIOHHUy1GIXcJK6QQQ+gmxV8uf7i5E91Pah+NW5j8XrNr+fsFTTqwLMZOLFLSUtNkkXQ6tFlI6p9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
Received-SPF: none client-ip=40.107.220.86; envelope-from=Michael.Roth@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 15:18:04
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We opendir("/sys/block") at the beginning of the function, but we never
close it prior to returning.

Fixes: Coverity CID 1436130
Fixes: fed3956429d5 ("qga: add implementation of guest-get-disks for Linux")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Tomáš Golembiovský <tgolembi@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qga/commands-posix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 3711080d07..12c1ba5ef7 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1443,6 +1443,9 @@ GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
         get_disk_deps(disk_dir, disk);
         ret = get_disk_partitions(ret, de->d_name, disk_dir, dev_name);
     }
+
+    closedir(dp);
+
     return ret;
 }
 
-- 
2.25.1


