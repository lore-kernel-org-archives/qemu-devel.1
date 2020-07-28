Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751C4C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E965206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SD1tdUn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E965206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0PaQ-0002Wh-G0
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1k0PZh-0001e1-29
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:23:21 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:54293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1k0PZe-0008TB-Ft
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1595942596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xgTc+Csbyx9Na7ogn9lUEBlcyPLWKD+B1ctCLpBJ45I=;
 b=SD1tdUn2Hwe5SNoWiDhN9a5azY8wRILnmZ4HV6GOZd/5c6K4Qeugpg3AfRt+5Kqy8KDyGg
 rJ4LKmk68TOA3XLTWAueAExmuKiWg19VNh5b62A5qz8YSlatJVRt9d9n/NB/QJTrJ4q8J/
 xyTVwfYfuAdmk2SnIg45rXMh19TCQX4=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2057.outbound.protection.outlook.com [104.47.6.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-11-33KHrsaaMLiew5f8xUjX0g-1; Tue, 28 Jul 2020 15:23:14 +0200
X-MC-Unique: 33KHrsaaMLiew5f8xUjX0g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RB2DNW+C3tC9eJjFbZGbzaLjgV2UK6N/2/80Mszu4JRG23ZuWkX7N+vseS0nK5X2flW+u9RRlPU3HgiAAlYKMsyizkcx2NyWEj9YqemVCngaYOLP+pclrYR519h0C6GMi4cuB/xSXREYcuQ880/y3SgG9V0O7mnrc86RN93wZsjTMQoBIaPAsfW2n0MigaNLokkZC1qDs3GXGEa3FyBwBNQoZmF4aHqds9BNJbGFM83hWWZ1bF6bZP6mTxSbL2nmGj6LCdYeAA3QoTxazUVeDhkqCvJmMxXBm0ukJevjRJ71PSFju/+YarcNa0HHbc9Jxz1Mf8hj4RIqM5/fXueIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgTc+Csbyx9Na7ogn9lUEBlcyPLWKD+B1ctCLpBJ45I=;
 b=HuXZHD7IiYgCfqUhvPvjd2RlpEc3x8+DE7QWLUZfiLgtgu0Al46AlMgIZMgT2CWqGLz/xB8M0EH0ArUVO+CkpG/wY45M7cPU6qnZu7QNpQfaBX/lCHzhcr/jmBMyAB8L/WWGh8njljcwetviSEJXhLsWTNeluAw7TKZzM8UVoLhqLmPoJQ+phd0fObHBhutwk332Wm4XYBeRQ/312ZzQkfhMml8aCfT4wlX3bB4qN5QagBwUgmSMm2IQWZYSYy2W9zItbqINSbP7/Wfe2h2t+zDokx2DV6skxYLPTs5DkQZJWJYN69iGdIDtLCXuEq/u819S/PN8vaE5x2uBbZ8H1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=suse.com;
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21) by AM0PR0402MB3761.eurprd04.prod.outlook.com
 (2603:10a6:208:4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Tue, 28 Jul
 2020 13:23:12 +0000
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::ac1e:4b9f:464c:d660]) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::ac1e:4b9f:464c:d660%12]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 13:23:12 +0000
Message-ID: <1d0557af4d3db5d843cb769a993e64c46e56f769.camel@suse.com>
Subject: Re: migration: broken snapshot saves appear on s390 when small
 fields in migration stream removed
From: Bruce Rogers <brogers@suse.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Claudio Fontana
 <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz
 <mreitz@redhat.com>
Date: Tue, 28 Jul 2020 07:23:05 -0600
In-Reply-To: <476f0f77-7676-f69b-99c8-a2bf16e69b94@virtuozzo.com>
References: <8bbafdec-836d-b7de-cab8-7a325b6e238d@suse.de>
 <55c406cd-b9ca-4e9b-0acd-d33cfe2a70e3@redhat.com>
 <bf074240-8cc3-96ff-e95e-bd301822b756@suse.de>
 <ea3b617f-c2ea-534c-06ba-f5f9f43828a7@suse.de>
 <8125b1ff-373a-aadc-eccf-27c567007a27@redhat.com>
 <8ff7eeab-bef1-0957-a95c-72819680c431@suse.de>
 <1db6d502-73d1-5e3d-10d1-796d80ab8f07@suse.de>
 <13728e69-75a5-2edc-9ed3-6e08d94c722d@suse.de>
 <636bb3c4-2242-284b-30cd-299f447117c2@suse.de>
 <5f455e82e0a4f3662918dcdc85d1cfc5a3187896.camel@suse.com>
 <476f0f77-7676-f69b-99c8-a2bf16e69b94@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0022.eurprd02.prod.outlook.com
 (2603:10a6:200:89::32) To AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (63.248.145.198) by
 AM4PR0202CA0022.eurprd02.prod.outlook.com (2603:10a6:200:89::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Tue, 28 Jul 2020 13:23:09 +0000
X-Originating-IP: [63.248.145.198]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87117c24-d66a-4ab1-a682-08d832f960aa
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3761:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB37615544D9D8CD6F10501B57D9730@AM0PR0402MB3761.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sPb6W8MM4GhaqvA9kZ8hcj0Aes9u1eKM7gsXAX6C1oW+VyfxzO1kNID811Q6RYNjahnTD98WyojSU3hNj2alC6tC9TWF3y1uGgCdUOLUqjAaVo/0Lhz2X8LiOQvkjBfV5c+ut8vFKoBuRJMWdWGZFMxnPoQHdkCK9F8YC1yr/TmvR9O3nf3RZ98QZbdQmvaldD2+IAuUv6X12G1Xg9nh1jWX6xsOh+nYL+6TfuiDCaHUzbttv2f9fHRCPeKBiTZxsteat7TVFjD7ZVb1/TmdbBIhUSQwbflY/LgCmC8cM5inW/tmZ3wQJxrm0SqljLJoR8QfQltjFzV6se5/skbVdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR0401MB2354.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(346002)(396003)(39860400002)(376002)(366004)(19627235002)(6486002)(66946007)(66476007)(54906003)(110136005)(2616005)(8676002)(83380400001)(86362001)(66556008)(36756003)(186003)(6666004)(5660300002)(26005)(16526019)(956004)(52116002)(53546011)(478600001)(7416002)(4326008)(316002)(2906002)(8936002)(16576012);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1ntTzX+u4I1ppl8iqnAzN4NxFrdAxLX2GuEFrOk6XkocEctoIxBDlg+uus/euTqdvvBEi9BDgJGAaiWHsl5smbCNcFtIWVx27woyyr0DMTbRd7AzIaL1vveAxmXZnxrcSrl2eQDRIekV9YMDYHxH+WkpO5Av6TUJ9oSG/3YUyBU2LqPSeBPfW+36mLi0LB0qG3RGQ2UXMzHsvupnGPkcdyw5C/AiJoQM6s4u8Xqml9ANxkzC4HGQJR8xIiVzwEhZEekG1rowMt6bwfnQBDFq4JfmBl/jV6/gHv9UQARQMb3olDijwmQP6Iern7z5ZKPBls7v//c/Cb9JXifvlU0VCa7Th9Uxi1k4fsfeCoxtHkjA1uhcD85u5Kq+DWJfzOzcmjYgFRIIseofprFKHJ1FWYkclP3D7NKKRG6LBJhr0gW84lOMPiB91uqTmtxgI7ebyEBQ8iedefo91k/ZbfwlQEHuUuwwK3DVJ3MwuWFhlWU=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87117c24-d66a-4ab1-a682-08d832f960aa
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 13:23:12.7485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6xcibNn8PtbbHk0tUwYp8gRsx5+253hAgLp+JmgwToR1Jv3AXflFXRj3x732lUAg4GBkZqwqkvqkJb7kmuz7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3761
Received-SPF: pass client-ip=51.163.158.102; envelope-from=brogers@suse.com;
 helo=de-smtp-delivery-102.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 09:23:16
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
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-07-28 at 11:43 +0300, Vladimir Sementsov-Ogievskiy wrote:
> 28.07.2020 02:09, Bruce Rogers wrote:
> > On Tue, 2020-07-21 at 10:22 +0200, Claudio Fontana wrote:
> > > On 7/20/20 8:24 PM, Claudio Fontana wrote:
> > > > I have now been able to reproduce this on X86 as well.
> > > > 
> > > > It happens much more rarely, about once every 10 times.
> > > > 
> > > > I will sort out the data and try to make it even more
> > > > reproducible,
> > > > then post my findings in detail.
> > > > 
> > > > Overall I proceeded as follows:
> > > > 
> > > > 1) hooked the savevm code to skip all fields with the exception
> > > > of
> > > > "s390-skeys". So only s390-skeys are actually saved.
> > > > 
> > > > 2) reimplemented "s390-skeys" in a common implementation in
> > > > cpus.c,
> > > > used on both x86 and s390, modeling the behaviour of save/load
> > > > from
> > > > hw/s390
> > > > 
> > > > 3) ran ./check -qcow2 267 on both x86 and s390.
> > > > 
> > > > In the case of s390, failure seems to be reproducible 100% of
> > > > the
> > > > times.
> > > > On X86, it is as mentioned failing about 10% of the times.
> > > > 
> > > > Ciao,
> > > > 
> > > > Claudio
> > > 
> > > And here is a small series of two patches that can be used to
> > > reproduce the problem.
> > > 
> > > Clearly, this is not directly related to s390 or to skeys or to
> > > icount in particular, it is just an issue that happened to be
> > > more
> > > visible there.
> > > 
> > > If you could help with this, please apply the attached patches.
> > > 
> > > Patch 1 just adds a new "300" iotest. It is way easier to extract
> > > the
> > > relevant part out of test 267, which does a bit too much in the
> > > same
> > > file.
> > > Also this allows easier use of valgrind, since it does not
> > > "require"
> > > anything.
> > > 
> > > Patch 2 hooks the savevm code to skip all fields during the
> > > snapshot
> > > with the exception of "s390-skeys", a new artificial field
> > > implemented to
> > > model what the real s390-skeys is doing.
> > > 
> > > After applying patch 1 and patch 2, you can test (also on X86),
> > > with:
> > > 
> > > ./check -qcow2 300
> > > 
> > > On X86 many runs will be successful, but a certain % of them will
> > > instead fail like this:
> > > 
> > > 
> > > claudio@linux-ch70:~/git/qemu-pristine/qemu-build/tests/qemu-
> > > iotests>
> > > ./check -qcow2 300
> > > QEMU          -- "/home/claudio/git/qemu-pristine/qemu-
> > > build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64"
> > > -nodefaults -display none -accel qtest
> > > QEMU_IMG      -- "/home/claudio/git/qemu-pristine/qemu-
> > > build/tests/qemu-iotests/../../qemu-img"
> > > QEMU_IO       -- "/home/claudio/git/qemu-pristine/qemu-
> > > build/tests/qemu-iotests/../../qemu-io"  --cache writeback --aio
> > > threads -f qcow2
> > > QEMU_NBD      -- "/home/claudio/git/qemu-pristine/qemu-
> > > build/tests/qemu-iotests/../../qemu-nbd"
> > > IMGFMT        -- qcow2 (compat=1.1)
> > > IMGPROTO      -- file
> > > PLATFORM      -- Linux/x86_64 linux-ch70 4.12.14-lp151.28.36-
> > > default
> > > TEST_DIR      -- /home/claudio/git/qemu-pristine/qemu-
> > > build/tests/qemu-iotests/scratch
> > > SOCK_DIR      -- /tmp/tmp.gdcUu3l0SM
> > > SOCKET_SCM_HELPER -- /home/claudio/git/qemu-pristine/qemu-
> > > build/tests/qemu-iotests/socket_scm_helper
> > > 
> > > 300      fail       [10:14:05] [10:14:06]      (last:
> > > 0s)    output
> > > mismatch (see 300.out.bad)
> > > --- /home/claudio/git/qemu-pristine/qemu/tests/qemu-
> > > iotests/300.out     2020-07-21 10:03:54.468104764 +0200
> > > +++ /home/claudio/git/qemu-pristine/qemu-build/tests/qemu-
> > > iotests/300.out.bad   2020-07-21 10:14:06.098090543 +0200
> > > @@ -12,6 +12,9 @@
> > >   ID        TAG                 VM
> > > SIZE                DATE       VM
> > > CLOCK
> > >   --        snap0                  SIZE yyyy-mm-dd
> > > hh:mm:ss   00:00:00.000
> > >   (qemu) loadvm snap0
> > > +Unexpected storage key data: 0
> > > +error while loading state for instance 0x0 of device 's390-
> > > skeys'
> > > +Error: Error -22 while loading VM state
> > >   (qemu) quit
> > >   
> > >   *** done
> > > Failures: 300
> > > Failed 1 of 1 iotests
> > > 
> > > 
> > > At this point somebody more knowledgeable about QCOW2, coroutines
> > > and
> > > backing files could chime in?
> > > 
> > <trim>
> > 
> > I used the reproducer you provide here to do a git bisect as I
> > assume
> > whatever is now broken wasn't always broken, and it pointed to the
> > following commit:
> > 
> > commit df893d25ceea3c0dcbe6d6b425309317fab6b22e (refs/bisect/bad)
> > Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > Date:   Tue Jun 4 19:15:13 2019 +0300
> > 
> >      block/qcow2: implement .bdrv_co_preadv_part
> > 
> > Indeed, I am currently able to reliable reproduce the issue with
> > this
> > commit applied, and not reproduce it without it.
> 
> Do you have a reproducer on top of df893d25ceea? I tried to apply the
> patches on it, there are a lot of conflicts and after solving them,
> the test not work for me.
> 
> What do you mean by not reproduce without df893d25ceea3c0d? I also
> tried to do "git rebase df893d25ceea3c0d --onto df893d25ceea3c0d^",
> after applying the reproducing patches on master, but again, there
> are conflicts..
> 
> How did you applied
> 
> commit 88f468e54696cd9ffc28ecf96f18f04125402541
> Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Date:   Mon Sep 16 20:53:22 2019 +0300
> 
>      block/qcow2: refactor qcow2_co_preadv_part
> 
> and, which is more important further
> 
> commit d710cf575ad5fb3ab329204620de45bfe50caa53
> Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Date:   Mon Sep 16 20:53:24 2019 +0300
> 
>      block/qcow2: introduce parallel subrequest handling in read and
> write
> 
> without df893d25ceea3c0d ?
> 
> 
> I can reproduce the bug on master with Claudio's two patches, but how
> to reproduce the relation with df893d25ceea3c0d?
> 
> 

Yeah, I didn't provide full reproducer info for the point where the
patch I mention got applied. No matter, it looks like a fix has been
identified in the mean time.

Thanks for the quick response, though.

Bruce


