Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E7CC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 13:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712E520B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 13:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rui0fwr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712E520B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw59g-0007CQ-Eq
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 09:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33232)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hw59H-0006gt-LY
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 09:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hw59G-0004bT-LB
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 09:41:39 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53716)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hw59G-0004aU-CO
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 09:41:38 -0400
Received: by mail-wm1-x342.google.com with SMTP id 10so5771539wmp.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 06:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ge9uy71wu24DAY9WE4GjffdoFT7bxiIKnwYte6dNnIM=;
 b=rui0fwr4HJn5KEfIVep6pH8B6C9XvhiiI/Stxh+2iD9dxf03VIlV8j9C5AGJPlEpjO
 lL8d1eZyHVOPyTqMpxehjCdygN1jqcTdBJjnsSrS53AJxpXXoyfTJ0m4HLr1wE0uw1Oq
 w6DWKD2TnfHVcowtHjDmcIScd43KRgpgoQ5zJMauWCZ/ilAejYPhSx9LoT/Hvad1M4FK
 mfi0VQRniW2oY+uBtOmdHTOvfotKjlNxPbGwFbXliujbVGw51GI5CXlI+vCAHnDYtIP3
 jwqPmDyTBQOveYdGcItR8oOHUDvM13pXq7s8tHkPpm1eQsiFFU4XHAZLJGP7Cwc+Ac73
 XnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ge9uy71wu24DAY9WE4GjffdoFT7bxiIKnwYte6dNnIM=;
 b=InypmXALsaL9XpTSISobWJQ4aIQxlyUHmam/q1WypYoDBrYSwDTYTMD4BCbgNPSleS
 l0XxhKetqu5XIhqXN8tWFRX1aAhcxjE1HYpuybEDPrMAQvCe3Ib58vMKviZ6Nkvw7ZWv
 KRt/9euIU5NiMLI0gYJ+cDvzjKcTP7HpvY7uxp7GXzM4HSH6WDfcHDOru8KleffcaVA0
 B0aIWvqEgC4tIy43wcDOys4aQRkK8V06JMjN2hT3rPEBQLJLJH8V9CQBEMa6+Q80l0GE
 7ONtWIWIpzqnt8DdoqsrB5ar3kKCglLWZNQJ1qAghi86YoOyfmFrzfIZpaxvVSjltwDr
 Ko3w==
X-Gm-Message-State: APjAAAV3XpaZEP+3w6yw45vJDnrSiB7gc9eL19IWYvlzURXqyo3L6Obu
 UDxejYHYDbjYDNEC9K1lh4g=
X-Google-Smtp-Source: APXvYqxmT2Id8HfE0g6XYO7OiHUZbgskFJNoQuH3CKEl3NYfuWBtwgw2vkNEiZlYETD69X1npgWfCw==
X-Received: by 2002:a7b:c149:: with SMTP id z9mr11471082wmi.0.1565358096812;
 Fri, 09 Aug 2019 06:41:36 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id e10sm16446141wrn.33.2019.08.09.06.41.35
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 06:41:35 -0700 (PDT)
Date: Fri, 9 Aug 2019 14:41:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Ning Bo <ning.bo9@zte.com.cn>
Message-ID: <20190809134134.GA8594@stefanha-x1.localdomain>
References: <1564975951-29263-1-git-send-email-ning.bo9@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <1564975951-29263-1-git-send-email-ning.bo9@zte.com.cn>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2] vhost-vsock: report QMP event when set
 running
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2019 at 11:32:31AM +0800, Ning Bo wrote:
> If a program in host communicates with a vsock device in guest via
> 'vsock://', but the device is not ready, the 'connect' syscall will
> block and then timeout after 2 second default.(the timeout is defined
> in kernel: #define VSOCK_DEFAULT_CONNECT_TIMEOUT (2 * HZ)).
> We can avoid this case if qemu reports an event when the vsock is
> ready and the program waits the event before connecting.
>=20
> Report vsock running event so that the upper application can
> control boot sequence.
> see https://github.com/kata-containers/runtime/pull/1918

Please describe the issue with connect(2) in detail.  Are you observing
that connect(2) always times out when called before the guest driver
hasn't set the virtio-vsock status register to
VIRTIO_CONFIG_S_DRIVER_OK?

I think that adding a QMP event is working around the issue rather than
fixing the root cause.  This is probably a vhost_vsock.ko problem and
should be fixed there.

Stefan

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1NeA4ACgkQnKSrs4Gr
c8heagf/Y7aB9rifZK1g8Xb+Jck2Jz0I4dOQaDNqy/21ogKJ8EEIkg2gEOtTF1LT
EbE7dsSlP9kl/yCYMcoP8Vm07MiszZutc25IFut9iHJjtwF2MDIfp7KujSvTb2/9
JGitxA6mev3x8ONaEK/0gdetq1vTKAg8Ayf/a1zbbZ+lHwdqsZfiBmTA7Byg4QSt
ppsMIRc9QvsrxYMNqUc7OjurCEkj+tN68GxsAwpp8/FBaMbduIImsH8EsvZPVrjS
mpa4TAsNLeErtRdp1CAHg4dvQp5Wegs1IqcRcWUxLag0xsS8w/0Vg3Mv5RcDGEH5
4m08JhiBYJ8GRoQdOnLEDZpely0K9A==
=PoPv
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

