Received: from eggs.gnu.org ([2001:4830:134:3::10]:34352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1epEoO-0005Dw-KA
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1epEoL-00044V-I8
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:59:00 -0500
Received: from outprodmail02.cc.columbia.edu ([128.59.72.51]:57079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1epEoL-000442-D0
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:58:57 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w1NEt8IC048334
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:58:56 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id CE82786
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:58:57 -0500 (EST)
Received: from sendprodmail02.cc.columbia.edu (sendprodmail02.cc.columbia.edu
	[128.59.72.14]) by hazelnut (Postfix) with ESMTP id 1860D85
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:58:57 -0500 (EST)
Received: from mail-wr0-f197.google.com (mail-wr0-f197.google.com
	[209.85.128.197])
	by sendprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w1NEwtiI031524
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:58:55 -0500
Received: by mail-wr0-f197.google.com with SMTP id h14so5678931wre.19
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 06:58:55 -0800 (PST)
Received: from mail-wr0-f175.google.com (mail-wr0-f175.google.com.
	[209.85.128.175])
	by smtp.gmail.com with ESMTPSA id m1sm2207004ede.39.2018.02.23.06.58.53
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Feb 2018 06:58:53 -0800 (PST)
Received: by mail-wr0-f175.google.com with SMTP id u49so14377603wrc.10
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 06:58:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191015735@SHSMSX101.ccr.corp.intel.com>
References: <CAHyh4xii5y-8=uMJeQGARrHZAETtW4ugmBWUypbQ923vk0P3Lw@mail.gmail.com>
	<20180223035555.GL18962@xz-mi>
	<CAHyh4xiCpJQZgtQR-KDrDntZZnAK5V5D=oB7UwQbuZNy7G_z7g@mail.gmail.com>
	<20180223061034.GM18962@xz-mi>
	<CAHyh4xh+EP6-vvrcQiQTBQQ4+3yrQvVFNGrtgt0w57ZZ0LNcZA@mail.gmail.com>
	<20180223070927.GN18962@xz-mi>
	<AADFC41AFE54684AB9EE6CBC0274A5D191015735@SHSMSX101.ccr.corp.intel.com>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Fri, 23 Feb 2018 09:58:52 -0500
Message-ID: <CAHyh4xg2GPwdUK=jnP6SN9AdHzyVSJnu9ZXManF08_nnQna6wA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] intel-iommu and vhost: Do we need 'device-iotlb'
 and 'ats'?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, QEMU Devel Mailing List <qemu-devel@nongnu.org>

Hi Kevin,

On Fri, Feb 23, 2018 at 2:34 AM, Tian, Kevin <kevin.tian@intel.com> wrote:
>> From: Peter Xu
>> Sent: Friday, February 23, 2018 3:09 PM
>>
>> >
>> > Right. I think my question was not clear. My question was that why don=
=E2=80=99t
>> > IOMMU invalidate device-iotlb along with its mappings in one go. Then
>> IOMMU
>> > device driver doesn=E2=80=99t need to flush device-iotlb explicitly. M=
aybe the
>> > reason is that ATS and IOMMU are not always coupled.. but I guess it=
=E2=80=99s
>> time
>> > for me to get some more background :)
>>
>> Ah, I see your point.
>>
>> I don't know the answer.  My wild guess is that IOMMU is just trying
>> to be simple and only provide most basic functionalities, leaving
>> complex stuff to CPU.  For example, if IOMMU takes over the ownership
>> to deliever device-iotlb invalidations when receiving iotlb
>> invalidations, it possibly needs to traverse the device tree sometimes
>> (e.g., for domain invalidations) to know what device is under what
>> domain, which is really compliated.  While it'll be simpler for CPU to
>> do this since it's very possible that the OS keeps a list of devices
>> for a domain already.
>>
>> IMHO that follows the *nix philosophy too - Do One Thing And Do It
>> Well.  Though again, it's wild guess and I may be wrong. :)
>>
>> CCing Alex, in case he has quick answers.
>>
>
> IOMMU and devices are de-coupled. You need a protocol so IOMMU
> knows which device enables translation caches and thus requires
> explicit invalidation, which is how ATS comes to play. ATS is not
> mandatory for vhost, but doing so provides more flexibility e.g.
> to enable I/O page fault if further emulating PCI PRS cap.

Thanks for the explanation!

Thanks,
Jintack

>
> Thanks
> Kevin
