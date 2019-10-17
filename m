Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2B0ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503CD2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503CD2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL3FE-00055V-Gg
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 06:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL3EY-0004aU-5p
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL3EW-0002gl-8h
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:42:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL3EW-0002ft-14
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:42:16 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E309050F45
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 10:42:14 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id m14so731955wru.17
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 03:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w7b4nH/P5f+bAD1c9cUnIsGN8q7TlnpEDNN1DtYchnE=;
 b=Rytji/T253kzQHo+HRPtfCXr+ltiTfu3OgtPbw//P2VCWnrq0XEVmdgh22zWpMlgZS
 bii+6CQAxUthay+fDC3xWXfo+449lMckzMpJTQRY8CoFnlJ/zwUO+KzkvyCOf0BIHOUO
 8kUlXVvKy32W+hi+0472O7g5b/6ZaOn9PrIvYz806GJRlyvKdPdvlpAp2UZoEhtVVPHx
 vQtHV3XhvKKpWB6Fu3pAeQcHlgPferQ19diWB0kxqmq0VuqYMye80J32GBNRNQy5mql0
 MbNOJLiYltUv/l4j8yEZB+dszcM8Zj2ttxYOHv28uVRBRwT3bkqa98ruGwQmVCWJBJNv
 lJNQ==
X-Gm-Message-State: APjAAAXsit4iYuHdzLiZU4u5EghgmD4r5lk7gz+jyrRjW5FxWcPv1IUD
 cBJ+loGyIHkGMPX9CsldaU2Q6YQ9ljOGU+EG75sGbGZJt2MgB+RFG8F0HtOyATEQX+T40TcwjLb
 gnPBkML2G/mHiGgY=
X-Received: by 2002:a5d:664f:: with SMTP id f15mr2443681wrw.358.1571308933665; 
 Thu, 17 Oct 2019 03:42:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx7COTnD81dJcN4mJb42nz2SD1dpFEG2H3OSe9bRjCSpgizoogVGDqVazPhpxyU8CXh39lI1A==
X-Received: by 2002:a5d:664f:: with SMTP id f15mr2443655wrw.358.1571308933328; 
 Thu, 17 Oct 2019 03:42:13 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id f13sm1721057wmj.17.2019.10.17.03.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 03:42:12 -0700 (PDT)
Subject: Re: s390x/qemu-user: TODO /home/dhildenb/git/qemu/tcg/tci.c:859:
 tcg_qemu_tb_exec()
To: David Hildenbrand <david@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <60a0d510-b693-0ed7-560f-e70904d9574d@redhat.com>
 <95ddf722-ba5d-dd48-a840-0d940ded3acd@redhat.com>
 <2f96242c-7108-f9a6-0a1a-fdef3eee2a47@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aa10989e-676e-8f57-cfd3-6b29d1d896ad@redhat.com>
Date: Thu, 17 Oct 2019 12:42:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2f96242c-7108-f9a6-0a1a-fdef3eee2a47@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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

On 10/17/19 12:35 PM, David Hildenbrand wrote:
> On 17.10.19 12:25, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi David,
>>
>> On 10/17/19 12:02 PM, David Hildenbrand wrote:
>>> Hi,
>>>
>>> I'm currently trying to run Fedora 31 under qemu-user
>>> (https://github.com/fedora-cloud/docker-brew-fedora/tree/8a81f67271e9=
59dfc8f8a888b161bbd540b7a83b/s390x)=20
>>>
>>> in order to debug=C2=A0 a vector instruction issue.
>>>
>>> Strangely, when trying to chroot into above rootfs and running
>>> /bin/bash, I get
>>>
>>> t460s: ~/f31=C2=A0 $ sudo chroot . ./qemu-s390x=C2=A0 /bin/bash
>>> TODO /home/dhildenb/git/qemu/tcg/tci.c:859: tcg_qemu_tb_exec()
>>> /home/dhildenb/git/qemu/tcg/tci.c:859: tcg fatal error
>>> Aborted
>>>
>>>
>>> But it's not fundamentally broken:
>>>
>>> t460s: ~/f31=C2=A0 $ sudo chroot . ./qemu-s390x=C2=A0 /bin/ls
>>> bin=C2=A0=C2=A0 dev=C2=A0 home=C2=A0 lib64=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 media=C2=A0 opt=C2=A0=C2=A0 qemu-s390x=C2=A0 run=C2=A0=C2=A0 sr=
v=C2=A0 tmp =20
>>> var
>>> boot=C2=A0 etc=C2=A0 lib=C2=A0=C2=A0 lost+found=C2=A0 mnt=C2=A0=C2=A0=
=C2=A0 proc=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sbin=C2=A0=
 sys=C2=A0 usr
>>>
>>>
>>> I do wonder why we don't run into the same issue under qemu-systems39=
0x.
>>
>> Are you also using TCI in system emulation?
>=20
> Most probably not. It took me longer than expected to find a ./configur=
e=20
> variant that at least allows me to build static qemu-user binaries. Mos=
t=20
> probably something sneeked in there.
>=20
>>
>> Can you simply use TCG to debug your vector instruction issue instead?
>=20
> I was using
>=20
> ./configure --disable-strip --disable-werror --python=3D/usr/bin/python=
3=20
> --enable-tcg-interpreter --disable-system --enable-linux-user --static=20
> --disable-pie --disable-sdl --disable-gtk --disable-spice=20
> --disable-tools --disable-guest-agent --disable-guest-agent-msi=20
> --disable-curses --disable-curl --disable-gnutls --disable-gcrypt=20
> --disable-nettle --disable-cap-ng --disable-brlapi --disable-mpath=20
> --disable-capstone --disable-xen --disable-rdma=20
> --extra-ldflags=3D"-Wl,-z,relro -Wl,-z,now" --target-list=3Ds390x-linux=
-user
>=20
> inspired by the Fedora rpm SPEC.
>=20
> "--enable-tcg-interpreter" is the relevant bit I blindly copied without=
=20
> thinking about it (in the rpm SPEC, it is wrapped by an ifdef ...)

I thought there was a patch adding a big warning when ./configure is run=20
with this option, but I can't find it so maybe we just talked about it.

> Thanks for the hint, will try with --disable-tcg-interpreter
>=20
>>
>> Regards,
>>
>> Phil.
>>

