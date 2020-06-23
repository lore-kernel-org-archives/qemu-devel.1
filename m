Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DB2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 18:00:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69E820774
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 18:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJc/RdpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69E820774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnnDL-0005NS-54
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 14:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jnnCe-0004wL-EZ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:59:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33992
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jnnCc-0000zz-GL
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592935160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D27k3mNZFXAfx6pNCajm6dJ+CmcByLBMSMKkDR3ldAU=;
 b=PJc/RdpVbUmoHOwI8f/m8kyaG8GNdwvsVaDw9Kc+31DS0ECoY2kE7I8XW1h/2iB9Aomp3S
 lqjtCG8OIOF+DYggpl6Knit2z418G4zZsFW0GS6GXKZ2CTY/kSeWFS4FMHoYrF3QAVH1FH
 PLGBEmZYarvSpmqo93iVnE0k4KCKUBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-uBBgDCX8P_CnlK4X2wDgsA-1; Tue, 23 Jun 2020 13:59:16 -0400
X-MC-Unique: uBBgDCX8P_CnlK4X2wDgsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3759F18A8221;
 Tue, 23 Jun 2020 17:59:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-214.rdu2.redhat.com
 [10.10.112.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AE5810013C0;
 Tue, 23 Jun 2020 17:59:10 +0000 (UTC)
Date: Tue, 23 Jun 2020 13:59:08 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 4/5] GitLab Gating CI: introduce pipeline-status contrib
 script
Message-ID: <20200623175908.GA955618@localhost.localdomain>
References: <20200312193616.438922-1-crosa@redhat.com>
 <20200312193616.438922-5-crosa@redhat.com>
 <20200618114524.GA677518@redhat.com>
 <20200622142056.GA791811@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200622142056.GA791811@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Erik Skultety <eskultet@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Wainer Moschetta <wmoschet@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 10:21:03AM -0400, Cleber Rosa wrote:
>=20
> The script should indeed work with the workflow you described.  I'll just
> run a few tests, to make sure that are no caveats, and I'll let you and
> Peter know about it.
>

FIY, I've cherry-pick just the patch with the scripts (for no reason other
than having some content) and pushed it to a different branch than staging:

  https://gitlab.com/cleber.gnu/qemuci/-/commits/exp/script_shared_runners

Then I ran:

  ./contrib/ci/scripts/gitlab-pipeline-status --wait --verbose -p 15173319 =
-c ef12b411985baab9071e5fab1851acdd07d9bec8

Which worked as expected.  BTW, the commit wouldn't be necessary if I
was checking on a "staging" branch.  The pipeline triggered (and being
waited on by the script is at):

   https://gitlab.com/cleber.gnu/qemuci/-/pipelines/159334485

So I believe it's now a matter of sorting out job the
inclusion/exclusion aspects, that is, if we start with all/some of the
current jobs and some or none of the jobs intended to run on the
s390/aarch64/x86_64 (non-shared) runners.

Thanks,
- Cleber.

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl7yQukACgkQZX6NM6Xy
CfOltw/8CJ7cso+uwRbZcRyTeJ7fXz2F4mQDssw82/722a19YlD0kprsRnx5g+QG
ieu2NrFugPuPH698hvehuI3UuTGJOVZ1/ZnHJ42Da4Zer0tu4gDbYs/vFiYNkVwH
tAuKD7/NMCuLtGVM2QwRoqdJfd7dRHbqDyZP8Up+igcDsAw3U2jln4Zr+/hxT+bf
0OJ3XwxgnE/ID79hUAVj52pKmeiO7nR4HojpweF4gCCUgkogJiTgnejLstHQ0872
8e2pW2Kl93gUCGqMEhZwChZTBAN/2XKWCsFpb4GbFB94W2U1YJ9BjAc0t6Xh2UhO
p7q/gwwAVfUxkH1OsGqVaDqbJBPYjvQORyyYMz42iPA2QTOqX3+RPORbJiXqYFAS
hTEc060Fd5I+FG4c+AANVd1jFvjho8s+gleJ/LeqHGIpWG+PGIbkx7V6dvyiEbyc
N3q5F55F/FScZXEYifI8p0OSkHVAql6RsxKBMoVkL6PEiwdGOo4hPzbP9LHHZWC2
zmdHC+FzpWNp5or/O+pn0R0SGNhv1Urz/NAGJpVfDwSqkW3CvZs2Oj9nrtkPZZRc
pGpmNLzZoHJ3k9su+BSNQik9wEeE9Zcd/2gxQi98KZ5mwvidrLVxZmYzboowIIa+
Ek/Klj3gSV6AmOOODCO8nUjysGUVhpxcA4yAsprooZWYVYofx44=
=aZ4D
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--


