Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207A2C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86AF62076C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=blade-group.com header.i=@blade-group.com header.b="f2Jb6a7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86AF62076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blade-group.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kITPr-0004GH-Ke
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1kITOD-00027o-1G
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:06:09 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:55143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1kITOA-0002hO-Ov
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:06:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id s13so1991860wmh.4
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 02:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blade-group.com; s=google;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=YNT5SgfD8ifAnULqjYZ1XevtHsOMstNPXvPVxwk1b6E=;
 b=f2Jb6a7t1zB8RLpKEPLfRUOWldQQrgXiQa4aSILL4rtCSLcv735leReh4gnfGYceZf
 Z4Z/RY2SLDtVpz1ctZE0TuBAUC9ro+z3nOa26OYp6CHgeEJQYjcTCgjlF2+2slI0N2Fr
 e2dIC80QDCbHiNXTBCrJwcbScSvKW3gZpyligVkCQgjEMyAW7wP5aySlb2cw32kwROKJ
 ECjkupsr73h/zRkm4bN4irRIZBle7TaLTzFRVENReiKtUvxolMbwqFEH7D90Rf9/UiGB
 ATVOhIl2n3eg/55rpe0jjCkOSpqHLz2TP7ntpnRZkBJyO0gim084VeNWbBndxp8rGzyG
 77aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=YNT5SgfD8ifAnULqjYZ1XevtHsOMstNPXvPVxwk1b6E=;
 b=rMkUSALCZBou+kgkqqZXL/QoA0FMxtELCN98FsARkOuCX04Qi4AD/qAPsdoPY4WOH7
 OZ3lXxrCdf/J3Cw4JVoQYeCzF3KRDGdu3SJIxRvvOfgdMgum+ptICH3Z/08oGH3JKer/
 +vIBL2SgIuFCwsOzYsI+cRdoE0wyUAre556z0KfES+ZqJTWMJ0fGDn7ttSvFY6h9YOBk
 vTEAwlMsNkYtusfUn7XlKYY+v+D58NRpzOVoWd/CnGi1axEbfQjCmX3PfsdLWE/RcAAc
 oec8T3pfW2oh1B7R9mSm3UUvIpmgLtjYUM4goFbaBrokWthzIC7xJpBAAyxVEGwqm4wz
 3d5g==
X-Gm-Message-State: AOAM531+ARcQr5S2yx2gS2P2fZSM/YCdRmVjqZn9vy1aiIXr7PG+9bAA
 wpIEvmnsQcOHC3RZVpX1laKixR4S3XoKuJPA
X-Google-Smtp-Source: ABdhPJxawktCIPN07IycYFO0In66jNFPT93vufAi1voxYFOqd1Xc9dmoCJ0O6Hs6D+nbTnp77pvJSQ==
X-Received: by 2002:a1c:678a:: with SMTP id b132mr3799667wmc.10.1600247164262; 
 Wed, 16 Sep 2020 02:06:04 -0700 (PDT)
Received: from localhost ([2a01:e34:ec16:8a90:4e1d:96ff:fe49:7109])
 by smtp.gmail.com with ESMTPSA id v6sm31208978wrt.90.2020.09.16.02.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 02:06:03 -0700 (PDT)
Date: Wed, 16 Sep 2020 11:06:02 +0200
From: Antoine Damhet <antoine.damhet@blade-group.com>
To: qemu-devel@nongnu.org
Subject: [BUG] Migration hv_time rollback
Message-ID: <20200916090602.blkm7eym6g5bnvvk@tartarus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z322mdwauz6mmmbm"
Content-Disposition: inline
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=antoine.damhet@blade-group.com; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--z322mdwauz6mmmbm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

We are experiencing timestamp rollbacks during live-migration of
Windows 10 guests with the following qemu configuration (linux 5.4.46
and qemu master):
```
$ qemu-system-x86_64 -enable-kvm -cpu host,kvm=3Doff,hv_time [...]
```

I have tracked the bug to the fact that `kvmclock` is not exposed and
disabled from qemu PoV but is in fact used by `hv-time` (in KVM).

I think we should enable the `kvmclock` (qemu device) if `hv-time` is
present and add Hyper-V support for the `kvmclock_current_nsec`
function.

I'm asking for advice because I am unsure this is the _right_ approach
and how to keep migration compatibility between qemu versions.

Thank you all,

--=20
Antoine 'xdbob' Damhet

--z322mdwauz6mmmbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEArm1WbQx2GmOsfF83AmjLzzljz4FAl9h1XQACgkQ3AmjLzzl
jz7fuQf/YOWOtaEqah9yzPR86vqrsq4fVbYzLp5y5BU8x6Y9NUq1vaseQkcD06M0
Avqy45oCHUVp7zcV7lZvo5qyO6f95QP2zyZ+amNQt6nKwxd+nfo4CKSb0za09BDg
SrXm+FFH+r0llg4KmJsApS86nDnh0qH5sxTjTaW9PuN4ddj72wF2Jp1m/Y+mSRnW
qxbwsbnERgC5q4r5WRgMgB1/JxNpbFQvZfTX6+jfuFkgJl7hIhVs+vxARu2fpjAi
rSmfQYXXtrSe9pNIAT19ifsLk8nsqC2eJMP0LG4T3VdGsfcvnsa95I4aCafvSLlI
FYmkzcqVLEDpjL57zBHnly2gWSUVSQ==
=2sDu
-----END PGP SIGNATURE-----

--z322mdwauz6mmmbm--

