Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C755C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DE521D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DE521D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5MY-0004vR-Dr
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iD5Ll-0004N9-36
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iD5Lj-00067R-L2
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:20:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48598)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iD5Lj-00066p-BZ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:20:47 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0DAEE89AC0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:20:46 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id r21so1837424wme.5
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 04:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=TQLyUyTVyN5f3rMPgbSqGLlYWyI3EuIZKhqjMak1wlM=;
 b=kKUVI0L3HuVTAXBAs1RrcbUihnPJoV1UAi/hlaEN1jhQFqA8HojMiYVDkPtFzbYN/q
 dKEW9KeOKtAlxI0XN31Fl4gVki6sBgtWNPMsBqrjPUVjDaXG3aU7VMMMmeMGQTawoZDd
 yO1jxbVxSm7iKUCWjo23ykzK+dYWwHGV76JE2Du1vDs6A50W3SvZS5mRy4SH6fURn8sv
 cYSH5Wu5JBGky7qil6JTE2XXQ4J97NBA3B3RFSBgJukwsxcgjD2gG3mv2kwdIekK4fdR
 xSrdpN99c1nt2PfQOxYgSXs8oiWIfFMzKOtbCtocqHZIoPs/Rs32lvF4WONHB25Git06
 RgWg==
X-Gm-Message-State: APjAAAWSvcbpZU34AQ9b1XhlfgupXcSkIry5PSfblMnrK3uuZ2K45Kq0
 K+5bz/weJlU5prE5Mh3hLtXsJAsENG9widNd2QDWxuFlOxQ4pYMZCGfTmXd8lcjUrLjDfK642iP
 d14kxsJH8lm04ho4=
X-Received: by 2002:adf:dd41:: with SMTP id u1mr9171304wrm.49.1569410444617;
 Wed, 25 Sep 2019 04:20:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwihDEnuRrpvaKbtRepAH8BlQ/4mZbya0BuvikfMc9haI+Iq1pqnyC2H/pBV39VR8L7dIFSKA==
X-Received: by 2002:adf:dd41:: with SMTP id u1mr9171275wrm.49.1569410444363;
 Wed, 25 Sep 2019 04:20:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id l10sm7276798wrh.20.2019.09.25.04.20.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 04:20:43 -0700 (PDT)
Subject: Re: [PATCH v4 7/8] docs/microvm.txt: document the new microvm machine
 type
To: Sergio Lopez <slp@redhat.com>
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-8-slp@redhat.com>
 <23a6e891-c3ba-3991-d627-433eb1fe156d@redhat.com> <87r245rkld.fsf@redhat.com>
 <317e53b1-d658-4b6b-c782-4b2a0dd091b2@redhat.com> <87ftkksr9u.fsf@redhat.com>
 <3fb455f8-13ef-2930-a10d-9cecd6e5931e@redhat.com> <87blv8skkk.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5d8a164b-90b9-96cb-a1a5-fbc7694db960@redhat.com>
Date: Wed, 25 Sep 2019 13:20:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87blv8skkk.fsf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mJgue5CzEEEizQwnAbeTt45ne4WnQgG6K"
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com, lersek@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mJgue5CzEEEizQwnAbeTt45ne4WnQgG6K
Content-Type: multipart/mixed; boundary="iaDySfsMolRS3THVVUKm8AXJsRJPxSCbm";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 marcel.apfelbaum@gmail.com, rth@twiddle.net, ehabkost@redhat.com,
 philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com,
 mtosatti@redhat.com, kvm@vger.kernel.org
Message-ID: <5d8a164b-90b9-96cb-a1a5-fbc7694db960@redhat.com>
Subject: Re: [PATCH v4 7/8] docs/microvm.txt: document the new microvm machine
 type
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-8-slp@redhat.com>
 <23a6e891-c3ba-3991-d627-433eb1fe156d@redhat.com> <87r245rkld.fsf@redhat.com>
 <317e53b1-d658-4b6b-c782-4b2a0dd091b2@redhat.com> <87ftkksr9u.fsf@redhat.com>
 <3fb455f8-13ef-2930-a10d-9cecd6e5931e@redhat.com> <87blv8skkk.fsf@redhat.com>
In-Reply-To: <87blv8skkk.fsf@redhat.com>

--iaDySfsMolRS3THVVUKm8AXJsRJPxSCbm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25/09/19 13:04, Sergio Lopez wrote:
> Yes, that would do the trick. There's another use of it at
> hw/intc/ioapic.c:78, but we should be safe as, at least in the case of
> Linux, DM_EXTINT is only used in check_timer(), which is only called if=

> it detects a i8259 PIC.

Even there it is actually LVT0's DM_EXTINT, not the IOAPIC's.  I think
pic_read_irq would have returned 7 (spurious IRQ on master i8259) until
commit 29bb5317cb ("i8259: QOM cleanups", 2013-04-29), so we should fix i=
t.

Paolo

> We should probably add an assertion with an informative message, just i=
n
> case.



--iaDySfsMolRS3THVVUKm8AXJsRJPxSCbm--

--mJgue5CzEEEizQwnAbeTt45ne4WnQgG6K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl2LTYoACgkQv/vSX3jH
roPDUAf/ThYeKfKLT6O82x8MZrdERraTDob3kiyMe4MKWOsoyuKRCSwRRdzGFNti
rVuBPQqcocANVqFKCVLta0BEUxEVsV5e7FRHJqN+gYd7MWa0OsIBKdjSkTSWG271
GPr5YY7jGszB+Je/anQs3uxy3SdNjZ1pjlFysVDV+YTHgn9wg4GXTrpr6J7JGjld
mjXVEczFp99+mBCtqYxof6VL4BkRHGp1Yb+XiFXM399Lmnu2y9mPd7VLRZpPHrxz
PLDuMcohnn0tKmccZ7HtwttuJ4nCIFSgGgkGiItHIugTD2X9ldAe5+JwYPtgknMV
wejmdsaz98KDNYvX35FKj8+a6XBoKQ==
=VmG6
-----END PGP SIGNATURE-----

--mJgue5CzEEEizQwnAbeTt45ne4WnQgG6K--

