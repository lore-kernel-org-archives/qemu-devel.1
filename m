Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDEEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1500721775
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XLs/5aFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1500721775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8ofD-0003Zt-V3
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 12:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1j8obq-0001nZ-8E
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1j8obo-0006HH-Mm
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:12:02 -0500
Received: from mout.gmx.net ([212.227.17.21]:47399)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1j8obo-0006Ee-Dn
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1583169110;
 bh=/WkRJwuECeEzFDnZooaaMKRACGiqYybwn61KPrXEkTI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=XLs/5aFyQ2hJ65DoHa4Ybi8JEIzJCMdA9VeeGSDJ6Ka+naUCh6T669881e5MUHNuI
 yStT4ZTvAqekel8uQcmhFED113LUDmRE28ENPHqdfFTdtQC+jJlZk44hB/DZdD5kEj
 j8nmwBoGignBSl7WDYvqnRyo3MgryA/+p4VHcopQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Msq6C-1jOPcM1OYq-00tCh7; Mon, 02
 Mar 2020 18:11:50 +0100
Subject: Re: [PATCH v4 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200206115731.13552-1-n54@gmx.com>
 <20200206213232.1918-1-n54@gmx.com>
 <3d63b5ea-2da8-499e-c617-c25a7d87106e@gmx.com>
 <b26b1c03-cb2b-9c8b-4796-24b3b296a103@gmx.com>
 <48851271-4a15-f207-ba17-335d9c9a7302@gmx.com>
 <20200302171027.GH4440@habkost.net>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <01e0ef70-b4de-1b74-1596-a816e111bd58@gmx.com>
Date: Mon, 2 Mar 2020 18:10:50 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302171027.GH4440@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GdQ9ygAAqZBxkRT7eQ+BjS3MNH5YNwJpR8nmLzvELVnUWjt68oJ
 X61n3gq2X0WtLKeVImSKr/tf+nY0RfJoA+ouorGI0P0BArCPHcJmke6ryn2Ows4Y6cMvG6i
 8Q7laQB06drr+rSsX2a5q5BVXJq6rBEJ/z3VEZ0DGBxBdDkoK2T9yVf1Ba2WprQLYPGMzK8
 7SwKkgXIOCuC+zoKxaT+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:huBUUZsQonE=:4NCTjheLShMmxEYkX/z5cZ
 XflbiBTeiZuw3EhMiMrH1CGTQKvhgofWGSHwmn1KN2kuWrJV0Bys/l3en5b9CNqqR5+APdAkf
 fKvfoqA8tWofWWPA7FNbUXA/eUu61+HkYTYss2TX8LD3fer6yYYfqeu/3DEju523HIEnRUZnP
 1Jtbx7qJ09eJPFnxeG3gATIC4wKznybwBDkA02GMKmVCYjZdQm1Zy5ZkT6sSiq/EgRZBEziNv
 fEUAoV4ywkQX8OhcN++LI90Dsh5JJ8b5v7WIyFoX0cCPj4BRK7p/uNFW0k+sL6+ZhSgDPiVrV
 gckbmEP8k6A0/TZIsNKCUAKZAbE2iaTyHoNi1IUxCUdXSXy5zT3l0uMMwwBcY/AIeprwX4ikh
 SMJK2EQaCVvWTsx6tOMvb8G8q3OdkU9p6M+JIDn7EAWj9nush/uGcb/ZQon2dic8KvC7hKVF3
 QjzTULf76+686ubreEWPojoopxgOjoy0ESpNLdq4cYGUYCkdrdKnT/MdB8zBzvjry7qO+UXq9
 tb+knhiWG2S7SFtpyPwGfnEV0e0HXmisy/3Sha3L1i5oQ9fi8vxS/7aIBFrqt4mnKIPZgEyBZ
 /47/Bz+4ZlcCO9Sjsa9KyHAD/VYUfqp4MlhqG+JtiRaQCV+aTDvG6DV1GI3pUTkReqzQPcdnH
 /8SaarqbunmqyWz27n4zcs8wdidSwQjEQrwPFlJ0GWsf/3a6SxYlwAnSjSqAOghdOqT6ZN3sx
 t23MtL73XrX+rDwhDAKZljLocPqxCVDFuJVdHAgZtTkzhG4cSAQFoTMU9qI2FhI8TjgVnUPf9
 0RV45/uTCx0wdYjy7WEURyaFPJDqyKgYecQnBVcd2nFeUeh1bIWxpoO8dNPTbCdRkTwP9ReVL
 6VESBKFrsFLZW9bfaJQpFkpkTnzKvt1TBfMwdYE0CGhcQ9TJct8eCZhHHBC5DKekVhGfshT+G
 zSy0XbkjbcoEjD4xP3Fxc8+ziREbvK80jGH0qEixZlLHQPRuuusB+Gfba9Yrne6yH57/qsvjh
 T+cH4KPjnLHteYmCtFd+SmmLBSCnuxIudYqYwL0TmAJFCveEkOn2DVM3mfgLE6eVimubFn4To
 Oc4zmGilvPiPC1SVPHsNvKruCpB0l1miz4yUJWCW4BAZ+SJF1w3opjYflHJGl56IWeu5RX1Zx
 z40GyVDEsIv6sf727jU/UerZNF1IDjBxk4G1XQN0aYXzPYwDw1/bxHmrzYvJZNGnSPS0A=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.21
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
Cc: peter.maydell@linaro.org, slp@redhat.com, qemu-devel@nongnu.org,
 jmcneill@invisible.ca, pbonzini@redhat.com, philmd@redhat.com, max@m00nbsd.net,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02.03.2020 18:10, Eduardo Habkost wrote:
> Hi Kamil, Maxime,
>
> I haven't managed to reserve time to review this, sorry for that.
> I hope others can chime in before I do.
>
> Would any of you be willing to be included as maintainer of the
> new code on MAINTAINERS?
>

I'm already mentioned as the NetBSD maintainer and NVMM is NetBSD-only
(at least today).

>
> On Mon, Mar 02, 2020 at 06:02:18PM +0100, Kamil Rytarowski wrote:
>> Ping?
>>
>> On 24.02.2020 16:17, Kamil Rytarowski wrote:
>>> Ping?
>>>
>>> On 17.02.2020 10:07, Kamil Rytarowski wrote:
>>>> Ping?
>>>>
>>>> On 06.02.2020 22:32, Kamil Rytarowski wrote:
>>>>> Hello QEMU Community!
>>>>>
>>>>> Over the past year the NetBSD team has been working hard on a new us=
er-mode API
>>>>> for our hypervisor that will be released as part of the upcoming Net=
BSD 9.0.
>>>>> This new API adds user-mode capabilities to create and manage virtua=
l machines,
>>>>> configure memory mappings for guest machines, and create and control=
 execution
>>>>> of virtual processors.
>>>>>
>>>>> With this new API we are now able to bring our hypervisor to the QEM=
U
>>>>> community! The following patches implement the NetBSD Virtual Machin=
e Monitor
>>>>> accelerator (NVMM) for QEMU on NetBSD 9.0 and newer hosts.
>>>>>
>>>>> When compiling QEMU for x86_64 passing the --enable-nvmm flag will c=
ompile the
>>>>> accelerator for use. At runtime using the '-accel nvmm' should see a
>>>>> significant performance improvement over emulation, much like when u=
sing 'hax'
>>>>> on NetBSD.
>>>>>
>>>>> The documentation for this new API is visible at https://man.netbsd.=
org under
>>>>> the libnvmm(3) and nvmm(4) pages.
>>>>>
>>>>> NVMM was designed and implemented by Maxime Villard.
>>>>>
>>>>> Thank you for your feedback.
>>>>>
>>>>> Refrences:
>>>>> https://m00nbsd.net/4e0798b7f2620c965d0dd9d6a7a2f296.html
>>>>>
>>>>> Test plan:
>>>>>
>>>>> 1. Download a NetBSD 9.0 pre-release snapshot:
>>>>> http://nycdn.netbsd.org/pub/NetBSD-daily/netbsd-9/latest/images/NetB=
SD-9.0_RC1-amd64.iso
>>>>>
>>>>> 2. Install it natively on a not too old x86_64 hardware (Intel or AM=
D).
>>>>>
>>>>> There is no support for nested virtualization in NVMM.
>>>>>
>>>>> 3. Setup the system.
>>>>>
>>>>>  export PKG_PATH=3Dhttp://www.ki.nu/pkgsrc/packages/current/NetBSD-9=
.0_RC1/All
>>>>>  pkg_add git gmake python37 glib2 bison pkgconf pixman
>>>>>
>>>>> Install mozilla-rootcerts and follow post-install instructions.
>>>>>
>>>>>  pkg_add mozilla-rootcerts
>>>>>
>>>>> More information: https://wiki.qemu.org/Hosts/BSD#NetBSD
>>>>>
>>>>> 4. Build qemu
>>>>>
>>>>>  mkdir build
>>>>>  cd build
>>>>>  ../configure --python=3Dpython3.7
>>>>>  gmake
>>>>>  gmake check
>>>>>
>>>>> 5. Test
>>>>>
>>>>>  qemu -accel nvmm ...
>>>>>
>>>>>
>>>>> History:
>>>>> v3 -> v4:
>>>>>  - Correct build warning by adding a missing include
>>>>>  - Do not set R8-R16 registers unless TARGET_X86_64
>>>>> v2 -> v3:
>>>>>  - Register nvmm in targetos NetBSD check
>>>>>  - Stop including hw/boards.h
>>>>>  - Rephrase old code comments (remove XXX)
>>>>> v1 -> v2:
>>>>>  - Included the testing plan as requested by Philippe Mathieu-Daude
>>>>>  - Formatting nit fix in qemu-options.hx
>>>>>  - Document NVMM in the accel section of qemu-options.hx
>>>>>
>>>>> Maxime Villard (4):
>>>>>   Add the NVMM vcpu API
>>>>>   Add the NetBSD Virtual Machine Monitor accelerator.
>>>>>   Introduce the NVMM impl
>>>>>   Add the NVMM acceleration enlightenments
>>>>>
>>>>>  accel/stubs/Makefile.objs |    1 +
>>>>>  accel/stubs/nvmm-stub.c   |   43 ++
>>>>>  configure                 |   37 ++
>>>>>  cpus.c                    |   58 ++
>>>>>  include/sysemu/hw_accel.h |   14 +
>>>>>  include/sysemu/nvmm.h     |   35 ++
>>>>>  qemu-options.hx           |   16 +-
>>>>>  target/i386/Makefile.objs |    1 +
>>>>>  target/i386/helper.c      |    2 +-
>>>>>  target/i386/nvmm-all.c    | 1226 ++++++++++++++++++++++++++++++++++=
+++
>>>>>  10 files changed, 1424 insertions(+), 9 deletions(-)
>>>>>  create mode 100644 accel/stubs/nvmm-stub.c
>>>>>  create mode 100644 include/sysemu/nvmm.h
>>>>>  create mode 100644 target/i386/nvmm-all.c
>>>>>
>>>>> --
>>>>> 2.25.0
>>>>>
>>>>>
>>>>
>>>
>>
>


