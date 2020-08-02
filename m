Return-Path: <SRS0=xk1j=BM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45663C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 12:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E66A2075A
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 12:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hdXteOCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E66A2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2CsO-0007sN-9K
	for qemu-devel@archiver.kernel.org; Sun, 02 Aug 2020 08:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k2Cro-0007TW-HE; Sun, 02 Aug 2020 08:13:29 -0400
Received: from mail-eopbgr60120.outbound.protection.outlook.com
 ([40.107.6.120]:27726 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k2Crm-0007CO-2r; Sun, 02 Aug 2020 08:13:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R973OClladS/X9fX5+Pmas7Kh6IPrGJxxTFmE2tDLnzGEzmdDd1sktSIGkou4PBKdTtuTLwb3LNyOdXKa1AeodulQBINZOb7J2p7Pld7PmJr4odn4D3sAAtkjmcaPQGBo3bdS38as54/of77VP/PC/gTa+kqiehI8e05CxFa1yOAPWTMaqdkmSewYbPZJMORBJZ0tHdn58zRiZmd1mTD/uicCCDJsTfYmfOh59SH432F9ICdU7Dyz/10/XBaTs4MMU/VyM1BN4+142bKjWPjxymXJDv6QYvEfzYSOoNgIRVLTyYmU8T2/InJm4mdQfU1N+z+C/vC89V7KJpGDUJWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB1KLt/XxUajseIxxRAMNfHVy0t5hyPLrQMksaaoCm0=;
 b=E9Pc0w/cNq6phV1V8pa7PEnQ8mQmMp5BvgvcCM/R7lue4uSP3M+OBePQsi/xOCu+zB7siqMabBfz4fT3MUIuUHCQYbFQbvabrTuoBcsBtCT0eC4zGeS6m1mc2/xJDvzzY78GnN14gzuFucirUZTzoHSM4j3DvloY39I5A3V3UcoRmPlJ+enMGII1GNf5ADLdCpio/YN9vdHNfH3MuIvkPP7X4PCe//NIXi5djGDGsOzrtxEQfeddmYgILgyePRmy1UWqZjqnhIPsPzcuSsaJU+okZYZcOrNqroKXs6rb+S186Y1HBLqYxJEiBPzCImxT0KuGB+LfZGY1k7fysRDGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB1KLt/XxUajseIxxRAMNfHVy0t5hyPLrQMksaaoCm0=;
 b=hdXteOCzSi4OPgtjvzNjV0LcOGQyO/jNiaNbOhE4chPihMIPDaWKcBIVO3924R95lkZKDHoYhHXcY2ngt+Sch05b97brllnsMT9Wk5PPRco1qkTTAlOXMsws4yxvqvM+bsFWtpsRV+C06tRCSzRT5slkVHFkCENXVKcwNUzyaDE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4168.eurprd08.prod.outlook.com (2603:10a6:20b:aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Sun, 2 Aug
 2020 12:13:21 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3239.021; Sun, 2 Aug 2020
 12:13:20 +0000
Subject: Re: [PATCH v7 46/47] iotests: Add test for commit in sub directory
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-47-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <afcef2c8-a2cb-95dc-32e2-94fb13094124@virtuozzo.com>
Date: Sun, 2 Aug 2020 15:13:15 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-47-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18)
 To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.13 via Frontend Transport; Sun, 2 Aug 2020 12:13:19 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba9aaafc-ff07-4176-f884-08d836dd7244
X-MS-TrafficTypeDiagnostic: AM6PR08MB4168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4168459651DA2567E66BA105F44C0@AM6PR08MB4168.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K6OrZvxtZMJoCJQFCogRahtttahjhyMr1AjjkiUpGJ2peBDf3Vl5vNgvatnJv4j2UCIAi6OuUr21k12t5xo4M3/NNi3V0QOPRJIWQ9pwopnktpmimGCFGHkrtB44iLkIiFVqNc5nWJJivJIqu3pHqpt5LWM45XzzjU5EFmOqmwEQ7TIAB8hEQY79nPyqDGTJsdTtMhAzBWJU+vn7ixyB5G5HfgTOBoX66umBVjBdAlDelci8XcOWCJg13ZXc/rzQq3N5/mLxn9ChorFvZ0mlGo1Tk2l2d+exEnLb0gN9Vw1+Z+TXYbqi+z7p+PGWpfC7IWpcSCH6QbvLST/cIq/cqtp5w21t3iOnUM99mzLWhyBkFgqrTUJeuqXPjfQQhyeoWqM0VXFFI9SwxbbzLZjphQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39830400003)(478600001)(26005)(6666004)(6486002)(2906002)(44832011)(6512007)(316002)(186003)(16526019)(54906003)(8676002)(52116002)(5660300002)(83380400001)(6506007)(66946007)(31696002)(53546011)(8936002)(66476007)(66556008)(36756003)(4326008)(2616005)(956004)(86362001)(31686004)(21314003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nzQ+Uj9Hxgqd3KiExJdIvHTHxN1JJy5URPvYdRgMV8Y+SPdNkajFJAJDsoKWjm3rhqDxb/59+1tqlbzD0yOSWf7xorGes6WSMqYRobF171zLDu/twuoai0JnvYVhiULYr1MWxJ18DmVc2BN0CXijPYvmpD/iTfUrkpOgced1DM6fV15E6bYO9ZkIQcKf3+ApMPOhDAqJAt5QBIe5SOPXzirZZdap0s9LGy45CU56zkGIINTE1oEM2incw5gVTWzbGgkxlwAzqdcGU8p0U+86fSZUW+gOgfq6IKC8gu370wjotCzN+5P4PDw5uxnXLSLKjG7QKzgIk9lxz6bN/ceuI0Dc9/ZCEWmKVpWYqSceohnGK741X+EM3vBUn2NOXi7slklm+lqwwrr7UFj5QC/rtSjEZ7y0yz1vKL13VruEEFJgkY3EX1I3Lb0l+ZHJHv6WxPCJeWwz1Y0tOHenTswwNYIFs+TNDZiOVn2Wc0beH9zn378PR2IcDk8ufoMXSa2cd6sJ8FiIBJ6Qbe5KiqLqdasng0S4aIwsq8RsbaDEgJWebp9JSaFylxNNz/ltNPKCz7eJl1RWv+3V4/+n47ir11+YD5Zt2dGu41xczv+m0d/Ztoq71QFyewdjvlG4LXZ8IgZq9QMyia7jiO7+HPw+yw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9aaafc-ff07-4176-f884-08d836dd7244
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2020 12:13:20.8728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wE0bH6jv+4F7afusTo35jeZ22aKQYDOAVRi9IlTp1MC0yonHaDS0MWVQcu+DiDD6SnIqxRG06kf9df8CAe065z8cHdkL6piN0oAHfJqEQxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4168
Received-SPF: pass client-ip=40.107.6.120;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/02 08:13:22
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.06.2020 18:22, Max Reitz wrote:
> Add a test for committing an overlay in a sub directory to one of the
> images in its backing chain, using both relative and absolute filenames.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/020     | 44 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/020.out | 10 +++++++++
>   2 files changed, 54 insertions(+)
>
> diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
> index 20f8f185d0..d5b5d34058 100755
> --- a/tests/qemu-iotests/020
> +++ b/tests/qemu-iotests/020
> @@ -31,6 +31,11 @@ _cleanup()
>       _cleanup_test_img
>       _rm_test_img "$TEST_IMG.base"
>       _rm_test_img "$TEST_IMG.orig"
> +
> +    _rm_test_img "$TEST_DIR/subdir/t.$IMGFMT.base"
> +    _rm_test_img "$TEST_DIR/subdir/t.$IMGFMT.mid"
> +    _rm_test_img "$TEST_DIR/subdir/t.$IMGFMT"
> +    rmdir "$TEST_DIR/subdir" &> /dev/null
>   }
>   trap "_cleanup; exit \$status" 0 1 2 3 15
>   
> @@ -134,6 +139,45 @@ $QEMU_IO -c 'writev 0 64k' "$TEST_IMG" | _filter_qemu_io
>   $QEMU_IMG commit "$TEST_IMG"
>   _cleanup
>   
> +
> +echo
> +echo 'Testing commit in sub-directory with relative filenames'
> +echo
> +
> +pushd "$TEST_DIR" > /dev/null
> +
> +mkdir subdir
> +
> +TEST_IMG="subdir/t.$IMGFMT.base" _make_test_img 1M
> +TEST_IMG="subdir/t.$IMGFMT.mid" _make_test_img -b "t.$IMGFMT.base"
> +TEST_IMG="subdir/t.$IMGFMT" _make_test_img -b "t.$IMGFMT.mid"
> +
> +# Should work
> +$QEMU_IMG commit -b "t.$IMGFMT.mid" "subdir/t.$IMGFMT"
> +
> +# Might theoretically work, but does not in practice (we have to
> +# decide between this and the above; and since we always represent
> +# backing file names as relative to the overlay, we go for the above)
> +$QEMU_IMG commit -b "subdir/t.$IMGFMT.mid" "subdir/t.$IMGFMT" 2>&1 | \
> +    _filter_imgfmt
> +
> +# This should work as well
> +$QEMU_IMG commit -b "$TEST_DIR/subdir/t.$IMGFMT.mid" "subdir/t.$IMGFMT"
> +
> +popd > /dev/null
> +
> +# Now let's try with just absolute filenames
> +# (This will not work with external data files, though, because when
> +# using relative paths for those, qemu will always resolve them
> +# relative to its CWD.  Therefore, it cannot find those data files now
> +# that we left $TEST_DIR.)
> +if _get_data_file '' > /dev/null; then
> +    echo 'Image committed.' # Skip test
> +else
> +    $QEMU_IMG commit -b "$TEST_DIR/subdir/t.$IMGFMT.mid" \
> +        "$TEST_DIR/subdir/t.$IMGFMT"
> +fi
> +
>   # success, all done
>   echo "*** done"
>   rm -f $seq.full
> diff --git a/tests/qemu-iotests/020.out b/tests/qemu-iotests/020.out
> index 4b722b2dd0..228c37dded 100644
> --- a/tests/qemu-iotests/020.out
> +++ b/tests/qemu-iotests/020.out
> @@ -1094,4 +1094,14 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=json:{'driv
>   wrote 65536/65536 bytes at offset 0
>   64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   qemu-img: Block job failed: No space left on device
> +
> +Testing commit in sub-directory with relative filenames
> +
> +Formatting 'subdir/t.IMGFMT.base', fmt=IMGFMT size=1048576
> +Formatting 'subdir/t.IMGFMT.mid', fmt=IMGFMT size=1048576 backing_file=t.IMGFMT.base
> +Formatting 'subdir/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=t.IMGFMT.mid
> +Image committed.
> +qemu-img: Did not find 'subdir/t.IMGFMT.mid' in the backing chain of 'subdir/t.IMGFMT'
> +Image committed.
> +Image committed.
>   *** done


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


