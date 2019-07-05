Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25007C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9E4821850
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E4821850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjLm9-0002Nw-9Y
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58771)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjLkV-0001Fx-Es
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjLkT-0007Ew-DL
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:47:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56161)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hjLkP-0006yy-D7
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:47:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so8378948wmj.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 03:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=+p6vBhAJ6v2YbDrmrcHlDCjUmNmBA4B3mQi/9Tlf36M=;
 b=ba9FGETvZQ+/S80a8H8d0Yd+1RfH16kQEPX8rWeiLxl4vycHZyneXqdkRkXF/lu6Ia
 yOBmCDk4hvsJYrVDALvsAbYemcJXjqpwaQGXr2A5yrhuUKzYwvn/o3Kyvdu4JPZjtKRZ
 OEVM1b+7Q/xJlmCQfT7ykVgYt3O+uE5K+DPvjDNpf9fvEQWVmEIzaSDR87nZPgP6gI/n
 ffdOzu1bQhw771jJHAcYz1FgOcigq9tSb3smW4DQkgp4AeLCLkKIYrn1W0PK/yx/Hape
 yYOO0nSWtQy973MXvTDcOatTOSIkl19kMu5PDgdkzKwAjWuaPOWOeE2ibqCCCNd3/Tso
 B3QA==
X-Gm-Message-State: APjAAAWxXxvlpEzAWCpy2TEYT6ot+GlH7iKuUJCwerdI4dH9qWU5luA7
 NZQ8TylIrc+L787pK3U0au5QMA==
X-Google-Smtp-Source: APXvYqyZ+HA7gijoOPT9HhChDPaBcoAM5dNXD54tslH2fxqzY53ZkUk8Bzqaw0MV5J6Vrmm2Y+Ax/w==
X-Received: by 2002:a1c:b604:: with SMTP id g4mr3105900wmf.111.1562323638615; 
 Fri, 05 Jul 2019 03:47:18 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id v18sm9877761wrs.80.2019.07.05.03.47.17
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 03:47:17 -0700 (PDT)
To: Kamil Rytarowski <n54@gmx.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-10-kraxel@redhat.com> <87zhlsvkx1.fsf@zen.linaroharston>
 <5d0e35f4-964e-e6e0-d644-ea19fc9cd029@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <908e3e29-eb07-deac-e753-6968fc68b2b6@redhat.com>
Date: Fri, 5 Jul 2019 12:47:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5d0e35f4-964e-e6e0-d644-ea19fc9cd029@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="w82dQgFgpVYzMR4rZDRlSAWkpX1HFTFlm"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
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
--w82dQgFgpVYzMR4rZDRlSAWkpX1HFTFlm
Content-Type: multipart/mixed; boundary="zd4aa28jUfN66WCXwUvPIm97hyJl16nbr";
 protected-headers="v1"
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Ed Maste <emaste@freebsd.org>, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Brad Smith <brad@comstyle.com>
Message-ID: <908e3e29-eb07-deac-e753-6968fc68b2b6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 09/11] tests/vm: netbsd autoinstall, using
 serial console
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-10-kraxel@redhat.com> <87zhlsvkx1.fsf@zen.linaroharston>
 <5d0e35f4-964e-e6e0-d644-ea19fc9cd029@gmx.com>
In-Reply-To: <5d0e35f4-964e-e6e0-d644-ea19fc9cd029@gmx.com>

--zd4aa28jUfN66WCXwUvPIm97hyJl16nbr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/5/19 12:43 PM, Kamil Rytarowski wrote:
> On 05.07.2019 12:24, Alex Benn=C3=A9e wrote:
>>
>> Gerd Hoffmann <kraxel@redhat.com> writes:
>>
>>> Instead of fetching the prebuilt image from patchew download the inst=
all
>>> iso and prepare the image locally.  Install to disk, using the serial=

>>> console.  Create qemu user, configure ssh login.  Install packages
>>> needed for qemu builds.
>>
>> I've had to drop this from my v3 PR as Peter was seeing a very
>> slow/hanging install when running his merge tests. I've tried to
>> reproduce and I see it stall while installing packages but nowhere nea=
r
>> the delay Peter has seen.
>>
>> Any pointers on how to debug gratefully received.
>>
>=20
> Does it use virtio? There were performance issues with virio disk devic=
e.

Yes, virtio-blk, you can see how the VM is started looking at
tests/vm/basevm.py:

 "-drive",
 "file=3D%s,if=3Dnone,id=3D%s,cache=3Dwriteback,format=3Draw" % (tarfile,=
 name),

 "-device",
 "virtio-blk,drive=3D%s,serial=3D%s,bootindex=3D1" % (name, name)


--zd4aa28jUfN66WCXwUvPIm97hyJl16nbr--

--w82dQgFgpVYzMR4rZDRlSAWkpX1HFTFlm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAl0fKrQACgkQoqP9bt6t
wN5GzBAArdWMRHpF75Eny9x/ZkTU/KIaWMm/feSX5IGcCSNtWeW2u0YwfkpUlaCN
8UvTopEkXPABjyofAMsNZ8dOspM9lYbRqu2UQPsIOdS4qOvPfMLaYXkLcdgYGNhV
Y5j7S4ef/EOm4hkaOxxgE4MpLUpqNHku7wKVhYJ1vspUgBgdZFRaFmb7nh/6d7kY
Ae7TSFgRMUUDgmwbh/vAa0eX8gYkKQgfE6vfrdT4S4g/MwM9CU/fMiYUUSFYlvhT
v4hSRNkJTkfU5tG/mC5RHmD89rIHqqbW+ZIvZzH+q5rD1uN2nVibTFK5fFboDVXp
PHyoBax3iluH8py/mVTtPQg6If+o4WRcrhJaMN8BehEvlRIJVjhUmYAyXmS2be6F
OhpkSSuRqNLFUZjEMkJOk+Q0MgrSTlF3Dp5xbaj51SZE+7oDEkhY3LuOaTq7Ow31
GygcY6Fm0Oqi+OrzZBXkhRAoutT+sFAOtXCwHNqNIcP8moPzlRzPYV/karhXDv5a
YXNIfxedMexIchPsXD881K+lPq81qiDMdZ+2zbZAu+g6A47ND29xK5ttimjdWI19
YiyXst73uET9G2vfXQPpUXO2rJur7j9/u35cN2NTqR3DDiheU/GrM+PuG0VGqOQ9
ihaRJYAHHIwR3s3DndWtilfGNbYjGb2N1mFuV6XhCbQ3O87Lt1s=
=d8EW
-----END PGP SIGNATURE-----

--w82dQgFgpVYzMR4rZDRlSAWkpX1HFTFlm--

