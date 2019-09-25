Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F6BC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 05:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE58121D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 05:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE58121D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD0EP-0000Or-1l
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 01:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iD0Cz-0007Yw-Dv
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iD0Cy-00054N-Fs
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:51:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iD0Cy-00053b-7k
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:51:24 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 310E47FDCC
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 05:51:23 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id 4so1299338wmj.6
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 22:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=OtEFV0m+GnWRM/tR47ubwOVlNUD3RY9PH6tuWisJOek=;
 b=Uq5phVmsxn1BN8KARxfP2r10iuxXLLujDxGN48i1WsSeFOuhpf6VdVznhrNhdGbbUb
 YHB2CMXXvLprVDfmpk2PpW7iqbHKppsIEn0ngO9QiI7C7/lK7d04Ya1ozvXR/h2W5LP1
 M9Xy0JVUW4F2AlxYF/z9lx+simR0SvELFjWoVwRunUdqG91P2qIjzHc1JQPwvDct8Roz
 5D2+U9cQqNvdLAZ3va3c3KFgs9DCqEGQ/mSFU0GbIzbKjGCEIb5K7DcQ5iKFoeLxaTUH
 mkvJWP/pTf3hCF1Zk01TafMJoYi7Ienbsd8MIk2teZ4mtLEKB5hIRHeAfDv41Q8Wp4io
 C8TQ==
X-Gm-Message-State: APjAAAUrTvo0YZrUE/AX4s9zJB66RwABD/HOb+EklqydSVvDR78yZxRj
 qMycMTbNgARpz/rW+CYjuPZjYY7Ak1jgVpxeuH2/uIF9hsGVhztuG2DbTTZ3IaOqxKcKQSv3GbV
 pn85jiFiGqH4mBgY=
X-Received: by 2002:a1c:1b14:: with SMTP id b20mr4953545wmb.122.1569390681949; 
 Tue, 24 Sep 2019 22:51:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzk/XSA8hgHlQwseDF2U3WU+JlYJtl/FUQYAHCtiXsg3G1to2Dj4NGideZ8SXt2mfq3cTXgWQ==
X-Received: by 2002:a1c:1b14:: with SMTP id b20mr4953515wmb.122.1569390681711; 
 Tue, 24 Sep 2019 22:51:21 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id s10sm3389670wmf.48.2019.09.24.22.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 22:51:21 -0700 (PDT)
References: <20190924124433.96810-1-slp@redhat.com>
 <CAFEAcA_2-achqUpTk1fDGWXcWPvTTLPvEtL+owNSWuZ5L3p=XA@mail.gmail.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 0/8] Introduce the microvm machine type
In-reply-to: <CAFEAcA_2-achqUpTk1fDGWXcWPvTTLPvEtL+owNSWuZ5L3p=XA@mail.gmail.com>
Date: Wed, 25 Sep 2019 07:51:18 +0200
Message-ID: <87pnjosz3d.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 24 Sep 2019 at 14:25, Sergio Lopez <slp@redhat.com> wrote:
>>
>> Microvm is a machine type inspired by both NEMU and Firecracker, and
>> constructed after the machine model implemented by the latter.
>>
>> It's main purpose is providing users a minimalist machine type free
>> from the burden of legacy compatibility, serving as a stepping stone
>> for future projects aiming at improving boot times, reducing the
>> attack surface and slimming down QEMU's footprint.
>
>
>>  docs/microvm.txt                 |  78 +++
>
> I'm not sure how close to acceptance this patchset is at the
> moment, so not necessarily something you need to do now,
> but could new documentation in docs/ be in rst format, not
> plain text, please? (Ideally also they should be in the right
> manual subdirectory, but documentation of system emulation
> machines at the moment is still in texinfo format, so we
> don't have a subdir for it yet.)

Sure. What I didn't get is, should I put it in "docs/microvm.rst" or in
some other subdirectory?

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2LAFYACgkQ9GknjS8M
AjUuNA/9HZkcHiAgWQjLv+hy9IJvlB94aSH8XhyJZ51P7tQtgJgxJMkWhUtLqm4x
J77G7mDacT/B3X96mhOCaS7UEeqGCeE1JE9LRo9DNN5ivN9kbetfb7he+EE3yQ7Z
5pQu2AhTm5e0BzFKDIpG9g0ybbRQERYpuPcqMNx1ZR1murW0XH+7yb7CCIuIozAm
LRNyKtlRzu8H+hU/0TuDB2zPA3dQvBrx9YCLivA06Ekyl1OFk2pHqmmPF/800G2C
tTHPTn2KqkeWjZmRoJS0cq5JloaMnfa59PWeGeCxB8b0JS69ZWXNCUpsYgN6Jzwc
oB+7YJT043vB0b2rdMPZEesa5PdaBbXR2WqOIO6li4rhZANKakGzJH450Sc8P17A
RC5aqCCse6ZXvsEAezoVR5C10w37YRxkZdMH8JB81jpcLZRRXYk0Gq/Gzar5eFBM
Vo1rlxgKbI+3X6doKWsVy01oxC0S4JayW08uPdZ6rletlJJuHvuR2Hn6NQdj/9Ew
5SUqZNo0j7/uOGBdDm/iWzLnh6prvl0LXl8OUvAwNM3PHxHSVHGY9mxUZSsHYiLO
bEyxj++CgkAEc+qYMmb3Ykzf1WQ45Uyl2DE9iPaUcKVyg1a8q2e0WklcWVgn/Q4x
u3j8gg6Yj/a8MfegbnQfP2+4u440reGFNDJGVlW9EJcTFlGK5L8=
=Y289
-----END PGP SIGNATURE-----
--=-=-=--

