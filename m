Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0911C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55002146E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNbxgJV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55002146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihw9x-0003X7-DG
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ihvz6-0005X2-Md
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:36:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ihvz5-0001l1-Ee
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:36:56 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ihvz5-0001eH-23
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:36:55 -0500
Received: by mail-wm1-x342.google.com with SMTP id u2so5642365wmc.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 05:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jUQDJhjTKos/ja3q3ysZsORRNM7M0DZ4wPgbcb2YqUo=;
 b=UNbxgJV4BcB6xZl4b5Lso04oPwHsaETIbNUNlD/xA9qOFnXy6K0nFeyrnJQY+2n+AJ
 67oa5NvvD67njrEzOyf0mpMdMPDmRtOUAe51Kdjg6lqiZ49u6Tt6rgcPECdwYLGuSyM6
 nWLM9bw/RkVwBryCNGtweglqH61p/YOCpuSUaNM2e1FZ4FIciOkHUletUP+wIeziLWVY
 ux2nZCIhNjmkamonhqSBCllpR1jocZ+fM6SUfKHLkrhp30S8xbbw+L06fUS8oLtxMFEd
 PJ/mtZB0n0ULDSC/e51WQvRm+Kkvtk9pZNsPEnlmv2gauNPdoZ2FgVzGw7iAtYN2tA7w
 O8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jUQDJhjTKos/ja3q3ysZsORRNM7M0DZ4wPgbcb2YqUo=;
 b=qLJDilOOF64LxpCsQnKEh3zpQvbvwI8JGUEfkZbJ/rh1olhLPZ+GiMnonKcgOyvZGx
 vPdDkTVOigZZA5yqW2YcGdeQ7uD2l/GKkcfVjjkMOwDchenYP0UlbdUQHjKTqOzPR38K
 8YMRAXAg3QQhZ+V7z5GJkvSW5zyXPdIX1LdSLMBiG/xXMQxiwMCfXWrTaZvRNFLFjxV0
 W8079HWhcj1SJgl+kH7fahL+Or2OBxRW2E3SNM4x+CmhFaWwIJD5owVBxls8C3J/7Zvb
 rCTE+/+xpkwd4UO42FwcfbPAebs7kPnBnKad2gsA2nocrt0SVNMmzcCGW47LbQdpjddQ
 J69A==
X-Gm-Message-State: APjAAAV1zsUVAznCKiM5uy8Ww36EWcUoGePi2SGZmftdqyFeWo7Ioa1M
 jfDJxaxva7I+ccw1Js4pIpQ=
X-Google-Smtp-Source: APXvYqw7U4kCIRGRBQ9fPfbEO42PBwhXlbgKG1UEmrdhOVssLKUz2XGXonv+T6pFw3s/kjtkkclaZg==
X-Received: by 2002:a1c:2e91:: with SMTP id u139mr9698801wmu.154.1576762613799; 
 Thu, 19 Dec 2019 05:36:53 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c9sm5931384wmc.47.2019.12.19.05.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 05:36:51 -0800 (PST)
Date: Thu, 19 Dec 2019 13:36:50 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20191219133650.GE1624084@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <4a302c6d-e2c8-0c3e-43d2-946e1fafea5d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline
In-Reply-To: <4a302c6d-e2c8-0c3e-43d2-946e1fafea5d@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2019 at 01:00:55AM +0100, Paolo Bonzini wrote:
> On 17/12/19 23:57, Felipe Franciosi wrote:
> > Doing it in userspace was the flow we proposed back in last year's KVM
> > Forum (Edinburgh), but it got turned down.
>=20
> I think the time since then has shown that essentially the cat is out of
> the bag.  I didn't really like the idea of devices outside QEMU---and I
> still don't---but if something like "VFIO over AF_UNIX" turns out to be
> the cleanest way to implement multi-process QEMU device models, I am not
> going to pull an RMS and block that from happening.  Assuming I could
> even do so!

There are a range of approaches that will influence how out-of-process
devices can be licensed and distributed.

A VFIO-over-UNIX domain sockets approach means a stable API so that any
license (including proprietary) is possible.

Another approach is a QEMU-centric unstable protocol.  I'll call this
the qdev-over-UNIX domain sockets approach.  Maintaining an out-of-tree
device is expensive and ugly since the protocol changes between QEMU
versions in ways that are incompatible and undetectable.

On top of that, the initialization protocol message could include the
QEMU version string that the device was compiled against.  If the
version string doesn't match then QEMU will refuse to talk to the
device.

Distributing a single device executable that works with many QEMUs (e.g.
CentOS, Ubuntu) and versions becomes difficult.

I want to mention that we have the option of doing this if there are
strong concerns about out-of-tree devices.  It does have downsides:
1. Inability to share devices with other VMMs.
2. Probably won't replace vhost-user due to the out-of-tree limitations.
3. Can still be circumvented by a motivated device author.

Stefan

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl37fPEACgkQnKSrs4Gr
c8iuGwgAqWnPKbBTJiOWhlGo3gw81pEUq1dOXAnKW/zietsudXTRLvN0arn3zAj5
i6mdCRPhkoO7fbZMJirkqovKhMnuosYo+zQK3lWTl2pRAQ0d+pknSuFISbilMQnv
YlS9iZxEZGrhIMP8bAJLhtI6/HkbJRBX3Jw0Iuk13d728DGipB9FLemHZhP5ytcZ
Y0KIIw6EQCUqZ53Hsl32g/OM8ys6pZqVQOKPjpFTFMwea+aTZWi2Aneh3ym1yR7a
uaQaXPUzisyJDKn6dcRxX7y3f6M1GWNDMd1vH/CFJNpwzsQ+0b9f4wirYmX6nLsH
wj7GlhwofBHyxp3Zyul2ahtD3TYyNA==
=jmaY
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--

