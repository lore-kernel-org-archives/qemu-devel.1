Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BB5C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D662133D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFG0ferY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D662133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49572 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbiRi-0002CH-SN
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 05:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37647)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hbiMC-0005Rm-Of
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hbiMB-0002L8-JW
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:18:48 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41546)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hbiMB-0002Iv-CU
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:18:47 -0400
Received: by mail-wr1-x443.google.com with SMTP id c2so1705691wrm.8
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 02:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=iLcYT359pj3wfIaMSCFjPG73QqWy8nKrRZs2WGLbKgM=;
 b=LFG0ferYwvUl1G1vWRnjbsiYBPvXtekGb/r632Gk5e+BRMFBab+b0V0c/efxxAf3em
 s9CtvI7tYMPUPcUfXxkES6Zug42PY7w54HTNKHFYIX6VMARse+CmS/gM1XI2EVjWDvE9
 3iB7P+I3nigorleQ+nFL3criQt50iN/sUvoXacSNfoUPNWiQL9KygAekREHG+WK6dAw9
 fmqqUtjvhAqNWWfyeaQ1TeYoe+V1pZUFllN/v+kV2Bepf7AsxeizO8QI1nNJsJoEiT3c
 yX3R9k+tkDLmWiwCkH8V2kSZ3i1r2gwuawp+WsVUc6WWkstU+lAvf/HcrTRG6aeYyLLs
 CAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=iLcYT359pj3wfIaMSCFjPG73QqWy8nKrRZs2WGLbKgM=;
 b=QfYx0+v+5AnEisezfIYCVTV7oXxAgM5ADFQ/bkxrskg0oqdirdsZUH70lnKm72Lstr
 iUbmU7aBdbBGtlVHmuQTdXQ5lxHPfBFg6cDO/PpP9aB4zaUA5MQ6qvqqQwh4ufs2B9Br
 IODWBoFCSzgjixGjrA3iHHc21bYBvbNhBUcI08Ni6VoPWYqd9+ooY9kYPGK1S4nLn/E2
 wyeJPD+G2iRqZRZWVXa7Xpb7MeNgy3f0oehPSlmV44YApFcoE72miFKhyse/DWMm5x90
 uyp5J6lb5huBWao/qbKdG7TC0moogkD9W51vtpyVXEHUCclZOGG2QAP4rjYylnXLhiKa
 iqFg==
X-Gm-Message-State: APjAAAVCe+Qn2IkMwjgG7gxGEBzeEzgUCfWNTDYTV9M8X7qN0d6dakYV
 S/9hZYzxFU3S3IsjJXofMck=
X-Google-Smtp-Source: APXvYqyDi7YnoKTY7CmjpGAAZoIpTxw0c7+YRh2Wh7rGJfbalff1wlRgbvwrHu8g84dsuApTaaBgeg==
X-Received: by 2002:adf:ba47:: with SMTP id t7mr7708415wrg.175.1560503925967; 
 Fri, 14 Jun 2019 02:18:45 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c11sm1563431wrs.97.2019.06.14.02.18.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 02:18:45 -0700 (PDT)
Date: Fri, 14 Jun 2019 10:18:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-ID: <20190614091841.GE10957@stefanha-x1.localdomain>
References: <1560299717-177734-1-git-send-email-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <1560299717-177734-1-git-send-email-raphael.norwitz@nutanix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH] vhost-user-scsi: prevent using
 uninitialized vqs
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2019 at 05:35:17PM -0700, Raphael Norwitz wrote:
> Of the 3 virtqueues, seabios only sets cmd, leaving ctrl
> and event without a physical address. This can cause
> vhost_verify_ring_part_mapping to return ENOMEM, causing
> the following logs:
>=20
> qemu-system-x86_64: Unable to map available ring for ring 0
> qemu-system-x86_64: Verify ring failure on region 0
>=20
> The qemu commit e6cc11d64fc998c11a4dfcde8fda3fc33a74d844
> has already resolved the issue for vhost scsi devices but
> the fix was never applied to vhost-user scsi devices.
>=20
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> ---
>  hw/scsi/vhost-user-scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0DZnEACgkQnKSrs4Gr
c8ifXwgApMA5XJWuY/9/J09zyT/1KXSiWnPqVdtxZlZ00sdSzqXYnDxZHZU/XlGB
Tj0WJadLrmP1p7eNSLgPHL/bH1Girbz7rBBp0SpkP4rRHqX0gaw5RVxwWXLVZets
Yaso/7dgufsgvkYDEUksyVbxh0RQlztutFqXIUUQlvdmwFK268Kr9a6TsWd/1LQO
LmBii15RMOuKEnn+Lqn9noWVtXKcP7PwgOCdkncFiYzGfvOHARy9hTip8dm9TRxv
dMXMgCx9B+t138z1N77Dc0FhmMq7La4WSvKGt12Dx/2cH4PRQNvRe8BF7eq73DHg
EWCIIgNZu4wllI134V1mH8x3ofAHUA==
=jntu
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--

