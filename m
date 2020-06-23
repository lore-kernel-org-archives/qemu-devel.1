Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFCEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CD12078A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wjp/JBIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CD12078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jni2Q-0001HU-RE
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jni1N-0000Px-7v
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:27:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jni1K-0002bz-2C
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:27:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id v3so12834287wrc.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 05:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hddKTGdBAzC2a/8v6PrB/iFri2aa/LLHCiGz5GQFoAY=;
 b=Wjp/JBITD2p2Vjgj8apDY1aADLx+m0vHamizZiG7ewNo1W8tR7Y32OPZxq8YyfnAu+
 jDcm9JbtRp0/um2vyImcRw+E6RATDt/rZBVehUIv4gyY5+v0asRYZqm8GXyCTFLq5mak
 vaDZPotFrCA7DBKFiNHYzlqsYL25QkWetuE6xB/RSnQnxt7j/Ovwwpw3tSz+p2O0OPSx
 FTJdgsjRGTZK2XTz9AOdWW7NCMVBmtUcL5UJDIxjmTE2RTLa0jmApTOZ4B49scejCw97
 YVCSNcgAlHnWKptbKlqB4AlF0zIfp/wv4JedIbIf64nzy9U26j9+e04CE/Lgnyosn2OL
 hIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hddKTGdBAzC2a/8v6PrB/iFri2aa/LLHCiGz5GQFoAY=;
 b=Hy86g1ftN9sucd230OiABA5jdDH3tpNTJQfqw5dqsxaYfy1ssXZxvEQQZvKgYtjHWw
 ybpELotaXLo96eZUMeC104eJnSbD7TFtxzs/sNUNj64fI5W8bXufflLv69eaAn7DXcyl
 coYHM4b0enGhjEU1dQBlKj4guyUXqu6QHG/Susn8Pi1vpsWfczugweK2S0q7M0YwYKbT
 GKeSQnYkJPMfz6fgmengB2QoQXzsYDueQ8D1ETIR4NBYyh0JES/C7kvv6vP11E8mDGT3
 qKjmGzWLZYXaKQ0+Db2Seh0FZirqqiu72d1fCBTmPRjWsEW2HmJC4PbiAEUi/L6A3kte
 uHHA==
X-Gm-Message-State: AOAM533QN83CKrDF9IL/7fJl0rAzXZAyY39GVeDe4n7T+uWIAbB6RvQC
 4KuyD8Un/sLvnkV8IiLEzwA=
X-Google-Smtp-Source: ABdhPJz4K1gHDaw+bV0JcK7qGgCa5/uDBbVRyq4XF1XuuU+ZbbE4Nr/g6npNorQDJHTwQB7RzB08Tg==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr13420477wro.413.1592915237692; 
 Tue, 23 Jun 2020 05:27:17 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id d13sm8134235wrn.61.2020.06.23.05.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 05:27:16 -0700 (PDT)
Date: Tue, 23 Jun 2020 13:27:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: John G Johnson <john.g.johnson@oracle.com>
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Message-ID: <20200623122715.GF36568@stefanha-x1.localdomain>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <8101D131-3B95-4CF5-8D46-8755593AA97D@oracle.com>
 <A0E4C51F-B41C-486B-A5CE-3C4C2C9C1A40@oracle.com>
 <20200602090629.66f9e3f7@x1.home>
 <E78F4C2E-4382-4C98-9606-F1ABD9753699@oracle.com>
 <20200615104929.GD1491454@stefanha-x1.localdomain>
 <DE330A27-2343-459F-9EA0-D3C5F20EE87D@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NGIwU0kFl1Z1A3An"
Content-Disposition: inline
In-Reply-To: <DE330A27-2343-459F-9EA0-D3C5F20EE87D@oracle.com>
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 "Harris, James R" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NGIwU0kFl1Z1A3An
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2020 at 02:38:04PM -0700, John G Johnson wrote:
> > On Jun 15, 2020, at 3:49 AM, Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
> > An issue with file descriptor passing is that it's hard to revoke access
> > once the file descriptor has been passed. memfd supports sealing with
> > fnctl(F_ADD_SEALS) it doesn't revoke mmap(MAP_WRITE) on other processes.
> >=20
> > Memory Protection Keys don't seem to be useful here either and their
> > availability is limited (see pkeys(7)).
> >=20
> > One crazy idea is to use KVM as a sandbox for running the device and let
> > the vIOMMU control the page tables instead of the device (guest). That
> > way the hardware MMU provides memory translation, but I think this is
> > impractical because the guest environment is too different from the
> > Linux userspace environment.
> >=20
> > As a starting point adding DMA_READ/DMA_WRITE messages would provide the
> > functionality and security. Unfortunately it makes DMA expensive and
> > performance will suffer.
> >=20
>=20
> 	Are you advocating for only using VFIO_USER_DMA_READ/WRITE and
> not passing FDs at all?  The performance penalty would be large for the
> cases where the client and server are equally trusted.  Or are you
> advocating for an option where the slower methods are used for cases
> where the server is less trusted?

I think the enforcing IOMMU should be optional (due to the performance
overhead) but part of the spec from the start.

Stefan

--NGIwU0kFl1Z1A3An
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7x9SMACgkQnKSrs4Gr
c8hjDwf9GtyUrDZuNpi+GK77AIAGj+B4/+2uzZitXt/JmzDLj4B/xmhywtgkvxKh
wkt31J5Z67CwSGgKmUSEDFUivRxf6cpNOqD/rbSElCz9AtY63bOc1AXyNYqfa5SQ
Nj6pIhQj29Vkcow5fdZn2ulLgXjB5cnqNfzJrinFf3PwzX39opNULmbtaCoc4xLa
dKXTacu45a7xz7nwHjV32XRRNJk9cpPbkMw8zEEtzo21hjgm3F8ubJFFAOOpdiKF
ghBTJQDCSOFTKh5dolA19U/lz1JKjhhZTfYTs1GjrgMAuohIPVQI6T4r1/RJ6qfg
gbDNUFwxdoFKN3sVI7rxpMOG/xFP/Q==
=Lq1l
-----END PGP SIGNATURE-----

--NGIwU0kFl1Z1A3An--

