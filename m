Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A73C41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A802070A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SJvw5wt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A802070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGipe-0001OW-Ui
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGiop-0000a8-Td
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGioo-0006lY-2l
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:38:07 -0400
Received: from mail-db8eur05on2130.outbound.protection.outlook.com
 ([40.107.20.130]:59521 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGioi-0006jh-GL; Tue, 24 Mar 2020 08:38:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TirPdqWf/Aer+5o5gpW8LT6yJL3P+Q3dl5P3qEKAfgQZxJB3sFXRMx+4M4IdsVkNZX3ssNaYY0mLaOPAzDkdUxrOrOyvs5Drpc1fR+yRWKUOvLS/G2qvhGTHVhcUIzxUS7FRkopxMRZtlAc2/jMEgfVZXZPrztxAghGC5OUnUhHr8UZWveK4PafBmAtaKui8+IwScKaeBps7ebloMF59/goIlIdmS+3DNVzgQrEjOWSPGxZTCOPfKfyP5z5CD5Boy0dNq9f0NdAK7yc3xhBoBiuEtWydddqhFhoOtMHI178SnQUxP1vE4el4CzjwpTqafsz6cWTQYmaZVKO18NxYyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WJbemYTBRymSp+hIbgGkufx/ZtRHZFj18dZs/QGYws=;
 b=A9GYgqzDoEKg/CzGhVFhkaa1goZonN+EmF3VDfgT9FQe75mUgkUHn73zEZpnMLzC/mWnJAaQnMvD5uz8BYMIz+G3upXsgL+aY0Xt402BlhHmrN0dgjkPd8Z5L2RF+Bf5i1tdYBLTRqSDR7k/mF/rxZtwIoNS9gvFMuY9AAjfQ+ZMwSc7IiMSUypxl3cHLj0Z0wzaQAtytwrxA3J+kc4aniegr1skRY5qqC1+DK/bTVow7VTfNFnlYh365CIaO3TxdaEC2Fc5O65Fr6SI85xWC53FIgL+9dkvonH2ltvwssYYGL1sUx1gXGXLND6x0mUO7I20DAKf8m4+nqofZjpefg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WJbemYTBRymSp+hIbgGkufx/ZtRHZFj18dZs/QGYws=;
 b=SJvw5wt+/m70fgWgkDEXIIcFLJYY9YeM58OBAZZswkc5D5D3iqVBmeDO8zgMmD9G2zJFcAPeb74+TSbkGbLNksZPfjwgK/tgkQQAMAYUOnevKhR7xtZbu0zgcxEnOmQuWuNwdFOFNdKnYBt9pTjjwIIRGE51fgg1gPqjM6NN77U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5525.eurprd08.prod.outlook.com (10.141.172.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 12:37:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 12:37:57 +0000
Subject: Re: Potential Null dereference
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <CAGT9xrCJSy6yQ48p3hCRuwgV7t8vPS7eo+83_pOiPp0gDOfvvQ@mail.gmail.com>
 <336bbdf8-140a-e884-d5d1-0610a9b1c6a6@redhat.com>
 <20200324095056.GD5417@linux.fritz.box>
 <b432626a-49c9-255e-5e26-b296490a52cd@virtuozzo.com>
X-Tagtoolbar-Keys: D20200324153755089
Message-ID: <c99b61b9-08eb-92cc-5590-e28076b23e43@virtuozzo.com>
Date: Tue, 24 Mar 2020 15:37:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <b432626a-49c9-255e-5e26-b296490a52cd@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR06CA0139.eurprd06.prod.outlook.com
 (2603:10a6:7:16::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 HE1PR06CA0139.eurprd06.prod.outlook.com (2603:10a6:7:16::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Tue, 24 Mar 2020 12:37:56 +0000
X-Tagtoolbar-Keys: D20200324153755089
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91a52bfb-fffe-4ddc-1bb0-08d7cff02e6d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5525:
X-Microsoft-Antispam-PRVS: <AM7PR08MB552531FF0A1E7539C59B10D4C1F10@AM7PR08MB5525.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(396003)(136003)(376002)(366004)(346002)(966005)(186003)(26005)(16526019)(53546011)(66946007)(5660300002)(478600001)(81166006)(66556008)(66476007)(2616005)(8936002)(81156014)(8676002)(3480700007)(956004)(7116003)(6486002)(31686004)(52116002)(110136005)(316002)(4326008)(16576012)(86362001)(36756003)(31696002)(2906002)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5525;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MXeJgAeJFn37WzQ/9ln2D9Md3nDsrwj2VxTNVjtztNFukRgFKFAwT5LOyYBLuD93iYpqfanfMOMUmI070434FN/NpCE9MECJH8/oYC6i6YGMNpvV6ZDNmVvNzPkHaKzB7U5cKydXnXe8blS2hN854OA70myv9M2zkJjc0qBa60OZtmvzXM1dXR6PifbVr/H1CqIOYPckem/VeaZdRI/vcmsS5htf1hZYrAQMdZAkcrN5G06cB0TMJmJyNwwlogdazaEmhi1lb9qJBn/YzK4LwPH1dnE5UVkcPyWtjRhlFt9T/NXpY98Q45OCe6/FkgASaOMZSFB2/LYq6ZpztXrY9h/fm2PpJa5sx+fqhPgg+ATJiUnxIbJ96Od8MMf8+Zarmj69fNA5qFEELwlKW049IrKcfHMXSfLeth8/Vj25gESeJcu+MaUTTUZM8KW+zGiTziafpAEMTFKHLVyg0iFQFvLbRYsAcnMlxS21tsCTXR1AOisMJ2bXIq2iIit1aNLlFqGM+zWqn2tjzVlyGm+W4A==
X-MS-Exchange-AntiSpam-MessageData: S00ahRVeAFET9t1jgkWN92A8rliha91NnLa3q0k0Rf5H2jv3eUQ5mW3mjm7zhoyFKL58kfv2C2hJE2/zU/a6jQ07g3N9ec2QzRFkctnwafZEtp1Q2+m5kSSV/0qplYU/8e94zO7xkfSQIdloWEMXGQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a52bfb-fffe-4ddc-1bb0-08d7cff02e6d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 12:37:57.5731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJFnxh/1ctDxFPym6qHNqCxpYT7VZsSeA9+K3sK4BzMMpBz0xWWRE4vZVb+kfa52cgaN+Eyx/nYp0jcvfcaG7r8cuSWmPR8CFm0rlYpxtF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5525
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.130
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
Cc: Mansour Ahmadi <ManSoSec@gmail.com>, qemu-devel@nongnu.org,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.03.2020 14:59, Vladimir Sementsov-Ogievskiy wrote:
> 24.03.2020 12:50, Kevin Wolf wrote:
>> Am 24.03.2020 um 08:14 hat Philippe Mathieu-Daud=C3=A9 geschrieben:
>>> On 3/24/20 4:05 AM, Mansour Ahmadi wrote:
>>>> Hi,
>>>>
>>>> Nullness of=C2=A0 needs to be checked here:
>>>> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4=
df76/block/commit.c#L221
>>>>
>>>> pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),...
>>
>> Do you have a reproducer? It's not obvious to me how bs->backing could
>> be NULL here.
>>
>>>>
>>>> While it is done at 2 other locations:
>>>> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4=
df76/block/backup-top.c#L113
>>>> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4=
df76/block/mirror.c#L1477
>>
>> Commit 18775ff3269 made the change for mirror, however its commit
>> message is terse and doesn't say anything about the scenario where it
>> would happen. We also didn't add a test case for it. I would have
>> expected that failure to add the backing file would immediately error
>> out and not try to refresh the filename first.
>>
>> backup-top.c has the check from the beginning. I assume it just copied
>> it from mirror.
>>
>> Vladimir, do you remember the details?
>>
>=20
> No :(
> But I believe that "Backing may be zero after failed bdrv_attach_child in=
 bdrv_set_backing_hd, which leads to SIGSEGV." means real problem, probably=
 reproduced on some experiment branch, not on master.
>=20
> Let's try most simple check:
>=20
> apply the following:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> diff --git a/include/block/block.h b/include/block/block.h
> index e569a4d747..dc20b55075 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -298,6 +298,8 @@ BdrvChild *bdrv_open_child(const char *filename,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 const BdrvChildRole *child_role,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 bool allow_none, Error **errp);
>  =C2=A0BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error *=
*errp);
> +void bdrv_set_backing_hd_ex(BlockDriverState *bs, BlockDriverState *back=
ing_hd,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 bool bdrv_attach_child_fail, Error **errp);
>  =C2=A0void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *b=
acking_hd,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Error **errp);
>  =C2=A0int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_opt=
ions,
> diff --git a/block.c b/block.c
> index a2542c977b..21b6124d73 100644
> --- a/block.c
> +++ b/block.c
> @@ -2743,8 +2743,8 @@ static bool bdrv_inherits_from_recursive(BlockDrive=
rState *child,
>  =C2=A0 * Sets the backing file link of a BDS. A new reference is created=
; callers
>  =C2=A0 * which don't need their own reference any more must call bdrv_un=
ref().
>  =C2=A0 */
> -void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing=
_hd,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Er=
ror **errp)
> +void bdrv_set_backing_hd_ex(BlockDriverState *bs, BlockDriverState *back=
ing_hd,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 bool bdrv_attach_child_fail, Error **errp)
>  =C2=A0{
>  =C2=A0=C2=A0=C2=A0=C2=A0 bool update_inherits_from =3D bdrv_chain_contai=
ns(bs, backing_hd) &&
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_inherits_from_recu=
rsive(backing_hd, bs);
> @@ -2766,8 +2766,14 @@ void bdrv_set_backing_hd(BlockDriverState *bs, Blo=
ckDriverState *backing_hd,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> -=C2=A0=C2=A0=C2=A0 bs->backing =3D bdrv_attach_child(bs, backing_hd, "ba=
cking", &child_backing,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errp);
> +=C2=A0=C2=A0=C2=A0 if (bdrv_attach_child_fail) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->backing =3D NULL;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Unpredicted=
 failure :)");
> +=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->backing =3D bdrv_attach_c=
hild(bs, backing_hd, "backing", &child_backing,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 errp);
> +=C2=A0=C2=A0=C2=A0 }
> +
>  =C2=A0=C2=A0=C2=A0=C2=A0 /* If backing_hd was already part of bs's backi=
ng chain, and
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * inherits_from pointed recursively to bs=
 then let's update it to
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * point directly to bs (else it will beco=
me NULL). */
> @@ -2779,6 +2785,12 @@ out:
>  =C2=A0=C2=A0=C2=A0=C2=A0 bdrv_refresh_limits(bs, NULL);
>  =C2=A0}
>=20
> +void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing=
_hd,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Er=
ror **errp)
> +{
> +=C2=A0=C2=A0=C2=A0 bdrv_set_backing_hd_ex(bs, backing_hd, false, errp);
> +}
>  =C2=A0/*
>  =C2=A0 * Opens the backing file for a BlockDriverState if not yet open
>  =C2=A0 *
> diff --git a/block/mirror.c b/block/mirror.c
> index 447051dbc6..907bb2b718 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -675,7 +675,7 @@ static int mirror_exit_common(Job *job)
>  =C2=A0=C2=A0=C2=A0=C2=A0 if (!abort && s->backing_mode =3D=3D MIRROR_SOU=
RCE_BACKING_CHAIN) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *backi=
ng =3D s->is_none_mode ? src : s->base;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (backing_bs(target_b=
s) !=3D backing) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_=
set_backing_hd(target_bs, backing, &local_err);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_=
set_backing_hd_ex(target_bs, backing, true, &local_err);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (local_err) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 error_report_err(local_err);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EPERM;
> @@ -1477,6 +1477,7 @@ static void bdrv_mirror_top_refresh_filename(BlockD=
riverState *bs)
>  =C2=A0=C2=A0=C2=A0=C2=A0 if (bs->backing =3D=3D NULL) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* we can be here after=
 failed bdrv_attach_child in
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_set_backin=
g_hd */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0 pstrcpy(bs->exact_filename, sizeof(bs->exact_fi=
lename),
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> [root@kvm qemu-iotests]# git grep -il mirror ??? | xargs
> 030 041 044 094 109 127 129 132 139 141 151 152 155 156 185 194 218 219 2=
29 235 248 255 257 281
>=20
> check -qcow2 030 041 044 094 109 127 129 132 139 141 151 152 155 156 185 =
194 218 219 229 235 248 255 257 281
> ...
> Failures: 041 141 155
>=20
>=20
> Have several core dumps, look at one:
>=20
>=20
> Wow! These crashes are due to another bug: use after free!
>=20
> Fix it:
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index 907bb2b718..22cf48e46a 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -678,6 +678,7 @@ static int mirror_exit_common(Job *job)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 bdrv_set_backing_hd_ex(target_bs, backing, true, &local_err);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (local_err) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 error_report_err(local_err);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 local_err =3D NULL;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EPERM;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 }
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -716,6 +717,7 @@ static int mirror_exit_common(Job *job)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_drained_end(target=
_bs);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 error_report_err(local_err);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local=
_err =3D NULL;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ret =3D -EPERM;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
>=20
> Roll:
>=20
>=20
> make -j9 && check -qcow2 030 041 044 094 109 127 129 132 139 141 151 152 =
155 156 185 194 218 219 229 235 248 255 257 281
>=20
> Aha, new crashes! Let's look at them.
>=20
> 41 and 155 failed with crash, 141 without but I see "+{"error": {"class":=
 "GenericError", "desc": "Block device drv0 is in use"}}" in its output.
>=20
> Hmm, but all crashes are because of assert(QTAILQ_EMPTY(&all_bdrv_states)=
); in bdrv_close_all..
>=20
> So, we have a problem, but another one..

Investigate it a bit more.

Accordingly to comment, bdrv_attach_child unrefs child bs even on failure, =
so let's do

--- a/block.c
+++ b/block.c
@@ -2768,6 +2768,7 @@ void bdrv_set_backing_hd_ex(BlockDriverState *bs, Blo=
ckDriverState *backing_hd,

      if (bdrv_attach_child_fail) {
          bs->backing =3D NULL;
+        bdrv_unref(backing_hd);
          error_setg(errp, "Unpredicted failure :)");
      } else {
          bs->backing =3D bdrv_attach_child(bs, backing_hd, "backing", &chi=
ld_backing,


- then, all three tests fails, but without crashes. OK.

The only interesting thing is that, it seems that bdrv_attach_child doesn't=
 unref child on all failure paths.

It calls bdrv_root_attach_child..

which doesn't unref child on the path

if (bdrv_get_aio_context(child_bs) !=3D ctx) {
   ...
    if (ret < 0) {
          error_propagate(errp, local_err);
          g_free(child);
          bdrv_abort_perm_update(child_bs);
          return NULL;
    }
}

or am I wrong?



--=20
Best regards,
Vladimir

