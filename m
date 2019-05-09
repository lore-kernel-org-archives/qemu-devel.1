Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541F8C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 19:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1085F20656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 19:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jJtxKQup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1085F20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59678 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOoS5-0000pu-9u
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 15:11:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50542)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1hOoRD-0000Bt-0D
	for qemu-devel@nongnu.org; Thu, 09 May 2019 15:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1hOoRB-0002pq-4D
	for qemu-devel@nongnu.org; Thu, 09 May 2019 15:10:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:38979)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1hOoR7-0002o8-DN
	for qemu-devel@nongnu.org; Thu, 09 May 2019 15:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1557429013;
	bh=0X1OMlcO6UxRX2IJNMbk8DLTnYlw46g33ubTzyIaIlo=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=jJtxKQupwbiMt8eLiASPRplq/gEdWTuQD+8x7lKR4z8KxcUW1CzOKcSdL6b/SyUHU
	fOJxQ7pxYEnDMA//rImZpObQ1CzDN2m8BW8YXm7K2z0Dpj9Xd90OTNJUv1+YRFCl8+
	G8LsUPGkF+RxPhJ/53J62Xcj4IgnCbaYJH/gKacs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx105
	[212.227.17.174]) with ESMTPSA (Nemesis) id 1MmlXK-1gxyCp0EA2-00jtlU;
	Thu, 09 May 2019 21:10:13 +0200
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20190508085645.11595-1-kraxel@redhat.com>
	<38ea2334-b819-a439-7a43-92b52263b402@redhat.com>
	<20190509135022.z5yjsrghixfrv2ta@sirius.home.kraxel.org>
	<4b26be42-d066-386d-fa28-8b1e5503bf9d@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
	mQINBFVwUF8BEADHmOg7PFLIcSDdMx5HNDYr8MY2ExGfUTrKwPndbt3peaa5lHsK+UGoPG48
	KiWkhEaMmjaXHFa7XgVpJHhFmNoJXfPgjI/sOKTMCPQ5DEHEHTibC4mta7IBAk+rmnaOF0k8
	bxHfP8Qbls66wvicrAfTRXn/1ReeNc3NP4Sq39PoVHkfQTlnQiD4eAqBdq61B7DhzjhbKAZ4
	RsNtLfB6eOv9qvmblUzs50ChYewM9hvn+c7MdDH+x2UXoSDhkBDkKcJGkX91evos8s9AuoEd
	D32X5e+bmdUGe8Cr3cAZJ8IEXR6F9828/kxzPliMsCWVRx1Fr28baCJOUGgFPNr3ips78m9+
	Iw8PdQ101jU0dvucDFxw/1SCGYEZzV+O/237oRPuLCiDX5nhQoxf6dn9ukQleLBMNy2BLI4H
	g342NhF21HLA+KlyLOHaMKQCKzlal+zVNZTRTCh/ikMhsxWQjBfnqTDbMj85DnWwtump27SI
	qhPjUnS0a6MKoS/A+hbi64k5zztkvloELfCSrX7NyBTT0jgF2IGFIxZMrKCtQ9StcGMCV9MX
	tjcBy6fj7QMontEaIDRJEMjg8UIGw1B687OhalOv1ISia4xOWvpYAM6ipgqh6tBQmFzasL9P
	h1RtcVdFpFbhwVlr1Bly8c25gBNQHL5GUjLMn45LlQz50OzrkwARAQABtCdLYW1pbCBSeXRh
	cm93c2tpIChOZXRCU0QpIDxuNTRAZ214LmNvbT6JAjwEEwEIACYCGyMHCwkIBwMCAQYVCAIJ
	CgsEFgIDAQIeAQIXgAUCVbKGFwIZAQAKCRBLswjpsC52bIVpD/9i8npieI91xMIVvAHIUMeo
	cQO0IrNb+b/PuTj2qNemdwU7dhVJ7tVU5O1H2hI2M4rHGzjzDTxYzdxka0+A8CVEuvFdf6sF
	lXlXF0wM7rC6MoaB0QLAKxkZB5OtCILxLx7Bl2Y4cTPMU9v+qSL6yrdmhxogkufa4d6O9Zl/
	FCWO2kH/BphKOiDtbyvdo2WULSLWP2IXN+0rCpNL4wbTfYLgV9JtMf8f0naGsdy7BFuDWsIE
	vtHh8dkQZP7dz6Qy67kx8negZaehSEgXwiae0HwQIn3xTQrFmBDALDsCgXuLWPTvglSkqTak
	uG+8X5fyTy0cU10TNKsU+rFBO+/xsUoIQOGrARwfWOIfJNPelzh/qigSnyNQNH8u5vFRPg9n
	fqB/AcvvAvtOYOo8EN9Ofx11gNj397NXc5HBQTrX6k5GNAeBWE3Ng1uO6scIwAS7qGnqGezU
	ABmQKLN37gmJiiGwhQAnSE6HILLBC5Z2b0S2rQsPKg8WgUmPa1YIcDkDtNB/LJcDsdU4Fm+r
	U2ksKU7tGD2ZfBt8H2nqfPKKeB+Uv/TBigjRvx/m70vjhqVxwCZA9Fqr9vkQkZroNfqP+3dp
	Z5V5fjmxO5abE2+IikSvFagwMtgx56i8Yrr2BzE8P5/S4cKq1kgyQoF+lVGDKRkUKCv1i4Fo
	aftnSxN8jTFZDbkCDQRVcFBfARAAutbzb8wAHGL5FPPWKErQ3Bsrp9RDTVqRzp7kBMOtd/14
	MrOsWWyiml4XnvBYsJuhZWomFoeulcOXAPoTJ2vTw6erWYtdOiZymfQ3GMWpxzgkOVeNjsFF
	9AQ38FCMKmIDs9dgn+KXSIXlZA34khKLd163SN5U/KHfYlnnocec31u+7rVa1hlF5DBSSpoi
	s8cs41foBYC5NsB/i+yqGIlfzHy7pC2u5kyQCuJotLH4y0rT5X+YBC7z7cqKChtILNDGw0ht
	qps29fwOGBE/FWmu8CbpSHj8pvg7uUyQcKbZbNChBfWtOJKdjnNs5VHf2ec95SwYmWl6Xz66
	G892HY4ODtvl05/kh0qtdJd2oI4gJBsBx/N1585/3JYN4k78GIHTnML3xJydRRs9wwM3AXf/
	iDGrMyY7qHQVXJLdO5nPe7LHg48vryCMkBnTMw5iNFPVCu5w1BaZyHxuS2HvpsgUtQoBa2QE
	P1jYNI+2qgoiIG4VQDhYtrD0WJaYdi/C2UVDxRy07dt73SV3RQ7ijOiUrz4g3/deFKY16/1k
	sE+N5Sc5Tjt84ChjO3nJRbHrQxd6dCOElR70e3R2yAuSB4m7LJpO20IB9CtWhlF/0AtfL91W
	O8GGGqLWB0Z04hmwRs/l8T4WWIlykLshbunWN6jsP1Y27FeilTZ+Pc9mYOEUFfEAEQEAAYkC
	HwQYAQgACQUCVXBQXwIbDAAKCRBLswjpsC52bPayD/9jE8mdNudrudSxbDB2vf8pU8r5flCq
	vIkfOdpZGV/Wx/Zx+HFHHp+b2aNBGSNyFTnph1Ku9bvg06vD0o+b7SdA1vrBgRG41t0OCIyf
	vejz65Xpin2EtCllcBM8zUCxHo43blON8fNw70P1Ec0loBp4TAal1MiXbB8kxRTRcEPVO9YF
	9NPsFxycoWl0ZSvu4ESrQlrjRbVv+W0Fy/XqcQwEtDziFQHQXNRbTy8INPD49CsB7BkKRK+f
	1vMmw7SxfsyEhyCgo9ZWfHb/+w9T5h+UhF87L/m287z7W+s4aCAPBzjbIWhtngGJJwIgiWdI
	I9J6YJLcHLvVZLw7xzA/flcjc0VfzOgJOJw3hBukHnEz7/CKgnABwyNu52P+PQbxVTiTjMKm
	06eV732u9ZLD9ZgEazfmyGDHzsuzoXwsRnmcnbwYYAiynS+vfGl5oMtMa5qzsPhlzuvRlXHm
	zr8VjF8c9RThvyZyyHtWYAqNmBecMvM0whigjMeoAMJ5LtpyZgxjbHj1XnVdNBZgfJkOzsc/
	twffi7RYphRx0d9z5UZ1Yl5Rvl05vTaJ7YhhNC7xuE8yGOQmDUsPDwWqO/eXUDErJjCOBR5b
	0yILqRPYNT0Fj/th9gtEbZy1Gp0TVBkZM3tfjDRu43Pn6iSKObO/j0rNuq1LwN/EMxDifeZO
	4XSbcg==
Message-ID: <8a48c62f-507f-c448-d747-07f45d5bf114@gmx.com>
Date: Thu, 9 May 2019 21:11:04 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <4b26be42-d066-386d-fa28-8b1e5503bf9d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YygjibzBwdp27I2r/MuLwbRVWCvv/XixDSci/x9z5i/uzPUZyTv
	Ir0ZlDvDHDCs3rNQD23vSWmxdxDtxRS6JcdifAXSa9E9FWNqn/MKCovbOpPTKEnCm4L+67b
	aNqHiTnYYXKPABzMzrHiUTUWc745Rji8mvE1RRQpxHhQukCOQGByNARWBkfrgmJUuWzwGB4
	PhXnn9Qi3EL08yAg0G24w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p6309kigsbI=:e2bHrcpdDSB/imYrJ/dK/G
	95xEKAxrmnhD2NcVMrEkVEDTDHjgujLZW0/rg/rmZG10u6vY9rYMKSp7GTnT9HFWWGtl38IQt
	Rp/1N+W64vqMniCnHBnR94ZwDtUlJy1xPtRKUxFkpnXToYfhzObjuT7wGo8t+hzdAhmTJpDnA
	Endygne9jqMr9w89i0pxsWZURAEobwP0+fNQeHx1wE96WrfvK/xC9vczKCu2YYXWgIXyeQmNf
	CTC+vFHmP2ergqmEP/JKbwMnDyEgegzcelDX7WS+4I4PRO4h8HHrIGpQ5H9ccz6aRb8BRjE0T
	JUpMn2yys8NlraX1TQ/FMIVRPdxF+NNsTQ8+9oZfFJb/MxvrYIysLuNHcgpuJJllgqBmRiCJF
	+TuOep591OhCR7PvYYkX0WGwj/7jjIVvLZefXbcR6cltvd2+1Zo2yMg5e0bXz+gc/872Eah0B
	2B1ZkKs3CyFJ5KvoBzm8RrbFbieDXHqnB4Muiy7tTfssEzwvLE/6fK7wXABRcdDrneHcbeXkz
	rhTt72YhXHFkKix2l2+h6FJ1s20uM7dCzHZJf+TklPnBuQ/QDHbbr6c4g+nE1k7eH0ZMl3RI7
	jIpMQMwXRCUth5Y2UV4LwWf3pIcwoNFzq0ZffqppQF20rVyKuJym/uK+nGJ4gFG+wjcM2rVVX
	Oz+Vqu5ZaBtQehYWiT43OBoe/cneF1J6CmBiWRxCNEsSv6+x0edycsRpGMN7uO0ZdcGDAA2bX
	fMc5BBTv+qbzNrGpXsM4R9k+aq/t/L4pDC1JnrmWkjf1+g6ti/++tEI4MUPDTcsMwpLSIOeKs
	7oqk4+Wdg+aSDmx+0S0qzl7jL2HEaJZfPtemOlhXAR3fBkBwxbaIfPVyhZJL4DqtAJrmoUk+e
	LgOlSCf0V6SATdWKFt1VPl2OwEgyAelZB6JKYaH6Pjco+UV4dJ00l04GvhHOgQ
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.21
Subject: Re: [Qemu-devel] [PATCH 00/13] tests/vm: serial console autoinstall,
 misc fixes.
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09.05.2019 15:57, Thomas Huth wrote:
> On 09/05/2019 15.50, Gerd Hoffmann wrote:
>>   Hi,
>>
>>>> Do we have accelerator support for the BSDs?  A "make check" for a fu=
ll
>>>> build takes ages, and I suspect tcg being used is part of the problem=
.
>>>> I did my tests using "TARGET_LIST=3Dx86_64-softmmu" because of that.
>>>
>>> I think they should be running with "--enable-kvm".
>>
>> The images themself yes, but the tests running *inside* (on make check)=
 don't.
>
> No, we don't have accelerator support for *BSD, as far as I know.

As mentioned in the other mail, KVM-style?

NetBSD does support HAXM (--accel hax) and in a downstream copy NVMM
(-accel nvmm).

http://blog.netbsd.org/tnf/entry/the_hardware_assisted_virtualization_chal=
lenge

http://blog.netbsd.org/tnf/entry/from_zero_to_nvmm

Once NVMM will stabilize we intend to submit it upstream.

There is no support for hardware assisted acceleration in qemu for any
other BSD.

> But we
> also do not run that much TCG tests during "make check" that you should
> see such a big difference here. And for me, the compilation step is
> already way slower than on the host, so I think the problem is likely
> something else...
>
>  Thomas
>


