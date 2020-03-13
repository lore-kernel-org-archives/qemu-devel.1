Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AA7C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA9A206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIQ9+xVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA9A206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCloR-0006Rh-Tn
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 11:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jCllx-0004Tq-Ub
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jCllw-00025A-22
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:58:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30130
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jCllv-00023j-TP
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584111527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IASS19teKNZHH5mIte3j08wOYmEvk0u4PuzIDsAMewA=;
 b=gIQ9+xVYmi8RLuUqLK+HOlOCGNoDBNtwkVLO5B3OaM6SCf3Htxo/je5tal+WoVpGgYfvrA
 NJ5hh8gGdhTJOMloRSN4Hyb6zwCAnsrygSUVQkrzCmstnyHfRsosd8cxceQVsOT80YhC60
 Add5VRe1jpAxgVrJF5PpFletlWjizFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-QNhLozNFOtGSAfFXvUFsDg-1; Fri, 13 Mar 2020 10:58:45 -0400
X-MC-Unique: QNhLozNFOtGSAfFXvUFsDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B626510824C2;
 Fri, 13 Mar 2020 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-127-103.rdu2.redhat.com
 [10.10.127.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 568EF3A5;
 Fri, 13 Mar 2020 14:58:39 +0000 (UTC)
Date: Fri, 13 Mar 2020 10:58:37 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/5] QEMU Gating CI
Message-ID: <20200313145837.GA492336@localhost.localdomain>
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA_PiX7LffcT9+1Bdn764fsqsSzUZib-yp=Og0Vpa3oOrw@mail.gmail.com>
 <20200312221619.GA483011@dhcp-17-173.bos.redhat.com>
 <CAFEAcA_aocOSyy+6vG5T6PJm9HgFC2sKa+BKGp-AcKosiiT8iA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_aocOSyy+6vG5T6PJm9HgFC2sKa+BKGp-AcKosiiT8iA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2020 at 01:55:49PM +0000, Peter Maydell wrote:
> On Thu, 12 Mar 2020 at 22:16, Cleber Rosa <crosa@redhat.com> wrote:
> >
> > On Thu, Mar 12, 2020 at 10:00:42PM +0000, Peter Maydell wrote:
> > > OK, so my question here is:
> > >  * what are the instructions that I have to follow to be
> > > able to say "ok, here's my branch, run it through these tests,
> > > please" ?
> >
> > The quick answer is:
> >
> >  $ git push git@gitlab.com:qemu-project/qemu.git my-branch:staging
> >
> > The longer explanation is that these jobs are limited to a "staging"
> > branch, so all you'd have to do is to push something to a branch
> > called "staging".  If that branch happens to be from the
> > "gitlab.com/qemu-project/qemu" repo, than the runners setup there
> > would be used.  The documentation an ansible playbooks are supposed
> > to help with this setup.
>=20
> Great, thanks. Could I do that for testing purposes with a
> staging branch that includes these patches, or would we have
> to wait for them to be in master before it works?
>

You can definitely do that with a staging branch that includes these
patches.

And with regards to setting up machines with runners and other
requirements, I tried to make it easy to replicate, but YMMV.  So,
please let me know if you find any issues whatsoever.

> -- PMM
>=20

Thanks,
- Cleber.

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl5rn5kACgkQZX6NM6Xy
CfMydw//VKUBNineZRmxIJk8tWogltiJFBTi41vL/2c3pcrNvWrEwIePS/17UdiX
5mPKO2MjrcZBzjU5JsZ1GMYFGsKDJiFxK3MEIP4LjfobyscWtVZJ9kNjm4cMBFWw
nHjIHEMUGgploHXwsO/KD1E4Y86bBQf0PAHIrWTZ0T0UOnyAUJn5wpASNEB5bDcn
awvdrllLlTh+ab9WpgXOcvrGvX8YoJ/Ixxo3cAEfvfg8kkfamuSn/zH59cKHG7hT
zsbYHb6l0N+qC/Qjj1F/pUJci47H62wFIxSd6n1HdVvxql80tCZ7QeXScBQiKJ3b
QZa4pTDky0M65VVNJN/Cpml/rS1lE85HM7Vj6SDCaFwwE6ZtXnQwArogwvJSm2Ql
0PGjMpPAvN6dGHJM4B48JtSeC/Z72EKGZg7CqhUQzlf/IVVCvI+botf3aNn2mXmw
ZO1SzVAIztfLxSNO652zZIaxDWCk/PxoUDkIdusBXKS+OpiZ+3OiYPpxjTDBqeMw
NoFbth29W1Q4XLR6vLLXOPnARKVzcDHEN//jY1LdhAlBV75ipSC6Y91Nn1L1jMYO
l8KHXyT9HSc60lAibouM+tCIshU86W+VeJ9mSHGW0bVWOcse12wL9q43VNy6n9f1
gzpf3EOTH6bZ5GZH7r5Rz+HkOkf75TZFKwTMxrRjQ4xqhHUCBJ0=
=3V0c
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--


