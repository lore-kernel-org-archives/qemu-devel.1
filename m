Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324CDC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E1420759
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKHB031w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E1420759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAzl-0003Fd-O6
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kNAyZ-0002Pt-Uz
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:27:07 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kNAyY-0004Uk-7f
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:27:07 -0400
Received: by mail-wr1-x443.google.com with SMTP id z1so4351185wrt.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 01:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=udwDCy4e/wlnFSgHZcCkMVFIs67+GyghU51aCG4MaMk=;
 b=JKHB031wJh7fLdCZmYKFIwfyEOE8tX+tkUOKw3VBMxu+ul0d0+JGnRPGT/4uQ0Qj3C
 fBTp78ympf7PA5yXA8YacDXHWaLd09Sh1XKH6qaLnltIHhbtCyvZgjthMcSPfkKHCwHD
 b1MVUGx0K4s1lAvC/djVLknOjn/nkA6h9TzzrSgt4Gj/cjxpZgR55jliIeY2+gWeeI9s
 dp51JOi097XaVJNBgavxE2bOSmgl6rN5Mz4JHBr4yegctfCR8yY3Yz0VJRngSM+xmKtV
 vVaxx5AY8Re75rpsq5/i0GOY+JXD1Nj2Eww/NXRVDE5Jv+QN06Ddd8b/6dPTgtPWBowW
 MAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=udwDCy4e/wlnFSgHZcCkMVFIs67+GyghU51aCG4MaMk=;
 b=sie7rv/zkLJwL8Pba7IvZX4JHiaiBYT5BW7BvvtF5LR9YPJ286D1HVnHMMe9CyB6Gi
 m/vCEacjB1O8DlaZ3gVv0OapOXuR+snE3OqYz9zgQCjxUWMArGnLIWvV1ekZEe1Yhvog
 1RTtHogBFNytq+fNToGIeIEU74GeVTi89cgKd3HQqTSWpH9YSX40HUkNNElZ/wSaVsEf
 2Gy2zwfF2ByzciiYKdKYRoS/4hSWjHPsmoEH8F5BjmORNaMKrqez53Oj0R3q4q8vmsNM
 6tKEU5cQkq3XCDGTRi80VSP0UmybXKP/WtTdh7bX4Hrprc3aWQVoaPYtut28g8L07997
 DqxA==
X-Gm-Message-State: AOAM531VqK8MXzac4fgBhmKJEhmwkbHzefUEY7pD/MT0zckl03Q+9EfB
 Ot30To2DMAub0B018XE9gfU=
X-Google-Smtp-Source: ABdhPJzEWMGpXR0C6BuQC9ijtnYHf2XlO/qAHDRdEO5knC9aoHHNHh0eD22HwwdszJ/DrkLZPgiMNQ==
X-Received: by 2002:adf:df87:: with SMTP id z7mr2951511wrl.239.1601368024443; 
 Tue, 29 Sep 2020 01:27:04 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a15sm5047282wrn.3.2020.09.29.01.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 01:27:03 -0700 (PDT)
Date: Tue, 29 Sep 2020 09:27:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH Kernel v24 0/8] Add UAPIs to support migration for VFIO
 devices
Message-ID: <20200929082702.GA181243@stefanha-x1.localdomain>
References: <1590697854-21364-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <1590697854-21364-1-git-send-email-kwankhede@nvidia.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: cjia@nvidia.com, kvm@vger.kernel.org, aik@ozlabs.ru,
 Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, eauger@redhat.com, yi.l.liu@intel.com,
 eskultet@redhat.com, ziye.yang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 changpeng.liu@intel.com, cohuck@redhat.com, zhi.a.wang@intel.com,
 jonathan.davies@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2020 at 02:00:46AM +0530, Kirti Wankhede wrote:
> * IOCTL VFIO_IOMMU_DIRTY_PAGES to get dirty pages bitmap with
>   respect to IOMMU container rather than per device. All pages pinned by
>   vendor driver through vfio_pin_pages external API has to be marked as
>   dirty during  migration. When IOMMU capable device is present in the
>   container and all pages are pinned and mapped, then all pages are marked
>   dirty.

=46rom what I can tell only the iommu participates in dirty page tracking.
This places the responsibility for dirty page tracking on IOMMUs. My
understanding is that support for dirty page tracking is currently not
available in IOMMUs.

Can a PCI device implement its own DMA dirty log and let an mdev driver
implement the dirty page tracking using this mechanism? That way we
don't need to treat all pinned pages as dirty all the time.

Stefan

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9y79UACgkQnKSrs4Gr
c8jVhwgAjiypvmL7JOtUmRv3GKhQ2tIewJV7/79aGG4hTvP6divYUzMs6Aqp1hKt
kqtLl2kHVoINotaX5w03iDjJnUZ7IMLUGoEG3bzs16DhEB9AYj6kTxxsWjZJHUdZ
nIHobpDgHNYUvhFh7UYVPyiAxLyXUuZJgKtL8UsK9A8WiSM/0AgIhs8tDgW6KVMN
9AVuTGllSV0/TXjxKI7e/9ZhH/u3zIFDEty3rApcGp8r5W9QYB8+S4j5NzBFsruo
zp6Ya+Dwm4rAon2DEN0oM2b+Uupb4RgCIbIaEIlsrtTFQ3+QJSUCBCVbKMKMBKpW
Bgn+A8mXCIexbP/D1tcUrCVtv6vsiw==
=BaMB
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

