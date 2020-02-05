Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0868CC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BEB2082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="M3qxmNlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BEB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLz1-0004y2-0g
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izLyE-0004GK-BX
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:48:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izLyD-0001xD-7S
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:48:02 -0500
Received: from mail-eopbgr80137.outbound.protection.outlook.com
 ([40.107.8.137]:49282 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1izLy9-0001a7-Ue; Wed, 05 Feb 2020 09:47:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLhgVfI0hb8JsvnVICmjGPjWBQi85lpYCRrIovEVc0ktppZyCijiv5+gr23RovJw3KhMAY3cUHJL8UreBU/J5ckmb7D7yYtvzDvQMv3NpmxbY2VcoNgJd16x3uU1URGMbbhYZkcxwGcgBB3waiImpGmFZoUl9xLqVb8KiXNsYbVHhJwJGIMj9ZMcJjmtKU3SmoWdobMsAnW1dlBzqs7WpRm87Dc9SfIORXrnGeY1Wko1R1qYI8VyDz8eK0xj11B+JirE1iboJPnVx2c88U+/ZiVvUREqbvHHgPBAkLCYAYNMZoyY/iJPbz+kkF1gBeRSP4zffFptld9MWZca5viPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4qqQiZJ+482HHl4paFka/vu9+xwjHYV1ZHm8HGXicc=;
 b=F0cxeI023ZswELGzGkgHITD3AOVrVY0CuzAV0gkXJNq5Ac1xA+t7CT/XYF2wASfJ/wRMWySEfoYm85dRlSoAzDsOz5SaeC1nwbEsfC4hKWuaHTsxi6T58B42qKgINvvVjhGeyfxcBF6LHGluOVBXELMqMZdGAoDV0Cx07f2VACnQddqKrpVZkKUBMHEe5N9BhyjNWbOiHtGXwIPxv3uizetPQwsvSV328OvVrD1te9XTUkOIg9xKOrP4RVTeHSOiCfhhRTcqKnZ1pG2ar7ru9Lq5AhZWRIesg4ydX2O2SgcHQ7TTga98ogCoaHGp13vB5w1B349AxbFNY1+5TmEE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4qqQiZJ+482HHl4paFka/vu9+xwjHYV1ZHm8HGXicc=;
 b=M3qxmNlBxi+VgEFDhaHJjkNhH2Z75iANpkjQblEQrJK+ET0UsGZwi7eIBfeug0hGju47uPFnOxpOlVP1RDCjfgSg8tP+QItuIms6oZExe03VeVXMkvnLCoiR1aerOMUB4Qt5cDxlLxg1AKf+JiLr6wl+GabLDXAcTwNjG5V8v9o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB4062.eurprd08.prod.outlook.com (20.178.127.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 5 Feb 2020 14:47:56 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0%2]) with mapi id 15.20.2686.034; Wed, 5 Feb 2020
 14:47:56 +0000
Subject: Re: [PATCH 00/17] Improve qcow2 all-zero detection
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <3bad82d4-4d60-4341-d87e-af37e1dd680e@virtuozzo.com>
 <99576c66-00d2-14a3-5f1f-6d7cebfa6553@virtuozzo.com>
 <8b650616-ff80-c430-5d4e-6c9311bec2f6@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200205174753712
Message-ID: <5494fd19-3dbe-8878-628b-20b3c0a0c6cd@virtuozzo.com>
Date: Wed, 5 Feb 2020 17:47:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <8b650616-ff80-c430-5d4e-6c9311bec2f6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0902CA0056.eurprd09.prod.outlook.com
 (2603:10a6:7:15::45) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0902CA0056.eurprd09.prod.outlook.com (2603:10a6:7:15::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32 via Frontend Transport; Wed, 5 Feb 2020 14:47:55 +0000
X-Tagtoolbar-Keys: D20200205174753712
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1010c0a-6584-4ae0-2169-08d7aa4a62c8
X-MS-TrafficTypeDiagnostic: VI1PR08MB4062:
X-Microsoft-Antispam-PRVS: <VI1PR08MB4062D72B0B955A6B20CE94ACC1020@VI1PR08MB4062.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(39850400004)(396003)(136003)(366004)(189003)(199004)(36756003)(2616005)(956004)(81156014)(81166006)(66476007)(66556008)(316002)(16526019)(52116002)(53546011)(26005)(8676002)(6486002)(2906002)(16576012)(31696002)(186003)(86362001)(8936002)(4326008)(5660300002)(66946007)(31686004)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4062;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Mso+EIEpu5HIcjlXlsdEzREEIWix5jZgX8/xYu9Thk/Vuy6oNN/psdhl4vulfGbb11XlVETbPKFnnAvQ2tIj5tTtY9m+kF9c9cswidonFmaigl6oJfO6XXZDBCpwOfrLKaiVDKDU0JAPr1a5yk5yDL7V/R++Jbrm8iEzuNk2OIXHDJttuofmEZ0014fiY3NNuJOKdiK1py/4OTmey9oNQ4WF2o30KPBAxWV6icKotWd/e48wBiLtXvh9On1mKqXJjIEG5kknOHt+F1WHM7zfXRLN7i3dx/G9x52PcvNE0tw127pAw3usIVld17mah+rqfS4XNI372nJFLrlCCogMJOrsmDiFFAgcXI+c3B5Q2iIeiOg9ihDsZsIb79WR6vYhWRdZlHwDR82M+1kANytN90Rxlk/SzKJVkFSe+i+JvoZLb6zhxSKqij/9PNOaL8V
X-MS-Exchange-AntiSpam-MessageData: uR7NsmlCTrUikJYjcPilcAgcdAwQojdfUlpmTV9tBjE6fkHcssfucBSqosHgssuA9EiTijaWB75jXMfQ70RNCHrCboP5olhVibQbR/HqI2vkZt5EWLAPIXR+Ntz3OjkOFlgMxbVwRClbQBDN+f2PhA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1010c0a-6584-4ae0-2169-08d7aa4a62c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 14:47:55.8908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iel98bCflIdrSiNnZ09gwNjhxVpZk8LmKKZTiHKqEFOmX78EH3X+/GNN7FNTefg0WjAGU9ECgLc5MsHe+TZ1UOUXZ6hrVrCAvyXwOcBWGTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4062
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.137
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
Cc: david.edmondson@oracle.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

05.02.2020 17:26, Eric Blake wrote:
> On 2/5/20 3:25 AM, Vladimir Sementsov-Ogievskiy wrote:
>=20
>>> 3. For qcow2
>>> Hmm. Here, as I understand, than main case is freshly created qcow2,
>>> which is fully-unallocated. To understand that it is empty, we
>>> need only to check all L1 entries. And for empty L1 table it is fast.
>>> So we don't need any qcow2 format improvement to check it.
>>>
>>
>> Ah yes, I forget about preallocated case. Hmm. For preallocated clusters=
,
>> we have zero bits in L2 entries. And with them, we even don't need
>> preallocated to be filled by zeros, as we never read them (but just retu=
rn
>> zeros on read)..
>=20
> Scanning all L2 entries is O(n), while an autoclear bit properly maintain=
ed is O(1).
>=20
>>
>> Then, may be we want similar flag for L1 entry (this will enable large
>> fast write-zero). And may be we want flag which marks the whole image
>> as read-zero (it's your flag). So, now I think, my previous idea
>> of "all allocated is zero" is worse. As for fully-preallocated images
>> we are sure that all clusters are allocated, and it is more native to
>> have flags similar to ZERO bit in L2 entry.
>=20
> Right now, we don't have any L1 entry flags.=C2=A0 Adding one would requi=
re adding an incompatible feature flag (if older qemu would choke to see un=
expected flags in an L1 entry), or at best an autoclear feature flag (if th=
e autoclear bit gets cleared because an older qemu opened the image and cou=
ldn't maintain L1 entry flags correctly, then newer qemu knows it cannot tr=
ust those L1 entry flags).=C2=A0 But as soon as you are talking about addin=
g a feature bit, then why add one that still requires O(n) traversal to che=
ck (true, the 'n' in an O(n) traversal of L1 tables is much smaller than th=
e 'n' in an O(n) traversal of L2 tables), when you can instead just add an =
O(1) autoclear bit that maintains all_zero status for the image as a whole?
>=20

My suggestion about L1 entry flag is side thing, I understand difference be=
tween O(n) and O(1) :) Still additional L1 entry will help to make efficien=
t large block-status and write-zero requests.

And I agree that we need top level flag.. I just try to say, that it seems =
good to make it similar with existing L2 flag. But yes, it would be incomap=
tible change, as it marks all clusters as ZERO, and older Qemu can't unders=
tand it and may treat all clusters as unallocated.


--=20
Best regards,
Vladimir

