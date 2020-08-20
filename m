Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D689EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A677023102
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HSE78c2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A677023102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8mrA-0000Iy-S4
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8mob-0005SN-RX; Thu, 20 Aug 2020 11:49:22 -0400
Received: from mail-am6eur05on2134.outbound.protection.outlook.com
 ([40.107.22.134]:39969 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8moY-0003CK-KS; Thu, 20 Aug 2020 11:49:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6E2Y8AkCjUg1RLPaYQv5aIHJvFzpNrE7Va2Z+yVhtm6uyNXubcqjHz5ZaKJxY4v/Hgt8zC2Ao7aG+NBO/IWQg5oJmG8xWQFKJbOjVc9V/1QU1n+B4cVzAvv9/lMvZ7LpETc3JcHuqFdGxBMQ7RBekh/x+co9v3/qnWKFV4YHzNoXljLHTyCL5rNfabnf5e31rzSnrbl1SFH6ND2Hv/D4uw3dhmf52P4rWypWcn/2jaKXSmLUnI8+zgpkVfbmNFcAgdglKaF6y+KeAvMYyQwc13Wv20XjXnY0muraHWM1f5GhoGedRcqmCxkLLTJqlrW8JISGy0kvfKga4RqAvMyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWhqiu87IxIRiypyTP+ORm5eA9Msd08cnBE36jSQelE=;
 b=G386Wt/9EYqrQzYWKsoqdV43LRp76j1f97ii5oE1cgSiOq0c4O9oN2y/hQZc3nK4CoPWbIcj+bdChYIammvole/3cWfwz/0l3CyLUQaSf0XIjxDInuoj9jRmFTMZ6U7jLsjAdjTHXhJOSZUEtWK2dFPZPpUjN1ElzA2favV56LX5hReh9T/GLDe3Go7H56ATGMB4Ya5piLdV/MC18Qm+4wcl51ERMk5RlRbstnav1BVryEBXHggjsR1KHp6goIxJe7n3jQTcMDcOB7my57AnEKWA/eSyyONUYcMfv7pyihmQCncdU4tRy546ZIe/ICWU2kxI7G2/P+GlGGknVGF1AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWhqiu87IxIRiypyTP+ORm5eA9Msd08cnBE36jSQelE=;
 b=HSE78c2JJFHS8C9aqUSrBCz7CV+vINg47QUWAeY1plFM31BriAY5G65euwm8XfCF7a5Xc8yAroJge0zCWelGYa/L0kXtuEuIjJkPxnWp/jjb/kyylyuaaA+HPsBW0br9yV8hr+y3WehdVqz8IEJTcXSePnb7Rm3+9lzWkouPiVc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4168.eurprd08.prod.outlook.com (2603:10a6:20b:aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 15:49:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 15:49:14 +0000
Subject: Re: [PATCH v4 4/4] iotests: Test node/bitmap aliases during migration
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200818133240.195840-1-mreitz@redhat.com>
 <20200818133240.195840-5-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b1ab8e28-f5ad-1cde-a706-02e4b32e1a0a@virtuozzo.com>
Date: Thu, 20 Aug 2020 18:49:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200818133240.195840-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0134.eurprd07.prod.outlook.com
 (2603:10a6:207:8::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM3PR07CA0134.eurprd07.prod.outlook.com (2603:10a6:207:8::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.10 via Frontend Transport; Thu, 20 Aug 2020 15:49:14 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d02d414b-329b-4f70-3b0d-08d845209706
X-MS-TrafficTypeDiagnostic: AM6PR08MB4168:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4168F84AB0530073B1A7863BC15A0@AM6PR08MB4168.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFc5BijwAA3cjkmygaGKPeu3TSgqdbsQobN4x85pGKAQFes+Jpp3/G14RcL2nH69/Tx210lNrWK6bHsF8nrgdV8P+81ahQDSGz9j09MiqSfpADbLWUXA4kbCUy5mxqSK6yLzrPQATCguc1mpj8CRLfHUOjmxxBnltR33ZglNCDR0r2qPfD5IovELkXOB5rHmUxfeWvBDmR+imHZ/Q0Rjmyv33a36byhOuJSvVoVa75+G07693HYnd056BMj+51CGV5ajphUtdjr28vtx0YtuJk9LOj2pXVBsYKUY+q6tAhRtYgf5PMTTpAMskVW7qxMKPDuGh717JY/GC6hV7EHA+gfnHvMiCHXWh2DXGQARzAurFN8H6wALIu1EIy0ywX7Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(376002)(346002)(136003)(396003)(366004)(8676002)(83380400001)(26005)(6486002)(31696002)(8936002)(36756003)(86362001)(956004)(66946007)(66556008)(66476007)(186003)(2616005)(16526019)(2906002)(478600001)(52116002)(5660300002)(4326008)(16576012)(316002)(54906003)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WlF/tgyASE2+wKck37eNua40rAELeFk48S8WqaGBOcSwPMuDgUcwlbvFVsRXVNNVAWEY+dSav2lPr96+JHm5zmDpWcObjgIIOLvzJpbhL6KWqhsxKd6avRk6TJFwAaGXrCZAwynITXJc/Od/rWUUz2TUUTNBXInQjLSuwVXFqkwlBuL1h9C9+Di2DoBsFkgbMZAOI8Zd39Vbvx1DcESvKmsRtbm5CsNmn5JBFBThLxeGGD92CcE1QB86u7Fw75BTOlPM8nPfehWUlMCcig2+eZatLfzo3v8uJdZ1oyZf49MqYK+41FF4iPzrScEuEm0ANKXcpeCzNmGhfeoJYiFJAhdOt3DQaoSrxSaMauG59ERMK5q8tQk+NWB/TeupX7VsmHfk4ZYQKfDORBu0D+HwL1GcABoyDg2N6n6E1D3+GdKdElNGW6hgq/tiQvLcYKKYOEnwa7Hqm/NPGCbYx//xnBy/SW/Raxg4y5i0HCLkdgVzBDJG7w1IKb82dj1zRbhR8N9Vtv1svc3lm4322+YpG+d4tNroOoKExLE5SLFrHd1fV9lJzLJUad429+Pc+5U6VFvccdH9Px2GeDjUrIIDz8CtRbVy5Ubh0oXxTZJG6Dt7jhgNY0HBL20rC8UNcZUpQiYzJ7EXzUfglXhyCNd4Rw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02d414b-329b-4f70-3b0d-08d845209706
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 15:49:14.9088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbyL/rlfvdaLw8LT8XtUZCok0WshYu88JemBk/lGqPaCnWsqqplJG0G7SIx/zqj7oFq/3eNlpTvFbprklyS4FDUYPMXH8EbkFLr1eFgbojQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4168
Received-SPF: pass client-ip=40.107.22.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 11:49:16
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

# MYPYPATH=../../python/ mypy 300
300:154: error: Item "None" of "Optional[Match[Any]]" has no attribute "group"
Found 1 error in 1 file (checked 1 source file)

- the only complain. Suggest a fix:

diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
index c6d86b1dbc..0241903743 100755
--- a/tests/qemu-iotests/300
+++ b/tests/qemu-iotests/300
@@ -148,11 +148,11 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
              result = vm.qmp('human-monitor-command',
                              command_line='info migrate_parameters')
  
-            hmp_mapping = re.search(r'^block-bitmap-mapping:\r?(\n  .*)*\n',
-                                    result['return'], flags=re.MULTILINE)
+            m = re.search(r'^block-bitmap-mapping:\r?(\n  .*)*\n',
+                          result['return'], flags=re.MULTILINE)
+            hmp_mapping = m.group(0).replace('\r', '') if m else None
  
-            self.assertEqual(hmp_mapping.group(0).replace('\r', ''),
-                             self.to_hmp_mapping(mapping))
+            self.assertEqual(hmp_mapping, self.to_hmp_mapping(mapping))
          else:
              self.assert_qmp(result, 'error/desc', error)
  
===

# flake8 300
300:24:1: F401 'time' imported but unused
300:34:1: E302 expected 2 blank lines, found 1
300:42:67: E502 the backslash is redundant between brackets
300:47:67: E502 the backslash is redundant between brackets
300:67:53: E502 the backslash is redundant between brackets
300:122:9: E125 continuation line with same indent as next logical line
300:134:9: E125 continuation line with same indent as next logical line
300:185:52: E502 the backslash is redundant between brackets
300:186:72: E502 the backslash is redundant between brackets
300:285:77: E502 the backslash is redundant between brackets
300:305:77: E502 the backslash is redundant between brackets
300:306:78: E502 the backslash is redundant between brackets
300:330:77: E502 the backslash is redundant between brackets
300:350:77: E502 the backslash is redundant between brackets
300:385:57: E502 the backslash is redundant between brackets
300:386:59: E502 the backslash is redundant between brackets
300:387:67: E502 the backslash is redundant between brackets
300:412:78: E502 the backslash is redundant between brackets
300:425:78: E502 the backslash is redundant between brackets
300:435:78: E502 the backslash is redundant between brackets
300:436:76: E502 the backslash is redundant between brackets
300:451:66: E502 the backslash is redundant between brackets
300:473:78: E502 the backslash is redundant between brackets
300:474:79: E502 the backslash is redundant between brackets
300:488:78: E502 the backslash is redundant between brackets
300:489:77: E502 the backslash is redundant between brackets

- I post it just because ALE plugin in vim highlights all these things for me. Up to you, I don't ask you to fix it.

18.08.2020 16:32, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/300     | 595 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/300.out |   5 +
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 601 insertions(+)
>   create mode 100755 tests/qemu-iotests/300
>   create mode 100644 tests/qemu-iotests/300.out
> 

[..]

> +    def test_alias_on_both_migration(self) -> None:
> +        src_map = self.mapping(self.src_node_name, 'node-alias',
> +                               self.src_bmap_name, 'bmap-alias')
> +
> +        dst_map = self.mapping(self.dst_node_name, 'node-alias',
> +                               self.dst_bmap_name, 'bmap-alias')
> +
> +        self.set_mapping(self.vm_a, src_map)
> +        self.set_mapping(self.vm_b, dst_map)
> +        self.migrate()
> +        self.verify_dest_error(None)

Hmm, probably verify_dest_error() should be called from migrate(), as you call it (almost) always after migrate()

> +
> +

[..]

> +    def test_unused_mapping_on_dst(self) -> None:
> +        # Let the source not send any bitmaps
> +        self.set_mapping(self.vm_a, [])
> +
> +        # Establish some mapping on the destination
> +        self.set_mapping(self.vm_b, [])

Seems, you wanted to specify non-empty mapping for vm_b, yes?
With any non-empty mapping here, just to better correspond to the comments:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

(or keep this case with both mappings empty, and add one similar with empty mapping only on src)



-- 
Best regards,
Vladimir

