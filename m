Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FEBCA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB52206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEf+4S68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB52206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYXZU-0004Ln-06
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jYXX3-0001SJ-Pp
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:13:25 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jYXX2-0006Da-EY
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:13:25 -0400
Received: by mail-wr1-x442.google.com with SMTP id y3so16167156wrt.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BS2Zqqe0j+9oHG8SIBauzYbMLE3wF8/MCFBpZuru7Jc=;
 b=XEf+4S68KlEeihq3imT8LQdaMuSdL1MQXPE02ElHtLeqXE/TCDDe6bdxFJSQ35rY5r
 vM81Q8osnFnnDv8/wn6NK9RHIJ6+voARTmE8jTNL7w325gb4ZF2lEV+RpYsYI2lIamM6
 84z++F84hfs21DXO2vUYEEZ4mcmFQ51ZBxBmfyNiFFAiNXKt7UM9UjxWunRDjZcdckIX
 BTQaRADPyf8Ek5LqseTnH7BPLXyO3ipOZKLW160JI00qhQt/H0XS8hZ7G9q1qTF/UYDB
 nn+t8nNQ4rZ4xazTmulpjUB6OJ5TeQurhDSKF3DZNnTsMcnLHFdkOC9zNgsSTmMVUiFb
 aQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BS2Zqqe0j+9oHG8SIBauzYbMLE3wF8/MCFBpZuru7Jc=;
 b=Yz/tZb0JGqZ5LbylNQsA9Z/fTRuHqXtBgUnLCWN6NFr7jFZNDjvMvQ4Ol6dw3Iaic5
 ospbStx3GnsMltXuL3bav9HZxNSFFJFaZq1PF4wADV48XmkPI7ewdnJI4Ca4qXVvFW/X
 mpV2k41TNOIgLdAS6PC3ouZs1lR4Zk6nidCYOtFOuC9r1yafIwiiOTFF0MU0hUamjLZ8
 0m40e/gqilvQNcH2mS8D0akAgDTniX+usW6XBRbR9ynYugVnaoRB9WnS2C4gu1jYs5ar
 CiY0rRen4L8Ut8Ij6rD5IypG8HKWeAwnBjE21APofFXr/wQ42sHNgPfyZ97/qc+LrdAL
 Nhrg==
X-Gm-Message-State: AGi0Puaor/r+j9j5P2c578v8pagEQoZVi+6F7xIzTJg6PK2sNjeus2KW
 5sJtjz32I5yjIJ/oI8F7N+Y=
X-Google-Smtp-Source: APiQypJUGurWxipmuBw+MJZNYba64r4rr7dAVYDQABNW8D0tGtD2iIDtCfTTBk/M4Sd7iVjXjCiRxQ==
X-Received: by 2002:adf:f207:: with SMTP id p7mr25474396wro.20.1589300002495; 
 Tue, 12 May 2020 09:13:22 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p9sm17131879wrj.29.2020.05.12.09.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:13:21 -0700 (PDT)
Date: Tue, 12 May 2020 17:13:19 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jag Raman <jag.raman@oracle.com>
Subject: Re: [PATCH RESEND v6 00/36] Initial support for multi-process qemu
Message-ID: <20200512161319.GA299814@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <20200511144005.GC182627@stefanha-x1.localdomain>
 <2D3D00E3-EFE0-4D60-8B68-9CF41F6154CA@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <2D3D00E3-EFE0-4D60-8B68-9CF41F6154CA@oracle.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 Swapnil Ingle <swapnil.ingle@nutanix.com>, john.g.johnson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 03:30:50PM -0400, Jag Raman wrote:
> > On May 11, 2020, at 10:40 AM, Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
> >=20
> > Hi,
> > Have you decided whether to drop the remote device program in favor of
> > using a softmmu make target?
> >=20
> > Is there anything in this series you'd like me to review before you send
> > the next revision?
>=20
> Hi Stefan,
>=20
> We are planning to drop the separate remote device program in the next
> revision. We are planning to use QEMU=E2=80=99s existing event loop inste=
ad of
> a separate event loop for the remote process, as well as the command
> line invocation you suggested in your feedback.
>=20
> We hope the following core patches look good to you, by and large:
> [PATCH RESEND v6 01/36] memory: alloc RAM from file at offset
> [PATCH RESEND v6 11/36] multi-process: define mpqemu-link object
> [PATCH RESEND v6 12/36] multi-process: add functions to synchronize proxy=
 and remote endpoints
> [PATCH RESEND v6 13/36] multi-process: setup PCI host bridge for remote d=
evice
> [PATCH RESEND v6 14/36] multi-process: setup a machine object for remote =
device process
> [PATCH RESEND v6 15/36] multi-process: setup memory manager for remote de=
vice
> [PATCH RESEND v6 17/36] multi-process: introduce proxy object
> [PATCH RESEND v6 18/36] multi-process: Initialize Proxy Object's communic=
ation channel
> [PATCH RESEND v6 19/36] multi-process: Connect Proxy Object with device i=
n the remote process
> [PATCH RESEND v6 20/36] multi-process: Forward PCI config space acceses t=
o the remote process
> [PATCH RESEND v6 21/36] multi-process: PCI BAR read/write handling for pr=
oxy & remote endpoints
> [PATCH RESEND v6 22/36] multi-process: Synchronize remote memory
> [PATCH RESEND v6 23/36] multi-process: create IOHUB object to handle irq
> [PATCH RESEND v6 24/36] multi-process: Retrieve PCI info from remote proc=
ess

I've completed the review of these patches. Looking forward to
discussing more.

Stefan

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl66yx8ACgkQnKSrs4Gr
c8jqhQf/ZJdcFD5OzutXLv5b39kkyzYu01Wx956y2FwU1RDfFaH1LDKuckcb+Rr6
nJjWSa1TMNUd0FIrxvWZWvxthBBn+NrnnGTSBeKduNwViVOwCP+536JRUFMX28X3
zLMzJuqcDR3liuZuMJrVliFpVHfa1PVWKHk6aKVSMnlyzGwhC6bFpHtnDojQMLDm
WZzTzP3bZEa4O+DUXR/F6fgOBwNMYX6ls5hFHuvIhS/DjEAj74jBPgvmYGr/N9wP
ahJkSer6lB2yYT4H+unOdCZfpDOXh/4rKlaF7TPWtgZx0hYbKtc20CEGRp/lWL4S
7K0duk0w2O9O6VDIprbFKLB+1/0R3g==
=l8sb
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

