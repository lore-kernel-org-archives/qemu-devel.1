Received: from eggs.gnu.org ([2001:4830:134:3::10]:40099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fDCqp-0007Qn-Tf
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fDCqk-0007RU-TF
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:44:35 -0400
Received: from outprodmail01.cc.columbia.edu ([128.59.72.39]:54026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1fDCqk-0007RF-OG
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:44:30 -0400
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w3UHiTPO009512
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 13:44:30 -0400
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id CE9CD87
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 13:44:29 -0400 (EDT)
Received: from sendprodmail01.cc.columbia.edu (sendprodmail01.cc.columbia.edu
	[128.59.72.13]) by hazelnut (Postfix) with ESMTP id 7019E81
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 13:44:26 -0400 (EDT)
Received: from mail-wm0-f71.google.com (mail-wm0-f71.google.com [74.125.82.71])
	by sendprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w3UHiPSd044644
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 13:44:26 -0400
Received: by mail-wm0-f71.google.com with SMTP id 74so3718085wme.0
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 10:44:26 -0700 (PDT)
Received: from mail-wr0-f180.google.com (mail-wr0-f180.google.com.
	[209.85.128.180]) by smtp.gmail.com with ESMTPSA id
	a2-v6sm826157edn.25.2018.04.30.10.44.24 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 30 Apr 2018 10:44:24 -0700 (PDT)
Received: by mail-wr0-f180.google.com with SMTP id p5-v6so8795405wre.12
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 10:44:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHyh4xgMqsxCUOH-_p=DWVWpp0stxfwdfFo2s2cn1nmR2v5Siw@mail.gmail.com>
References: <CAHyh4xgMqsxCUOH-_p=DWVWpp0stxfwdfFo2s2cn1nmR2v5Siw@mail.gmail.com>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Mon, 30 Apr 2018 13:44:23 -0400
Message-ID: <CAHyh4xjzi5CK8+OJPpnr+F2ABpy5Jbbo1S4YR5ATi62LMRn+Pw@mail.gmail.com>
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
To: iommu@lists.linux-foundation.org
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, KVM General <kvm@vger.kernel.org>

Add iommu mailing list since this question might be more related to iommu.

On Mon, Apr 30, 2018 at 10:11 AM, Jintack Lim <jintack@cs.columbia.edu> wrote:
> Hi,
>
> I wonder how to check if Vt-d is capable of posted-interrupt? I'm
> using Intel E5-2630 v3.
>
> I was once told that APICv and posted-interrupt capability always come
> together. But it seems like my cpu support APICv
> (/sys/module/kvm_intel/parameters/enable_apicv is Y), but
> posted-interrupt capability is only shipped with the next generation
> of the cpu (E5-2600 v4, which is Broadwell).
>
> What would be an easy way to check this?
>
> Thanks,
> Jintack
