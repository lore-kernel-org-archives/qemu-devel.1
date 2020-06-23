Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65C8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0CED20723
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh2KqRhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CED20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkTh-0000JQ-NA
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnkRv-0006yk-LB
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:03:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnkRt-0007CL-Kz
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:02:59 -0400
Received: by mail-wm1-x341.google.com with SMTP id l17so3294687wmj.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 08:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5PwrATtHZw1hjoYBvmunfj7/De2WHM1t+Yv+XjrCkOs=;
 b=Wh2KqRhpkz4M7ZwcRF7Gax42p/3O90C8CMFoXKsM2QXJbFwZnRe2TFILvLiEG4moG0
 lt6gufsWNFS3tkMngkAMOTGIxhwAtQVaPNCRPlIL9K7MOrNd5wSP+0IV9Q9+E7kUWPlk
 +cUe73j1+0QveydEC/wCqrFWVhzB2tbN0SzuXvtiyXoWRj/HYpKES69Q9OHCFvglVoxK
 2seRB9JOOfR0oFCHhArN3S9n5VXoFwyxTX5SH2VlfE7iJVMgMDIrVqTzfiOGZcO+lZEj
 TCkoDuymU77dVO9OZszN//XiMJHw9E856sx48dauLA9NtTuaS+EOOxQbyWzKUKF7UxeL
 XVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5PwrATtHZw1hjoYBvmunfj7/De2WHM1t+Yv+XjrCkOs=;
 b=KRZC8dcS2s3uM8qUMj13CPXvlp40FYFHbej/8QNLu1e9usDrT2pj0soHtP04HfHEos
 l0tGP1YMA5zXU4V4OcOg0KzYTHS+2DrzSLoEsLUsMoxA4+EmL2MbBnkNkQfMscP4qVtp
 ONbrZWGkm8C/+h2Xfk9XneX0PeOlZL4YRAVg2snQCzwFxowD/JJ4gPsc7zBftdo2mT2m
 BeznNQenDO1XmRm01sCRdDveBjWYYTvMTtXC1l1rVnrt0D9qdmauuEAmy/MlWvsvi100
 HRYU3fUsVMVxOj4Ih8lrLhor4nYSHurIBRF+H6geJNKYCpa2+kihYrmByU/Ez0x3Jx8S
 cnGg==
X-Gm-Message-State: AOAM533LlztzM5qLt94LSkadr7rT0RXy87bwTJvIpgK7bSV5rhvCrT11
 dbix9IyQExWu+cVC7yz57ak=
X-Google-Smtp-Source: ABdhPJxVOkLhkOzjPjhVc31NO+RXr2uklUx05PsilDeb94LL+FdPE9aw/TOrVqGtDI1dQhuajoim5w==
X-Received: by 2002:a1c:3c82:: with SMTP id j124mr1650804wma.155.1592924575894; 
 Tue, 23 Jun 2020 08:02:55 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c143sm3931928wmd.1.2020.06.23.08.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 08:02:54 -0700 (PDT)
Date: Tue, 23 Jun 2020 16:02:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Antonio Raffaele <windowsnotfound@gmail.com>
Subject: Re: Overriding PCI Vendor/Device IDs
Message-ID: <20200623150253.GT36568@stefanha-x1.localdomain>
References: <CAFES52nPcmpF9dB175J4xdAqsJO+GK2614OOoKDArt+=cX2mhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4Kq+wHeKEs1nwG7z"
Content-Disposition: inline
In-Reply-To: <CAFES52nPcmpF9dB175J4xdAqsJO+GK2614OOoKDArt+=cX2mhA@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4Kq+wHeKEs1nwG7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 21, 2020 at 09:31:30AM +0200, Antonio Raffaele wrote:
> Hi I'm trying to create a qemu virtual machine that runs windows 10. I
> would like to try to make it almost indistinguishable from a real computer
> (I know it's impossible, but at least I get close). I have already changed
> any suspicious identifiers (smbios, hard disk, card network and so on,
> host-passthroug cpu etc.) But now checking the various components that the
> guest computer recognizes, I realized (through the hwinfo64 program) that
> in the bus section, then pcibus there are devices called "Red Hat , Device
> ID "and with the same devicename, as device class have:" PCI-to-PCI Bridge
> ". Is there a way to change the devicename of these virtual compontents
> (maybe even changing the qemu source)?

As far as I know there is no command-line parameter for overriding PCI
Vendor/Device IDs.

If you are able to modify the QEMU source code you can change the
PCIDeviceClass fields. For example, in hw/pci-bridge/pci_bridge_dev.c:

  k->vendor_id = PCI_VENDOR_ID_REDHAT;
  k->device_id = PCI_DEVICE_ID_REDHAT_BRIDGE;

Stefan

--4Kq+wHeKEs1nwG7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7yGZ0ACgkQnKSrs4Gr
c8iVAQf7BClvhFdAgUFOaWhaYBKWdPctSv/Cgt8PO+EvNfIEKMw5gUKnq+vpZgwT
5O74HKDcWLXq9KSh9Fl83H5CAMA8kentq4BEEUdaUUwVu8pJTndD73ZutcWZB09y
57Zjn6UbnzBcIFfPnLHVOBx7dk/iogvxCPel7gFfvMu5t9XtWjPKvIO4arGuiDeq
9J46oM/LHpEnVuMS3ewQn5qBiw7pyxxf6JT9qCWces2e/LQLcA3kzVz0OVh7Ccuf
7jVsk0E5WTtZcmROYqp6ZH2HjJiRLQZJS6OIdeJEqDnp03o0+KMIMlbHHQPElGLH
PD9Y2OkkeOPoPRVjQRo/gOJ5JwkEnQ==
=jcYx
-----END PGP SIGNATURE-----

--4Kq+wHeKEs1nwG7z--

