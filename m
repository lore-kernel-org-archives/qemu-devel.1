Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0CDC35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C9D20714
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QCR75oqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C9D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Wq4-0004Mz-Mf
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j6Wp2-0003Ix-5I
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:48:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j6Wox-0003rb-UK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:48:11 -0500
Received: from mail-eopbgr30110.outbound.protection.outlook.com
 ([40.107.3.110]:61408 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j6Wox-0003qa-7p; Tue, 25 Feb 2020 04:48:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQs3eHUzwP0B8ainXtPMy0zbPWvP/6dVBWN10jizORrSrvu0ThUQV6EKoetM67UDANjhcqs0uzFsdZN9lxL8pTP4mexgNEdlp4r+0noU4wooYnmbddU6E84My20reJK37CWBI2jbR55VY+9muZzdaOb0VeR1PAHA6OJPH1Eaeg6w0uaZ7BmIYf2x2bhe5j9gWEaU0YxG/aL7CGK35hMghzmbZr1Kqbt18gm8waTBAxadvwUlZr50KfwZcgmNv8yANmwdm2I8Qxth5rHLMor8GLoIfMN/H0B2+6y2PW05+zKvKoEd2puXDfmccu72OD4xoYk27cmrvLtc90LMwFglnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzFzDdFhNuYA0H1WYMx7O2tIPlVjTUw4Ta9jGgofKbo=;
 b=LuJ/Nf0giYmZaRhN3teNBmNZC5+p/oYtzzNT0cgHQhGrUgteiiad+wIFcO1mGiuWuZYRnSCsxnmgpUtqkoxazSrFbX8Rsy4M6ijKw/NgQ45dZXvjf4jB3g/uABiiJk+39v7w5Ji0OmT8Cion4F4+R1EnYcmTIc9maN/VmNKImP4G06XCOjzjOuHVudPt1qwFXVB4tXGG6G0XHoTsn6yA8o2OcSjEyug51/tp+oOCD+n1vZmzmZPoJqy8wMT9em7TNbq+DATOVnkGcPbzKtQREAVXlabgFOE7iH/myEB94vQmcy4+si1Ib6xH5qy7bMFq02Qm1A9GI9juo5USZRQVsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzFzDdFhNuYA0H1WYMx7O2tIPlVjTUw4Ta9jGgofKbo=;
 b=QCR75oqw0Mc3PjAFd1wvT93YBrykiaJcqSn0YHxI2QF5HlUXSS+xNyJINvtv3zbgbmKKTQBpcxgDVeeH1bqoolXbqdMMlAnTKLt5YpVffSsiuHKAUp7WBy1QXZQYxWe6yWrFapg8RzDKDiLMPsfFGcgfdr84BjugLt6Pfgj1YnQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3303.eurprd08.prod.outlook.com (52.135.161.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 09:48:05 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 09:48:05 +0000
Subject: Re: [PATCH v7 01/11] qapi/error: add (Error **errp) cleaning APIs
To: Markus Armbruster <armbru@redhat.com>
References: <20200131130118.1716-1-vsementsov@virtuozzo.com>
 <20200131130118.1716-2-vsementsov@virtuozzo.com>
 <87d0a88k6d.fsf@dusky.pond.sub.org>
 <7856fcbb-8c01-aba3-a11b-63058c117362@virtuozzo.com>
 <875zfz6gsh.fsf@dusky.pond.sub.org>
 <064ca8e9-458e-c780-92a0-05f40cf0975b@virtuozzo.com>
 <87sgj31140.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200225124802252
Message-ID: <4da07feb-5c78-8a09-8d88-c324c76ebc02@virtuozzo.com>
Date: Tue, 25 Feb 2020 12:48:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87sgj31140.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0502CA0024.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::34) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0502CA0024.eurprd05.prod.outlook.com (2603:10a6:3:e3::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 09:48:04 +0000
X-Tagtoolbar-Keys: D20200225124802252
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f947fbd6-4ff9-417f-4a91-08d7b9d7cfb5
X-MS-TrafficTypeDiagnostic: AM6PR08MB3303:
X-Microsoft-Antispam-PRVS: <AM6PR08MB33034B30FBB81CB81D6DA906C1ED0@AM6PR08MB3303.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(136003)(366004)(376002)(346002)(189003)(199004)(956004)(2616005)(26005)(6486002)(316002)(66476007)(66556008)(7416002)(186003)(16576012)(16526019)(66946007)(478600001)(31696002)(2906002)(54906003)(5660300002)(86362001)(52116002)(81156014)(8936002)(31686004)(8676002)(6916009)(36756003)(81166006)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3303;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akj98jl3JKy7yMQ9LuIxebm1X/gR3djWHI9z2zNxEa0pV7u9jugv0dvQv9o/QC+PXqMEDe/uF8GpRlavRWcScILGLJ3VdmxIEsWiS8tX+xTR0cPMrym+T/XWQOEASvsBgyr/GQYC4ng2P17ztZNv34d2gE3k8q6EMCBFkG4gK+60tAfyyuMfuzmke6dhBeXwDomXlzGe19K0qro20HZ9/Z6GBfcxW74JTtr8C9XMeNmEEt5/mwjLw/bF4lN4WdBOyi5poFGu+M1g7G2DzEgPDdwhRBRodARutCU7Fmcp7tnYukTWfLBIIhKHSn2j4TWX2/2oVAVL6yMJCwgynBg1n0aB0C5xuBFLSh5uA9Ulu09Nw1xkfPyoKAo1YJirYKl7s1c8fW5DsyG2la3ZuqWi2HqLzFGYKyJzjho+jf9CNC1oJvzRVywOxrDBa552y+m9
X-MS-Exchange-AntiSpam-MessageData: rR2l7kte+Gbo27oyz08nd+nzzBQDwfDE366t0u6yircd7AI7bOIpgbrU6GCYSGm8sB0lQSwX23dDRDE+WbfBu9K8oTCijYRZfCl6JrwM0OL8Re+6OWxeshOalNMBpcL8jPXDTic/b+NNuAKoeUOhPA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f947fbd6-4ff9-417f-4a91-08d7b9d7cfb5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 09:48:05.1635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7WBzBlpC+LXitylKP9EToDlsPb2r+zQs8L9MPYq6oQehMULH2n2EpXsRI01nIad+nQRM3ihL/QDbI91VBeJ+iwk2bZjrLGhU9v4SZ/4pg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3303
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.110
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
 Laszlo Ersek <lersek@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

22.02.2020 11:23, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> 21.02.2020 19:34, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>
>>>> 21.02.2020 10:38, Markus Armbruster wrote:
>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>
>>>>>> Add functions to clean Error **errp: call corresponding Error *err
>>>>>> cleaning function an set pointer to NULL.
>>>>>>
>>>>>> New functions:
>>>>>>      error_free_errp
>>>>>>      error_report_errp
>>>>>>      warn_report_errp
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>>>> Reviewed-by: Greg Kurz <groug@kaod.org>
>>>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>>>> ---
>>>>>>
>>>>>> CC: Eric Blake <eblake@redhat.com>
>>>>>> CC: Kevin Wolf <kwolf@redhat.com>
>>>>>> CC: Max Reitz <mreitz@redhat.com>
>>>>>> CC: Greg Kurz <groug@kaod.org>
>>>>>> CC: Stefano Stabellini <sstabellini@kernel.org>
>>>>>> CC: Anthony Perard <anthony.perard@citrix.com>
>>>>>> CC: Paul Durrant <paul@xen.org>
>>>>>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>> CC: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>>>>>> CC: Laszlo Ersek <lersek@redhat.com>
>>>>>> CC: Gerd Hoffmann <kraxel@redhat.com>
>>>>>> CC: Stefan Berger <stefanb@linux.ibm.com>
>>>>>> CC: Markus Armbruster <armbru@redhat.com>
>>>>>> CC: Michael Roth <mdroth@linux.vnet.ibm.com>
>>>>>> CC: qemu-block@nongnu.org
>>>>>> CC: xen-devel@lists.xenproject.org
>>>>>>
>>>>>>     include/qapi/error.h | 26 ++++++++++++++++++++++++++
>>>>>>     1 file changed, 26 insertions(+)
>>>>>>
>>>>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>>>>> index ad5b6e896d..d34987148d 100644
>>>>>> --- a/include/qapi/error.h
>>>>>> +++ b/include/qapi/error.h
>>>>>> @@ -309,6 +309,32 @@ void warn_reportf_err(Error *err, const char *f=
mt, ...)
>>>>>>     void error_reportf_err(Error *err, const char *fmt, ...)
>>>>>>         GCC_FMT_ATTR(2, 3);
>>>>>>     +/*
>>>>>> + * Functions to clean Error **errp: call corresponding Error *err c=
leaning
>>>>>> + * function, then set pointer to NULL.
>>>>>> + */
>>>>>> +static inline void error_free_errp(Error **errp)
>>>>>> +{
>>>>>> +    assert(errp && *errp);
>>>>>> +    error_free(*errp);
>>>>>> +    *errp =3D NULL;
>>>>>> +}
>>>>>> +
>>>>>> +static inline void error_report_errp(Error **errp)
>>>>>> +{
>>>>>> +    assert(errp && *errp);
>>>>>> +    error_report_err(*errp);
>>>>>> +    *errp =3D NULL;
>>>>>> +}
>>>>>> +
>>>>>> +static inline void warn_report_errp(Error **errp)
>>>>>> +{
>>>>>> +    assert(errp && *errp);
>>>>>> +    warn_report_err(*errp);
>>>>>> +    *errp =3D NULL;
>>>>>> +}
>>>>>> +
>>>>>> +
>>>>>>     /*
>>>>>>      * Just like error_setg(), except you get to specify the error c=
lass.
>>>>>>      * Note: use of error classes other than ERROR_CLASS_GENERIC_ERR=
OR is
>>>>>
>>>>> These appear to be unused apart from the Coccinelle script in PATCH 0=
3.
>>>>>
>>>>> They are used in the full "[RFC v5 000/126] error: auto propagated
>>>>> local_err" series.  Options:
>>>>>
>>>>> 1. Pick a few more patches into this part I series, so these guys com=
e
>>>>>       with users.
>>>>
>>>> It needs some additional effort for this series.. But it's possible. S=
till,
>>>> I think that we at least should not pull out patches which should be i=
n
>>>> future series (for example from ppc or block/)..
>>>
>>> Yes, we want to keep related stuff together.
>>>
>>>> Grepping through v5:
>>>>    for x in {warn_report_errp,error_report_errp,error_free_errp}; do e=
cho =3D=3D $x =3D=3D; git grep -l $x | grep -v coccinelle | grep -v 'error\=
.h'; echo; done
>>>> =3D=3D warn_report_errp =3D=3D
>>>> block/file-posix.c
>>>> hw/ppc/spapr.c
>>>> hw/ppc/spapr_caps.c
>>>> hw/ppc/spapr_irq.c
>>>> hw/vfio/pci.c
>>>> net/tap.c
>>>> qom/object.c
>>>>
>>>> =3D=3D error_report_errp =3D=3D
>>>> hw/block/vhost-user-blk.c
>>>> util/oslib-posix.c
>>>>
>>>> =3D=3D error_free_errp =3D=3D
>>>> block.c
>>>> block/qapi.c
>>>> block/sheepdog.c
>>>> block/snapshot.c
>>>> blockdev.c
>>>> chardev/char-socket.c
>>>> hw/audio/intel-hda.c
>>>> hw/core/qdev-properties.c
>>>> hw/pci-bridge/pci_bridge_dev.c
>>>> hw/pci-bridge/pcie_pci_bridge.c
>>>> hw/scsi/megasas.c
>>>> hw/scsi/mptsas.c
>>>> hw/usb/hcd-xhci.c
>>>> io/net-listener.c
>>>> migration/colo.c
>>>> qga/commands-posix.c
>>>> qga/commands-win32.c
>>>> util/qemu-sockets.c
>>>>
>>>> What do you want to add?
>>>
>>> PATCH v5 032 uses both error_report_errp() and error_free_errp().
>>> Adding warn_report_errp() without a user is okay with me.  What do you
>>> think?
>>>
>>> If there are patches you consider related to 032, feel free to throw
>>> them in.
>>
>> 032 is qga/commands-win32.c and util/oslib-posix.c
>>
>> Seems that they are wrongly grouped into one patch.
>>
>> qga/commands-win32.c matches qga/ (Michael Roth)
>> and  util/oslib-posix.c matches POSIX (Paolo Bonzini)
>>
>> So, it should be two separate patches anyway.
>>
>> For [1.] I only afraid that we'll have to wait for maintainers, who were
>> not interested in previous iterations, to review these new patches..
>=20
> We won't.
>=20
> We should and we will give every maintainer a chance to review these
> patches, even though the changes are mechanical.  Maintainers are free
> to decline or ignore this offer.  I will feel free to interpret that as
> "go ahead and merge this through your tree".
>=20
> In fact, I fully expect the bulk of the changes to go through my tree.
> Chasing umpteen maintainers for each one to merge a trivial part of this
> massive tree-wide change would take ages and accomplish nothing.
>=20
> [...]
>=20

Hmm, then OK. I'll add these two patches.. Still, you pointed missed in coc=
ci script
cases about error_reportf_err() and warn_reportf_err()... I'm afraid we jus=
t don't have
corresponding files, and therefore don't want to add unused errp wrappers f=
or them..

--=20
Best regards,
Vladimir

