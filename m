Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A804C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 08:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A9520848
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 08:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tsUximaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A9520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBwo1-0000F2-58
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 04:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBwnB-0007oU-IN
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 04:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBwn7-0004nZ-5l
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 04:32:41 -0400
Received: from mail-db3eur04on070d.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::70d]:12101
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jBwmz-0004Zh-K5; Wed, 11 Mar 2020 04:32:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEk7UxwH2tEfsTnZ05W+ljw/WWhxRT91iTTwZEMuNugCnDcCPAZCb8OwblrBTIUquro9R50lVbUn89qSffRceYXMdVGs9Iz1bnLBEg0LzxA+JUBGhfyWyxYT1jae0I59a+iY4FFSjhJ3ST5EU82fIJW1q9b9foZzlSIxP0p42PbOx851qHWBqDyck9dYs3AGUdI52rNAgJas5kKQkUWZ0s4nZh1w6KxgHUbtEXLTTtI+izMjOiNSQuLY84FzLux+pRbumruHqx82ZW7VHctGQ6nrQizo1kDzB9uykVoMDZ1R+jpxQYjyY/tzEbgNcxMI6lDTG2fTWZ6A8Zb3gDWXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhdzVze29VFot6BAq2eXp3PIhkhirf9Q0k1Lbtofrts=;
 b=SOiqnUTjUi0PBhhNrc6wjVrdHwmp0Sa2NN9nLf3MeUzvs02NhZQaSgCefp+tykMY8GKajb22eKMID/HBwmAIgDOS9Vd9zECuJ3A4eqy41PLnqdgVMX0cHQVmbqD6xYfRuvYLcAn38Kbr+AOkwPPcAFSE4L6YIO/aED+nZWXWZnTfBFhUtYJ6ZQJyhZaZ2ThkMdHty2W1aJHSb5a+r1KHV+Ym6UQNhVXzg3AxZE7pxVhZX+fJ2ie1faLLq1dWbPKTATY3T0v1ZJvFvpxaGTlK5g0UeTKBQVZYJJIQzvkNoi1fuwJtFVX9PQ9OkCsw8KSiiVb2W2tezCCecf+t+ZiIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhdzVze29VFot6BAq2eXp3PIhkhirf9Q0k1Lbtofrts=;
 b=tsUximaJmBaftk2Qp+Mx2JfGtqr6f+SM4I5BxthxpZPg246lb49BKvtF4TYq8KOsbvrNDrd0b4RmI0h5h/D9nxkJJZH8EEjwvYZjS4iV6hIraUOb9PXng8Gw+a6oXhdfoRZ7K0oNpTG125HiBAvaVMZRyuCr0LbzAy0P6tFrUyY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4487.eurprd08.prod.outlook.com (20.179.18.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 08:32:26 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 08:32:26 +0000
Subject: Re: [PATCH v8 02/10] scripts: add coccinelle script to use auto
 propagated errp
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-3-vsementsov@virtuozzo.com>
 <87lfo997hs.fsf@dusky.pond.sub.org>
 <e5b19cf6-f206-a0ed-27cc-173c3a137ef2@virtuozzo.com>
 <87lfo8nrdo.fsf@dusky.pond.sub.org>
 <4ad4f78d-bdf2-1302-a9b4-0324119217c7@virtuozzo.com>
X-Tagtoolbar-Keys: D20200311113222911
Message-ID: <edc9de1b-550e-2840-c605-c29adba2a0ee@virtuozzo.com>
Date: Wed, 11 Mar 2020 11:32:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <4ad4f78d-bdf2-1302-a9b4-0324119217c7@virtuozzo.com>
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
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Wed, 11 Mar 2020 08:32:25 +0000
X-Tagtoolbar-Keys: D20200311113222911
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6393085c-6b0a-47cd-78f3-08d7c596bab1
X-MS-TrafficTypeDiagnostic: AM6PR08MB4487:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4487380EDBA4441C42E1E0B6C1FC0@AM6PR08MB4487.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(346002)(376002)(136003)(396003)(199004)(66556008)(8676002)(31696002)(66476007)(6666004)(2906002)(30864003)(956004)(81166006)(86362001)(26005)(36756003)(81156014)(2616005)(7416002)(5660300002)(8936002)(316002)(4326008)(478600001)(52116002)(16576012)(31686004)(6486002)(16526019)(186003)(54906003)(6916009)(66946007)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4487;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzk9wPaMHm8ZgGlp+bdkib4+LDExxtijIYCUFOnMMqS2EEbTw76g0Ouo/GQ/A9JHya+4xzbv3fkuwXP3IJDNUvzi+bWSrF/0VfAqns7TR4n1LTFrU5Id3dC3BdpfxoTAq7FleqsgXiRk9wbsMnlB0rBl8hXYMGooK94HYyVadXHANNw8X3422qakMe+pzWybGYdlSEi8YzAcLeR2vPNarq6vlOvISrAlPWwYeyZ0KM3+bzx0zIgYoSOdtlPJ7GN/HWRO+lHUgzd6+5ots5UnMsUA15Kd9PRYLujDEFhfS3DQ8esCC3Vgp8FJyrO7Knkuc0458aHUNNhWmXwVFrM4jvNk+0akTw9PL5zcvKNuOzEfztDnkekKYesFjRCMO0vADswbZ7g/HDBjz5PVewVe+iss8Lly0FuhtTzC49XQcNEl0xjiUCSX+pBBabVKWQmUy4zroaiIaOP5Go/pWRY/0RYs322bnnAFeEHQtOv/Utb55MtrPclNbGKEq7Lf3s8sLcl0ctHCGjxMhHxEfkb40Rkf8TCvKE3o6fY/i646bjHx503Iyahe3OGc2SRo2eLw
X-MS-Exchange-AntiSpam-MessageData: fsN6T2avoOV5VTDX4LiEH1M4l3LRBmxLHateE4psaa9Ywm7VaRDmx8GrbIGF9X0Deykkvd0vvnNinIfTT7BvvHNMiSsnqxsBIrewzG3aa2go+xw7oMLmWHOfXHwX4QaanPSDK3RgwtRB0hV+1D0r8w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6393085c-6b0a-47cd-78f3-08d7c596bab1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 08:32:26.6002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBbCha8z+UiKmx+faUDoMTBvzGoQUZHjijgz/Hre+MW28wdkyS5ljVCwoCy542HQFztzgykyyoS9/lyBiC/kKGcBMSwZHq5QY4JB/MZIWac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4487
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0c::70d
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.03.2020 9:55, Vladimir Sementsov-Ogievskiy wrote:
> 10.03.2020 18:47, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>
>>> 09.03.2020 12:56, Markus Armbruster wrote:
>>>> Suggest
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scripts: Coccinelle script to use auto-=
propagated errp
>>>>
>>>> or
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scripts: Coccinelle script to use ERRP_=
AUTO_PROPAGATE()
>>>>
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>
>>>>> Script adds ERRP_AUTO_PROPAGATE macro invocation where appropriate an=
d
>>>>> does corresponding changes in code (look for details in
>>>>> include/qapi/error.h)
>>>>>
>>>>> Usage example:
>>>>> spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>>> =C2=A0=C2=A0 --macro-file scripts/cocci-macro-file.h --in-place --no-=
show-diff \
>>>>> =C2=A0=C2=A0 blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/bloc=
k/nbd*}.[hc]
>>>>
>>>> Suggest FILES... instead of a specific set of files.
>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>>>> ---
>>>>>
>>>>> Cc: Eric Blake <eblake@redhat.com>
>>>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>>>> Cc: Max Reitz <mreitz@redhat.com>
>>>>> Cc: Greg Kurz <groug@kaod.org>
>>>>> Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
>>>>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>>>>> Cc: Anthony Perard <anthony.perard@citrix.com>
>>>>> Cc: Paul Durrant <paul@xen.org>
>>>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>>>> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>>>>> Cc: Laszlo Ersek <lersek@redhat.com>
>>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>>> Cc: Stefan Berger <stefanb@linux.ibm.com>
>>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>>>>> Cc: qemu-block@nongnu.org
>>>>> Cc: qemu-devel@nongnu.org
>>>>> Cc: xen-devel@lists.xenproject.org
>>>>>
>>>>> =C2=A0=C2=A0 include/qapi/error.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
>>>>> =C2=A0=C2=A0 scripts/coccinelle/auto-propagated-errp.cocci | 231 ++++=
++++++++++++++
>>>>> =C2=A0=C2=A0 2 files changed, 234 insertions(+)
>>>>> =C2=A0=C2=A0 create mode 100644 scripts/coccinelle/auto-propagated-er=
rp.cocci
>>>>>
>>>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>>>> index bb9bcf02fb..fbfc6f1c0b 100644
>>>>> --- a/include/qapi/error.h
>>>>> +++ b/include/qapi/error.h
>>>>> @@ -211,6 +211,9 @@
>>>>> =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
>>>>> =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
...
>>>>> =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> + *
>>>>> + * For mass conversion use script
>>>>
>>>> mass-conversion (we're not converting mass, we're converting en masse)
>>>>
>>>>> + *=C2=A0=C2=A0 scripts/coccinelle/auto-propagated-errp.cocci
>>>>> =C2=A0=C2=A0=C2=A0 */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 #ifndef ERROR_H
>>>>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/=
coccinelle/auto-propagated-errp.cocci
>>>>> new file mode 100644
>>>>> index 0000000000..bff274bd6d
>>>>> --- /dev/null
>>>>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>>>>
>>>> Preface to my review of this script: may aim isn't to make it
>>>> bullet-proof.=C2=A0 I want to (1) make it good enough (explained in a
>>>> jiffie), and (2) automatically identify the spots where it still isn't
>>>> obviously safe for manual review.
>>>>
>>>> The latter may involve additional scripting.=C2=A0 That's okay.
>>>>
>>>> The script is good enough when the number of possibly unsafe spots is
>>>> low enough for careful manual review.
>>>>
>>>> When I ask for improvements that, in your opinion, go beyond "good
>>>> enough", please push back.=C2=A0 I'm sure we can work it out together.
>>>>
>>>>> @@ -0,0 +1,231 @@
>>>>> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
>>>>> +//
>>>>> +// Copyright (c) 2020 Virtuozzo International GmbH.
>>>>> +//
>>>>> +// This program is free software; you can redistribute it and/or mod=
ify
>>>>> +// it under the terms of the GNU General Public License as published=
 by
>>>>> +// the Free Software Foundation; either version 2 of the License, or
>>>>> +// (at your option) any later version.
>>>>> +//
>>>>> +// This program is distributed in the hope that it will be useful,
>>>>> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See th=
e
>>>>> +// GNU General Public License for more details.
>>>>> +//
>>>>> +// You should have received a copy of the GNU General Public License
>>>>> +// along with this program.=C2=A0 If not, see <http://www.gnu.org/li=
censes/>.
>>>>> +//
>>>>> +// Usage example:
>>>>> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>>> +//=C2=A0 --macro-file scripts/cocci-macro-file.h --in-place --no-sho=
w-diff \
>>>>> +//=C2=A0 --max-width 80 blockdev-nbd.c qemu-nbd.c \
>>>>
>>>> You have --max-width 80 here, but not in the commit message.=C2=A0 Def=
ault
>>>> seems to be 78.=C2=A0 Any particular reason to change it to 80?
>>>
>>> Hmm. As I remember, without this parameter, reindenting doesn't work co=
rrectly.
>>> So, I'm OK with "--max-width 78", but I doubt that it will work without=
 a parameter.
>>> Still, may be I'm wrong, we can check it.
>>
>> If you can point to an example where --max-width helps, keep it, and
>> update the commit message to match.=C2=A0 Else, drop it.
>>
>>>>
>>>>> +//=C2=A0 {block/nbd*,nbd/*,include/block/nbd*}.[hc]
>>>>> +
>>>>> +// Switch unusual (Error **) parameter names to errp
>>>>
>>>> Let's drop the parenthesis around Error **
>>>>
>>>>> +// (this is necessary to use ERRP_AUTO_PROPAGATE).
>>>>
>>>> Perhaps ERRP_AUTO_PROPAGATE() should be ERRP_AUTO_PROPAGATE(errp) to
>>>> make the fact we're messing with @errp more obvious.=C2=A0 Too late; I
>>>> shouldn't rock the boat that much now.
>>>>
>>>>> +//
>>>>> +// Disable optional_qualifier to skip functions with "Error *const *=
errp"
>>>>> +// parameter.
>>>>> +//
>>>>> +// Skip functions with "assert(_errp && *_errp)" statement, as they =
have
>>>>> +// non generic semantics and may have unusual Error ** argument name=
 for purpose
>>>>
>>>> non-generic
>>>>
>>>> for a purpose
>>>>
>>>> Wrap comment lines around column 70, please.=C2=A0 It's easier to read=
.
>>>>
>>>> Maybe
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 // Skip functions with "assert(_errp && *_err=
p)" statement, because that
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 // signals unusual semantics, and the paramet=
er name may well serve a
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 // purpose.
>>>
>>> Sounds good.
>>>
>>>>
>>>>> +// (like nbd_iter_channel_error()).
>>>>> +//
>>>>> +// Skip util/error.c to not touch, for example, error_propagate and
>>>>> +// error_propagate_prepend().
>>>>
>>>> error_propagate()
>>>>
>>>> I much appreciate your meticulous explanation of what you skip and why=
.
>>>>
>>>>> +@ depends on !(file in "util/error.c") disable optional_qualifier@
>>>>> +identifier fn;
>>>>> +identifier _errp !=3D errp;
>>>>> +@@
>>>>> +
>>>>> + fn(...,
>>>>> +-=C2=A0=C2=A0 Error **_errp
>>>>> ++=C2=A0=C2=A0 Error **errp
>>>>> +=C2=A0=C2=A0=C2=A0 ,...)
>>>>> + {
>>>>> +(
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 ... when !=3D assert(_errp && *_errp)
>>>>> +&
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 <...
>>>>> +-=C2=A0=C2=A0=C2=A0 _errp
>>>>> ++=C2=A0=C2=A0=C2=A0 errp
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 ...>
>>>>> +)
>>>>> + }
>>>>
>>>> This rule is required to make the actual transformations (below) work
>>>> even for parameters with names other than @errp.=C2=A0 I believe it's =
not
>>>> used in this series.=C2=A0 In fact, I can't see a use for it in the en=
tire
>>>> tree right now.=C2=A0 Okay anyway.
>>>>
>>>>> +
>>>>> +// Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where nec=
essary
>>>>> +//
>>>>> +// Note, that without "when any" final "..." may not want to mach so=
mething
>>>>
>>>> s/final "..." may not mach/the final "..." does not match/
>>>>
>>>>> +// matched by previous pattern, i.e. the rule will not match double
>>>>> +// error_prepend in control flow like in vfio_set_irq_signaling().
>>>>
>>>> Can't say I fully understand Coccinelle there.=C2=A0 I figure you came=
 to
>>>> this knowledge the hard way.
>>>
>>> It's follows from smpl grammar document:
>>>
>>> "Implicitly, =E2=80=9C...=E2=80=9D matches the shortest path between so=
mething that matches the pattern before the dots (or the beginning of the f=
unction, if there is nothing before the dots) and something that matches th=
e pattern after the dots (or the end of the function, if there is nothing a=
fter the dots)."
>>> ...
>>> "_when any_ removes the aforementioned constraint that =E2=80=9C...=E2=
=80=9D matches the shortest path"
>>
>> Let me think that through.
>>
>> The pattern with the cases other than error_prepend() omitted:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn(..., Error **errp, ...)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0 +=C2=A0=C2=A0 ERRP_AUTO_PROPAGATE();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...=C2=A0 when !=3D ERR=
P_AUTO_PROPAGATE();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_prepend(errp, ...=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ... when any
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> Tail of vfio_set_irq_signaling():
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D index_to_str(v=
basedev, index);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (name) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 error_prepend(errp, "%s-%d: ", name, subindex);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 error_prepend(errp, "index %d-%d: ", index, subindex);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_prepend(errp,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to %s =
%s eventfd signaling for interrupt ",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd < 0 ? "tear=
 down" : "set up", action_to_str(action));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> The pattern's first ... matches a "shortest" path to an error_prepend(),
>> where "shortest" means "does not cross an error_prepend().=C2=A0 Its whe=
n
>> clause makes us ignore functions that already use ERRP_AUTO_PROPAGATE().
>>
>> There are two such "shortest" paths, one to the first error_prepend() in
>> vfio_set_irq_signaling(), and one to the second.=C2=A0 Neither path to t=
he
>> third one is not "shortest": they both cross one of the other two
>> error_prepend().
>>
>> The pattern' s second ... matches a path from a matched error_prepend()
>> to the end of the function.=C2=A0 There are two paths.=C2=A0 Both cross =
the third
>> error_prepend().=C2=A0 You need "when any" to make the pattern match any=
way.
>>
>> Alright, I think I got it.=C2=A0 But now I'm paranoid about ... elsewher=
e.
>> For instance, here's rule1 with error_propagate_prepend() omitted:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 // Match scenarios with propagation of local er=
ror to errp.
>> =C2=A0=C2=A0=C2=A0=C2=A0 @rule1 disable optional_qualifier exists@
>> =C2=A0=C2=A0=C2=A0=C2=A0 identifier fn, local_err;
>> =C2=A0=C2=A0=C2=A0=C2=A0 symbol errp;
>> =C2=A0=C2=A0=C2=A0=C2=A0 @@
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn(..., Error **errp, ...)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =
=3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(e=
rrp, local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> The second and third ... won't match anything containing
>> error_propagate().=C2=A0 What if a function has multiple error_propagate=
() on
>> all paths?
>=20
> I thought about this, but decided that double error propagation is a stra=
nge pattern, and may be better not match it...
>=20
>> Like this one:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 extern foo(int, Error **);
>> =C2=A0=C2=A0=C2=A0=C2=A0 extern bar(int, Error **);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 void frob(Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NU=
LL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int arg;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 foo(arg, errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bar(arg, &local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, l=
ocal_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bar(arg + 1, &local_err=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, l=
ocal_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> This is actually a variation of error.h's "Receive and accumulate
>> multiple errors (first one wins)" code snippet.
>=20
> ah yes, we can propagate to already filled errp, which just clean local_e=
rr.
>=20
>>
>> The Coccinelle script transforms it like this:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void frob(Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0 ERRP_AUTO_PROPAGATE();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =
=3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int arg;
>>
>> The rule that adds ERRP_AUTO_PROPAGATE() matches (it has ... when any),
>> but rule1 does not, and we therefore don't convert any of the
>> error_propagate().
>>
>> The result isn't wrong, just useless.
>>
>> Is this the worst case?
>>
>> Possible improvement to the ERRP_AUTO_PROPAGATE() rule: don't use
>> "... when any" in the error_propagate() case, only in the other cases.
>> Would that help?
>=20
> I think not, as it will anyway match functions with error_prepend (and an=
y
> number of following error_propagate calls)...

But it's correct to add ERRP_AUTO_PROPAGATE to such functions.. So, may be =
you
are right. Let's do it, seems better.

>=20
>>
>> I think this is the only other rule with "..." matching control flow.
>>
>>>>
>>>>> +//
>>>>> +// Note, "exists" says that we want apply rule even if it matches no=
t on
>>>>> +// all possible control flows (otherwise, it will not match standard=
 pattern
>>>>> +// when error_propagate() call is in if branch).
>>>>
>>>> Learned something new.=C2=A0 Example: kvm_set_kvm_shadow_mem().
>>>>
>>>> Spelling it "exists disable optional_qualifier" would avoid giving
>>>> readers the idea we're disabling "exists", but Coccinelle doesn't let
>>>> us.=C2=A0 Oh well.
>>>>
>>>>> +@ disable optional_qualifier exists@
>>>>> +identifier fn, local_err, errp;
>>>>
>>>> I believe this causes
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warning: line 98: errp, previously decl=
ared as a metavariable, is used as an identifier
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warning: line 104: errp, previously dec=
lared as a metavariable, is used as an identifier
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warning: line 106: errp, previously dec=
lared as a metavariable, is used as an identifier
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warning: line 131: errp, previously dec=
lared as a metavariable, is used as an identifier
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warning: line 192: errp, previously dec=
lared as a metavariable, is used as an identifier
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warning: line 195: errp, previously dec=
lared as a metavariable, is used as an identifier
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warning: line 228: errp, previously dec=
lared as a metavariable, is used as an identifier
>>>>
>>>> Making @errp symbol instead of identifier should fix this.
>>>
>>> Hmm, I didn't see these warnings.. But yes, it should be symbol.
>>>
>>>>
>>>>> +@@
>>>>> +
>>>>> + fn(..., Error **errp, ...)
>>>>> + {
>>>>> ++=C2=A0=C2=A0 ERRP_AUTO_PROPAGATE();
>>>>> +=C2=A0=C2=A0=C2=A0 ...=C2=A0 when !=3D ERRP_AUTO_PROPAGATE();
>>>>> +(
>>>>> +=C2=A0=C2=A0=C2=A0 error_append_hint(errp, ...);
>>>>> +|
>>>>> +=C2=A0=C2=A0=C2=A0 error_prepend(errp, ...);
>>>>> +|
>>>>> +=C2=A0=C2=A0=C2=A0 error_vprepend(errp, ...);
>>>>> +|
>>>>> +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>>>> +=C2=A0=C2=A0=C2=A0 ...
>>>>> +(
>>>>> +=C2=A0=C2=A0=C2=A0 error_propagate_prepend(errp, local_err, ...);
>>>>> +|
>>>>> +=C2=A0=C2=A0=C2=A0 error_propagate(errp, local_err);
>>>>> +)
>>>>> +)
>>>>> +=C2=A0=C2=A0=C2=A0 ... when any
>>>>> + }
>>>>> +
>>>>> +
>>>>> +// Match scenarios with propagation of local error to errp.
>>>>> +@rule1 disable optional_qualifier exists@
>>>>> +identifier fn, local_err;
>>>>> +symbol errp;
>>>>> +@@
>>>>> +
>>>>> + fn(..., Error **errp, ...)
>>>>> + {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>>>> +(
>>>>> +=C2=A0=C2=A0=C2=A0 error_propagate_prepend(errp, local_err, ...);
>>>>> +|
>>>>> +=C2=A0=C2=A0=C2=A0 error_propagate(errp, local_err);
>>>>> +)
>>>>
>>>> Indentation off by one.
>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>>>> + }
>>>>> +
>>>>> +// Convert special case with goto in separate.
>>>>
>>>> s/in separate/separately/
>>>>
>>>>> +// We can probably merge this into the following hunk with help of (=
 | )
>>>>> +// operator, but it significantly reduce performance on block.c pars=
ing (or it
>>>>
>>>> s/reduce/reduces/
>>>>
>>>>> +// hangs, I don't know)
>>>>
>>>> Sounds like you tried to merge this into the following hunk, but then
>>>> spatch took so long on block.c that you killed it.=C2=A0 Correct?
>>>
>>> Yes.
>>
>> I'd say something like "I tried merging this into the following rule the
>> obvious way, but it made Coccinelle hang on block.c."
>>
>>>>
>>>>> +//
>>>>> +// Note interesting thing: if we don't do it here, and try to fixup =
"out: }"
>>>>> +// things later after all transformations (the rule will be the same=
, just
>>>>> +// without error_propagate() call), coccinelle fails to match this "=
out: }".
>>>>
>>>> Weird, but not worth further investigation.
>>>
>>> It partially match to the idea which I saw somewhere in coccinelle docu=
mentation,
>>> that coccinelle converts correct C code to correct C code. "out: }" is =
an example
>>> of incorrect, impossible code flow, and coccinelle can't work with it..=
. But it's
>>> just a thought.
>>>
>>>>
>>>>> +@@
>>>>> +identifier rule1.fn, rule1.local_err, out;
>>>>> +symbol errp;
>>>>> +@@
>>>>> +
>>>>> + fn(...)
>>>>> + {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 <...
>>>>> +-=C2=A0=C2=A0=C2=A0 goto out;
>>>>> ++=C2=A0=C2=A0=C2=A0 return;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 ...>
>>>>> +- out:
>>>>> +-=C2=A0=C2=A0=C2=A0 error_propagate(errp, local_err);
>>>>
>>>> You neglect to match error_propagate_prepend().=C2=A0 Okay, because (1=
) that
>>>> pattern doesn't occur in the tree right now, and (2) if it gets added,
>>>> gcc will complain.
>>>
>>> No, because it should not removed. error_propagate_prepend should be co=
nverted
>>> to prepend, not removed. So, corresponding gotos should not be removed =
as well.
>>
>> You're right.
>>
>>>>
>>>>> + }
>>>>> +
>>>>> +// Convert most of local_err related staff.
>>>>
>>>> s/staff/stuff/
>>>>
>>>>> +//
>>>>> +// Note, that we update everything related to matched by rule1 funct=
ion name
>>>>> +// and local_err name. We may match something not related to the pat=
tern
>>>>> +// matched by rule1. For example, local_err may be defined with the =
same name
>>>>> +// in different blocks inside one function, and in one block follow =
the
>>>>> +// propagation pattern and in other block doesn't. Or we may have se=
veral
>>>>> +// functions with the same name (for different configurations).
>>>>
>>>> Context: rule1 matches functions that have all three of
>>>>
>>>> * an Error **errp parameter
>>>>
>>>> * an Error *local_err =3D NULL variable declaration
>>>>
>>>> * an error_propagate(errp, local_err) or error_propagate_prepend(errp,
>>>> =C2=A0=C2=A0=C2=A0 local_err, ...) expression, where @errp is the para=
meter and
>>>> =C2=A0=C2=A0=C2=A0 @local_err is the variable.
>>>>
>>>> If I understand you correctly, you're pointing out two potential issue=
s:
>>>>
>>>> 1. This rule can match functions rule1 does not match if there is
>>>> another function with the same name that rule1 does match.
>>>>
>>>> 2. This rule matches in the entire function matched by rule1, even whe=
n
>>>> parts of that function use a different @errp or @local_err.
>>>>
>>>> I figure these apply to all rules with identifier rule1.fn, not just
>>>> this one.=C2=A0 Correct?
>>>
>>> Yes.
>>
>> Thanks!
>>
>>>>
>>>> Regarding 1.=C2=A0 There must be a better way to chain rules together,=
 but I
>>>> don't know it.
>>>> =C2=A0 Can we make Coccinelle at least warn us when it converts
>>>> multiple functions with the same name?=C2=A0 What about this:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 @initialize:python@
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 @@
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 fnprev =3D {}
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 def pr(fn, p):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print("### %s:%s: %s(=
)" % (p[0].file, p[0].line, fn))
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 @r@
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 identifier rule1.fn;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 position p;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 @@
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn(...)@p
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 @script:python@
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn << rule1.fn;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p << r.p;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 @@
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 if fn not in fnprev:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fnprev[fn] =3D p
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 else:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if fnprev[fn]:
>>>
>>> hmm, the condition can't be false
>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pr(fn, fnprev[fn])
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 fnprev[fn] =3D None
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr(fn, p)
>>>
>>> and we'll miss next duplication..
>>
>> The idea is
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 first instance of fn:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn not in fnprev
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fnprev[fn] =3D position=
 of instance
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 don't print
>> =C2=A0=C2=A0=C2=A0=C2=A0 second instance:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fnprev[fn] is the posit=
ion of the first instance
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print first two instanc=
es
>> =C2=A0=C2=A0=C2=A0=C2=A0 subsequent instances: fnprev[fn] is None
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print this instance
>>
>> I might have screwed up the coding, of course :)
>>
>>> But I like the idea.
>>>
>>>>
>>>> For each function @fn matched by rule1, fncnt[fn] is an upper limit of
>>>> the number of functions with the same name we touch.=C2=A0 If it's mor=
e than
>>>> one, we print.
>>>>
>>>> Reports about a dozen function names for the whole tree in my testing.
>>>> Inspecting the changes to them manually is feasible.=C2=A0 None of the=
m are
>>>> in files touched by this series.
>>>>
>>>> The line printed for the first match is pretty useless for me: it poin=
ts
>>>> to a Coccinelle temporary file *shrug*.
>>>>
>>>> Regarding 2.=C2=A0 Shadowing @errp or @local_err would be in bad taste=
, and I
>>>> sure hope we don't do that.=C2=A0 Multiple @local_err variables... hmm=
.
>>>> Perhaps we could again concoct some script rules to lead us to spots t=
o
>>>> check manually.=C2=A0 See below for my attempt.
>>>>
>>>> What's the worst that could happen if we blindly converted such code?
>>>> The answer to that question tells us how hard to work on finding and
>>>> checking these guys.
>>>>
>>>>> +//
>>>>> +// Note also that errp-cleaning functions
>>>>> +//=C2=A0=C2=A0 error_free_errp
>>>>> +//=C2=A0=C2=A0 error_report_errp
>>>>> +//=C2=A0=C2=A0 error_reportf_errp
>>>>> +//=C2=A0=C2=A0 warn_report_errp
>>>>> +//=C2=A0=C2=A0 warn_reportf_errp
>>>>> +// are not yet implemented. They must call corresponding Error* - fr=
eeing
>>>>> +// function and then set *errp to NULL, to avoid further propagation=
 to
>>>>> +// original errp (consider ERRP_AUTO_PROPAGATE in use).
>>>>> +// For example, error_free_errp may look like this:
>>>>> +//
>>>>> +//=C2=A0=C2=A0=C2=A0 void error_free_errp(Error **errp)
>>>>> +//=C2=A0=C2=A0=C2=A0 {
>>>>> +//=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_free(*errp);
>>>>> +//=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *errp =3D NULL;
>>>>> +//=C2=A0=C2=A0=C2=A0 }
>>>>> +@ exists@
>>>>> +identifier rule1.fn, rule1.local_err;
>>>>> +expression list args;
>>>>> +symbol errp;
>>>>> +@@
>>>>> +
>>>>> + fn(...)
>>>>> + {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 <...
>>>>> +(
>>>>
>>>> Each of the following patterns applies anywhere in the function.
>>>>
>>>> First pattern: delete @local_err
>>>>
>>>>> +-=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>>>
>>>> Common case: occurs just once, not nested.=C2=A0 Anything else is susp=
icious.
>>>>
>>>> Both can be detected in the resulting patches with a bit of AWK
>>>> wizardry:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ git-diff -U0 master..review-error-v8 =
| awk '/^@@ / { ctx =3D $5; for (i =3D 6; i <=3D NF; i++) ctx =3D ctx " " $=
i; if (ctx !=3D octx) { octx =3D ctx; n =3D 0 } } /^- *Error *\* *[A-Za-z0-=
9_]+ *=3D *NULL;/ { if (index($0, "E") > 6) print "nested\n=C2=A0=C2=A0=C2=
=A0 " ctx; if (n) print "more than one\n=C2=A0=C2=A0=C2=A0 " ctx; n++ }'
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nested
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static void xen=
_block_drive_destroy(XenBlockDrive *drive, Error **errp)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nested
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static void xen=
_block_device_destroy(XenBackendInstance *backend,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nested
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static void xen=
_block_device_destroy(XenBackendInstance *backend,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 more than one
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static void xen=
_block_device_destroy(XenBackendInstance *backend,
>>>>
>>>> Oh.
>>>>
>>>> xen_block_drive_destroy() nests its Error *local_err in a conditional.
>>>>
>>>> xen_block_device_destroy() has multiple Error *local_err.
>>>>
>>>> In both cases, manual review is required to ensure the conversion is
>>>> okay.=C2=A0 I believe it is.
>>>>
>>>> Note that the AWK script relies on diff showing the function name in @=
@
>>>> lines, which doesn't always work due to our coding style.
>>>>
>>>> For the whole tree, I get some 30 spots.=C2=A0 Feasible.
>>>>
>>>>> +|
>>>>
>>>> Second pattern: clear @errp after freeing it
>>>>
>>>>> +
>>>>> +// Convert error clearing functions
>>>>
>>>> Suggest: Ensure @local_err is cleared on free
>>>>
>>>>> +(
>>>>> +-=C2=A0=C2=A0=C2=A0 error_free(local_err);
>>>>> ++=C2=A0=C2=A0=C2=A0 error_free_errp(errp);
>>>>> +|
>>>>> +-=C2=A0=C2=A0=C2=A0 error_report_err(local_err);
>>>>> ++=C2=A0=C2=A0=C2=A0 error_report_errp(errp);
>>>>> +|
>>>>> +-=C2=A0=C2=A0=C2=A0 error_reportf_err(local_err, args);
>>>>> ++=C2=A0=C2=A0=C2=A0 error_reportf_errp(errp, args);
>>>>> +|
>>>>> +-=C2=A0=C2=A0=C2=A0 warn_report_err(local_err);
>>>>> ++=C2=A0=C2=A0=C2=A0 warn_report_errp(errp);
>>>>> +|
>>>>> +-=C2=A0=C2=A0=C2=A0 warn_reportf_err(local_err, args);
>>>>> ++=C2=A0=C2=A0=C2=A0 warn_reportf_errp(errp, args);
>>>>> +)
>>>>
>>>> As you mention above, these guys don't exist, yet.=C2=A0 Builds anyway=
,
>>>> because this part of the rule is not used in this patch series.=C2=A0 =
You
>>>> don't want to omit it, because then the script becomes unsafe to use.
>>>>
>>>> We could also open-code:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 // Convert error clearing functions
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 (
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 error_free(local_err);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0 error_free(*errp);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0 *errp =3D NULL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 |
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ... and so forth ...
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 )
>>>>
>>>> Matter of taste.=C2=A0 Whatever is easier to explain in the comments.=
=C2=A0 Since
>>>> you already wrote one...
>>>
>>> I just feel that using helper functions is safer way..
>>>
>>>>
>>>> We talked about extending this series slightly so these guys are used.
>>>> I may still look into that.
>>>>
>>>>> +?-=C2=A0=C2=A0=C2=A0 local_err =3D NULL;
>>>>> +
>>>>
>>>> The new helpers clear @local_err.=C2=A0 Assignment now redundant, dele=
te.
>>>> Okay.
>>>>
>>>>> +|
>>>>
>>>> Third and fourth pattern: delete error_propagate()
>>>>
>>>>> +-=C2=A0=C2=A0=C2=A0 error_propagate_prepend(errp, local_err, args);
>>>>> ++=C2=A0=C2=A0=C2=A0 error_prepend(errp, args);
>>>>> +|
>>>>> +-=C2=A0=C2=A0=C2=A0 error_propagate(errp, local_err);
>>>>> +|
>>>>
>>>> Fifth pattern: use @errp directly
>>>>
>>>>> +-=C2=A0=C2=A0=C2=A0 &local_err
>>>>> ++=C2=A0=C2=A0=C2=A0 errp
>>>>> +)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 ...>
>>>>> + }
>>>>> +
>>>>> +// Convert remaining local_err usage. It should be different kinds o=
f error
>>>>> +// checking in if operators. We can't merge this into previous hunk,=
 as this
>>>>
>>>> In if conditionals, I suppose.=C2=A0 It's the case for this patch.=C2=
=A0 If I
>>>> apply the script to the whole tree, the rule gets also applied in othe=
r
>>>> contexts.=C2=A0 The sentence might mislead as much as it helps.=C2=A0 =
Keep it or
>>>> delete it?
>>>
>>> Maybe, just be more honest: "It should be ..., but it may be any other =
pattern, be careful"
>>
>> "Need to be careful" means "needs careful manual review", which I
>> believe is not feasible; see "Preface to my review of this script"
>> above.
>>
>> But do we really need to be careful here?
>>
>> This rule should apply only where we added ERRP_AUTO_PROPAGATE().
>>
>> Except when rule chaining via function name fails us, but we plan to
>> detect that and review manually, so let's ignore this issue here.
>>
>> Thanks to ERRP_AUTO_PROPAGATE(), @errp is not null.=C2=A0 Enabling
>> replacement of @local_err by @errp is its whole point.
>>
>> What exactly do we need to be careful about?
>=20
> Hmm.. About some unpredicted patterns. OK, then "For example, different k=
inds of .."
>=20
>>
>>>
>>>>
>>>>> +// conflicts with other substitutions in it (at least with "- local_=
err =3D NULL").
>>>>> +@@
>>>>> +identifier rule1.fn, rule1.local_err;
>>>>> +symbol errp;
>>>>> +@@
>>>>> +
>>>>> + fn(...)
>>>>> + {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 <...
>>>>> +-=C2=A0=C2=A0=C2=A0 local_err
>>>>> ++=C2=A0=C2=A0=C2=A0 *errp
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 ...>
>>>>> + }
>>>>> +
>>>>> +// Always use the same patter for checking error
>>>>
>>>> s/patter/pattern/
>>>>
>>>>> +@@
>>>>> +identifier rule1.fn;
>>>>> +symbol errp;
>>>>> +@@
>>>>> +
>>>>> + fn(...)
>>>>> + {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 <...
>>>>> +-=C2=A0=C2=A0=C2=A0 *errp !=3D NULL
>>>>> ++=C2=A0=C2=A0=C2=A0 *errp
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 ...>
>>>>> + }
>>>>
>>
>=20
>=20


--=20
Best regards,
Vladimir

