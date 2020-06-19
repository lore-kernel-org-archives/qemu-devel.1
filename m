Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7C3C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:00:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8529F206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="GzxbBQ6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8529F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmHZN-00065S-EL
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 10:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jmHVe-0003aA-Hj
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:56:46 -0400
Received: from mout.web.de ([217.72.192.78]:39891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jmHVc-0001cm-BW
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592574964;
 bh=zunp3WXGUc0GvTdbd5gefrZw1pgu2yROP7XQMq0zrRs=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=GzxbBQ6X/naVU/fbgkwmx6aLiBGi3BGvgcyk3X+faxvzwZiNzpSYzSpbEgOo05Sdu
 3uGL1FtAvGjZzy0j20yWw578buXkLFN1SeSIv7MXaQszlxadEVf2AHiVniIpJUNphR
 sLc0ZChcINlo5P4WcQOdfTuzcTGSv+uxJ97Hb/kA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.165]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxHU2-1ixVG819Vw-00xZrG; Fri, 19
 Jun 2020 15:56:04 +0200
Date: Fri, 19 Jun 2020 15:55:45 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH 0/5] colo: Introduce resource agent and test suite/CI
Message-ID: <20200619155545.292c7f14@luklap>
In-Reply-To: <8f8990d3a2f540bdaa44eb48eeafbc67@intel.com>
References: <cover.1589199922.git.lukasstraub2@web.de>
 <a1d3390036cd4007b53786cf6cb7b5a9@intel.com>
 <20200606205932.30099b9f@luklap>
 <8f8990d3a2f540bdaa44eb48eeafbc67@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4Y+uBjRyKVdelK3hKjUGG.u";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:pqZJIzve5d5APizpNSlKzN4EuUfxa51lknVmQ6F603nungkpMqp
 Kr8Fzlt78koM5iLMkPE86vCGk9a5/nmm5E7StniiqhohcB2WDToKfEZbhCxmbXah3b5k4SE
 2lyEXWUpLYpN5D4WAAuZh8mdK53DUZrbfkgPnvrTRsJ1Ux7B03J2sYheA4hkvdg5lDH1h3c
 sdF3JcDIEX9QkdCTn5nWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IP3kNCRVMec=:u+vjifANvNlZTSw7bwZow3
 x38ULjsxfiISlE33XIoy9PxHMXVFfFerzCTZ9//5/s62hcp0duwr+iGAPiqca0AFeAInx9pmu
 OK2ykIg+gKRcpRLfRrELIx9QKeZWPKufYhdaSE2BALo0kTo6yo33/J3pCBfcg+JqI6eKkOMeu
 X5PNd+KiiniBgPU2jdlzfGMgKpHkW0X15WmBlK6W26n+CigJXHMSezF2nKZIB051GG6eNC/Zl
 V3LKWRWM8nuHoIIlJads0J926xzv7b7JjAr3+6+xB8Hhntzbp9rYRBOMBCt3H1Aa6AK2L6gzd
 ICzjPUHtXm/oMUf1Gb/CotD1tPKHgjqNZpJomSEheLn1mxIsJMh1XvmF9VS+Q0CVJHc09QOj0
 jgTiAhLVv+EbDGQOawtBLnvYgQfBHO0L1TmKB4ANKYKR7jVK2lJqn2GjWmLebyQDYyFXUr8Bj
 ib6yQDUnLM/rNIvJ1kf6eIL4THx3nmEtVrU6f+FozjQxYPlKbXVzcdz5Wsbrmd9pAXF405PJR
 Yy/SCMARWq7/WdhAbMmzIGlovSJ+fHzVnYIlHFq5vQD9GcsSYOJQeY1JU9ufd/r2yfiqdF4ED
 kl1CwjZbCRfMv/SL2HIGm5bEJ4DC8qUyaA4E5HDUBzXu+vpfS2HByZqfFNcJNuti+c/vAVUQl
 UbFSIbVa8eFj0LP+HI3+FG3a6sNTdqoMPUh8eCITVFgExdfB1gRcecHtbBFZ6Hwfbh1Ar9fqr
 c2JMIBsxD9oJidFKlE+hLSh5IslQTphr9Alema+kiBiuKwhiRL9Dja3iPHW9U9zebAMhZDR8Q
 D6zMq8vlSlMV4IbMD0spFiCyxiAsb5ZIOHZ1ojaxvX2R+rcezlN+p/pv+APxMlhVzMo8mFtKi
 NC1u2zPoac72FlMbCan5DYxzD/2P+3LpxKal7uAZPiPjSij7RtlvI6Hct4mg9L3/lbf8iOkIJ
 7BieMpgAWj0yUL1pa1vOxaFlXocVz5kpop/fZSSZmXnae3cdfCrtOSa/QoYTaAUauJkHoB7oI
 JJOfhSqdxa5cH01r3fOuciuzKbYDkECWk2XZjqzpq/OjTdRts1S9qCLvkPPwFPdfCRHzMgiYc
 ti3A78YIVJsyKEHpYMEOu+2i6d/stegm2KAwwnUEj/2i9e6pIOfIP//V6U0SGBuF5oQ1hQ79X
 RXK0iCE1aMNld5M/QXXI/mmun3YieXD+gxZTK7sau5XbEbsuU+5wH7r/gVcSeUL+CKPOcQcuK
 m+HAWqeTi4y6vAvFB
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 09:56:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Jason Wang <jasowang@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/4Y+uBjRyKVdelK3hKjUGG.u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jun 2020 01:42:45 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Sunday, June 7, 2020 3:00 AM
> > To: Zhang, Chen <chen.zhang@intel.com>
> > Cc: qemu-devel <qemu-devel@nongnu.org>; Alberto Garcia
> > <berto@igalia.com>; Dr. David Alan Gilbert <dgilbert@redhat.com>; Jason
> > Wang <jasowang@redhat.com>
> > Subject: Re: [PATCH 0/5] colo: Introduce resource agent and test suite/=
CI
> >=20
> > On Mon, 18 May 2020 09:38:24 +0000
> > "Zhang, Chen" <chen.zhang@intel.com> wrote:
> >  =20
> > > > -----Original Message-----
> > > > From: Lukas Straub <lukasstraub2@web.de>
> > > > Sent: Monday, May 11, 2020 8:27 PM
> > > > To: qemu-devel <qemu-devel@nongnu.org>
> > > > Cc: Alberto Garcia <berto@igalia.com>; Dr. David Alan Gilbert
> > > > <dgilbert@redhat.com>; Zhang, Chen <chen.zhang@intel.com>
> > > > Subject: [PATCH 0/5] colo: Introduce resource agent and test
> > > > suite/CI
> > > >
> > > > Hello Everyone,
> > > > These patches introduce a resource agent for fully automatic
> > > > management of colo and a test suite building upon the resource agen=
t to =20
> > extensively test colo. =20
> > > >
> > > > Test suite features:
> > > > -Tests failover with peer crashing and hanging and failover during
> > > > checkpoint -Tests network using ssh and iperf3 -Quick test requires
> > > > no special configuration -Network test for testing colo-compare
> > > > -Stress test: failover all the time with network load
> > > >
> > > > Resource agent features:
> > > > -Fully automatic management of colo
> > > > -Handles many failures: hanging/crashing qemu, replication error,
> > > > disk error, ...
> > > > -Recovers from hanging qemu by using the "yank" oob command -Tracks
> > > > which node has up-to-date data -Works well in clusters with more
> > > > than 2 nodes
> > > >
> > > > Run times on my laptop:
> > > > Quick test: 200s
> > > > Network test: 800s (tagged as slow)
> > > > Stress test: 1300s (tagged as slow)
> > > >
> > > > The test suite needs access to a network bridge to properly test the
> > > > network, so some parameters need to be given to the test run. See
> > > > tests/acceptance/colo.py for more information.
> > > >
> > > > I wonder how this integrates in existing CI infrastructure. Is there
> > > > a common CI for qemu where this can run or does every subsystem have
> > > > to run their own CI? =20
> > >
> > > Wow~ Very happy to see this series.
> > > I have checked the "how to" in tests/acceptance/colo.py, But it looks
> > > not enough for users, can you write an independent document for this =
=20
> > series? =20
> > > Include test Infrastructure ASC II diagram,  test cases design ,
> > > detailed how to and more information for pacemaker cluster and resour=
ce =20
> > agent..etc ?
> >=20
> > Hi,
> > I quickly created a more complete howto for configuring a pacemaker clu=
ster
> > and using the resource agent, I hope it helps:
> > https://wiki.qemu.org/Features/COLO/Managed_HOWTO =20
>=20
> Hi Lukas,
>=20
> I noticed you contribute some content in Qemu COLO WIKI.
> For the Features/COLO/Manual HOWTO
> https://wiki.qemu.org/Features/COLO/Manual_HOWTO
>=20
> Why not keep the Secondary side start command same with the qemu/docs/COL=
O-FT.txt?
> If I understand correctly, add the quorum related command in secondary wi=
ll support resume replication.
> Then, we can add primary/secondary resume step here.

I haven't updated the wiki from qemu/docs/COLO-FT.txt yet, I just moved it =
there from the main page.

Regards,
Lukas Straub

> Thanks
> Zhang Chen


--Sig_/4Y+uBjRyKVdelK3hKjUGG.u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7sw+EACgkQNasLKJxd
slg3gQ/9FEqJeGJN8o4vBOG/q/LZ8EJolBpYy9Y8QdDy67i0nO//ei/mq7mGwm5d
uHBL3j+6Z2QFOIruDfsIvliO/jJbDV29SZ724Ov4jVVqiF9NRZmxzj9S4OeRlE20
ucjhkF7jNCAAqjdlrXMyqmS68ti31IxEzLPkl3T/rqaMBLpXK8by89p1BfYj+u+H
UcX7wOFERMJF84QYEBYRebtw0uZI8b2w5LFiPa4zIg3ZNd0ZDShzij3lzn8MZ+7T
vTl2HppUbWw41ZB1Uj8dNVnIJQgJMNeS2b9bychScsRh5yd0apQti3ZOEFoPiOKf
97uIOKyIpPqqw4tae/KbOM+RVbcaaO77fRw0pTMIPEOsKt6fdDKVoWPekWMHO/CX
3yVM3p5ESaaLoEttHqvWYkVBoDMUi8dxx290IZ4cNh8f0+DXR749AwLOuk6JwMPb
8FibYWnC4yu+kyYbKzCNbGbq68csjFd5zLeavE+4xrwqiPwo1i54Ym2UuKWXFbWO
Zk+b1yGrDMMFotze669HK6K0NmggZiI1yHKj7Xcgc5M6ZbC8mw3UnSV7Ra/zLR4E
EeXWy07sjSXk/PniZqs5u6cuo/uCj6rYT4K8iB4Lw4K16vx15GF7Pwus6ueeSNYi
EOa5vY6sQeAd9NFyTH5CNdSAgzLgF9nZ8T5+oOyfiIIvZ/hg2Ko=
=7vRz
-----END PGP SIGNATURE-----

--Sig_/4Y+uBjRyKVdelK3hKjUGG.u--

