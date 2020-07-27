Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234BEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 23:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC67120729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 23:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ehKQTLKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC67120729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0CG6-0004n2-Sh
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 19:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1k0CFO-0004MA-PU
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 19:09:31 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:44434)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1k0CFM-0004WR-Mh
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 19:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1595891364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPJT1/q0CRTiwc2paydTmGubTLXTAfM3/uA8TCs2exY=;
 b=ehKQTLKabSs8gG5CjnBeS7HX9/GM+1VR55k4qH0rWHOIlP2EYGefzjeOgB1GR2QP4bc1qj
 JAPnDQ9ZEUodbi64RhwiDKRtxk0DhILLoRsHKU9IsecRtf5WQUUjhbQXu8VfwDhwkOp1EY
 y3P4NOCxM34RQpLomocwML4cGA6V0oQ=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2054.outbound.protection.outlook.com [104.47.14.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-3-SLuzz1uTMR-6BUjb1v-39w-1;
 Tue, 28 Jul 2020 01:09:23 +0200
X-MC-Unique: SLuzz1uTMR-6BUjb1v-39w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRboABEy83bwWi8urOAESFHXJ6OpIEdUb0epfS/tsnj5K5SHLXNu0LSLvpfb78d36ec2skmAh2rlROJoLIGJLLLJ0Ry5kbdYAka3SQqACU8lotQzAtSDfrk20auPhSEysyieRo6l+hnUT1TT/rp+e7Ws/Io5wUXXpQG3zvGL3G2tB3KH1+8bcEHq3FJDN8UMtljkZ4PXf8lkZp8IYou3CWroFvciia0QaKLcgMKZqeSYrPLCqmxd363Vdkha16HQY+2u8GaQ+r+2tlEDC9xb0n9UM0U88BN0tA0gJwLvqTRey0UJ2LtarnuGxN2avKsXI9fgmus/s9x41u3d1pmwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPJT1/q0CRTiwc2paydTmGubTLXTAfM3/uA8TCs2exY=;
 b=g7g5EkJ7ehZU1FFO1UA9gIeYAF3UV2kxkh/DrA64bhneXc+6GsPIxrxBoPkg5H5N+gp5QvgipzmQy7gsECOPUOHtAg/lUPECpNtVX1z6/4Y5jcWhbyCjUJk9pmhblL4fAkjMTn0g7Ji6hnlJCmtZ8RWkVSSbd73XnKC2+POYpxCrGk+5ELxwxzoGUHrQ0I+a4jAJCICIVVE0aGxadEHE59PYooc0l+fAse45XOS4kpkdoG+mZIz/lHq5mrh2LhcuJIxRtdEg9ZkBNgWozij6kD5oRGas1NrutzhmUjzO6YRhlvwRxdTQovVradGCspLtUbmx9u5qwX3FMNxoAozTaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=suse.com;
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21) by AM4PR0401MB2355.eurprd04.prod.outlook.com
 (2603:10a6:200:51::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Mon, 27 Jul
 2020 23:09:20 +0000
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::ac1e:4b9f:464c:d660]) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::ac1e:4b9f:464c:d660%12]) with mapi id 15.20.3216.033; Mon, 27 Jul
 2020 23:09:20 +0000
Message-ID: <5f455e82e0a4f3662918dcdc85d1cfc5a3187896.camel@suse.com>
Subject: Re: migration: broken snapshot saves appear on s390 when small
 fields in migration stream removed
From: Bruce Rogers <brogers@suse.com>
To: Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Date: Mon, 27 Jul 2020 17:09:13 -0600
In-Reply-To: <636bb3c4-2242-284b-30cd-299f447117c2@suse.de>
References: <8bbafdec-836d-b7de-cab8-7a325b6e238d@suse.de>
 <55c406cd-b9ca-4e9b-0acd-d33cfe2a70e3@redhat.com>
 <bf074240-8cc3-96ff-e95e-bd301822b756@suse.de>
 <ea3b617f-c2ea-534c-06ba-f5f9f43828a7@suse.de>
 <8125b1ff-373a-aadc-eccf-27c567007a27@redhat.com>
 <8ff7eeab-bef1-0957-a95c-72819680c431@suse.de>
 <1db6d502-73d1-5e3d-10d1-796d80ab8f07@suse.de>
 <13728e69-75a5-2edc-9ed3-6e08d94c722d@suse.de>
 <636bb3c4-2242-284b-30cd-299f447117c2@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0015.eurprd03.prod.outlook.com
 (2603:10a6:208:14::28) To AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.156.197.180] (65.132.116.252) by
 AM0PR03CA0015.eurprd03.prod.outlook.com (2603:10a6:208:14::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Mon, 27 Jul 2020 23:09:17 +0000
X-Originating-IP: [65.132.116.252]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f16bc0c-4dbf-489e-69b1-08d83282180b
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0401MB235505F2880B200EB0BB70D7D9720@AM4PR0401MB2355.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /JuZTKV0FfK4BS0T6T8FtZlNmKQ1J0OKcL7r+Cbv4p4kVGb4X7hHJcGqa4x//z6/V0Foo/rZRAav/wzS11R0i/SnH2/R6gxFvR+/CvofJuTxsbK/kCrPtAs++3LdUGaNPeEfEM3kqIzw/oAEiIm44ihjNx9cpLWYyuG+J+N2bz+gA7zp+IKsAdWeQfp6RMGSVAXm4byLuvkiMf/bI0UbvCcGAWuUUwCl3iE3hzmT1dLaQkEOR17v+JcbSNCya9n0neMsGs8LHicdHvR3PjLu9Wnx6mUK8LbnAL8uFzq90mrberH3oAzTze53CjAT1jq4/8hG2PfG20jUfdtigsnGwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR0401MB2354.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(39860400002)(366004)(136003)(396003)(376002)(54906003)(36756003)(86362001)(7416002)(83380400001)(5660300002)(8936002)(16526019)(186003)(52116002)(110136005)(26005)(53546011)(19627235002)(2616005)(956004)(316002)(478600001)(16576012)(8676002)(2906002)(6666004)(6486002)(66476007)(66556008)(4326008)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: lWqrKYWqhC1pOVuE48Zu6pe4t1Q8h6uCl8LVltZD8sQLWujvPd00yZ9DeylQ6PdBGR401bd/jsImHyUZ3dPKh1pLqjn/YNWJMs0vgooezprIWDHIoAVsvOdlnEVuCD2kbbLTBBGYkbkI7Fa+D0j8LnR5mou+LWtKZcT3m0gWoP6KVboVdLgbrZCbGCju4OFDcc0pnlzOEVJ3GVT186KeQzj7+ciXtyVNm638S6rIH48aWNBF+f6tkXu4ezYYp42mEOATQT5/dJSl50NJavv6H2WeOaUI1Z4q9ndymylGCAj5S8UTi510ivRUzOpn76tVHZ8ziJBP6F9u1kreP6np2FgRGJYGLZBzg//y90RTLseDyuKSvyfN8qziUyV8WJdjfBCChCaXFbXdEFa0jxRgWD6G1BNBbJT2UpZ32WharTAMWjBpbzhh6+XxC3veBxpIL50l7L8ibhlFpbAtQauFLl10mqUZKrZdirjuHRhYb/pxR+Uh50uimiJE6nm3x4DC
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f16bc0c-4dbf-489e-69b1-08d83282180b
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 23:09:20.7191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4304AWbFatkTFVz1Df0O8wzWmrTkrsmmFBVXE8+G6VY6tT+44aQlgimaTllKB4tcURRJA62GZZdYgFTceFWcAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2355
Received-SPF: pass client-ip=51.163.158.102; envelope-from=brogers@suse.com;
 helo=de-smtp-delivery-102.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 19:09:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Liang Yan <lyan@suse.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 vsementsov@virtuozzo.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-07-21 at 10:22 +0200, Claudio Fontana wrote:
> On 7/20/20 8:24 PM, Claudio Fontana wrote:
> > I have now been able to reproduce this on X86 as well.
> > 
> > It happens much more rarely, about once every 10 times.
> > 
> > I will sort out the data and try to make it even more reproducible,
> > then post my findings in detail.
> > 
> > Overall I proceeded as follows:
> > 
> > 1) hooked the savevm code to skip all fields with the exception of
> > "s390-skeys". So only s390-skeys are actually saved.
> > 
> > 2) reimplemented "s390-skeys" in a common implementation in cpus.c,
> > used on both x86 and s390, modeling the behaviour of save/load from
> > hw/s390
> > 
> > 3) ran ./check -qcow2 267 on both x86 and s390.
> > 
> > In the case of s390, failure seems to be reproducible 100% of the
> > times.
> > On X86, it is as mentioned failing about 10% of the times.
> > 
> > Ciao,
> > 
> > Claudio
> 
> And here is a small series of two patches that can be used to
> reproduce the problem.
> 
> Clearly, this is not directly related to s390 or to skeys or to
> icount in particular, it is just an issue that happened to be more
> visible there.
> 
> If you could help with this, please apply the attached patches.
> 
> Patch 1 just adds a new "300" iotest. It is way easier to extract the
> relevant part out of test 267, which does a bit too much in the same
> file.
> Also this allows easier use of valgrind, since it does not "require"
> anything.
> 
> Patch 2 hooks the savevm code to skip all fields during the snapshot
> with the exception of "s390-skeys", a new artificial field
> implemented to
> model what the real s390-skeys is doing.
> 
> After applying patch 1 and patch 2, you can test (also on X86), with:
> 
> ./check -qcow2 300
> 
> On X86 many runs will be successful, but a certain % of them will
> instead fail like this:
> 
> 
> claudio@linux-ch70:~/git/qemu-pristine/qemu-build/tests/qemu-iotests> 
> ./check -qcow2 300
> QEMU          -- "/home/claudio/git/qemu-pristine/qemu-
> build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64"
> -nodefaults -display none -accel qtest
> QEMU_IMG      -- "/home/claudio/git/qemu-pristine/qemu-
> build/tests/qemu-iotests/../../qemu-img" 
> QEMU_IO       -- "/home/claudio/git/qemu-pristine/qemu-
> build/tests/qemu-iotests/../../qemu-io"  --cache writeback --aio
> threads -f qcow2
> QEMU_NBD      -- "/home/claudio/git/qemu-pristine/qemu-
> build/tests/qemu-iotests/../../qemu-nbd" 
> IMGFMT        -- qcow2 (compat=1.1)
> IMGPROTO      -- file
> PLATFORM      -- Linux/x86_64 linux-ch70 4.12.14-lp151.28.36-default
> TEST_DIR      -- /home/claudio/git/qemu-pristine/qemu-
> build/tests/qemu-iotests/scratch
> SOCK_DIR      -- /tmp/tmp.gdcUu3l0SM
> SOCKET_SCM_HELPER -- /home/claudio/git/qemu-pristine/qemu-
> build/tests/qemu-iotests/socket_scm_helper
> 
> 300      fail       [10:14:05] [10:14:06]      (last: 0s)    output
> mismatch (see 300.out.bad)
> --- /home/claudio/git/qemu-pristine/qemu/tests/qemu-
> iotests/300.out     2020-07-21 10:03:54.468104764 +0200
> +++ /home/claudio/git/qemu-pristine/qemu-build/tests/qemu-
> iotests/300.out.bad   2020-07-21 10:14:06.098090543 +0200
> @@ -12,6 +12,9 @@
>  ID        TAG                 VM SIZE                DATE       VM
> CLOCK
>  --        snap0                  SIZE yyyy-mm-dd
> hh:mm:ss   00:00:00.000
>  (qemu) loadvm snap0
> +Unexpected storage key data: 0
> +error while loading state for instance 0x0 of device 's390-skeys'
> +Error: Error -22 while loading VM state
>  (qemu) quit
>  
>  *** done
> Failures: 300
> Failed 1 of 1 iotests
> 
> 
> At this point somebody more knowledgeable about QCOW2, coroutines and
> backing files could chime in?
> 
<trim>

I used the reproducer you provide here to do a git bisect as I assume
whatever is now broken wasn't always broken, and it pointed to the
following commit:

commit df893d25ceea3c0dcbe6d6b425309317fab6b22e (refs/bisect/bad)
Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date:   Tue Jun 4 19:15:13 2019 +0300

    block/qcow2: implement .bdrv_co_preadv_part

Indeed, I am currently able to reliable reproduce the issue with this
commit applied, and not reproduce it without it.

That said, I've not been able to identify exactly what is going wrong.
I'm fairly confident the savevm data is correctly written out, but on
the loadvm side, somehow the last part of the s390 data is not
correctly read in the data (it's in the second pass through the while
loop in qcow2_co_preadv_part() where that happens.)

If anyone familiar with this code can have a look or provide some
pointers, it would be much appreciated.

Adding commit author to CC.

Thanks,

Bruce


