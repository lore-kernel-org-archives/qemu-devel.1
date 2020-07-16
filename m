Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DD8C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D75B20760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D75B20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvzDN-0000B8-Ia
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 04:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jvzCl-00083W-54
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 04:25:23 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:44312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jvzCd-0001Sx-Ct
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 04:25:17 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=teawaterz@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0U2shvgI_1594887901; 
Received: from 127.0.0.1(mailfrom:teawaterz@linux.alibaba.com
 fp:SMTPD_---0U2shvgI_1594887901) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 16 Jul 2020 16:25:05 +0800
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC for Linux v4 1/2] virtio_balloon: Add
 VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
From: teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <20200716024114-mutt-send-email-mst@kernel.org>
Date: Thu, 16 Jul 2020 16:25:00 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <CEB4BCB7-E146-4F62-A8AC-8641B5469963@linux.alibaba.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <1594867315-8626-2-git-send-email-teawater@gmail.com>
 <20200716024114-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Received-SPF: pass client-ip=115.124.30.57;
 envelope-from=teawaterz@linux.alibaba.com;
 helo=out30-57.freemail.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:08
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -98
X-Spam_score: -9.9
X-Spam_bar: ---------
X-Spam_report: (-9.9 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001,
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
Cc: virtio-dev@lists.oasis-open.org, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 linux-kernel@vger.kernel.org,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> 2020=E5=B9=B47=E6=9C=8816=E6=97=A5 14:43=EF=BC=8CMichael S. Tsirkin =
<mst@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Jul 16, 2020 at 10:41:51AM +0800, Hui Zhu wrote:
>> diff --git a/include/uapi/linux/virtio_balloon.h =
b/include/uapi/linux/virtio_balloon.h
>> index dc3e656..4d0151a 100644
>> --- a/include/uapi/linux/virtio_balloon.h
>> +++ b/include/uapi/linux/virtio_balloon.h
>> @@ -37,6 +37,7 @@
>> #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free =
pages */
>> #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page =
poisoning */
>> #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
>> +#define VIRTIO_BALLOON_F_CONT_PAGES	6 /* VQ to report continuous =
pages */
>>=20
>> /* Size of a PFN in the balloon interface. */
>> #define VIRTIO_BALLOON_PFN_SHIFT 12
>=20
> So how does the guest/host interface look like?
> Could you write up something about it?

Continuous pages are report by num_pfns and pfns in virtio_balloon too.
The function to set pfns is set_page_pfns_size in =
https://github.com/teawater/linux/blob/balloon_conts/drivers/virtio/virtio=
_balloon.c#L221

static void set_page_pfns_size(struct virtio_balloon *vb,
                               __virtio32 pfns[], struct page *page,
                               size_t size)
{
        /* Set the first pfn of the continuous pages.  */
        pfns[0] =3D cpu_to_virtio32(vb->vdev, =
page_to_balloon_pfn(page));
        /* Set the size of the continuous pages.  */
        pfns[1] =3D (__virtio32) size;
}

Each of continuous pages need 2 pfn.
The first pfn of the pages is set to pfns[0].  The size of the pages is =
set to pfns[1].

The pfn is 32 bits.
So the max order of inflate continuous pages is =
VIRTIO_BALLOON_INFLATE_MAX_ORDER.
#define VIRTIO_BALLOON_INFLATE_MAX_ORDER min((int) (sizeof(__virtio32) * =
BITS_PER_BYTE - \
                                                    1 - PAGE_SHIFT), =
(MAX_ORDER-1))

The max page number of deflate continuous pages is =
VIRTIO_BALLOON_DEFLATE_MAX_PAGES_NUM.
#define VIRTIO_BALLOON_DEFLATE_MAX_PAGES_NUM (((__virtio32)~0U) >> =
PAGE_SHIFT)

Best,
Hui=

