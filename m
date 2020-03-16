Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D62C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7012051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCSCG+69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7012051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDonu-0004YT-TI
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 08:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jDnoN-0006zw-3i
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jDnoM-0003Wd-30
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:21:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43381)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jDnoL-0003G9-Qt
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:21:34 -0400
Received: by mail-wr1-x442.google.com with SMTP id b2so14451450wrj.10
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 04:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=4GK03kA8oNgvX3UTiv2z1xXBynif/uVMbj3je63Vv5Y=;
 b=JCSCG+6966WrQH1jb1pxiWFV/ifAT79jbbHM38L73dN7NhfUjsUp8y5fCq/30lOYyM
 7VnTPInb7RZoNbGIo1Gt4Jy6bd3H0ggeOP1NuaciRPboQTdTm3uaYNz4XRKAComqBIeN
 tNoOhJBA18oYzDfB+RAqj+Z6jllj+WFyeR1O6hzRRV6iYvRIwLCjYVnG0pes4zW5fat+
 pc+QM7mZLuWMSthNI1+jsjdGwv8oKToKz53Z1FgHdzqng2I1nizOb22HIMeC1Yd7EVRB
 H2vU1ka1g+YAK+JPJc64kfdvYalisnLE3x+JbnTgjZWZuinqQcXuhhu8VU6bGcfUgKjN
 Bvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4GK03kA8oNgvX3UTiv2z1xXBynif/uVMbj3je63Vv5Y=;
 b=uJXgfqoVGciJtgVVWQ9AEfNWTjJLwDKTw3AsuZtSVcs20V+uDEObnnRgxuH2+hS8xq
 bj+F8jocHuunP2faxMBR0Kv/O3sZVX4r1PYA5oEdGcEPpqo1Si4Buw5phdu/vY1QEDKK
 KLCLRDY4ZAh5J3p7AqLRmVTD8x8DGuywQzpS71LULuggAOKrqf8gHdK7VdZHt7BcmJ45
 gR65aSm5SiP15RQua2bQWMlddTFY7hJl7xgmJLOgKFmO1jpYoeESaUp44HwD9FEswsOu
 8JE1hnrNw+NhylCxrRtQSkmZ5hotm34LkjcH5CZ+dqTP58P33M85WLPmndUVmVAvfuyw
 WV0g==
X-Gm-Message-State: ANhLgQ0E/CekocSCCHqxZWmxc2OPt14vAEhVib/drqIfOM1Hb+M5quhK
 BCk6iZ4Ir80u1Vl1bT+bKKZ8D4wg
X-Google-Smtp-Source: ADFU+vvT1pXOzZRaR5V3NNhvsScHx1qW7LP0Uh+1GQK+0fM3pljgzmexYEj7M3KIAiP/wdvoDCE6lw==
X-Received: by 2002:a5d:480c:: with SMTP id l12mr35588174wrq.19.1584357692395; 
 Mon, 16 Mar 2020 04:21:32 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id l26sm1376501wmi.37.2020.03.16.04.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 04:21:30 -0700 (PDT)
Date: Mon, 16 Mar 2020 11:21:29 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Subject: Re: [PATCH] modules: load modules from versioned /var/run dir
Message-ID: <20200316112129.GA449975@stefanha-x1.localdomain>
References: <20200306132648.27577-1-christian.ehrhardt@canonical.com>
 <20200310093910.GB140737@stefanha-x1.localdomain>
 <CAATJJ0KvA65i4463wCX1m2e4L=r=O1oaFjojXDvOX3otmMX=dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <CAATJJ0KvA65i4463wCX1m2e4L=r=O1oaFjojXDvOX3otmMX=dg@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, pkg-qemu-devel@lists.alioth.debian.org,
 Cole Robinson <crobinso@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Miroslav Rezanina <mrezanin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2020 at 12:47:49PM +0100, Christian Ehrhardt wrote:
> On Tue, Mar 10, 2020 at 10:39 AM Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
> > On Fri, Mar 06, 2020 at 02:26:48PM +0100, Christian Ehrhardt wrote:
> And finally this has to be considered an "offer" by qemu to the packagers
> to fix a real field issue.
> The packaging does not "have to" exploit this, every Distro is free to ju=
st
> ignore it.

I understand.  My intention is just to draw the attention of the right
people so that other distros are aware of the problem and improvements
can be discussed.

=46rom my own perspective it seems fine to merge this or a similar patch
into qemu.git.

Stefan

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5vYTkACgkQnKSrs4Gr
c8ibvgf7Bj1MD5TlMqJhOeSlzoPwQoBiDuHeLeTwai7hqALH+WcCKxugnp8qh2cn
jm6XrA7kwG5rclIvsuM+SAUxO5TwTDLJZiNjfhKCizOAVkTdC/S90K5hVa4vGFFn
9u3xWkuPc+lhSMYHNBxkmNsQjhIpJyVONnQumtrzSi5Kievu1pmA43xUPICvt3y7
MP0kAeEsiwtO+FhpPEaOm2nb8S40OrEzQVqhyxzbL7uTr1v+d960yxskzfFU9OB5
MBEka1NQivLiDFarHuubmYosxTmlHm91wjJh2u4iE/NhfYQPwVaEipElzNc/XKLh
cw0Lx8EL9bMFVsEpGJcFc13adZhwXg==
=kzvU
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

