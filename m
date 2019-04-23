Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE06AC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9108020645
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adCNPAsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9108020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54350 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIw47-0008Go-P8
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 10:06:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hIw2V-00074I-Ur
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hIvuZ-0000iZ-VR
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:56:40 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:52349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hIvuZ-0000dD-OR; Tue, 23 Apr 2019 09:56:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id j13so191757wmh.2;
	Tue, 23 Apr 2019 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=L38sPrGGGtJvstAOL2NnU3hwoiTbLSSZIhZ20HOkLwY=;
	b=adCNPAsZJ8j7gkeVHnSTbOD0xuxxBNsvFnTmNZLq9UN1OCaWMS2JS6FfRdpff0AZDN
	FUeNCk6xNcHzR6MFniqHCyS7yRIi3qVyeXDsPOQ5vAOdDVSFL141RgTVLwgsfj1Tmw1D
	6k31jiIt0jXOP8TiWFbxPhKpTFisNs8huI1+c8lhhn6F6Jyu2jpjuktWLyZ9yj2BF7NC
	VlnMhRri3WbRSSiTJPIaBhu7ZMFmVGGPtQNGPmHz/0QM8FCVYKSues/whul4dyA7eLNR
	wRJeZnUitxopSjBmHuMg3/wXj/CvpC8tB/0iEpO2QYGKc9pwwDHkx20WYtCb7JN3NZz2
	+E6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=L38sPrGGGtJvstAOL2NnU3hwoiTbLSSZIhZ20HOkLwY=;
	b=PGi70YfGEBh34EDhH4SrzlWZ1aLTUPbzz2U04a5ZqYRQoC8FrYto7FyBhv5WFt66gQ
	jdz8Lb0ZoK5b5PkxyhfXNx8yTg2B2w+6S+AMSFjim5CfS9ghXvjY8H2Q+A/BJGURyaVW
	ljv2EqUzk0zevb/hD8hTVV7siawvrL6Zhm108uYj7qXV3gVrsZO0BQPGyu8bCltsnmj2
	mrG36s0Dw4LaSlyJTh3vZ2pY++g64QFJUJXaxorZLanYZ1ox/xskFjKKxaPFGtR4rLcr
	DBCg9w7V1o3a7zq5uCiQoeITTp+99tVNtwunICzKXD3kr7YvJzErJfDefzbgiG2f6sf3
	0FTA==
X-Gm-Message-State: APjAAAVvu2/VKdVRe3Qlqc9bujRlog5mRgRn+UBfllmL0PXqeFFVkW06
	1MYm+/MOJ5VT18AsOxEZeZc=
X-Google-Smtp-Source: APXvYqy8akEXzWVUV3ehlH/CrFRYmdmpQwydkC4EuiSZjfzjhKHWJkVIdhyIMBEm6GD+df/TtuLLhQ==
X-Received: by 2002:a05:600c:20d:: with SMTP id
	13mr2464516wmi.60.1556027798342; 
	Tue, 23 Apr 2019 06:56:38 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	z11sm14949383wmf.12.2019.04.23.06.56.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 23 Apr 2019 06:56:37 -0700 (PDT)
Date: Tue, 23 Apr 2019 14:56:35 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jie Wang <wangjie88@huawei.com>
Message-ID: <20190423135635.GL32465@stefanha-x1.localdomain>
References: <c47aea74-cec7-0369-591e-e1b1fdddc3e6@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1hKfHPzOXWu1rh0v"
Content-Disposition: inline
In-Reply-To: <c47aea74-cec7-0369-591e-e1b1fdddc3e6@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Cc: "Zhangbo \(Oscar\)" <oscar.zhangbo@huawei.com>, qemu-devel@nongnu.org,
	qemu-block@nongnu.org, "Fangyi \(C\)" <eric.fangyi@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423135635.MSfE8vH5z-qcrh2PDLHlZpXGcd3uEGagBKneuWuZmjI@z>


--1hKfHPzOXWu1rh0v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 11:12:40AM +0800, Jie Wang wrote:
> =C2=A0Does qemu-pr-helper have its own log files=EF=BC=9F

No, it does not.  qemu-pr-helper uses stderr for errors and there is not
much output during normal operation.

Check journalctl(1) for errors if you are launching it as a systemd
service.

Stefan

--1hKfHPzOXWu1rh0v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcvxmTAAoJEJykq7OBq3PI6QUIAMiYRUcvsCI5IZ3WKTnXeJFw
31XmCdsP8k8VO4c9FCN+pwSNhJg4jDZO7vbREKbOu1AYSdCY7c6NfAQKAswu/5hF
LFsXPoH4SST8qu7cmykmPmebgdAv34P0jjdpqhWhNHBlPrp+TgcD9QJVSsRG3pZq
I1TtNp3HpKeVXiRWg+C8fSTqaEnl+fQEvCA9TCustcwTgm3JqRZbueNU/tD5vht2
74/XZpz5MHIydh/jNEf/CRwDHIvejERL+XPOg784eZW1J6EP6qMIqcry0pTFT0JP
xOOF4/xI5V/0sDSXfvj/RuQQJgxtKhlcpIGbYxbRWuHmyHg4erm6BPtD+Mtwfc4=
=RyMb
-----END PGP SIGNATURE-----

--1hKfHPzOXWu1rh0v--

