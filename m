Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113EBC10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0FE208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaIuU9E7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0FE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53859 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJZqe-0000pK-UT
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 04:35:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJZoD-0007oj-02
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJZoB-0004pa-PA
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:32:44 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hJZoB-0004oW-G4; Thu, 25 Apr 2019 04:32:43 -0400
Received: by mail-wr1-x441.google.com with SMTP id b1so17731477wru.3;
	Thu, 25 Apr 2019 01:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=zUhlyxyeZrFmslqNufeb6Jk7wOU4GfXLzccQ5GHPens=;
	b=gaIuU9E7bb8SQkAkUwhyu9FLNV7J0GsgV2fIjRtJRaZ23tLQaj+G/QEosDaQ4UDmPt
	go/Xd5wiDEZD4SlMvvalpGWOHhPHV2RtLwBiohspWD8PanD97O1D/98dd98JWLev8A9I
	d+LWraSQMctUD1W1S03R1FJozzG7AnqliwBsoEYn64yMEt+hFjEfOiR0bw3mbwglLuqi
	orMD1t3IstC6TnQi3+6GQiSP4Ys8Bp2FZC/qO5XDQufQ1TifMo1Sra60Sue3aeHRPPZI
	yTpCBLygpMxH7Dv17JCO3CZHmX4jBvszS2foKy/yujV1CKQT160DEZmebOA5lhg5hXbZ
	Nb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=zUhlyxyeZrFmslqNufeb6Jk7wOU4GfXLzccQ5GHPens=;
	b=qY8SCRsR0X7OsVG2CtJ2pLigz6bjaK+6RoYnHZI4UB0T+qmwKojft9hLcvDv6ICmN8
	3gGJQO3w7BUsw8YKrmSa/Oxg0KG0B0g4j70c6snumfuvSeXp5O1JAX03hNzqiBXE3lIa
	kxar5aHmEZamjDLdgJMeTxk780ylolcm9T7wIhJJg1Qq3irUQ2d+AUTDUoEJXcMBeVww
	XroY9t2DEDPC4Fhc4xOiHaO5WILhcde1AyMxgGPQX2O9FrHlXIl8zTqa7c+rt9YZIV+O
	fP8NbpJl/TSdwbmQFtB/mBCyc4ZWcFMrQ1BMYExR/LXNcOh1vtsi1XAXbgRr0Bcg6OFL
	urDQ==
X-Gm-Message-State: APjAAAWh0quQldPn++uo8ft6wHqvQRcCVz3jUtvB2db++r0M3JXJeWVj
	dZqe9Uhwv8gu0uM6/ki5wYI=
X-Google-Smtp-Source: APXvYqxb5hSOnZRVXmnRDNWyMCjTvET5suBd0FeuoQDU5Z35rjqq2zd6sUZd3JNLjyNQYOhRRgXbxg==
X-Received: by 2002:a5d:6b48:: with SMTP id x8mr11849214wrw.266.1556181161754; 
	Thu, 25 Apr 2019 01:32:41 -0700 (PDT)
Received: from localhost ([51.15.41.238])
	by smtp.gmail.com with ESMTPSA id y2sm8010700wrl.79.2019.04.25.01.32.40
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 01:32:41 -0700 (PDT)
Date: Thu, 25 Apr 2019 09:32:39 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
Message-ID: <20190425083239.GD30231@stefanha-x1.localdomain>
References: <c47aea74-cec7-0369-591e-e1b1fdddc3e6@huawei.com>
	<20190423135635.GL32465@stefanha-x1.localdomain>
	<0259E1C966E8C54AA93AA2B1240828E65D0BE6FB@DGGEML529-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline
In-Reply-To: <0259E1C966E8C54AA93AA2B1240828E65D0BE6FB@DGGEML529-MBS.china.huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] 
 =?utf-8?q?=5BQemu-block=5D_question=EF=BC=9A_Does_q?=
 =?utf-8?q?emu-pr-helper_have_its_own_log_files=EF=BC=9F?=
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
Cc: "Wangjing \(King\)" <king.wang@huawei.com>,
	"Fangyi \(C\)" <eric.fangyi@huawei.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"wangjie \(P\)" <wangjie88@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425083239.xtBa-lbd_p7IKgTQ9DV0A-dmL5bqF397pd3HFt7WY2U@z>


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 02:37:36AM +0000, Zhangbo (Oscar) wrote:
> >From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> >Sent: Tuesday, April 23, 2019 9:57 PM
> >On Tue, Apr 23, 2019 at 11:12:40AM +0800, Jie Wang wrote:
> >> =C2=A0Does qemu-pr-helper have its own log files=EF=BC=9F
> >
> >No, it does not.  qemu-pr-helper uses stderr for errors and there is not
> >much output during normal operation.
> >
> >Check journalctl(1) for errors if you are launching it as a systemd
> >service.
> >
> >Stefan
>=20
> The error messages that sent to *stderr* are *not* captured by anyone, th=
en
> these error messages seems helpless.

This depends on how qemu-pr-helper was launched.

Daniel Berrange mentioned that stderr is not captured when libvirt
launches qemu-pr-helper.  So in this case there is a problem.

> It's different form qemu's log,  qemu's stderr logs are transferred to vi=
rtlogd,
> that means these logs are finally written into disk.
> Any further development plan?
>=20
> We thought of:
> 1 logging into syslog, but the malicious guest may cause large amount of =
error
>   messages to overflow the message log.
> 2 or, let virtlogd to redirect its logs. But if virtlogd get restarted, t=
he helper's log would
>   no longer be logged, because, unlike qemu, there's no qmp socket betwee=
n=20
>   libvirtd and the helper, the channel between the helper and virtlogd co=
uld not be
>   re-established.
> 3 or, let qemu to log the helper's log, seems a little odd and complex.
> 4 or, let the helper realize its own logging scheme and log into itself's=
 logfile ?

Perhaps libvirt should be modified to handle stderr.

Stefan

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwXCnAAoJEJykq7OBq3PI0p4H/0eotECdLXd992aTU3WnqVmT
7+FvRrQRyORu8P6gPaJPEIRGD5mQSL8Py+L8EyaIP52hw+LkTzpAkVWOldFS9ix/
asTP9i9WC0s9WUl+023ja9JntQcg0Xog3i7tFCCtcp1FS2EXp5J4pFEyh8e31Uzt
5Vq/eq6dAQYpA9d05kplop3nTevZokVva6cbkTMXM95HGmlK80r0hHz6x+I5ehZG
VVQEppiMLnPUD0YzimAfwLyEoStJw0CrT89DrUJ5+ep6YmRIIMOLu8kD/bW6YswF
HyAiuNGpw4XDMSh32e/k+k/sH0sEalfx1QhOS/8c2zhdbVZe0cNbPPLxgOuzDi4=
=bRO/
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--

