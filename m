Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91CBECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7062089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7062089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL39A-0002vZ-Vf
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 06:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iL388-0001xT-Ng
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iL385-0007vF-Ks
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:35:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34456)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iL385-0007uk-GC; Thu, 17 Oct 2019 06:35:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A85A58AC6FB;
 Thu, 17 Oct 2019 10:35:36 +0000 (UTC)
Received: from [10.36.117.42] (ovpn-117-42.ams2.redhat.com [10.36.117.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F3FF60BE1;
 Thu, 17 Oct 2019 10:35:33 +0000 (UTC)
Subject: Re: s390x/qemu-user: TODO /home/dhildenb/git/qemu/tcg/tci.c:859:
 tcg_qemu_tb_exec()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <60a0d510-b693-0ed7-560f-e70904d9574d@redhat.com>
 <95ddf722-ba5d-dd48-a840-0d940ded3acd@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2f96242c-7108-f9a6-0a1a-fdef3eee2a47@redhat.com>
Date: Thu, 17 Oct 2019 12:35:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <95ddf722-ba5d-dd48-a840-0d940ded3acd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 17 Oct 2019 10:35:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17.10.19 12:25, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi David,
>=20
> On 10/17/19 12:02 PM, David Hildenbrand wrote:
>> Hi,
>>
>> I'm currently trying to run Fedora 31 under qemu-user
>> (https://github.com/fedora-cloud/docker-brew-fedora/tree/8a81f67271e95=
9dfc8f8a888b161bbd540b7a83b/s390x)
>> in order to debug=C2=A0 a vector instruction issue.
>>
>> Strangely, when trying to chroot into above rootfs and running
>> /bin/bash, I get
>>
>> t460s: ~/f31=C2=A0 $ sudo chroot . ./qemu-s390x=C2=A0 /bin/bash
>> TODO /home/dhildenb/git/qemu/tcg/tci.c:859: tcg_qemu_tb_exec()
>> /home/dhildenb/git/qemu/tcg/tci.c:859: tcg fatal error
>> Aborted
>>
>>
>> But it's not fundamentally broken:
>>
>> t460s: ~/f31=C2=A0 $ sudo chroot . ./qemu-s390x=C2=A0 /bin/ls
>> bin=C2=A0=C2=A0 dev=C2=A0 home=C2=A0 lib64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 media=C2=A0 opt=C2=A0=C2=A0 qemu-s390x=C2=A0 run=C2=A0=C2=A0 srv=C2=
=A0 tmp=C2=A0 var
>> boot=C2=A0 etc=C2=A0 lib=C2=A0=C2=A0 lost+found=C2=A0 mnt=C2=A0=C2=A0=C2=
=A0 proc=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sbin=C2=A0 =
sys=C2=A0 usr
>>
>>
>> I do wonder why we don't run into the same issue under qemu-systems390=
x.
>=20
> Are you also using TCI in system emulation?

Most probably not. It took me longer than expected to find a ./configure=20
variant that at least allows me to build static qemu-user binaries. Most=20
probably something sneeked in there.

>=20
> Can you simply use TCG to debug your vector instruction issue instead?

I was using

./configure --disable-strip --disable-werror --python=3D/usr/bin/python3=20
--enable-tcg-interpreter --disable-system --enable-linux-user --static=20
--disable-pie --disable-sdl --disable-gtk --disable-spice=20
--disable-tools --disable-guest-agent --disable-guest-agent-msi=20
--disable-curses --disable-curl --disable-gnutls --disable-gcrypt=20
--disable-nettle --disable-cap-ng --disable-brlapi --disable-mpath=20
--disable-capstone --disable-xen --disable-rdma=20
--extra-ldflags=3D"-Wl,-z,relro -Wl,-z,now" --target-list=3Ds390x-linux-u=
ser

inspired by the Fedora rpm SPEC.

"--enable-tcg-interpreter" is the relevant bit I blindly copied without=20
thinking about it (in the rpm SPEC, it is wrapped by an ifdef ...)

Thanks for the hint, will try with --disable-tcg-interpreter

>=20
> Regards,
>=20
> Phil.
>=20


--=20

Thanks,

David / dhildenb

