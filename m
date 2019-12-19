Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BC6C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2F320716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlS1/Rfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2F320716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihu67-0000qd-Se
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ihu5F-00007z-Gb
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ihu5E-00027X-8P
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:35:09 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ihu5D-00020y-Qf
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:35:08 -0500
Received: by mail-wr1-x444.google.com with SMTP id b6so5663665wrq.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 03:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=byGVsnsK1HpFaVsemiho/h1Fbn4ci/pb4Ac4/GaaLtg=;
 b=mlS1/RfvcEMfZe2RiwSGdVmZPXZiHsw6aGacKVzuJzhU/slX0EB3owiulExZPFQSEF
 uWa5WoKUzT8lH6pprIpNOwmllnMioRB8kupBXZan9iiz/Mk2157lxeBuAuYjXO8z3ZQs
 4XFAS1oGRe441j6+PO9NrRqebO4ScHWODR5VJDFmHg1jd5nBGToPJ+UylfX0PY+sZWS+
 RDjfOktQA70a72pGRIw0o7LBzGabb1AfeGdeVS+vUMONjJ5WRzuEmmiNsZPgi0WKTTB3
 pQ8V0wrlS+PRvaEB1HNB9diO6xuvYNGAbAHNFjNQY5VTSHNttJUKsRPzX5pIY6B+nifR
 8IGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=byGVsnsK1HpFaVsemiho/h1Fbn4ci/pb4Ac4/GaaLtg=;
 b=UwnXa+bdEkwOGHPuyXufc0K6qUGsZQlv0PV2beoeI9fWsTUzjr+Pozq1eB76/Web/W
 na/DojQtpbcbbWsrwp47eafGNG8Hqw66P2NK7IYbttCEd+nhX22KvLtdLbaFGYVKZsv+
 qZhYLFGxo40d/SdWkJclYi1uYxJL0h4imgm5ALjdNkvxYyuc+YU++LikU8nDDTZPysPg
 6kNCwIYDK7y51S23nahC1euBMFBRuAldcX23B0PVFTNLYc9v2AuZbJ4zD78wkTbuvDe0
 5jxpemg+Gantt5AHFGC9Flh9nUfILtMqwCSA1kbapMSJqWHRfWrxzALhFC4uGrD9jBf1
 4JZg==
X-Gm-Message-State: APjAAAXQZ0dwEmi4WLNGRxAYClbwiwzEIlKTfAsMUTePUWp45Tao1jWN
 shl219OFtnQJ6s/sObmhk6Y=
X-Google-Smtp-Source: APXvYqwuPBmXMi5ihAkoPl9iYW8tNdLY/dpfmg+KbCXKxWfzJPdUjMQcE+m/pChPgrpX2IRi2nsWew==
X-Received: by 2002:adf:e5ca:: with SMTP id a10mr8788234wrn.347.1576755306476; 
 Thu, 19 Dec 2019 03:35:06 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id t125sm2402838wmf.17.2019.12.19.03.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 03:35:05 -0800 (PST)
Date: Thu, 19 Dec 2019 11:35:03 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: ning.bo9@zte.com.cn
Subject: Re: [Qemu-devel] [PATCH v2] vhost-vsock: report QMP event
 whensetrunning
Message-ID: <20191219113503.GC1624084@stefanha-x1.localdomain>
References: <20191212110525.GA1141992@stefanha-x1.localdomain>
 <201912131511549044400@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <201912131511549044400@zte.com.cn>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2019 at 03:11:54PM +0800, ning.bo9@zte.com.cn wrote:
> > This can be done efficiently as follows:
> > 1. kata-runtime listens on a vsock port
> > 2. kata-agent-port=3DPORT is added to the kernel command-line options
> > 3. kata-agent parses the port number and connects to the host
> >=20
> > This eliminates the reconnection attempts.
>=20
> There will be an additional problem if do this:
> Who decides which port the `runtime` should listen?

Let the host kernel automatically assign a port using VMADDR_PORT_ANY.
It works like this:

  struct sockaddr_vm svm =3D {
      .svm_family =3D AF_VSOCK,
      .svm_port =3D VMADDR_PORT_ANY,
      .svm_cid =3D VMADDR_CID_ANY,
  };

  int fd =3D socket(AF_VSOCK, SOCK_STREAM, 0);
  ...
  if (bind(fd, (const struct sockaddr *)&svm, sizeof(svm)) < 0) {
      ...
  }

  socklen_t socklen =3D sizeof(svm);
  if (getsockname(fd, (struct sockaddr *)&svm, &socklen) < 0) {
      ...
  }

  printf("cid %u port %u\n", svm.svm_cid, svm.svm_port);

> Consider the worst case:=20
> The ports selected by two `runtime` running in parallel always conflict,=
=20
> and this case is unavoidable, even if we can reduce the possibility of co=
nflicts through algorithms.
> Because we don't have a daemon that can allocate unique port to `runtime`.

The kernel assigns unique ports and only fails if the entire port
namespace is exhausted.  The port namespace is 32-bits so this is not a
real-world concern.

Does this information clarify how the runtime can connect to the guest
agent without loops or delays?

Stefan

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl37YGcACgkQnKSrs4Gr
c8itLwf/Tm73CHcytGzxhWzZlBIHTe7Ft31ZhykGjERFJg4Gmj5XTWKtyFJvsqkN
u6m/2cbMmG9+GSjL3bCqP8h3cvHO/ed9AdwhUfjDbA12sls5HqG5hQFa76qmUlCG
g8pwjJgjly58y+XxFXMlrKYzoDeBTcnc8MIjhqPjyCYhfKnfJSrv3WTbAwFGlPy6
tE41begiLVuswEyiAlZJiPUzdn85G/b6rEqttQou2bdOtnwhU09Yetx+RnFI6F1D
y2B2ukfU5mxRcQ/ppzKHrhS+kcYSzKa9CaCm0xTFQ2dkNLmGqLAiClIsmcg4Umix
6uUrDSrGDAQVwpWLY+ofSoJKk1P2lw==
=OXpX
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--

