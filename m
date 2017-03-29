Received: from eggs.gnu.org ([2001:4830:134:3::10]:33359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct3oC-0002qm-Kf
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct3o8-0007op-Mh
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:58:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ct3o8-0007of-H7
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:58:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CE638050B
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 02:57:59 +0000 (UTC)
References: <1489980999-5965-1-git-send-email-jasowang@redhat.com>
	<1489980999-5965-3-git-send-email-jasowang@redhat.com>
	<20170320090734.GN17405@pxdev.xzpeter.org>
	<20170321031220-mutt-send-email-mst@kernel.org>
	<3d33b743-3939-9917-fc8c-f13c09ff7f1d@redhat.com>
	<20170321013943.GB3860@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ea385e19-ab6e-c530-b433-8e4281ec304a@redhat.com>
Date: Wed, 29 Mar 2017 10:57:49 +0800
MIME-Version: 1.0
In-Reply-To: <20170321013943.GB3860@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH fixup 2/2] vhost: genearlize iommu memory
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org



On 2017=E5=B9=B403=E6=9C=8821=E6=97=A5 09:39, Peter Xu wrote:
> On Mon, Mar 20, 2017 at 08:21:44PM -0500, Eric Blake wrote:
>> On 03/20/2017 08:12 PM, Michael S. Tsirkin wrote:
>>
>>>> Since this patchset depends on vtd vfio series and fixes its breakag=
e
>>>> to vhost, I'll pick them up for consistency for next post of vtd vfi=
o
>>>> series as well.
>>>>
>>>> Thanks,
>>>>
>>>> -- peterx
>>> Sounds good. It's best to order patches in a way that avoids
>>> breakages even for people that bisect though.
>>> Might require some patch squashing.
>> Indeed - a patch submitted with 'fixup' in the title is usually best
>> incorporated by squashing into a prior patch that has not actually
>> landed in master, rather than as a standalone patch.
>>
>> But if you do post this to master as a standalone patch, please fix th=
e
>> subject line: s/genearlize/generalize/
> Will do. Thanks!
>
> -- peterx

Looks like the assumption were broken by the introducing of bus master=20
container, so this patch is needed for 2.9.  Will post a formal patch=20
for this.

Thanks
