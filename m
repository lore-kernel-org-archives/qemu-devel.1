Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A90C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ED0C2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IYQTCmZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED0C2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03Ba-0004Hs-LB
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k03B0-0003nu-3w; Mon, 27 Jul 2020 09:28:22 -0400
Received: from mail-eopbgr10106.outbound.protection.outlook.com
 ([40.107.1.106]:12385 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k03Aw-00074Y-WB; Mon, 27 Jul 2020 09:28:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKLO5q3aLqCu7RJHtdxv7uKSKeDG6WsjssXsr9jjt5hk1BvvP5ziWCkcjs/3IWRy7fVqXNU9aflftzLtUyrz4e9OWjpmH/nfeBk/7gS3VGuzRsh9EYBy7a3aETD6+v8EgQHh81L0LGCnJKBdQhloVh1WmdnHcEDw43BsXaHGYVj5tC1Zhl2h9BFX+5sL9y8+7DYwSNu3osymimGX0Zy8/AbAeB0w2NACszvXFojWeMuY6WSaOQriSSyX1MSQol86qVmDe4jdWMP2ZTuUt7hFQx1tE24vHMTyOr5qj7dOj6cp0Ft/RLRa1lmuN550jWK4FqaZvyVCrmRWWZEMo21vqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5AYrrVJYZsPDRTmWNH6bA68k9RPb33EaiGnh7xtu/I=;
 b=hOHyvVQAZcBwgqz3n1hvtu6CKT+FyPTl0d7L7e5KkoJ3ERNOk1/Et1v7IgPVL1/ZAD7ileLKQRfwJcjGHBTXN5UEQD4itova2i6MNAKs4TX+2w0XPYfDqz2+PIjGH8Aup4CGPViLkVE5I7JQh9uSo5Y4rDDCn6mBNfM3B0qvmG6+oXU5CZ9LYMQoQi6fhiFOa/CQS9sNl3J/a+fxLUDIvteV2XD8+kulKj5gWmUPV6iz8AdlHtP8crVsp/o5z4+sV8Z4HzW4+GMi6nZqHIBWtBTrsL9LeqNk468nDI/KQsczX2CYZEHw1Eca3FO9xYHxMyM3Ja5srQKoKt3k4axb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5AYrrVJYZsPDRTmWNH6bA68k9RPb33EaiGnh7xtu/I=;
 b=IYQTCmZmWu4eoyTPN8k81Jk4yxJ5gqmfKDlL0y5v59S3KTptFWanuTbqD2YFIS3V5NoiRcqnZpklRrBdzYqYSyNHzL9r1P7rW0+ZjxBV79q8sKISmM5H1/UNfJNRRVyXW+DmcEAl3XdH48R2wzzCHjFWpCI2Pz6CqbuV26qZNGU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3224.eurprd08.prod.outlook.com (2603:10a6:209:47::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 13:28:14 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 13:28:14 +0000
Subject: Re: [PATCH v7 42/47] iotests: Test that qcow2's data-file is flushed
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-43-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <081ee25b-556d-0f52-a471-ccb773eb04e3@virtuozzo.com>
Date: Mon, 27 Jul 2020 16:28:04 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-43-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR03CA0059.eurprd03.prod.outlook.com
 (2603:10a6:207:5::17) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM3PR03CA0059.eurprd03.prod.outlook.com (2603:10a6:207:5::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Mon, 27 Jul 2020 13:28:10 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6807b232-4aba-4310-cd8f-08d83230ea52
X-MS-TrafficTypeDiagnostic: AM6PR08MB3224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB32245A3D9D8AC370447B2B19F4720@AM6PR08MB3224.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H9ZBwiNAkz/fuwrk/S126OOUQ/jAevIdzOsN73z28oGwZTFZEnZ/sYDv2MKBmVfBSTzjYGUL6rjKTvnT2xeqnRt4oj5tMe4b01NVrdg3DhyQ3XHjvSJVEsVQ05CeJupdNptZnwskcqpBD7n8nCCZ3pBWAiiFO7+4zRkidzsxWQKogmt9WyEh0MjrJPuOOk21+LzXXplErb0AdpnlcbtY5XS/5hnXqIJOL00OgtLI/F/Byqv4sVehGzORr5RX8GVhusupsfa2xmEYjKnQaopqihJqhiI5GCMPYiDa19vilX6HKxUaG09DAtFmKIxjwABAg3IC/1s7HC8fCfTwRoTNLPlJOJs1p6ed8NOIsPFR41uZ9LNi9ZM0BpZktls16ad+getJu55bZzBSCH2cw9vDUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39840400004)(6506007)(5660300002)(66476007)(478600001)(54906003)(66556008)(53546011)(6512007)(66946007)(44832011)(316002)(36756003)(956004)(6666004)(26005)(52116002)(2906002)(2616005)(6486002)(186003)(16526019)(8676002)(4326008)(31686004)(8936002)(31696002)(86362001)(21314003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: AD7vOUhh0WIiLJL+fluF8zCRxmLabbt28keRNP6JhVIzAFBFkcieRJg4FRwgQegPvjtksmbbrqgv4J1loSuiy1Te62C6cpBf8axUmVmKPN+4Xd3qNeBSylIiDBjf354Q7IyIq+LwCOD25uC5WbjgjB8F1Oc+XDKqTWdgG4+BPxjrcXyrkQD5m4Jf0gkoHul2hd+aGy/dJLnXBAkofaZV2RG0b3QNIXYZ4ge6NR92ghVB/A8pMbyaSszO5NWJ/izojUhW9ssiCBxUx+0u+CH7GQrn4mReIop0GVq2W4OW3GoSdXTQ7C/V5HS8ZuV2hbvuBQvatt98ncyinbWFvF2HFtrKImhqz4zKPwBASjT8pW0Fl//nA2cOdBCDBupjf9hWuRJTfaNnvrcJDB8XoX368bLem1WssuVwXWh6hLRvjaKSx00Lkkh6lqWVE/uL94MZArPXLAh8E4wTvPq7KEbQ0gaH+2+EeTy204MYe4O+VGWbi4FhFNRHG4zRW0xEaX1x
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6807b232-4aba-4310-cd8f-08d83230ea52
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 13:28:14.6407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsNAgrAasSeoLBOyjQ7ALmo00CWpQKsKW07D0fYkg9JTWDNWTtUZwnkwMPyfCiDYbOWpGZQUUsKtckWMI6G9y+M3h/RAPbPcRplHoPOEWfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3224
Received-SPF: pass client-ip=40.107.1.106;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 09:28:16
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
> Flushing a qcow2 node must lead to the data-file node being flushed as
> well.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/244     | 49 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/244.out |  7 ++++++
>   2 files changed, 56 insertions(+)
>
> diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
> index efe3c0428b..f2b2dddf1c 100755
> --- a/tests/qemu-iotests/244
> +++ b/tests/qemu-iotests/244
> @@ -217,6 +217,55 @@ $QEMU_IMG amend -f $IMGFMT -o "data_file=blkdebug::$TEST_IMG.data" "$TEST_IMG"
>   $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n -C "$TEST_IMG.src" "$TEST_IMG"
>   $QEMU_IMG compare -f $IMGFMT -F $IMGFMT "$TEST_IMG.src" "$TEST_IMG"
>   
> +echo
> +echo "=== Flushing should flush the data file ==="
> +echo
> +
> +# We are going to flush a qcow2 file with a blkdebug node inserted
> +# between the qcow2 node and its data file node.  The blkdebug node
> +# will return an error for all flushes and so we if the data file is
> +# flushed, we will see qemu-io return an error.
> +
> +# We need to write something or the flush will not do anything; we
> +# also need -t writeback so the write is not done as a FUA write
> +# (which would then fail thanks to the implicit flush)
> +$QEMU_IO -c 'write 0 512' -c flush \
> +    -t writeback \
> +    "json:{
> +         'driver': 'qcow2',
> +         'file': {
> +             'driver': 'file',
> +             'filename': '$TEST_IMG'
> +         },
> +         'data-file': {
> +             'driver': 'blkdebug',
> +             'inject-error': [{
> +                 'event': 'none',
> +                 'iotype': 'flush'
> +             }],
> +             'image': {
> +                 'driver': 'file',
> +                 'filename': '$TEST_IMG.data'
> +             }
> +         }
> +     }" \
> +    | _filter_qemu_io
> +
> +result=${PIPESTATUS[0]}
> +echo
> +
> +case $result in
> +    0)
> +        echo "ERROR: qemu-io succeeded, so the data file was not flushed"
> +        ;;
> +    1)
> +        echo "Success: qemu-io failed, so the data file was flushed"
> +        ;;
> +    *)
> +        echo "ERROR: qemu-io returned unknown exit code $result"
> +        ;;
> +esac
> +
>   # success, all done
>   echo "*** done"
>   rm -f $seq.full
> diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
> index dbab7359a9..7269b4295a 100644
> --- a/tests/qemu-iotests/244.out
> +++ b/tests/qemu-iotests/244.out
> @@ -131,4 +131,11 @@ Offset          Length          Mapped to       File
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data
>   Images are identical.
>   Images are identical.
> +
> +=== Flushing should flush the data file ===
> +
> +wrote 512/512 bytes at offset 0
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +Success: qemu-io failed, so the data file was flushed
>   *** done


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



