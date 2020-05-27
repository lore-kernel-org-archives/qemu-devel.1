Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F07DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A6820899
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4lp+nI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A6820899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxKV-00086i-7n
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdxJQ-0006U3-UL
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:45:45 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdxJP-0001Qd-G6
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:45:44 -0400
Received: by mail-wr1-x444.google.com with SMTP id j10so8664734wrw.8
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=4ncUjfrJRVD2o/p7nlAgb1zc6UKT0YYie1b+tLAb++w=;
 b=H4lp+nI8kvYQUF2bdbs0+rDeUmo4R4bUY1I3netX++quOH1fkoMtL0dlOFd/G6Xips
 Z1AoGZHJhFgMwoiQ5SwbiL/aIzF7m5D3Pkz69SkDeW6sUakpylw52N7RwKLayvbqrJq4
 H6aZ7LR80+cNsb/DkDMcWHnrzAe8Hl7zmEeIS6kf2A6OPXM4fODjnN7p+9BxZ7eCGmDe
 9T2bl4qkO4oQlMuhotgRZdVcBe40MkmpIX/xPGN+s0Zs/I/s3Nvob+5S2pAtmYnQw4Xg
 WZJr60raz/SaBCdTUjtR+RL5Xwg5nl05k0lbRLuEXZQFEl4UcMlsHeXhWWfxeiFPKhaE
 xQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4ncUjfrJRVD2o/p7nlAgb1zc6UKT0YYie1b+tLAb++w=;
 b=hRmc4+DLgEAjY0xCmU++azic5mXKBIaLs5+Ya4aBTf0vonxc/0RIFad8qPQh2Wh0Aa
 KRR9vDM4bJIiGJZX0C4CP4ng8fOgGTx41Mgw+TYwFpwDS/puOCvwu24dAp0y45mX9n5M
 XdHKeZ3V+P/CM6/dN77zy1c2es49TprIm4gd6acfBR1QnxW013CfnXcSI4Z7MZLN2pw5
 REbXF+4khQDaneoC3QXGmG5l4ehcQZkOtLX6xOGEWeHcax/JmCDkz2pq7YYOQgQB541h
 C1+9nlfEStIw48ZpH4SojvhC/Lt2rSeSMBxjjclcnghUycI6g7NKeAGbg8DuswPAlVPg
 r7NA==
X-Gm-Message-State: AOAM531ZFfewnS/OnQ7yBzlO68PpczVeiSNMDTkzXPUD714APOJyoLfP
 e+KK5ljwstPNv2YgODUetk0=
X-Google-Smtp-Source: ABdhPJwrYqiHIwHL8JCrIyUvZEXq9Z5OD/THMLo/FKQFQx//DjiZWUp1cxdGqlU+UWkn41KrvodMJg==
X-Received: by 2002:adf:e883:: with SMTP id d3mr15323235wrm.274.1590590741907; 
 Wed, 27 May 2020 07:45:41 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v7sm3157269wre.93.2020.05.27.07.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 07:45:40 -0700 (PDT)
Date: Wed, 27 May 2020 15:45:39 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 3/7] device-core: use RCU for list of childs of a bus
Message-ID: <20200527144539.GI29137@stefanha-x1.localdomain>
References: <20200511160951.8733-1-mlevitsk@redhat.com>
 <20200511160951.8733-4-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7IgncvKP0CVPV/ZZ"
Content-Disposition: inline
In-Reply-To: <20200511160951.8733-4-mlevitsk@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7IgncvKP0CVPV/ZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 07:09:47PM +0300, Maxim Levitsky wrote:
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index d87d989e72..ef47cb2d9c 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -3,6 +3,8 @@
> =20
>  #include "qemu/queue.h"
>  #include "qemu/bitmap.h"
> +#include "qemu/rcu.h"
> +#include "qemu/rcu_queue.h"
>  #include "qom/object.h"
>  #include "hw/hotplug.h"
>  #include "hw/resettable.h"
> @@ -230,6 +232,7 @@ struct BusClass {
>  };
> =20
>  typedef struct BusChild {
> +    struct rcu_head rcu;
>      DeviceState *child;
>      int index;
>      QTAILQ_ENTRY(BusChild) sibling;

Please add a doc comment to struct BusState saying the children field is
an RCU QTAILQ and writers must hold the QEMU global mutex.

Stefan

--7IgncvKP0CVPV/ZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7OfRMACgkQnKSrs4Gr
c8jYxQf/doNUdg3EFjEhdI8EMtOpXdaZRKGk2Epc2GdkXS+Z8Pgv8ETKw0P9CSVE
+wBuYB/DxWbevnjJiTv1kJz8+y/qrtDPRWY/7LBZO2X7E9302Gz0V8zCGPalVrXi
GJoR/cpanUw6FfOcSc4uK+yHk07yQ5RqOp0fWGeNmVMrVouJeSdgWxAuDAI7/Bl7
dzL9MedjoiLWFgknoxVnv/DCYunYncz5s8V34DCMyU1fm1FhB/+Iq52Mqjb5u2Nx
g6bpSJj9E5n/Q18fSI/9SHNoP7neSfi8StL++WHaJMYPsnEoxBgbut49LlXvjJlj
ImN+L8eUxCgu6ND0i03EWH7MKICvHQ==
=kdU/
-----END PGP SIGNATURE-----

--7IgncvKP0CVPV/ZZ--

