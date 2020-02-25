Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108C7C35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D164A21556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Jo1XWqnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D164A21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6WQ3-0007Eb-39
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j6WN5-00047a-8l
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:19:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j6WN0-0004dF-ET
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:19:18 -0500
Received: from mail-db8eur05on2130.outbound.protection.outlook.com
 ([40.107.20.130]:50872 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j6WMz-0004cW-Qh
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:19:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzhkz+FZ9g1rVIj34CbMoAlzsMRoMvQ5PAMq2+11jWK6uKFrM4GmJgpR0jIEwOVdY1GuGETBkO0lwtIkLKxuuaHbMGSarwe+uJeHKjfil2rzoMcHycmPquexjsRvQNQ+/Kwv9TujOOaLPXUbDWsG9wsSlIHi9VZYi9QOLyGmrwEScVqEDtVPJjLyMLL/Juki2TlRArrVFyqYwfzE+YXDHf1wdv6lqBfixnV2cpfsufH0Pw+bvJG//N0VV14GMEw5kGoDZ4dEKVvI5fcfGTYl2oU776vZkKz6bSaBKyMF5VxLZjoTelSPfMj2RqtzPvAaReC2weI0BQUFdAxfBxIN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eMiA/mPg78Brbeu/9EgpstAUhWDxYJHE5338B+aJXA=;
 b=JkohazrQ4AX4jW4E3XcQEzmsRv/RJf6FfmClUexHD8nwWqnutR57bX3lVe2nKcGP8DCod64E+D4GpzT2ISSYWjnwak/w7FYfGEDs0GcLK+zGpuZQYELfYIgvO5I7vChvILn8vW1mFUOuoxHiXOKCIFEKZrZrCk7/bdoenqUI4A19PuL/i/rMeNjMx3oQm2sK7nnL1eZZ6Gcj+8g0yfAPTXVY69zyKD7mgep0f9xaASxhkrS29R4VfFMw3qY62wZUDRk5+dajYJ3NcfbMbQ3gYSRPOtxJPiO+kiO9NWTL6dgGRQb4h+TrCqAw6WFZR6ncu0aAIX0H9XahN9OhodV5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eMiA/mPg78Brbeu/9EgpstAUhWDxYJHE5338B+aJXA=;
 b=Jo1XWqnTSW0iv3HVdcCrDrY/SAYphyszmxqLeaWqO18l8xzm4G61Z+kay833OJsaqtYKd9RmLa10m5Wn/mCncEbTsgrhYqlLks4xLM0GMEYitWCkShBxnkCTUHjZxpXjrcf9nAcokERCqCHylkkMP2U87foDnxtC8gJUFQylVNM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4309.eurprd08.prod.outlook.com (20.179.6.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 09:19:11 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 09:19:11 +0000
Subject: Re: Race condition in overlayed qcow2?
To: dovgaluk <dovgaluk@ispras.ru>
References: <2fb9fb4840d5aa92a716487f83ceb36c@ispras.ru>
 <0afe41fc-cc09-5682-a667-574c44fd6da3@virtuozzo.com>
 <5891b48a131321be62a4a311253da44c@ispras.ru>
 <af246719-910b-1394-2f18-b88e3daa9c81@virtuozzo.com>
 <0cbd2c7a-44e1-272f-9995-1ff7e2fb9e36@virtuozzo.com>
 <b3405d429e42bdf03177db1b8f7531ee@ispras.ru>
 <b5811027-388a-98db-fe73-93230b5e29ae@virtuozzo.com>
 <5fe1747e6e7b818d93fd9a7fd0434bed@ispras.ru>
 <99ed3129-9460-dbad-0441-95bad08d5636@virtuozzo.com>
 <796f18ec7246b8d07ac5d6bb59dca71f@ispras.ru>
 <b408733f-a0d7-62ab-8862-8d70d7148e5f@virtuozzo.com>
 <ac41c395f09a4101b7403e4116beba6a@ispras.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200225121910033
Message-ID: <e11be78b-9461-6068-969a-2f242ef5ada0@virtuozzo.com>
Date: Tue, 25 Feb 2020 12:19:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <ac41c395f09a4101b7403e4116beba6a@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR08CA0051.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::22) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR08CA0051.eurprd08.prod.outlook.com (2603:10a6:7:2a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 09:19:11 +0000
X-Tagtoolbar-Keys: D20200225121910033
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e27457b-284e-41b9-42d1-08d7b9d3c675
X-MS-TrafficTypeDiagnostic: AM6PR08MB4309:
X-Microsoft-Antispam-PRVS: <AM6PR08MB430989EC96808E9C78B5DCFAC1ED0@AM6PR08MB4309.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(366004)(346002)(39850400004)(136003)(189003)(199004)(186003)(6916009)(16526019)(8936002)(86362001)(66556008)(956004)(4326008)(66946007)(66476007)(5660300002)(36756003)(31696002)(2906002)(478600001)(81156014)(8676002)(2616005)(26005)(316002)(52116002)(16576012)(81166006)(6486002)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4309;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dXvTrLmn3P45GlgD76RE88HPiuS6HmyJbeah+UU2sjPlPHDCm4qOGDp2GIm1rZYGdwdRs5xRptWuypfqTLIjsOaxIJQsvQV8Nil+dH/olvVto7LjQmB/flTBK3lTOtFBZEBNehxHXCJN7roKyd3h4BGL2lF2z/xBPlO/ErXM/ojDlUPUKTTUhEVVwqnhgdfeuOlF6lf1KMpOf7/T+MEjCmY93xVInYk3kQexxGC3pKFrObEdeOOePPT+BC+rQiC9oo6b7WNDj3BTf0gaT81Nghu5GgMgBHyCCuYSdL30IZRb8EbZ10YNiX3ee9k6VB8A9/hwW7hkTVPjnvAZ5BhA3cQdfdJE6GaLfONfXEH+ZNLMA9l7nqEAwl1tmEYy0mHSHyIqSGudn9dbVli9x4gGaX2Cs0MKe+s3fzCaboh/Kwa1EJf8tvN9umQx3SvYjKRA
X-MS-Exchange-AntiSpam-MessageData: kwFTPKjHoft9uM8gUm5cv2PkFCojTdj24ujWPwfie58mXdkMuJBdBrAyaghhfMeeZxUfXgexRqlIIzwlTbj49ngId8kDvpxbQNbvzq47D6lusQIYIZjqjlNfVcsRtSrxTUPMt80AxepWWwK1o7lEcA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e27457b-284e-41b9-42d1-08d7b9d3c675
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 09:19:11.6095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9v0ovCfJuQDuIuPe+wKrEdo+Ft3bHik0/vVi/Q9ffg2x2XdjfBYZ1YQsGXAmPwNqLjcKTAVxPeysp4s4avSjFZ/ibb4RSb4GJnteqCY/vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4309
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.02.2020 10:56, dovgaluk wrote:
> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-25 10=
:27:
>> 25.02.2020 8:58, dovgaluk wrote:
>>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-21 =
16:23:
>>>> 21.02.2020 15:35, dovgaluk wrote:
>>>>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-2=
1 13:09:
>>>>>> 21.02.2020 12:49, dovgaluk wrote:
>>>>>>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02=
-20 12:36:
>>>>>>
>>>>>> So, preadv in file-posix.c returns different results for the same
>>>>>> offset, for file which is always opened in RO mode? Sounds impossibl=
e
>>>>>> :)
>>>>>
>>>>> True.
>>>>> Maybe my logging is wrong?
>>>>>
>>>>> static ssize_t
>>>>> qemu_preadv(int fd, const struct iovec *iov, int nr_iov, off_t offset=
)
>>>>> {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ssize_t res =3D preadv(fd, iov, nr_iov, offs=
et);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 qemu_log("preadv %x %"PRIx64"\n", fd, (uint6=
4_t)offset);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 int i;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t sum =3D 0;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 int cnt =3D 0;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0 ; i < nr_iov ; ++i) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int j;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (j =3D 0 ; j < (=
int)iov[i].iov_len ; ++j)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sum +=3D ((uint8_t*)iov[i].iov_base)[j];
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ++cnt;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 qemu_log("size: %x sum: %x\n", cnt, sum);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 assert(cnt =3D=3D res);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 return res;
>>>>> }
>>>>>
>>>>
>>>> Hmm, I don't see any issues here..
>>>>
>>>> Are you absolutely sure, that all these reads are from backing file,
>>>> which is read-only and never changed (may be by other processes)?
>>>
>>> Yes, I made a copy and compared the files with binwalk.
>>>
>>>> 2. guest modifies buffers during operation (you can catch it if
>>>> allocate personal buffer for preadv, than calculate checksum, then
>>>> memcpy to guest buffer)
>>>
>>> I added the following to the qemu_preadv:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 // do it again
>>> =C2=A0=C2=A0=C2=A0=C2=A0 unsigned char *buf =3D g_malloc(cnt);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 struct iovec v =3D {buf, cnt};
>>> =C2=A0=C2=A0=C2=A0=C2=A0 res =3D preadv(fd, &v, 1, offset);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 assert(cnt =3D=3D res);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t sum2 =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0 ; i < cnt ; ++i)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sum2 +=3D buf[i];
>>> =C2=A0=C2=A0=C2=A0=C2=A0 g_free(buf);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 qemu_log("--- sum2 =3D %x\n", sum2);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 assert(sum2 =3D=3D sum);
>>>
>>> These two reads give different results.
>>> But who can modify the buffer while qcow2 workers filling it with data =
from the disk?
>>>
>>
>> As far as I know, it's guest's buffer, and guest may modify it during
>> the operation. So, it may be winxp :)
>=20
> True, but normally the guest won't do it.
>=20
> But I noticed that DMA operation which causes the problems has the follow=
ing set of the buffers:
> dma read sg size 20000 offset: c000fe00
> --- sg: base: 2eb1000 len: 1000
> --- sg: base: 3000000 len: 1000
> --- sg: base: 2eb2000 len: 3000
> --- sg: base: 3000000 len: 1000
> --- sg: base: 2eb5000 len: b000
> --- sg: base: 3040000 len: 1000
> --- sg: base: 2f41000 len: 3000
> --- sg: base: 3000000 len: 1000
> --- sg: base: 2f44000 len: 4000
> --- sg: base: 3000000 len: 1000
> --- sg: base: 2f48000 len: 2000
> --- sg: base: 3000000 len: 1000
> --- sg: base: 3000000 len: 1000
> --- sg: base: 3000000 len: 1000
>=20
>=20
> It means that one DMA transaction performs multiple reads into the same a=
ddress.
> And no races is possible, when there is only one qcow2 worker.
> When there are many of them - they can fill this buffer simultaneously.
>=20

Hmm, actually if guest start parallel reads into same buffer from different=
 offsets, races are possible anyway, as different requests run in parallel =
even with one worker, because MAX_WORKERS is per-request value, not total..=
. But several workers may increase probability of races or introduce new on=
es.

So, actually, several workers of one request can write to the same buffer o=
nly if guest provides broken iovec, which references the same buffer severa=
l times (if it is possible at all).



--=20
Best regards,
Vladimir

