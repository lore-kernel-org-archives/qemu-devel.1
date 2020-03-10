Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B385C18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D30D20637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLVDyI3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D30D20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbua-0003tL-Ee
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jBbtn-0003TJ-Rw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jBbtm-0004aq-U9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:14:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:35833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jBbtm-0004Wb-NH
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:14:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id m3so641371wmi.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pknhD5uPr4WOV2Q9zoveaP/srxnbWb1KCchhbmEaHO4=;
 b=GLVDyI3xzLVV6d0a/eMUfZOZcKxFqUTcnZRdOSg0tiEexA1cvswNwIhtTADsFvmdIV
 dZimQ66m6MPI5zjD1THbzkuCp31u8Ydl0NFy4w2pn24VvNNWdhY+P9H+BrbFmZygGWox
 STjyJo3BII2Bwa5ReVQzduPdlyMqfxF0qxIuEdK1Hu5Jt2fHZii2inVcEvmZ8MjTrxJ+
 Jsj2rG0LPs5I+H20oWkfx5Q9dlJp1RningR1CbcuQ6CNFJ2YxWfXMch75ZzA3Vhc3pwY
 p7RmLeHxUNG2P6Yk6N3oGYQjKDnvMmfR7z1GvwycLRDnxqEHSexeI5WzVi6o+vRP9JGz
 rFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pknhD5uPr4WOV2Q9zoveaP/srxnbWb1KCchhbmEaHO4=;
 b=r/YPMWCLRK1eCnfF+5X3Cs+lKKGvy8+OlhUermjc3dO2EZzRKglEfLn8LzH+W15ILm
 Rk724+uOr1u1zqXbPTOB/lOzE5Fa+rHFAd1niB6SPLq/otDN33Ac+JYplsnmM1OkoHfw
 2eAc5kASDSSwaZ8HGIGVu8MC8tNOYXPl6WvP7fdbAYv3v6uD6KEu4zxzGCdwhABL5z7q
 ZFo8kf4R8/GXwPcFl6ofO53WYHmdgvW9cdkV5TYFBLs3Hd033p0j5hs8GtmomsT0+nW9
 EyVgMNZaOpy9LWx5PSjNdO/NQHSoc+zPpDQF80PkmYYN1HkvI68PNjUrcmsvxBKCUU7v
 Xlzg==
X-Gm-Message-State: ANhLgQ2/MRTrt54Tq6jkGpsPAcT0Fb/6cbNWcuUl2MET9w14eHGD/FvB
 5C380tsqXwDiKr8S89qAw+o=
X-Google-Smtp-Source: ADFU+vtcynrLTrSLyDzhmqa8dkpdq8zrwTegX9ArehdQvo10RolJ4IVUB22W9psaywEdhYgG3haFqA==
X-Received: by 2002:a05:600c:247:: with SMTP id
 7mr1412895wmj.181.1583835245562; 
 Tue, 10 Mar 2020 03:14:05 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a7sm10409624wrn.25.2020.03.10.03.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 03:14:04 -0700 (PDT)
Date: Tue, 10 Mar 2020 10:14:03 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Adema Yergara <adema.yergara@nu.edu.kz>
Subject: Re: Wiki account creation request
Message-ID: <20200310101403.GF140737@stefanha-x1.localdomain>
References: <CAFTFcbCVQxiH-acfX4rPmnNp6M4cREExaj0FEnB3KgqaBjdq0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ni93GHxFvA+th69W"
Content-Disposition: inline
In-Reply-To: <CAFTFcbCVQxiH-acfX4rPmnNp6M4cREExaj0FEnB3KgqaBjdq0A@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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


--ni93GHxFvA+th69W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2020 at 11:29:34PM +0600, Adema Yergara wrote:
> I understand that I subscribed to your mailing lit now but what about the
> point
> - To create an account in the QEMU wiki, you must ask on the mailing list
> for someone else to do it on your behalf (self-creation is prohibited to
> cut down on spam accounts)
> Who can create this for me?

Hi,
I have created an account and sent you the details in a private email.

Please use the "Subject" line on emails, it makes it easier to identify
email conversations (if all your emails have no subject I won't be able
to distinguish between them when browsing by inbox).  For example,
"Wiki account creation request" could be the subject of this email.

Thanks,
Stefan

--ni93GHxFvA+th69W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5naGsACgkQnKSrs4Gr
c8ji6Af/Ux1AoPbuAZxjKHpJc7n59hL64GNK5ugAGu+UA6saJCRT7PxpfB3qZWs5
otleVM/f4woXP4HTJ5GcmoowKBokxviiLwjtktXrU/nQAXNdiQGsQp+W0nPElmxS
eRiLnrZAVUn/cAXN6QSSy4BNTTr8cCbXHEanPgP9KJVbWo9qoNmxxculSHa3HEFx
NJQphmMwbZHCb21Vm92tZAzigqARiCsayKOI8o8N5M6CPewIhTSeCLkI0730gb5A
FSnKgewrdyRWykF/E338v1n8jxWMWE/7EC4Wz//4sTNAfLOcBwKqQDPMjCeQSg5N
qsKzpMdcVlnDeyB+MWcNgHwM9hkrjw==
=X2+Z
-----END PGP SIGNATURE-----

--ni93GHxFvA+th69W--

