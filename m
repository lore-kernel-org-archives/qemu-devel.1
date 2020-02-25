Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D076C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6697E222C2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HMNLvPUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6697E222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Udl-0003SP-Kr
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 02:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j6UdB-00033o-1o
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:27:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j6Ud8-0005mV-Qy
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:27:48 -0500
Received: from mail-eopbgr80112.outbound.protection.outlook.com
 ([40.107.8.112]:57729 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j6Ud7-0005jH-Q1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:27:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJFwz28/SbnjPIodj6OSYh/JKBikq0EwZLjsJ3jTfwItpOMJ5/pwLXFlG1pZQtKlZRUgLHdKseYHx04VLyO0gYWmLbA/qwSjlycjVVARVqAZTqRN6B1bS8ZTJ0o6jvx/RDKtx9wc/UHsWbSWH24SMr1kq0dBzrgwnadb2JXwQsXFQrUKmlfLIFk6BBNhAAacbs2QEy6hWzj0T2NJDDZOOMgPMS5ZNwaMxqTk6CL0OF0Q7N7uPNwtgAdXDblCj8aByHXUJrpkYbnkbhuadO8WAaSTh5YUs83feGHPxyG+HK06HGdVlAnphjV9MY+BAijy+PvNFK1Zgbp+SFWVwWaQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00aQ17MsWtSeIZvHJjdeeSa9aYhkcVTrZDKsL/bpBTg=;
 b=HQBpDN3Xp0j2usWdUsDQtHgWJVfRm3bXn4zBKHghWYrSDqWt4Zb/ZMChXnj0+8XfHlUJqfdDf8U/pSwliYQQyrb2BJlADlTXqNVxEx04WoxzkOsYp6PkMUO/GUGvRocD6F5ddAIsQE9g4stHSoAhhIiNF7oLGUA5y32zr/qmfmhHmN0qNxLqlyAA2HGyrmMNEXj0KDNzrGsMcYUWM0Jy+6hD3GkC1SGnfwXY5JQVAj5xNpQBM9ZEo6rp7b4cxyNs3OCIw4R6OL1udMRUZuDgZNWP64r7NLlNjKdc02hhFw3PxKKkO62RedvAxJ7F3rdiJf1M5BR+C5TW+z35801KRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00aQ17MsWtSeIZvHJjdeeSa9aYhkcVTrZDKsL/bpBTg=;
 b=HMNLvPUlwqOdc37hga9pPgi1kN+hUPMBBUW9Npyg/njs39n5QTTRwTwHgJJXKc3cHEtmBUaWJ/CeXCaTcNK7BKI8FxMf66DEAXzYqb5AZlo45G6x+Mm6xcsUGpT4EH8xfDya3z2E+7EC2NnTHSlcK3rYMCjlIQ+hxP2AKJyVPAc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4197.eurprd08.prod.outlook.com (20.179.3.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 07:27:40 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 07:27:38 +0000
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
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200225102735605
Message-ID: <b408733f-a0d7-62ab-8862-8d70d7148e5f@virtuozzo.com>
Date: Tue, 25 Feb 2020 10:27:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <796f18ec7246b8d07ac5d6bb59dca71f@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0301CA0009.eurprd03.prod.outlook.com
 (2603:10a6:3:76::19) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0301CA0009.eurprd03.prod.outlook.com (2603:10a6:3:76::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 07:27:37 +0000
X-Tagtoolbar-Keys: D20200225102735605
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6abbc7e-a0e8-4d31-f53b-08d7b9c430ec
X-MS-TrafficTypeDiagnostic: AM6PR08MB4197:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4197D0BE4134976AD26FF961C1ED0@AM6PR08MB4197.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(136003)(376002)(39850400004)(346002)(199004)(189003)(81156014)(81166006)(2616005)(956004)(8676002)(186003)(66556008)(16526019)(66476007)(16576012)(26005)(66946007)(36756003)(31686004)(8936002)(4326008)(6916009)(5660300002)(478600001)(52116002)(86362001)(6486002)(316002)(31696002)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4197;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPidUfneYtij7wS0fWqTRos097vBDom3UJRx72Ufeq+xztgdQTxWs83Nn4q2DswRZJu+9Z2TMYIojjAdWmr70Zk2tPfaTYD4MI4wkGwreQdyTuINv68A3B8Dq5CVIHugLOuPIug7vXEI8M9SEfgTompva4Fh/Ovl/w0f5/IHj/IivOsEODcj6bnGcPepHlJCTY94xB5Q5egy75jSR9N5IGJcEYckmZlwzn/J6uDyg1SG/WO04r4gAS2qcX4rY/6yIzy5uvoXWqVuOPRzsFYuOiy6twQ1YMTZaGyEMr7f/7T38EpBso15TDNg+hbxb8WHdW/n1GXm/xbYcpNR5m2id3JqvTpbSI+w2ITT31ZGjsRjdzqPHG1f/tVTlUag6nn3l8jV1PznqsMKqZCiz8BCULFYJj7RjKhCpcRqrapaqYNOo5hMl8dt4UEHhp6ElXV9
X-MS-Exchange-AntiSpam-MessageData: 57QZoWQ/cvdc+yv/d3GSx+uzjAaKr+XSAXf7bC/aK9H3sS6gP5pkfIeMwOBVE5KI4NlslIIztskuBN27TT5XIvb+2i51Dhr3ri2AZqPwVTZPwn4a4R9Cak3wn9uDrsz+ygJSHsPioZWG/x/kvGEebg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6abbc7e-a0e8-4d31-f53b-08d7b9c430ec
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 07:27:38.3627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xk9RqEqbtX/hWGFN4h0/WxxWkuOz9fiSidxXZ07An9wQI09AfseMs8HLce7mxl+pYDkD8UPtoAYlLIBWsR9VCdDBjc0a1mCmkMl/KQY/Wp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4197
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.112
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

25.02.2020 8:58, dovgaluk wrote:
> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-21 16=
:23:
>> 21.02.2020 15:35, dovgaluk wrote:
>>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-21 =
13:09:
>>>> 21.02.2020 12:49, dovgaluk wrote:
>>>>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-2=
0 12:36:
>>>>>>>> 1 or 2 are ok, and 4 or 8 lead to the failures.
>>>>>>>>
>>>>>>>>
>>>>>>>> That is strange. I could think, that it was caused by the bugs in
>>>>>>>> deterministic CPU execution, but the first difference in logs
>>>>>>>> occur in READ operation (I dump read/write buffers in blk_aio_comp=
lete).
>>>>>>>>
>>>>>>>
>>>>>>> Aha, yes, looks strange.
>>>>>>>
>>>>>>> Then next steps:
>>>>>>>
>>>>>>> 1. Does problem hit into the same offset every time?
>>>>>>> 2. Do we write to this region before this strange read?
>>>>>>>
>>>>>>> 2.1. If yes, we need to check that we read what we write.. You say =
you dump buffers
>>>>>>> in blk_aio_complete... I think it would be more reliable to dump at=
 start of
>>>>>>> bdrv_co_pwritev and at end of bdrv_co_preadv. Also, guest may modif=
y its buffers
>>>>>>> during operation which would be strange but possible.
>>>>>>>
>>>>>>> 2.2 If not, hmm...
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Another idea to check: use blkverify
>>>>>
>>>>> I added logging of file descriptor and discovered that different resu=
lts are obtained
>>>>> when reading from the backing file.
>>>>> And even more - replay runs of the same recording produce different r=
esults.
>>>>> Logs show that there is a preadv race, but I can't figure out the sou=
rce of the failure.
>>>>>
>>>>> Log1:
>>>>> preadv c 30467e00
>>>>> preadv c 30960000
>>>>> --- sum =3D a2e1e
>>>>> bdrv_co_preadv_part complete offset: 30467e00 qiov_offset: 0 len: 820=
0
>>>>> --- sum =3D 10cdee
>>>>> bdrv_co_preadv_part complete offset: 30960000 qiov_offset: 8200 len: =
ee00
>>>>>
>>>>> Log2:
>>>>> preadv c 30467e00
>>>>> --- sum =3D a2e1e
>>>>> bdrv_co_preadv_part complete offset: 30467e00 qiov_offset: 0 len: 820=
0
>>>>> preadv c 30960000
>>>>> --- sum =3D f094f
>>>>> bdrv_co_preadv_part complete offset: 30960000 qiov_offset: 8200 len: =
ee00
>>>>>
>>>>>
>>>>> Checksum calculation was added to preadv in file-posix.c
>>>>>
>>>>
>>>> So, preadv in file-posix.c returns different results for the same
>>>> offset, for file which is always opened in RO mode? Sounds impossible
>>>> :)
>>>
>>> True.
>>> Maybe my logging is wrong?
>>>
>>> static ssize_t
>>> qemu_preadv(int fd, const struct iovec *iov, int nr_iov, off_t offset)
>>> {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 ssize_t res =3D preadv(fd, iov, nr_iov, offset=
);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 qemu_log("preadv %x %"PRIx64"\n", fd, (uint64_=
t)offset);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 int i;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t sum =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 int cnt =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0 ; i < nr_iov ; ++i) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int j;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (j =3D 0 ; j < (in=
t)iov[i].iov_len ; ++j)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sum +=3D ((uint8_t*)iov[i].iov_base)[j];
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ++cnt;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0 qemu_log("size: %x sum: %x\n", cnt, sum);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 assert(cnt =3D=3D res);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 return res;
>>> }
>>>
>>
>> Hmm, I don't see any issues here..
>>
>> Are you absolutely sure, that all these reads are from backing file,
>> which is read-only and never changed (may be by other processes)?
>=20
> Yes, I made a copy and compared the files with binwalk.
>=20
>> 2. guest modifies buffers during operation (you can catch it if
>> allocate personal buffer for preadv, than calculate checksum, then
>> memcpy to guest buffer)
>=20
> I added the following to the qemu_preadv:
>=20
>  =C2=A0=C2=A0=C2=A0 // do it again
>  =C2=A0=C2=A0=C2=A0 unsigned char *buf =3D g_malloc(cnt);
>  =C2=A0=C2=A0=C2=A0 struct iovec v =3D {buf, cnt};
>  =C2=A0=C2=A0=C2=A0 res =3D preadv(fd, &v, 1, offset);
>  =C2=A0=C2=A0=C2=A0 assert(cnt =3D=3D res);
>  =C2=A0=C2=A0=C2=A0 uint32_t sum2 =3D 0;
>  =C2=A0=C2=A0=C2=A0 for (i =3D 0 ; i < cnt ; ++i)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sum2 +=3D buf[i];
>  =C2=A0=C2=A0=C2=A0 g_free(buf);
>  =C2=A0=C2=A0=C2=A0 qemu_log("--- sum2 =3D %x\n", sum2);
>  =C2=A0=C2=A0=C2=A0 assert(sum2 =3D=3D sum);
>=20
> These two reads give different results.
> But who can modify the buffer while qcow2 workers filling it with data fr=
om the disk?
>=20

As far as I know, it's guest's buffer, and guest may modify it during the o=
peration. So, it may be winxp :)



--=20
Best regards,
Vladimir

