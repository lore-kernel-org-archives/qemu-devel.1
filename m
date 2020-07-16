Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA7AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B65206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B65206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvxub-0006iI-1s
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 03:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jvxts-0006Gy-AW
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 03:01:48 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:49719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jvxth-0003Ge-Vf
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 03:01:42 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=teawaterz@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0U2sgXws_1594882879; 
Received: from 127.0.0.1(mailfrom:teawaterz@linux.alibaba.com
 fp:SMTPD_---0U2sgXws_1594882879) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 16 Jul 2020 15:01:26 +0800
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [virtio-dev] [RFC for Linux v4 0/2] virtio_balloon: Add
 VIRTIO_BALLOON_F_CONT_PAGES to report continuous pages
From: teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <20200716021929-mutt-send-email-mst@kernel.org>
Date: Thu, 16 Jul 2020 15:01:18 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <744230FA-78D8-4568-8188-683087065E84@linux.alibaba.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <20200716021929-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Received-SPF: pass client-ip=115.124.30.45;
 envelope-from=teawaterz@linux.alibaba.com;
 helo=out30-45.freemail.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 03:01:30
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -98
X-Spam_score: -9.9
X-Spam_bar: ---------
X-Spam_report: (-9.9 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, virtio-dev@lists.oasis-open.org,
 david@redhat.com, qemu-devel@nongnu.org, jasowang@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, akpm@linux-foundation.org, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> 2020=E5=B9=B47=E6=9C=8816=E6=97=A5 14:38=EF=BC=8CMichael S. Tsirkin =
<mst@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Jul 16, 2020 at 10:41:50AM +0800, Hui Zhu wrote:
>> The first, second and third version are in [1], [2] and [3].
>> Code of current version for Linux and qemu is available in [4] and =
[5].
>> Update of this version:
>> 1. Report continuous pages will increase the speed.  So added deflate
>>   continuous pages.
>> 2. According to the comments from David in [6], added 2 new vqs =
inflate_cont_vq
>>   and deflate_cont_vq to report continuous pages with format 32 bits =
pfn and 32
>>   bits size.
>> Following is the introduction of the function.
>> These patches add VIRTIO_BALLOON_F_CONT_PAGES to virtio_balloon. With =
this
>> flag, balloon tries to use continuous pages to inflate and deflate.
>> Opening this flag can bring two benefits:
>> 1. Report continuous pages will increase memory report size of each =
time
>>   call tell_host.  Then it will increase the speed of balloon inflate =
and
>>   deflate.
>> 2. Host THPs will be splitted when qemu release the page of balloon =
inflate.
>>   Inflate balloon with continuous pages will let QEMU release the =
pages
>>   of same THPs.  That will help decrease the splitted THPs number in
>>   the host.
>>   Following is an example in a VM with 1G memory 1CPU.  This test =
setups an
>>   environment that has a lot of fragmentation pages.  Then inflate =
balloon will
>>   split the THPs.


>> // This is the THP number before VM execution in the host.
>> // None use THP.
>> cat /proc/meminfo | grep AnonHugePages:
>> AnonHugePages:         0 kB
These lines are from host.

>> // After VM start, use usemem
>> // =
(https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git)
>> // punch-holes function generates 400m fragmentation pages in the =
guest
>> // kernel.
>> usemem --punch-holes -s -1 800m &
These lines are from guest.  They setups the environment that has a lot =
of fragmentation pages.

>> // This is the THP number after this command in the host.
>> // Some THP is used by VM because usemem will access 800M memory
>> // in the guest.
>> cat /proc/meminfo | grep AnonHugePages:
>> AnonHugePages:    911360 kB
These lines are from host.

>> // Connect to the QEMU monitor, setup balloon, and set it size to =
600M.
>> (qemu) device_add virtio-balloon-pci,id=3Dballoon1
>> (qemu) info balloon
>> balloon: actual=3D1024
>> (qemu) balloon 600
>> (qemu) info balloon
>> balloon: actual=3D600
These lines are from host.

>> // This is the THP number after inflate the balloon in the host.
>> cat /proc/meminfo | grep AnonHugePages:
>> AnonHugePages:     88064 kB
These lines are from host.

>> // Set the size back to 1024M in the QEMU monitor.
>> (qemu) balloon 1024
>> (qemu) info balloon
>> balloon: actual=3D1024
These lines are from host.

>> // Use usemem to increase the memory usage of QEMU.
>> killall usemem
>> usemem 800m
These lines are from guest.

>> // This is the THP number after this operation.
>> cat /proc/meminfo | grep AnonHugePages:
>> AnonHugePages:     65536 kB
These lines are from host.



>>=20
>> Following example change to use continuous pages balloon.  The number =
of
>> splitted THPs is decreased.
>> // This is the THP number before VM execution in the host.
>> // None use THP.
>> cat /proc/meminfo | grep AnonHugePages:
>> AnonHugePages:         0 kB
These lines are from host.

>> // After VM start, use usemem punch-holes function generates 400M
>> // fragmentation pages in the guest kernel.
>> usemem --punch-holes -s -1 800m &
These lines are from guest.  They setups the environment that has a lot =
of fragmentation pages.

>> // This is the THP number after this command in the host.
>> // Some THP is used by VM because usemem will access 800M memory
>> // in the guest.
>> cat /proc/meminfo | grep AnonHugePages:
>> AnonHugePages:    911360 kB
These lines are from host.

>> // Connect to the QEMU monitor, setup balloon, and set it size to =
600M.
>> (qemu) device_add virtio-balloon-pci,id=3Dballoon1,cont-pages=3Don
>> (qemu) info balloon
>> balloon: actual=3D1024
>> (qemu) balloon 600
>> (qemu) info balloon
>> balloon: actual=3D600
These lines are from host.

>> // This is the THP number after inflate the balloon in the host.
>> cat /proc/meminfo | grep AnonHugePages:
>> AnonHugePages:    616448 kB
>> // Set the size back to 1024M in the QEMU monitor.
>> (qemu) balloon 1024
>> (qemu) info balloon
>> balloon: actual=3D1024
These lines are from host.

>> // Use usemem to increase the memory usage of QEMU.
>> killall usemem
>> usemem 800m
These lines are from guest.

>> // This is the THP number after this operation.
>> cat /proc/meminfo | grep AnonHugePages:
>> AnonHugePages:    907264 kB
These lines are from host.

>=20
> I'm a bit confused about which of the above run within guest,
> and which run within host. Could you explain pls?
>=20
>=20

I added some introduction to show where these lines is get from.

Best,
Hui


>=20
>> [1] https://lkml.org/lkml/2020/3/12/144
>> [2] =
https://lore.kernel.org/linux-mm/1584893097-12317-1-git-send-email-teawate=
r@gmail.com/
>> [3] https://lkml.org/lkml/2020/5/12/324
>> [4] https://github.com/teawater/linux/tree/balloon_conts
>> [5] https://github.com/teawater/qemu/tree/balloon_conts
>> [6] https://lkml.org/lkml/2020/5/13/1211
>>=20
>> Hui Zhu (2):
>>  virtio_balloon: Add VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
>>  virtio_balloon: Add deflate_cont_vq to deflate continuous pages
>>=20
>> drivers/virtio/virtio_balloon.c     |  180 =
+++++++++++++++++++++++++++++++-----
>> include/linux/balloon_compaction.h  |   12 ++
>> include/uapi/linux/virtio_balloon.h |    1
>> mm/balloon_compaction.c             |  117 +++++++++++++++++++++--
>> 4 files changed, 280 insertions(+), 30 deletions(-)
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


