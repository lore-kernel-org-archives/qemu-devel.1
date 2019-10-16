Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDCBC4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD27D21835
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="L4Ej24Mq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD27D21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKeiH-0006Yj-U3
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 04:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iKedE-0005VF-4R
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iKedC-0005eE-Rf
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:26:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:34445)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iKedC-0005df-DT
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1571214345;
 bh=SRMMTBzljmn8SJhFt/M1BvrZjfZd0EjYHluCPMN8u2I=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=L4Ej24MqTFotRuddK2Z6lDkQXtXgSM2idgo6fIQu/fXsCzRFIxQLzDXC7wBnEGAwm
 wPvpTYnKaF1T8/LAPSv+2OmgpEKinXux46QuoAhHLnawkyD5xHk7UuS8PApUXDx3xq
 m4KgqvePNffremRb425kRqqhz84xDH8HFWC8ucD0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNKhm-1iiEBm3jiM-00OlRo; Wed, 16
 Oct 2019 10:25:45 +0200
Subject: Re: Python 2 and test/vm/netbsd
To: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20191016030021.GD4084@habkost.net>
 <a83d518a-6e39-0017-203d-2ee3d61935ca@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <b61252af-9eae-d655-0602-d270ce6223ef@gmx.com>
Date: Wed, 16 Oct 2019 10:25:57 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <a83d518a-6e39-0017-203d-2ee3d61935ca@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rMy6prtXtoLon0MXVoSkS1RG6+xIzB++b8Ffnisuzh96u3kdL8q
 xvo38YJN/47rspHm324PjGhMDJ+bf3nIeQyYcxS55S4/KocMndZTyBtOn5bffIiLtt1zfki
 a6u7koZyhAJvOPOWhjyOVZOQ5g52IWeku6hv8Qxt+lZmI8OrcaKy/i5yJsDQVxUeu4AkIOn
 cy/hT+HAXONUDH3jL1pUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GQYALzUxzYY=:VPZLSw5/yVMGbsTO6Z0ca+
 8DUoIXdSg66GKHgn+mS5ygvwQzEXGr3WIGI5h3InfSLIMtBHiQa1qFSUs4LeOOhYb/pcuc+4C
 aXSUHT7P2Lcyy4YJh63vNvgRJpAVVijJHqayXf/32AbMi4lOrN2dgTM+lxUP0rW44Y5om+rCs
 n0o4ki+3M4GJNrq4LSMnyDr3aV06uNfCCBj0TunY0rWUu2vow9cV3AN3grEZayQDhpYO2VEYR
 iefO+aZjFcd7r8Xgg042usy7EFl9M3Jfa8LtEBsIzuUmokXr+W8v0Qp+MdTjhEjQ6nbSsPvg7
 l4hVjPN6PUqkIRrufJBjo66rhZKLIqPvmuF6RyB+UIjA4r1jF9z4zz0VBLR7NC9TlYdBDEcq6
 EIWUK0pJFgK7T97hizdOKAGJeKtaV8XDgu2wwrCTQCwVVXVFni33xDezYRwUwTMnyJrWJvPYa
 YwbIm2Rcb0GfbVEzZgcaaHKwi9YnFVPPg6pGUSxuBR+oqSgdz72fbpDvuPD7Rp9MYQdq4RjEu
 oR3Oq8/lMWGQ9o9v7JhMheavflyHSmKG1/NEb7Jf7+CxKhdmIiqmNig9hZa8MT1BXkghoeA3Z
 KD0Dp1QoFuXBQCLgKdBLX5pa0UiiYa5NfztqdzW0CORvzs1M+PB+mgGRcsA9H6hG5MW2HuwqW
 IkG9JszdOPbT9e00Droib4UXlpCThSFyHP2riv62LaxHHh8fYmNsYnv2EyM/4SKiWY+OVL62w
 unbmmEXVFusYDtN0rDRIR3TXZKNTSuEnQmGyYTzB6at0AYB2YtTjZfG/ltqJ+qM9qYO1Rsvme
 O40P5HJmKkfgByHeqHxMxWPGHpZDx6pNqO50okUjNpwKiKnFJUTuxxms51TV0D5sjugDBwLUe
 gmfp2IKsIr+jpvRhgT/XdwjMKbHZE7SIv0OtvMndcCNZAvadgGOkDWwAd87eem2DC6UCJIwgC
 feIE7dBdshl1MyTFUrx0GjUc9MKFUYyiJwR68I2G/cu+uabsIzBRzjpqF8qsjfiRhomNZzF6r
 OtQfgGe4963Dyh8JqMt+iV2jLKSNx8OKW558YV74Q0lnF+msvaxAu1llNULrVNOlXZ8+nuqyj
 4Y4o2Q37AF7hXaQe7a+nBMX53DWsUcZ2Tz+qxhAfQZsdXhDQHRbv+k//RDU1Jod/hZe1tjg/L
 7QnWbb96GKTTPuxy6pYspXLBwn9E5WK0OZy4VswRkIG/SG7HZqimsifSTBITxiEq8Lk35MyW/
 rZr8EDFTA3BgFSk2uZJ2LHpcBV1s/Vq24xktCwg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.22
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16.10.2019 08:11, Thomas Huth wrote:
> On 16/10/2019 05.00, Eduardo Habkost wrote:
>> On Tue, Sep 17, 2019 at 08:31:40PM -0300, Eduardo Habkost wrote:
>>> On Mon, Jul 01, 2019 at 07:25:27PM -0300, Eduardo Habkost wrote:
>>>> On Mon, Jun 10, 2019 at 01:58:50PM +0100, Peter Maydell wrote:
>> [...]
>>>>> The configure check also spits out deprecation warnings for
>>>>> the NetBSD/FreeBSD/OpenBSD tests/vm configurations. It would be nice
>>>>> to get those updated.
>>>>
>>>> CCing the test/vm maintainers.
>>>>
>>>> Fam, Alex, are you able to fix this and create new BSD VM images
>>>> with Python 3 available?  I thought the VM image configurations
>>>> were stored in the source tree, but they are downloaded from
>>>> download.patchew.org.
>>>
>>> Fam, Alex, can you help us on this?  Python 2 won't be supported
>>> anymore, so we need the VM images to be updated.
>>
>> Anyone?
>>
>> I'm about to submit patches to remove Python 2 support, and this
>> will break tests/vm/netbsd.
>>
>> I'm powerless to fix this issue, because the netbsd image is
>> hosted at download.patchew.org.
>
> Gerd had a patch to convert the netbsd VM script to ad hoc image
> creation, too:
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg04459.html
>
> But there was a regression with the serial port between QEMU v3.0 and
> v4.x, so it was not included:
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg06784.html
>
> I guess someone=E2=84=A2 needs to bisect that regression, so we can fix =
that bug
> and finally include Gerd's patch...
>
>   Thomas
>

Is this a regression in qemu? How to reproduce the problem? "make
vm-build-netbsd V=3D1" ?

I can have a look but I need to know exact specifics of the problem.

