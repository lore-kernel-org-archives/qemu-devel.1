Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB219C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 09:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8120220821
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 09:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd3ApPkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8120220821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38699 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH3kn-0002e4-RQ
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 05:54:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hH3jm-0002L5-8u
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hH3ji-0003bn-Gx
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:53:46 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hH3je-0003Yz-AH
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:53:42 -0400
Received: by mail-wr1-x443.google.com with SMTP id h4so2168384wre.7
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 02:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=JdtnDXw9x8bRwi8AqLYho7KCi3o9TjNS92KKMirlDbc=;
	b=hd3ApPkYCv5DG8Z0YxztuEqJ5kCbAxTdlHy1zcxI/n/3fT/m/VAaowFyyGZWp1Zqkv
	lFOcW+c/3yc/ReZfRZrZZvTNBGLNZ+2RMmAo24oYXYSt7FCrSqf3fL3IaXGcQOGIgrha
	IeNMcqryI4NNUkSPgYFaLySO9OwQJrA0g9seRVnQSv4mZHVXoDKgddPTiRx9cqnSYv44
	ihPhyMWgBC6kpmHvJ1BmIq1wi8X1CZCiuGV9bpESEvD3B1wA0KxNysu3+u7pQKFMfHwK
	AvZEiPe9RtrRY4dLxWh7OVsEpHpyPs/engMBOszVV9SS1/w+/Od4DnvVsq2l6WWl7YiP
	ldiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=JdtnDXw9x8bRwi8AqLYho7KCi3o9TjNS92KKMirlDbc=;
	b=NnQEtwfvofkFvGxa9NSEFwnhl5LOSONtxVdY/qvaitxX4LaLKAf9JGduADV4ns0bCw
	1Ica/GjPQFHdtF0vgl6v99nyWDAqOgsFAvQQvcAyCyf0/Fuhxf6JCT961FqUebGaOu3/
	vH1mrpl4uHYncVqfTkFPPZuAIBSUgvrqYreGn63jCaX4GKCNHM/48kdjdcHmqdXJDnol
	dHcoqUzTfLCJBeL4oGrq2G3VASf+ywfl8gD4/D5VCyXEF5qECnshIV286dP31R9GJ3Lp
	KkQ58uI37hN2uccKUtoK61UR4UDdCe1sChsAh9TjGHBEGUbbPmI0OyhkcxJQgg31dKuk
	w1SA==
X-Gm-Message-State: APjAAAXyv75HOlge3CO1qAgeU3+NmjNcpyRC/3W299mU89Mo5wXymYQ3
	TVjBlPWNARKcNQoGIfyJsJQ=
X-Google-Smtp-Source: APXvYqzkePbll3f/dXtwmEDpcuX00NmtSLl12vtuX5vyrlOJz0BPoWcRbz9Kldqth9fpK3McrBv1hA==
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr48359274wru.58.1555581166628; 
	Thu, 18 Apr 2019 02:52:46 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	z140sm2396137wmc.27.2019.04.18.02.52.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 18 Apr 2019 02:52:45 -0700 (PDT)
Date: Thu, 18 Apr 2019 10:52:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Nikos Dragazis <ndragazis@arrikto.com>
Message-ID: <20190418095244.GB23876@stefanha-x1.localdomain>
References: <6021647b-20c7-2801-4f3e-a91a297f36e2@arrikto.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <6021647b-20c7-2801-4f3e-a91a297f36e2@arrikto.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] revising virtio-vhost-user device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Vangelis Koukis <vkoukis@arrikto.com>, "Stojaczyk,
	Dariusz" <dariusz.stojaczyk@intel.com>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418095244.7Jbq9BXjnXGO1cd4K8RPk7niVjbfgMxt2ua4lH15qWw@z>


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2019 at 05:05:31PM +0300, Nikos Dragazis wrote:
> Hi everyone,
>=20
> as you may already know, there is an experimental feature in QEMU wiki
> page called =E2=80=9Cvirtio-vhost-user=E2=80=9D [1]. Stefan Hajnoczi laun=
ched this
> feature a year ago. He even wrote an RFC implementation [2]. However,
> this feature is still a WIP.
>=20
> At present, I am working with Dariusz Stojaczyk from Intel in order to
> integrate the virtio-vhost-user device with SPDK/DPDK. Part of the plan
> is to finish up and merge the virtio-vhost-user device with the latest
> QEMU. Thereby, I have been working on Stefan=E2=80=99s device code [3] ov=
er the
> last few weeks. Stefan has already made a TODO list [2] with all the
> missing parts.
>=20
> The updated device code is here [4]. In short, I have done the following
> things so far:
>=20
> - implement the virtio PCI capabilities for the additional device
> =C2=A0 resources
>=20
> - add support for guest notifications in response to master virtqueue
> =C2=A0 kicks
>=20
> - use ioeventfd mechanism for the callfds in order to avoid entering
> =C2=A0 QEMU
>=20
> - add UUID configuration field
>=20
> - rebase on top of latest qemu:master
>=20
> - update the virtio device spec [5][6]
>=20
> I have deliberately kept the commits separate in order to clearly
> demonstrate the above changes.
>=20
> There is still some work to be done. However, given the fact that I am
> not familiar with QEMU code and development process, I thought about
> sharing this with the community at an early stage. Hopefully, I could
> receive from you some reviews/pointers/comments/suggestions.
>=20
> Looking forward to your feedback.

Hi Nikos,
Nice to see your progress on this feature!

Please send the VIRTIO specification changes to
virtio-dev@lists.oasis-open.org.  For more info, see
https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=3Dvirtio#feedba=
ck.

Getting the specification approved is important so that QEMU can merge
the device implementation.  SPDK may be willing to merge code before it
is an official VIRTIO spec, but this will lead to problems with
non-compliant implementations and confusion for users when devices don't
work due to version mismatches.  I suggest focussing on getting
agreement on the spec.

Guidelines for submitting QEMU patches are here:
https://wiki.qemu.org/Contribute/SubmitAPatch

Please CC me on the VIRTIO and QEMU patches.  I'll be happy to review
them.

Note that David Gilbert has posted a shared memory resources patch for
the VIRTIO specification.  virtio-vhost-vsock should use this mechanism:
https://lists.oasis-open.org/archives/virtio-dev/201902/msg00142.html

Thanks,
Stefan

> Best regards,
> Nikos
>=20
> [1] https://wiki.qemu.org/Features/VirtioVhostUser
> [2] http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg04806.html
> [3] https://github.com/stefanha/qemu/tree/virtio-vhost-user
> [4] https://github.com/arrikto/qemu-qemu/commits/virtio-vhost-user
> [5] https://github.com/ndragazis/virtio/commits
> [6] https://ndragazis.github.io/virtio-v1.0-cs04.html#x1-2830007
>=20

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcuEjsAAoJEJykq7OBq3PIaaUH/0YsCNA8tNFbZRhqFeusnWMo
ejkKTje3pBxkPveN5dV7H8IZn4GGyWbmcYtPqDkLc35TfIBt/z+AvfOTBknwEdfF
W03z44mk+x90HwMXSM+2qnHMDwP7cuekDPiaYuYQ1ipG0B1DuaJHwNeVFejWfzrf
z8pHSgNSFqJxiNUycMXTJMhR/5Ylza43uDea37iI+IF/0taKZ9WBwfRm9edwASeo
lp+4GA/nzbG/fjrGT7BaAc1+bBseCJE3Jkr7U5I8mNb8Uq/W/8pk4u9oHdIo3VK1
Rj9eUqQIsB9vuEZbQ7FaQOHHJPmIDvdVK4/ID4+bs9yon6XLFXtyj2OOm5fPLCU=
=nuMm
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--

