Received: from eggs.gnu.org ([2001:4830:134:3::10]:47523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fDDJH-0001Oe-Q9
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fDDJD-00042B-OF
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:13:59 -0400
Received: from outprodmail01.cc.columbia.edu ([128.59.72.39]:34580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1fDDJD-000421-Ji
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:13:55 -0400
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w3UI9ZFA024491
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 14:13:54 -0400
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id A0BB66D
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 14:13:53 -0400 (EDT)
Received: from sendprodmail02.cc.columbia.edu (sendprodmail02.cc.columbia.edu
	[128.59.72.14]) by hazelnut (Postfix) with ESMTP id 767F281
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 14:13:53 -0400 (EDT)
Received: from mail-wm0-f69.google.com (mail-wm0-f69.google.com [74.125.82.69])
	by sendprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w3UIDqdL009230
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 14:13:53 -0400
Received: by mail-wm0-f69.google.com with SMTP id w74so5321873wmw.0
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 11:13:53 -0700 (PDT)
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com.
	[74.125.82.50]) by smtp.gmail.com with ESMTPSA id
	b43-v6sm4747070edc.34.2018.04.30.11.13.50 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 30 Apr 2018 11:13:50 -0700 (PDT)
Received: by mail-wm0-f50.google.com with SMTP id i3so15626326wmf.3
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 11:13:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180430120941.741f31cb@w520.home>
References: <CAHyh4xgMqsxCUOH-_p=DWVWpp0stxfwdfFo2s2cn1nmR2v5Siw@mail.gmail.com>
	<CAHyh4xjzi5CK8+OJPpnr+F2ABpy5Jbbo1S4YR5ATi62LMRn+Pw@mail.gmail.com>
	<20180430120941.741f31cb@w520.home>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Mon, 30 Apr 2018 14:13:49 -0400
Message-ID: <CAHyh4xjaLUibVMRVfCc5_kyqhu=HYDfZXkcLRmWsoZ=KCyo+MQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] How to check if Vt-d is capable of
 posted-interrupt?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, QEMU Devel Mailing List <qemu-devel@nongnu.org>, KVM General <kvm@vger.kernel.org>

On Mon, Apr 30, 2018 at 2:09 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Mon, 30 Apr 2018 13:44:23 -0400
> Jintack Lim <jintack@cs.columbia.edu> wrote:
>
>> Add iommu mailing list since this question might be more related to iommu.
>>
>> On Mon, Apr 30, 2018 at 10:11 AM, Jintack Lim <jintack@cs.columbia.edu> wrote:
>> > Hi,
>> >
>> > I wonder how to check if Vt-d is capable of posted-interrupt? I'm
>> > using Intel E5-2630 v3.
>> >
>> > I was once told that APICv and posted-interrupt capability always come
>> > together. But it seems like my cpu support APICv
>> > (/sys/module/kvm_intel/parameters/enable_apicv is Y), but
>> > posted-interrupt capability is only shipped with the next generation
>> > of the cpu (E5-2600 v4, which is Broadwell).
>> >
>> > What would be an easy way to check this?
>
> PI support is bit 59 in the capability register which is exposed
> through sysfs at /sys/class/iommu/dmar*/intel-iommu/cap so you could do
> something like:
>
> # for i in $(find /sys/class/iommu/dmar* -type l); do echo -n "$i: "; echo $(( ( 0x$(cat $i/intel-iommu/cap) >> 59 ) & 1 )); done
>

Thanks for a nice solution, Alex.
It turns out my cpu doesn't have the PI capability.
/sys/class/iommu/dmar0: 0
/sys/class/iommu/dmar1: 0

> I think the relationship between APICv and PI goes the other direction,
> if you have PI, you probably have APICv.  Having APICv implies nothing
> about having PI.  Thanks,

Yeah, I think that makes sense.

Thanks,
Jintack

>
> Alex
>
