Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646B6C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B6D6206E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6D6206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48444 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZGFa-00041B-GF
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 10:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52517)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hZFgX-0002VK-7Q
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hZFgV-0001HZ-Qi
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:17:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hZFgT-000189-Me
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:17:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so2088386wma.4
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 07:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=2padRDLkZ9aPDeGcAuykHuQF1uZ48UvGT7lNCtNP3t8=;
 b=YX2t0PrMBnWUhBXHlqkCd4stebfsVxlNWpQlrinGHLHm0uIZnhiIvoWFiYtEFx8Tc+
 RtVUT3z92qdWKipsLKUx+beZQVI3oIrGTTVkY0+0GnbvHTAzd+WEipvR+40TVh9mOVJK
 UBRMVB5j4JxtPZB4zXeGSbIHWfPWldAiRBr7SZC4rNymxm1yTmkcsw1h/tXK7+BJX3KH
 HJLSDeg1mh7drKVb7+8E5Ft6Kr0AL/ZDd5cSo5EFh/srVpLYHt7dSUF9/hYOPPBA1XKb
 bkQCvouN9j2E6lZGaCTUKQ9Kqedf+z+bZHxHl8lCuxaGtM1zNqHRyeC9a4Xm9qgX3zj3
 mArw==
X-Gm-Message-State: APjAAAUOfXGiaHMbGGTyvmeSyOPlhqYr+v9Jy8Sg4KVISoKEKdHGf8GV
 Lr7V73UF1e34REfWRjTH9q84KA==
X-Google-Smtp-Source: APXvYqxqjAugFytGP+FjT1CO03jBa0ojKe0I7bnLG8ByBvlFGdOCnELWirhjX6riphRRokFfV2aRGg==
X-Received: by 2002:a7b:cb4b:: with SMTP id v11mr3866398wmj.103.1559917047838; 
 Fri, 07 Jun 2019 07:17:27 -0700 (PDT)
Received: from dritchie.redhat.com (143.red-81-44-182.dynamicip.rima-tde.net.
 [81.44.182.143])
 by smtp.gmail.com with ESMTPSA id t6sm2334914wrp.14.2019.06.07.07.17.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 07:17:27 -0700 (PDT)
References: <20190603123823.32661-1-mehta.aaru20@gmail.com>
 <878sudu0d1.fsf@redhat.com> <20190607141006.GA13542@stefanha-x1.localdomain>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
In-reply-to: <20190607141006.GA13542@stefanha-x1.localdomain>
Date: Fri, 07 Jun 2019 16:17:12 +0200
Message-ID: <877e9xtr87.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v4 0/9] Add support for io_uring
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
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, saket.sinha89@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Fri, Jun 07, 2019 at 12:59:54PM +0200, Sergio Lopez wrote:
>> I gave this version of the patchset a try, and found that IO hangs when
>> the device is assigned to an IOThread. Sometimes is able to serve a few
>> requests getting through the Guest OS boot process, to hang the moment
>> you try generate some IO on the device, while others it hangs when Linux
>> tries to read the partitions from the device.
>>=20
>> I'm starting QEMU this way:
>>=20
>> ./x86_64-softmmu/qemu-system-x86_64 -enable-kvm -name rhel80,debug-threa=
ds=3Don -m 2g -smp 4 -object iothread,id=3Diothread0 -blockdev node-name=3D=
rhel80,driver=3Dqcow2,file.driver=3Dfile,file.filename=3D/home/VirtualMachi=
nes/rhel80.qcow2 -device virtio-blk,drive=3Drhel80 -serial tcp::6667,server=
,nowait -qmp tcp::6668,server,nowait -nographic -net user,hostfwd=3Dtcp::66=
66-:22 -net nic,model=3Dvirtio -device virtio-rng -drive file=3D/dev/nullb0=
,format=3Draw,cache=3Dnone,aio=3Dio_uring,if=3Dnone,id=3Dtest -device virti=
o-blk,drive=3Dtest,iothread=3Diothread0
>>=20
>> Could you please take a look at this issue?
>
> BTW I was referring to the inverted logic where qemu_luring_process_compl=
etions_and_submit() fails to call ioq_submit().

Yes, that was the problem.

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAlz6cegACgkQ9GknjS8M
AjWpbBAAjwR83rybA2ej8jLgrwgm8hhkMbLyK29/yo9brehxMnJJLHm/LOINAzxB
vxS6QTIoec4GwqtHHsfo+K+HXastARPUsCHKwDJ1vraLjm8+O8KaM0mSuzx60GNB
TQVTfsxV+LPDo00z2gsR5S2e7KPZ7j8e4PkhR0LytFP59f5fQH6vEyKNk0MLW8hb
qm9b2TuYyHlqZgzItmSbqQC8VT0KHGj41sawwphkl2bx4YAFoRamO0lZ/XhWJ+3v
W4SvQq7k9qLjBXROWwykEHiPcLesgdqZt/q64A+X3P480P9CWIhuD0nfaDamslw1
C0AYIqssLcLB2m4hwvIb+5S23uNCyqRHrwyxi3C13Uw4Sf4zdat7covKSjT/vh1W
EGQ1Ez+G2Scm82VStjK2ePJH4YjwnTOdd8sIsHW4HZ6sDUJyUgq7Zv5wTNpAZr/t
gXzLqLAGaFo8+uCmi9R9tBZGZ7ktHG1OMUS6+ttAKw5wZF3fHgrXv5QmbqtPGqz3
nyOSGwWULK3uS3SFZXxnbndkZU1rxlrijkJAhbFDlS3e5Z09XrBv/XYxkHJ5i9yY
1aEUadqJw1cISsOoRUlIzMKuOZTdf8N2JsAuGLA6BZKJ59A6rDXNB6k9/KvvD7T0
OQS6nFf+tpf6Pgo2MlY7I9MfJGxskfCtMsutHdztFszqcnp05FU=
=lf1g
-----END PGP SIGNATURE-----
--=-=-=--

