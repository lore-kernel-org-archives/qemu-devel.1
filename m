Received: from eggs.gnu.org ([2001:4830:134:3::10]:52961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFMpt-0003xq-8p
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:16:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFMpn-0004sc-Js
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:16:17 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:44520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eFMpn-0004nV-D4
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:16:11 -0500
Received: by mail-wm0-x242.google.com with SMTP id r68so1333497wmr.3
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 08:16:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171116161344.GU16461@redhat.com>
References: <1510769835-31902-1-git-send-email-mst@redhat.com>
	<CAFEAcA_f_Pxd8aX606KBamm4sKvodr1xt9o4_hbONnqx1uTBBQ@mail.gmail.com>
	<20171116173033-mutt-send-email-mst@kernel.org>
	<20171116154534.GR16461@redhat.com>
	<20171116175149-mutt-send-email-mst@kernel.org>
	<CAFEAcA_DqWVaZ-oK8S9j9Hqu_AJ5nE2g9waf7Gd5vmeyKGZLsA@mail.gmail.com>
	<20171116161344.GU16461@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Nov 2017 16:15:49 +0000
Message-ID: <CAFEAcA8BC9WPTRFhr_DTAZw9EZRi54-iHCZ+FHyL5g1YtC=j=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] pc, pci, virtio: fixes for rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 16 November 2017 at 16:13, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Thu, Nov 16, 2017 at 04:10:22PM +0000, Peter Maydell wrote:
>> If there are known-buggy iasl versions in the wild we could
>> consider a configure test and treat buggy-iasl like no-iasl.
>
> iasl has long been broken on big-endian, but it has also long contained
> code that simply makes it exit immediately in that case, and qemu copes
> with that. So if there's buggy iasl it would be a distro which removed
> this big-endian check and tried to make it work on big-endian but failed.
> Fedora tried the latter, but at least in rawhide it works properly now.
> I'm unclear if we shipped broken iasl with the BE check removed in stable
> versions though

In this case this is Ubuntu 16.04.2 LTS (xenial) on s390x, with

linux1@lxub05:~$ iasl -v

Intel ACPI Component Architecture
ASL+ Optimizing Compiler version 20160108-64
Copyright (c) 2000 - 2016 Intel Corporation

thanks
-- PMM
