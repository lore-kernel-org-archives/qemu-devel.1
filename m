Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA926C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747B7216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FRWpAhLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747B7216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjLto-0006cf-Or
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60559)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <n54@gmx.com>) id 1hjLsP-0005Zo-42
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1hjLsN-00066S-67
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:55:36 -0400
Received: from mout.gmx.net ([212.227.15.18]:47219)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1hjLsM-000639-Rc
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1562324123;
 bh=7w7VbzdQbrlDzhDQS3G4Af3lrtTa6VoYMa1zuhsjYqs=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=FRWpAhLCIFlXcHlnnqjVgdxBk8F3tJ4sUkVjfEf/WTyFSwTxhRsqv7v7DRP7guVF/
 SGtDVMQizwSdcBGaIjWHHyeJQP/E1g91ECZr9KcWZ/UAjQ/8jIBKBKAAyHaGRqL84G
 puhNl/PA5LO+ofRCy57cIitRSjIYI1yVJjha2mI8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MjS9I-1iOgrY3Vog-00kumQ; Fri, 05
 Jul 2019 12:49:15 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-10-kraxel@redhat.com> <87zhlsvkx1.fsf@zen.linaroharston>
 <5d0e35f4-964e-e6e0-d644-ea19fc9cd029@gmx.com>
 <908e3e29-eb07-deac-e753-6968fc68b2b6@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <532ddc1a-75bb-85f8-4fa8-686244b6146f@gmx.com>
Date: Fri, 5 Jul 2019 12:49:33 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <908e3e29-eb07-deac-e753-6968fc68b2b6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EqxZh1dsaeSwegjnVoekTHc7e9kzIn3Gb"
X-Provags-ID: V03:K1:+Nfx+wdllKVNalKT8394v85KD2e6kourLAOw947wsZqVdLPX1gG
 TDKq7uGX4t+3ZbzkJSIpLRIkRNUQv/jsxEesmbqPGnEneAIJteJngIVOvEE+ZNOfG8gOvqR
 jU5pqd/YTAZHXxTX2eLSaJqcE9uCy6wSGtkpkq3gJfB4oKlkaMenQAszGuqg7GgvRHRbiup
 mJCyo7ilh+lBN0WzMyBMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/DHBttWpOo4=:e7ALqrRHGEurrfXp0sGetw
 kDqEnoJH3XGg90UFdiFCiHx1sg4KAypg62bJVn5wjelgZYbTB9bWBmoLYF05wEE3K/C6KyBaJ
 4lzwT+SInFL8myU4SSWJKpr8Yv+ob7Nmw5RrH6I4xLr4LfmyjdGCeBPBfXq9fdI52Jiu9/n7k
 L4Ksnrye4glJF2nLJa37R4yyhNQGUQkuGNK1MXmfO1K7ui1iusPm+vHNasba2xT+9A+I+8B0U
 EJSJh4OKa3JIyhQ8ovpr6QT97Fn4TabGZTtVn6h8rwXUQaXzGqjP/VRUvJni4Zi2aJsIcNgF5
 Jq54MSIACCVQswwgecuech+u+OGnxQtfd0SlgT4EzxjogyWDh7BS3lAeLcY49T85DEgwK5X4k
 x9uMq7vuI8EPkV2X18H98zmktrzqPJXe8WdAK7VOF56on63Fq5nYIEUfnVpsyFBOTJfxS8TzY
 HHH/y2aT2AdslgZS1t6YXTd4T7LQIgBk0k0dSnO1O+W3gqKExwTh5ZUGpk7tr4/0QtClfr9kw
 tLEQ4zHhSTu2NJZgJmRIQEGCsJ6lPknX/UgEgKgpy798j2IgbGkjoV+WSzXPNAlQCrpgFBBxh
 9DRmO97kJbNHrNh8i8ThJVQVRrwhrXrO0bQ16eF+OXAc7NpMLwxEaqz0PBncQ+4aC412r5awo
 vjcQ0A6M6SA3jsu8O7DQm44dx9C9E/bVRRtC3FIBg+CXa4X4/1w3+1aS8PSIqoYR3LxIbquw/
 uaV5/4CpXLkdUgXqVuedVrYNDyXlYRGl7cR4w80t6lDpqePkTFJTFhtEe02Ln4jXDnFRtftKy
 KRY9Vc1KGa1KrJ7Y2BIo0Hcq6117TAX6i0RGwo8B/WD+PPwX0PHVp8WlB/XFh71MIuDEt5e8n
 Vgkt26A/i4cL1hqXAmUllC5Y3wm6GRMaJLJIJaz99wKDOabF9RZpUqDt5CdrWWzTNyrfjB/F3
 XVqKAegyE8YTlsSTb20pHuZgal9qtJeg6xnf9XisBmD9P1Jh7XuBQSXnUA8h8l2dJ52MFWuzl
 PZSk7lrYzZF1DeDlfGXogoDRC1NTehzP9PBWpP7pvhsDmf7Wkxny3kHqCQZeF9gwVA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.18
Subject: Re: [Qemu-devel] [PATCH v4 09/11] tests/vm: netbsd autoinstall,
 using serial console
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Ed Maste <emaste@freebsd.org>, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EqxZh1dsaeSwegjnVoekTHc7e9kzIn3Gb
Content-Type: multipart/mixed; boundary="dgsg765Kg9MUB4cl5IgTKTx9bTTpTjEWL";
 protected-headers="v1"
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Ed Maste <emaste@freebsd.org>, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Brad Smith <brad@comstyle.com>
Message-ID: <532ddc1a-75bb-85f8-4fa8-686244b6146f@gmx.com>
Subject: Re: [Qemu-devel] [PATCH v4 09/11] tests/vm: netbsd autoinstall, using
 serial console
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-10-kraxel@redhat.com> <87zhlsvkx1.fsf@zen.linaroharston>
 <5d0e35f4-964e-e6e0-d644-ea19fc9cd029@gmx.com>
 <908e3e29-eb07-deac-e753-6968fc68b2b6@redhat.com>
In-Reply-To: <908e3e29-eb07-deac-e753-6968fc68b2b6@redhat.com>

--dgsg765Kg9MUB4cl5IgTKTx9bTTpTjEWL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.07.2019 12:47, Philippe Mathieu-Daud=C3=A9 wrote:
> On 7/5/19 12:43 PM, Kamil Rytarowski wrote:
>> On 05.07.2019 12:24, Alex Benn=C3=A9e wrote:
>>>
>>> Gerd Hoffmann <kraxel@redhat.com> writes:
>>>
>>>> Instead of fetching the prebuilt image from patchew download the ins=
tall
>>>> iso and prepare the image locally.  Install to disk, using the seria=
l
>>>> console.  Create qemu user, configure ssh login.  Install packages
>>>> needed for qemu builds.
>>>
>>> I've had to drop this from my v3 PR as Peter was seeing a very
>>> slow/hanging install when running his merge tests. I've tried to
>>> reproduce and I see it stall while installing packages but nowhere ne=
ar
>>> the delay Peter has seen.
>>>
>>> Any pointers on how to debug gratefully received.
>>>
>>
>> Does it use virtio? There were performance issues with virio disk devi=
ce.
>=20
> Yes, virtio-blk, you can see how the VM is started looking at
> tests/vm/basevm.py:
>=20
>  "-drive",
>  "file=3D%s,if=3Dnone,id=3D%s,cache=3Dwriteback,format=3Draw" % (tarfil=
e, name),
>=20
>  "-device",
>  "virtio-blk,drive=3D%s,serial=3D%s,bootindex=3D1" % (name, name)
>=20

Try to switch to a non-virtio option and retry.


--dgsg765Kg9MUB4cl5IgTKTx9bTTpTjEWL--

--EqxZh1dsaeSwegjnVoekTHc7e9kzIn3Gb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAl0fKz0ACgkQS7MI6bAu
dmxxnxAAojRASbeGfWpuHBRBEqS+8UyXzO2cdT59ohhtPm+DbsQ5NfgwS8OD5sAC
+L6lsr+7+rsDeqfWLSImc30/LZ8ndQY3m9QE1efZt19ZmJKXBi4KZY2vWbUeZYX6
FZW36KVPr65cCPwP29Tfu8SuWX8XuyzMxOVCFuG9WG4mKMgriRnwKhQljKgEYlkM
uQrYfvQL7isTqGAvRvrjPT4K4hRuqxvASb4NtM4b4VDS+wo69N2N6tv799jS9kII
NCpITE+LbY6ZjyEpwwOcLxtXYxokJC31qdFVoFwrkWBRsLjAxOiZeVnJRV6yt98P
AWv3jpWj62ec7Wf2hOSAbkP0U2GLMQJrMkQSYiG5kpIpnSgSGmzqLW1PqNKZZWzr
n3w32MSyRTQl3j//nae4I3XSyx6mcxtrFX6V8xoYOftAkcApoM4ulJfL/oucyp2P
SRXK7Jw4R4Kg87HNMDgYNybq9+wrwtSVOZzArwdSxs7DCaDqX0lpSna0ssC2d3uB
lCkUTE3nEUB7DS6P7oXMPtEjbxsfTjLzpc4WvdgXLhgOPC+ehK8VeccnDIAzT2WB
SosOnfMQBcA27q1tuoFHgJb0N1Nu+74R4UtzJOJ5ZEg8WEH4qljFZO485u8lgAEu
ZLRUNuPc7N9nR8rTZXgkNGEFyzh6MRuzFVnINwIQnTMYgsAscxI=
=XuUE
-----END PGP SIGNATURE-----

--EqxZh1dsaeSwegjnVoekTHc7e9kzIn3Gb--

