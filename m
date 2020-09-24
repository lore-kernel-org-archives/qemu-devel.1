Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB15C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F162220C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uffrfN8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F162220C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLSEp-0005gB-GM
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ameynarkhede03@gmail.com>)
 id 1kLSC3-0003DI-Q8
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:25:55 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:56146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ameynarkhede03@gmail.com>)
 id 1kLSC1-0003mj-3F
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:25:55 -0400
Received: by mail-pj1-x102b.google.com with SMTP id q4so1782019pjh.5
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 07:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=+TVbVligqIvCciqg82ZCSp9nGXwv5sbAem1jDybjYhk=;
 b=uffrfN8d1lGVeXepPjS34059Mue3gkZsb/JSQq0Rkd9fAPkBdsjA+rJlHRFCAE5p3p
 CzKPEi3EM85COnelMMIWknIQaYh0QZsJRRUAYMUOGdXt03dFI/1EYoagY86T62SKSuia
 6mNzBn411qieFLqeXwL5xgEhfNLi0WFxRA3l1Vi5bDD/72zM08C7R5GpJ43l7DKlJGcz
 H0OjnS2sU4yJJSOXu+RXye995KerLVlnjbGVWBCqfgt17QyvrpHQC4j2oC3t2hjVd6Q4
 EIzLY1Pyt4ewneg2GgYbvyYprJu2azM2OD46j1HZ3Vj5l0tjcjJNxegCjIfG/ZEid3xg
 EjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=+TVbVligqIvCciqg82ZCSp9nGXwv5sbAem1jDybjYhk=;
 b=LuSFPybtkBUeUKAZra3lC6a1h7eFV9TVTefb6yxo6f83XdL1WC8VmBC/Y/ej+7cCyG
 yMDvHPFj47pC1iTVcBhAvf1cpFV+7QgQGzY/VYReLOZtqEEo2a6xrNw7qPDNfQ+9FhnH
 Yot3qoEm43I6rxUMzKC6T+/v9IZg/weR3By3KLwZKlfXU2LO+Ad3fOtG9IhnYqCf7Ae0
 Y4tt1IQVmjOChF2pEyuAGeUDjxaF8GROq3D/tPxVRk/HJT4YYIVf9oWjaWALIlrVrRSk
 qf4Rdk7HpZrIw40Z2K7bW66dPtJEIxTZtLts4DmtwnIUeHSJMcYMNETSUGNFPYI7Vw6n
 0COw==
X-Gm-Message-State: AOAM5311XSqAYLxYb1BcYYLE9N3dZoNEIHbHRSeXdEWpCRDcghZ2K12O
 o2//jmsajJ6tJP6X6ZY22EhP8U8CnTM=
X-Google-Smtp-Source: ABdhPJycTAAUXjJi6MaxcqpjF6udd0Ol/2Hq/SIwB0505wEfepcHToydjzLZewaTe0E/XaaPt+H9yQ==
X-Received: by 2002:a17:90a:fb4d:: with SMTP id
 iq13mr4143197pjb.179.1600957551110; 
 Thu, 24 Sep 2020 07:25:51 -0700 (PDT)
Received: from localhost ([103.248.31.175])
 by smtp.gmail.com with ESMTPSA id u4sm2733541pfk.166.2020.09.24.07.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 07:25:50 -0700 (PDT)
Date: Thu, 24 Sep 2020 19:55:37 +0530
From: Amey Narkhede <ameynarkhede03@gmail.com>
To: its@irrelevant.dk
Subject: About TODO in nvme emulation
Message-ID: <20200924142537.xctoxv7xdr2nab7o@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yesmsjrvbdyyqqjz"
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=ameynarkhede03@gmail.com; helo=mail-pj1-x102b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--yesmsjrvbdyyqqjz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Is there any TODO file/wiki for nvme emulation code?
I'm a beginner who is interested in getting into
nvme emulation. I have read nvme v1.4a specification
and some code in hw/block/nvme.

Regards,
Amey

--yesmsjrvbdyyqqjz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEb5tNK+B4oWmn+0Z9BBTsy/Z3yzYFAl9srFwACgkQBBTsy/Z3
yzZ1SAgAggVfv37+e/Yz58FRnom3skf/8xadopAIP5+12+RKNZYJW2SV3a5yl7EQ
4nJfwtPIBZj2DAVRyFWz4LxU1LNoD14fI2x/eODQe5GdZLELcF6vLlI0jyvMDifp
tFSlhD//cCfbmjBmchIQRB9IxcuXnSXpzoqWYWBlzkymzIoxDAridSUXYVg17Gnr
B005wE+R6TypZz/hxkKaeqYW41t0ps9NN/hc2XXoOxHcIZsQHQUT0Q4FLpQ9wCZu
o+UJEnucNDZXcWP+sbRoh+jYvj5qQFUV23aPUj0VK+gj9g5v9yZCCZkgy1JOjD0C
wtJxrOMt8QanznvaEo1e4WruYpjhrg==
=wOop
-----END PGP SIGNATURE-----

--yesmsjrvbdyyqqjz--

