Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CDEC34053
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D9A24654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dIybEDwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D9A24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Ru8-00016n-Ur
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4RtE-0000CL-Qz
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4RtD-0007xw-Ha
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:07:56 -0500
Received: from mail-vi1eur05on20710.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::710]:34686
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j4RtC-0007ws-Ve
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:07:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1g3n+O7rY515LBq0IlmLVX8cLMgXIYku86P6PZIoxYgp3Y34nF9Y5z6VSFErUGMjzNZXSHoR8BiAER5JxYVtIMe6kxIBsS1Eq0n+ImuGjZD3JaVDhssdq34s+7kQVMKYxz9y5XqiiWic+D2UJj4Az4LNr3WWytcjp9wQeAoILE9AaYBuLLZaDKA5ts4wRcT5eYjP/ZwwDiKVg6Y/drlRLbEKYZSyRxJVKHv6WH7+Qd4NFaYqQDy7SKgwOC6fC1O+aSjk6g+r38KwzZsXo8R4PmFb4iWyVd52pBW5lcQ19ddxzLuK57Yc+cDlOv6PpXc794tlOEZ542NKW2AX6eVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm1fdhpLT42sHuPmhR7vQ6n1nG/W7bvlytsH57vwABQ=;
 b=GLc5HxjlrmfGj/Y/V36ZINlkjXhvRJhjaNh7ODp8inGlI1ZznLf9ZyQ2kXwR3RfMpFa7OZFXjlLpXlspMyAweQZg868ZV7a/m3/PD5SMl1ox+KShz/+7Mk89capmoVIas8DZdAIj/jE901/jGdqUo7MabDELAL8W8OBPgQnNwjJUSukpJrbf5arEyEAIHVLCahZgRrYC4W7llLgA+hjF5Ut4cG0z7NGaJTwq+W38oeV+Bhd5gvu0J2W6cLvUzhaSqGZwGDW3VNYEHZajMz0z16GvcljTLwCwojgWjbyzPprSfVT4SjkOLcqhVzresXUKyEF1aeOnMJMKJOT1aCeIOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm1fdhpLT42sHuPmhR7vQ6n1nG/W7bvlytsH57vwABQ=;
 b=dIybEDwQ/zxY1Ht2aX3kfst1WupINkfUMbWiAUqZYg2UTdS64vydSfeLH2N4reGmzrbrWfYCf+ETy7XkRHvaeI4WQ49JEqo7uXDzGvbhQ5ZaNbe4cpFhMhVyOG50iUGv4ePuxnbxbPwVlHux9fsVBp5UYCSHMQygaY4Xx6gVZ74=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5061.eurprd08.prod.outlook.com (10.255.34.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 16:07:51 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 16:07:51 +0000
Subject: Re: Race condition in overlayed qcow2?
To: dovgaluk <dovgaluk@ispras.ru>, qemu-devel@nongnu.org, mreitz@redhat.com,
 kwolf@redhat.com
References: <2fb9fb4840d5aa92a716487f83ceb36c@ispras.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200219190748840
Message-ID: <0afe41fc-cc09-5682-a667-574c44fd6da3@virtuozzo.com>
Date: Wed, 19 Feb 2020 19:07:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <2fb9fb4840d5aa92a716487f83ceb36c@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0102CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::44) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0102CA0031.eurprd01.prod.exchangelabs.com (2603:10a6:7:14::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Wed, 19 Feb 2020 16:07:50 +0000
X-Tagtoolbar-Keys: D20200219190748840
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c425ce37-29a4-4f4a-ac0d-08d7b555dee7
X-MS-TrafficTypeDiagnostic: AM6PR08MB5061:
X-Microsoft-Antispam-PRVS: <AM6PR08MB50616505B14E066CBCB24798C1100@AM6PR08MB5061.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(366004)(396003)(346002)(136003)(189003)(199004)(2906002)(36756003)(31686004)(6486002)(52116002)(316002)(66946007)(31696002)(16576012)(956004)(2616005)(478600001)(66476007)(66556008)(86362001)(16526019)(186003)(26005)(81156014)(8936002)(5660300002)(8676002)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5061;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQPREgfr52+068O4LYlNzCeXvFLsNA0JGmqN8cu89FGBv/phlJicMK4+57n8rOWDhKxCT0Vzugq3Ebq2liDIpBScJtXDPsaAAUFnpiawhfVwTd5k0WwMoVGFs3lDaoBoRLr2pvyo2F8IBg5uPmvkV/eVzbmmEkyVJnRCe+zbsVCWoCLzQr+QsAFEhJzGCNsHlY6WKW3+fmSkbXeR1kpofYorEEKdkkJGKnkDpWnAku+72jKshJiLIiKAHUPOL0fUs5XjqsIsVLSQhxF2Cn8Vx7cQIIBwATZFm18ApfxAFJqOYqBCLj6NBNhIdFOgzhP3n8HSDgBnks/LiTS9w74D4cVwuK3Hs4RDiVdjnpjuYi5Sbjhdv+zB1uu0z0+NhSJ03wNEh7hAii9GM9IQt1TMq0zXx2DplwfPfb73l0/ITFc6mJnI/Cza2xVmXsSJx88P
X-MS-Exchange-AntiSpam-MessageData: 8APuNPm67tZZWIR4x5aKUCeZkpz3lprgfmP6qv4Zk2jaUUEp9rFgK7FlW/Aa5O7HCeaWA5nYwv5NLwOJbCywXUoxnw7giSupmnSWJv+GAYq0Fl3RUeQNIUeI9qX6vT2XW9m9U604oxsh33oSUeUtIQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c425ce37-29a4-4f4a-ac0d-08d7b555dee7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 16:07:51.4386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsH3CBq9K0JlUFuLYByj3fjGd907OfOVAKoEikH4ie2qhPXR7n9dUcsWr2bIztlHavfKBi/6HuVnoZhfO21ximABOlkZKXtCwy95fMtAZJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5061
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:7d00::710
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

19.02.2020 17:32, dovgaluk wrote:
> Hi!
>=20
> I encountered a problem with record/replay of QEMU execution and figured =
out the following, when
> QEMU is started with one virtual disk connected to the qcow2 image with a=
pplied 'snapshot' option.
>=20
> The patch d710cf575ad5fb3ab329204620de45bfe50caa53 "block/qcow2: introduc=
e parallel subrequest handling in read and write"
> introduces some kind of race condition, which causes difference in the da=
ta read from the disk.
>=20
> I detected this by adding the following code, which logs IO operation che=
cksum. And this checksum may be different in different runs of the same rec=
orded execution.
>=20
> logging in blk_aio_complete function:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log("%"PRId64": blk_aio_=
complete\n", replay_get_current_icount());
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMUIOVector *qiov =3D acb->r=
wco.iobuf;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qiov && qiov->iov) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_=
t i, j;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint6=
4_t sum =3D 0;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int c=
ount =3D 0;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (=
i =3D 0 ; i < qiov->niov ; ++i) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 for (j =3D 0 ; j < qiov->iov[i].iov_len ; ++j) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sum +=3D ((uint8_t*)qiov->iov[i]=
.iov_base)[j];
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ++count;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_=
log("--- iobuf offset %"PRIx64" len %x sum: %"PRIx64"\n", acb->rwco.offset,=
 count, sum);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> I tried to get rid of aio task by patching qcow2_co_preadv_part:
> ret =3D qcow2_co_preadv_task(bs, ret, cluster_offset, offset, cur_bytes, =
qiov, qiov_offset);
>=20
> That change fixed a bug, but I have no idea what to debug next to figure =
out the exact reason of the failure.
>=20
> Do you have any ideas or hints?
>=20

Hi!

Hmm, do mean that read from the disk may return wrong data? It would be ver=
y bad of course :(
Could you provide a reproducer, so that I can look at it and debug?

What is exactly the case? May be you have other parallel aio operations to =
the same region?

Ideas to experiment:

1. change QCOW2_MAX_WORKERS to 1 or to 2, will it help?
2. understand what is the case in code: is it read from one or several clus=
ters, is it aligned,
what is the type of clusters, is encryption in use, compression?
3. understand what kind of data corruption. What we read instead of correct=
 data? Just garbage, or may be zeroes, or what..

and of course best thing would be creating small reproducer, or test in tes=
ts/qemu-iotests


--=20
Best regards,
Vladimir

