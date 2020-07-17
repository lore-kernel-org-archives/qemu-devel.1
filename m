Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4A9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 03:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E139320739
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 03:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E139320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwHRf-0004PY-7F
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 23:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jwHQy-0003yU-2d
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 23:53:16 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:47780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jwHQq-0001x9-5t
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 23:53:11 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01355; MF=teawaterz@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0U2yEEgS_1594957963; 
Received: from 127.0.0.1(mailfrom:teawaterz@linux.alibaba.com
 fp:SMTPD_---0U2yEEgS_1594957963) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 17 Jul 2020 11:52:53 +0800
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [virtio-dev] [RFC for Linux v4 0/2] virtio_balloon: Add
 VIRTIO_BALLOON_F_CONT_PAGES to report continuous pages
From: teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <20200716064340-mutt-send-email-mst@kernel.org>
Date: Fri, 17 Jul 2020 11:52:42 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <A8B48063-59E3-4398-B41F-9CABA9DFA7AC@linux.alibaba.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <20200716021929-mutt-send-email-mst@kernel.org>
 <744230FA-78D8-4568-8188-683087065E84@linux.alibaba.com>
 <20200716064340-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Received-SPF: pass client-ip=115.124.30.44;
 envelope-from=teawaterz@linux.alibaba.com;
 helo=out30-44.freemail.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:52:59
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
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> 2020=E5=B9=B47=E6=9C=8816=E6=97=A5 18:45=EF=BC=8CMichael S. Tsirkin =
<mst@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Jul 16, 2020 at 03:01:18PM +0800, teawater wrote:
>>=20
>>=20
>>> 2020=E5=B9=B47=E6=9C=8816=E6=97=A5 14:38=EF=BC=8CMichael S. Tsirkin =
<mst@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Thu, Jul 16, 2020 at 10:41:50AM +0800, Hui Zhu wrote:
>>>> The first, second and third version are in [1], [2] and [3].
>>>> Code of current version for Linux and qemu is available in [4] and =
[5].
>>>> Update of this version:
>>>> 1. Report continuous pages will increase the speed.  So added =
deflate
>>>>  continuous pages.
>>>> 2. According to the comments from David in [6], added 2 new vqs =
inflate_cont_vq
>>>>  and deflate_cont_vq to report continuous pages with format 32 bits =
pfn and 32
>>>>  bits size.
>>>> Following is the introduction of the function.
>>>> These patches add VIRTIO_BALLOON_F_CONT_PAGES to virtio_balloon. =
With this
>>>> flag, balloon tries to use continuous pages to inflate and deflate.
>>>> Opening this flag can bring two benefits:
>>>> 1. Report continuous pages will increase memory report size of each =
time
>>>>  call tell_host.  Then it will increase the speed of balloon =
inflate and
>>>>  deflate.
>>>> 2. Host THPs will be splitted when qemu release the page of balloon =
inflate.
>>>>  Inflate balloon with continuous pages will let QEMU release the =
pages
>>>>  of same THPs.  That will help decrease the splitted THPs number in
>>>>  the host.
>>>>  Following is an example in a VM with 1G memory 1CPU.  This test =
setups an
>>>>  environment that has a lot of fragmentation pages.  Then inflate =
balloon will
>>>>  split the THPs.
>>=20
>>=20
>>>> // This is the THP number before VM execution in the host.
>>>> // None use THP.
>>>> cat /proc/meminfo | grep AnonHugePages:
>>>> AnonHugePages:         0 kB
>> These lines are from host.
>>=20
>>>> // After VM start, use usemem
>>>> // =
(https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git)
>>>> // punch-holes function generates 400m fragmentation pages in the =
guest
>>>> // kernel.
>>>> usemem --punch-holes -s -1 800m &
>> These lines are from guest.  They setups the environment that has a =
lot of fragmentation pages.
>>=20
>>>> // This is the THP number after this command in the host.
>>>> // Some THP is used by VM because usemem will access 800M memory
>>>> // in the guest.
>>>> cat /proc/meminfo | grep AnonHugePages:
>>>> AnonHugePages:    911360 kB
>> These lines are from host.
>>=20
>>>> // Connect to the QEMU monitor, setup balloon, and set it size to =
600M.
>>>> (qemu) device_add virtio-balloon-pci,id=3Dballoon1
>>>> (qemu) info balloon
>>>> balloon: actual=3D1024
>>>> (qemu) balloon 600
>>>> (qemu) info balloon
>>>> balloon: actual=3D600
>> These lines are from host.
>>=20
>>>> // This is the THP number after inflate the balloon in the host.
>>>> cat /proc/meminfo | grep AnonHugePages:
>>>> AnonHugePages:     88064 kB
>> These lines are from host.
>>=20
>>>> // Set the size back to 1024M in the QEMU monitor.
>>>> (qemu) balloon 1024
>>>> (qemu) info balloon
>>>> balloon: actual=3D1024
>> These lines are from host.
>>=20
>>>> // Use usemem to increase the memory usage of QEMU.
>>>> killall usemem
>>>> usemem 800m
>> These lines are from guest.
>>=20
>>>> // This is the THP number after this operation.
>>>> cat /proc/meminfo | grep AnonHugePages:
>>>> AnonHugePages:     65536 kB
>> These lines are from host.
>>=20
>>=20
>>=20
>>>>=20
>>>> Following example change to use continuous pages balloon.  The =
number of
>>>> splitted THPs is decreased.
>>>> // This is the THP number before VM execution in the host.
>>>> // None use THP.
>>>> cat /proc/meminfo | grep AnonHugePages:
>>>> AnonHugePages:         0 kB
>> These lines are from host.
>>=20
>>>> // After VM start, use usemem punch-holes function generates 400M
>>>> // fragmentation pages in the guest kernel.
>>>> usemem --punch-holes -s -1 800m &
>> These lines are from guest.  They setups the environment that has a =
lot of fragmentation pages.
>>=20
>>>> // This is the THP number after this command in the host.
>>>> // Some THP is used by VM because usemem will access 800M memory
>>>> // in the guest.
>>>> cat /proc/meminfo | grep AnonHugePages:
>>>> AnonHugePages:    911360 kB
>> These lines are from host.
>>=20
>>>> // Connect to the QEMU monitor, setup balloon, and set it size to =
600M.
>>>> (qemu) device_add virtio-balloon-pci,id=3Dballoon1,cont-pages=3Don
>>>> (qemu) info balloon
>>>> balloon: actual=3D1024
>>>> (qemu) balloon 600
>>>> (qemu) info balloon
>>>> balloon: actual=3D600
>> These lines are from host.
>>=20
>>>> // This is the THP number after inflate the balloon in the host.
>>>> cat /proc/meminfo | grep AnonHugePages:
>>>> AnonHugePages:    616448 kB
>>>> // Set the size back to 1024M in the QEMU monitor.
>>>> (qemu) balloon 1024
>>>> (qemu) info balloon
>>>> balloon: actual=3D1024
>> These lines are from host.
>>=20
>>>> // Use usemem to increase the memory usage of QEMU.
>>>> killall usemem
>>>> usemem 800m
>> These lines are from guest.
>>=20
>>>> // This is the THP number after this operation.
>>>> cat /proc/meminfo | grep AnonHugePages:
>>>> AnonHugePages:    907264 kB
>> These lines are from host.
>>=20
>>>=20
>>> I'm a bit confused about which of the above run within guest,
>>> and which run within host. Could you explain pls?
>>>=20
>>>=20
>>=20
>> I added some introduction to show where these lines is get from.
>>=20
>> Best,
>> Hui
>=20
>=20
> OK so we see host has more free THPs. But guest has presumably less =
now - so
> the total page table depth is the same. Did we gain anything?
>=20


cat /proc/meminfo | grep AnonHugePages:
This command will output how many THPs is used by current system.
There is no program using THPs except qemu.
So this command will show how many THPs is used by qemu.

The last outout of =E2=80=9Ccat /proc/meminfo | grep AnonHugePages:=E2=80=9D=
 show how many THPs is used by qemu when this 2 qemu=E2=80=99s anon page =
number is same.
Without =E2=80=9Ccont-pages=3Don=E2=80=9D, qemu keep 65536kb THPs.
Wiht =E2=80=9Ccont-pages=3Don=E2=80=9D, qemu keep 907264kb THPs.
Keep more THPs will make memory access speed high.

This is a test record use this 1G 1 cpu qemu after the fragmentation =
balloon test:
Without =E2=80=9Ccont-pages=3Don=E2=80=9D, qemu keep 81920kB THPs.
/ # usemem 800m
943718400 bytes / 489412 usecs =3D 1883076 KB/s
18725 usecs to free memory
/ # usemem 800m
943718400 bytes / 487070 usecs =3D 1892130 KB/s
18913 usecs to free memory
/ # usemem 800m
943718400 bytes / 484234 usecs =3D 1903212 KB/s
18538 usecs to free memory
/ # usemem 800m
943718400 bytes / 486568 usecs =3D 1894082 KB/s
18982 usecs to free memory

With =E2=80=9Ccont-pages=3Don=E2=80=9D, qemu keep 907264kb THPs.
/ # usemem 800m
943718400 bytes / 479098 usecs =3D 1923614 KB/s
18980 usecs to free memory
/ # usemem 800m
943718400 bytes / 477433 usecs =3D 1930323 KB/s
18562 usecs to free memory
/ # usemem 800m
943718400 bytes / 479790 usecs =3D 1920840 KB/s
18663 usecs to free memory
/ # usemem 800m
943718400 bytes / 480253 usecs =3D 1918988 KB/s
19011 usecs to free memory

Best,
Hui



>>=20
>>>=20
>>>> [1] https://lkml.org/lkml/2020/3/12/144
>>>> [2] =
https://lore.kernel.org/linux-mm/1584893097-12317-1-git-send-email-teawate=
r@gmail.com/
>>>> [3] https://lkml.org/lkml/2020/5/12/324
>>>> [4] https://github.com/teawater/linux/tree/balloon_conts
>>>> [5] https://github.com/teawater/qemu/tree/balloon_conts
>>>> [6] https://lkml.org/lkml/2020/5/13/1211
>>>>=20
>>>> Hui Zhu (2):
>>>> virtio_balloon: Add VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
>>>> virtio_balloon: Add deflate_cont_vq to deflate continuous pages
>>>>=20
>>>> drivers/virtio/virtio_balloon.c     |  180 =
+++++++++++++++++++++++++++++++-----
>>>> include/linux/balloon_compaction.h  |   12 ++
>>>> include/uapi/linux/virtio_balloon.h |    1
>>>> mm/balloon_compaction.c             |  117 +++++++++++++++++++++--
>>>> 4 files changed, 280 insertions(+), 30 deletions(-)
>>>=20
>>>=20
>>> =
---------------------------------------------------------------------
>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail: =
virtio-dev-help@lists.oasis-open.org


