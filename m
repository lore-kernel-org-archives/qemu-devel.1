Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03E4C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC60218AE
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXGS7YOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC60218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iShyj-0006Zb-MA
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 08:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iShy2-00065e-RN
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iShy1-0004Ic-N7
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:36:54 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36838)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iShy1-0004Hy-GA
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:36:53 -0500
Received: by mail-wr1-x444.google.com with SMTP id r10so3082865wrx.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 05:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=GnCNMfYkYY4GAdxQXDYAfYDmvOjItsAiIlGyHE/3hSc=;
 b=aXGS7YOQOgdOyDmFhTYC/tbCfEp1q3I0IYI0hytx9vpA1jejH6I759MHiNNUPgjCRn
 4ptXh0BIy9E0tBz9zyn0QqFKMSaIdDPC54UX6wlGWqcL/SD45YA3QrXBN1ld2cQbajXP
 toVLUaUpQo7XPgS05vtk67HyseN7GC6PbWEpAqw6JMXQtIUJk64viCGU4brC5GPql4Nu
 ig04QwNSehoCR+ppKWHICrhDmF+3VyCJqUWNAd3V4w8ADbLllret3o4eBMJ6i693RNot
 8jEx02YT46smifRc2QuaTef48sMhTv+3EFFDlcde+IfggrjYIUBGfBeSqTPFKKX8mX3q
 Fecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GnCNMfYkYY4GAdxQXDYAfYDmvOjItsAiIlGyHE/3hSc=;
 b=RZKmDcgQQnrSJxhOTH2SaKIkZPShYbrHOFrh4lCUirLWvzem7jOi/Wez8M1xmYwgsN
 p3XUlwVwiFbhmDpSIm84cxRZjMsjWSotlFyaM6e2q/vHifjEWRzuriUeeJ/qkSKE6Fex
 Dt6CZMEjA6HqudWC7Kn4st9fIWl4GX7e0YqU+XN77Sph8IlnffV/YtKjyTftjQAxgVoN
 X6hUJcMGPbayfizVNncru6Ib4AyLaxOliHMAVIEIYca6PYGFrdGwdAI7zS0V3/F9it3C
 SlrGwLm5NUyepV87vHGrnNm/5l507KRR66Ulc51AfA/2w74eh0od5Ew5t1aivgETl2RB
 XEhw==
X-Gm-Message-State: APjAAAXnK5nGCdUePBthc6MDryoq9EUxr9qcK0Rlv7VeWqWi09R9hp9S
 opixkGzprZmBsbUuxDn+ysM=
X-Google-Smtp-Source: APXvYqxp99qdTUdFjJAFMoL2jiIuq54Z9VkyQgWR95ESICrs0a0yIzxByQZXwjQa6KMoADrgIH2DVQ==
X-Received: by 2002:a05:6000:1051:: with SMTP id
 c17mr2879329wrx.124.1573133812197; 
 Thu, 07 Nov 2019 05:36:52 -0800 (PST)
Received: from localhost (77.119.131.75.wireless.dyn.drei.com. [77.119.131.75])
 by smtp.gmail.com with ESMTPSA id d13sm2177399wrq.51.2019.11.07.05.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 05:36:50 -0800 (PST)
Date: Thu, 7 Nov 2019 14:36:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 19/20] fuzz: add virtio-net fuzz target
Message-ID: <20191107133641.GE365089@stefanha-x1.localdomain>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-20-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-20-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2019 at 02:50:03PM +0000, Oleinik, Alexander wrote:
> +static void virtio_net_fuzz_multi(QTestState *s,
> +        const unsigned char *Data, size_t Size)
> +{
> +    typedef struct vq_action {
> +        uint8_t queue;
> +        uint8_t length;
> +        uint8_t write;
> +        uint8_t next;
> +        bool kick;
> +    } vq_action;
> +
> +    uint64_t req_addr[10];
> +    int reqi = 0;
> +    uint32_t free_head = 0;
> +
> +    QGuestAllocator *t_alloc = fuzz_qos_alloc;
> +
> +    QVirtioNet *net_if = fuzz_qos_obj;
> +    QVirtioDevice *dev = net_if->vdev;
> +    QVirtQueue *q;
> +    vq_action vqa;
> +    int iters = 0;
> +    while (true) {
> +        if (Size < sizeof(vqa)) {
> +            break;
> +        }

More concisely:

  while (Size < sizeof(vqa)) {

> +        memcpy(&vqa, Data, sizeof(vqa));
> +        vqa = *((vq_action *)Data);

The assignment is redundant after the memcpy.

> +        Data += sizeof(vqa);
> +        Size -= sizeof(vqa);
> +
> +        q = net_if->queues[vqa.queue % 3];
> +
> +        vqa.length = vqa.length >= Size ? Size :  vqa.length;
> +
> +        req_addr[reqi] = guest_alloc(t_alloc, vqa.length);
> +        qtest_memwrite(s, req_addr[reqi], Data, vqa.length);
> +        if (iters == 0) {

What is the difference between iters and reqi?  The values of these
variables are always identical so I think only one of them is needed.

> +            free_head = qvirtqueue_add(s, q, req_addr[reqi], vqa.length,
> +                    vqa.write, vqa.next);
> +        } else {
> +            qvirtqueue_add(s, q,
> +                    req_addr[reqi], vqa.length, vqa.write , vqa.next);
> +        }
> +        iters++;
> +        reqi++;
> +        if (iters == 10) {
> +            break;
> +        }
> +        Data += vqa.length;
> +        Size -= vqa.length;
> +    }
> +    if (iters) {
> +        qvirtqueue_kick(s, dev, q, free_head);
> +        qtest_clock_step_next(s);

Here we could run the main loop until free_head appears in the used
ring.  That should allow the request processing code path to be explored
more fully, but this it's okay to leave it like this for now.

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3EHekACgkQnKSrs4Gr
c8jAbwf+N/JbDzaIpDwdTXNyW/FswAXQEoUhz0MnopcDJeKDExqdf+xQCbv4IRW6
fTpGH+s81MvjLoolWYf5Z9mZEE6VaDM0fH+77lld3Hz/U/2T0Bg/vY03UBihIyA6
TaTwpCwxnpcViERj069Ja91ddpUd7nVr2XkNoJLVqpqKVO82zBf0FuXzQvzYGz6G
k/5gqn4ya+Uyta4DOvjPwG4B6ABy2nz4gsqJzrUMGaQ1Mb8pPMZrHEX7CMAei7qe
Xkm43MbsN2Z9yvX05P9Ovjgx+XMOXZTb1opvjBPggscDmPNpR3HYAwTPb/nuyIC6
66JjSOpZPx7Qbw5D5glKOPyvGAKWpA==
=tv3Q
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--

