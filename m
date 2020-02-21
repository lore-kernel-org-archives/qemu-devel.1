Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37220C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C7620578
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXOXK2hd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C7620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58mB-0004KF-7A
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j58jt-00027b-5c
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j58js-0001QK-AP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:53:09 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34621)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j58js-0001Py-4D
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:53:08 -0500
Received: by mail-wr1-x441.google.com with SMTP id n10so2190463wrm.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=i7PbMVv2unDSnNzciIQ4e2ziSyGgFxQmv+PdpIn8FtI=;
 b=JXOXK2hdbDpuhUDxgwX+t+2IUNFDxxJtteQCwAa2MUtZVdNPukQ7W5hwZKV1nphUzl
 EkU6ODhWFhrASEkzV/Cxq751FVxsF8l32d3peT+8znrZD5CnU9tSytWydOobRBiU3I1v
 9n0akflKU9kp+WcEo9v987tqr+DyXYYvKDAxwc1ZrkiPLDgW8gJ/n4PzxxWdu0Oe79sz
 XABo3nLkzeIpGQMKZEnN3wRNztMZxi7CjScSlAlaIqGdidTw7gxRzp+61t1uq/Yj9k/I
 gQHBaIDrE4r8TPBb4li1kQtoR7mTiuwn2STogRf0Ho6zqbkp6pU5TL+xhImJ/CVo1a8g
 hP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i7PbMVv2unDSnNzciIQ4e2ziSyGgFxQmv+PdpIn8FtI=;
 b=QTiw6vYsRi6siHANzZPbwbcEWMBZVAMOF52WUisqTepSiSjTnzJDgyOu7aV9zzetcX
 Oxaq7a2qxYDthWxWg/2hmYHPcSXW52CYH07CjQnxVdeE6z1Ey+9PDlBnfhChkVfX3NPt
 cD8aUTiQ+bG8Fv4o1jtXPUdzxATyFqtNZPeLw4InfvwSIUn3RXlMfBEhNY05aQEEzFAv
 U9nIyiRF3BvQzHVy3dL2YwMm55yhXxGZwm88PbwpmvkVash86tNXSuyt+WmS1bkzJCmT
 6F+YBe7C9R2/Xq/zVItxfoKfwAZkB/JPdSHziTZpYy8WuMpOW+zl6dGdZ8UBQAX1k8iC
 RjOQ==
X-Gm-Message-State: APjAAAWAdDhc1g2W6WcXBCSkZ41FLp6TBYopxLY+dBnplHz2l1FcTkHA
 NGg+DxhSQSUusgWmvsaWFjk=
X-Google-Smtp-Source: APXvYqw+zqkEN1fQPFcC+cbxY/pYaMjFAf78/0nUKHHqevxkIVy7yFRGpw5IO+/4s4TuPf+nUd0hOQ==
X-Received: by 2002:adf:db84:: with SMTP id u4mr49706394wri.317.1582293187238; 
 Fri, 21 Feb 2020 05:53:07 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o15sm4225134wra.83.2020.02.21.05.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:53:06 -0800 (PST)
Date: Fri, 21 Feb 2020 13:53:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH] qdev-monitor: Forbid repeated device_del
Message-ID: <20200221135305.GN1484511@stefanha-x1.localdomain>
References: <20200220165556.39388-1-jusual@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i6vqABX3nJKXLk01"
Content-Disposition: inline
In-Reply-To: <20200220165556.39388-1-jusual@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--i6vqABX3nJKXLk01
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2020 at 05:55:56PM +0100, Julia Suvorova wrote:
> Device unplug can be done asynchronously. Thus, sending the second
> device_del before the previous unplug is complete may lead to
> unexpected results. On PCIe devices, this cancels the hot-unplug
> process.
>=20
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
>  qdev-monitor.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--i6vqABX3nJKXLk01
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5P4MEACgkQnKSrs4Gr
c8jsRQf+NbfChvyiuR3/C1Oo3XgKxxmN+Q/bMJWFOlbn7ZdBqjQJOKNZiI5mf8iS
F76Pz2KH2MiDNdTZ89eXKohlYvEA7AUU08ur9asmEAnmmJ/7ja+eLZcYOuiac3LA
hWK8iF34Gxo5reui8KEDu4DEneJtjPlA2Bx/HfAFPbBZtLxU57F09/yefHqUr5Cx
j2+QSqlhBYN2nvh859vFNb4U5tIujPhsEza9NssW3lgLTLShPAs0RnESsUyA6I4I
Idyh1WbD5ghFpFYIk8k0p0cXEw8yDZoy2sLIOtImwg54eWp3Xv0yFgEciTA9lOiB
HUE+zw7+jYD/GXIebAnwsPygF5D+9A==
=j8eS
-----END PGP SIGNATURE-----

--i6vqABX3nJKXLk01--

