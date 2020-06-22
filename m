Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E40AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E40320720
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuORmT6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E40320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNKm-0003z8-2Y
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jnNJy-0003YX-5P
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:21:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47495
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jnNJu-0003rc-KO
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592835668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2F7OpPG3CWeEoJSEHNRy9I0jK3bzn1vgOO2gLYqr7HU=;
 b=QuORmT6zTUSVynyj54Cx31W91yC6kPYtGB6BUI896hT4q0wSyHu65dsa+cCrzA4pJst2pD
 kX8iyPmGvxRm2CvWn6aWo3I0ItEf6TRg9jS3xBEvDYYSuYVeztGt7ncvfJ22pfH0nJlbR5
 /+TY+3H/94C+cMkvViWtEwaoBDPgthE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-wEv4yJ2jO0yklrvfDF2nIQ-1; Mon, 22 Jun 2020 10:21:04 -0400
X-MC-Unique: wEv4yJ2jO0yklrvfDF2nIQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29DDA1054F91;
 Mon, 22 Jun 2020 14:21:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-214.rdu2.redhat.com
 [10.10.112.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C8FA10013D7;
 Mon, 22 Jun 2020 14:20:58 +0000 (UTC)
Date: Mon, 22 Jun 2020 10:20:56 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 4/5] GitLab Gating CI: introduce pipeline-status contrib
 script
Message-ID: <20200622142056.GA791811@localhost.localdomain>
References: <20200312193616.438922-1-crosa@redhat.com>
 <20200312193616.438922-5-crosa@redhat.com>
 <20200618114524.GA677518@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200618114524.GA677518@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
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

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2020 at 12:45:24PM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Mar 12, 2020 at 03:36:15PM -0400, Cleber Rosa wrote:
> > This script is intended to be used right after a push to a branch.
> >=20
> > By default, it will look for the pipeline associated with the commit
> > that is the HEAD of the *local* staging branch.  It can be used as a
> > one time check, or with the `--wait` option to wait until the pipeline
> > completes.
> >=20
> > If the pipeline is successful, then a merge of the staging branch into
> > the master branch should be the next step.
>=20
> On IRC yesterday we were discussing the current .gitlab-ci.yml status,
> and how frustrating it is that every time we get it green, more code is
> soon merged that turns it red again.
>

Hi Daniel,

I know this is nothing new to you, but "green" turning "red" is
something that can be minimized, but never completely abolished.
We've had discussions on how we could minimize those, and suggestions
on how to address those occurrences.  The points that I remember about
it are:

1. For jobs supposed to run on containers and vms, use images prepared
   to run the builds and tests, that is, don't do the prep steps
   (package installations and others) within the job itself - this is
   currently missing.

2. For bare metal, have the setup either documented or scripted and run
   before the jobs (in the patch series I sent, these were done in
   a number of Ansible based playbooks).

3. Have a mechanism for promoting non-gating jobs to gating jobs.  Keeping
   track of their reliability over a period of time is a way to forecast
   it future behavior, as much as it can be done.

4. Have a MAINTAINERS entry for those jobs, and have maintainers
   attemtp to address issues within a specified amount of time; if
   that fails, have a mechanism to downgrade those jobs to non-gating.
   A patch removing/moving entries from .gitlab-ci*.yml would do that
   and of course sping another set of CI jobs bringing things back to
   green.

> It feels like it should be an easy win to declare that the current GitLab
> CI jobs are to be used as a gating tests for merges to master.
>

I'm fine with that approach if most people agree.  This would mean
point #1 is ignored for now.  For everyone's sake, points #3 and #4
are a must IMO.  Point #2 will applied as we introduced our non-shared
gitlab runners.

> As & when custom runners come online, their jobs can simply augment the
> existing jobs. IOW, use of GitLab CI for gating master shouldn't be
> dependant on setup of custom runners which we've been waiting on for a
> long term.
>=20
> Peter indicated that his main requirement is a way to automate the task
> of kicking off the CI job & getting its status. It seems like the script
> in this patch should fullfill that requirement.
>=20
> Assuming Peter (or whomever is going todo the merge) has a fork of
>=20
>    https://gitlab.com/qemu-project/qemu
>=20
> then they need to find the "ID" number of their fork. This is
> visible at the top for the page for their fork eg mine:
>=20
>    https://gitlab.com/berrange/qemu
>=20
> reports:
>=20
>    "Project ID: 18588805 "
>=20
> Assuming the fork is configured as a git remote called "gitlab", then
> to use GitLab CI as gating test, all that appears to be needed is
>=20
>    $ git push gitlab
>    $ ./contrib/ci/scripts/gitlab-pipeline-status --wait -p 18588805
>=20
> If this is an acceptable level of automation for Peter, then can we
> get this specific patch merged right now and make current GitLab CI
> be gating for master.
>=20
>=20
> With GitLab as gating, then we have further incentive to move all
> the jobs currently on Travis CI and Shippable, over to use GitLab
> too, and also use cirrus-run  to make Cirrus CI jobs be proxied
> from GitLab.  All this can be in parallel with adding custom GitLab
> runners for expanding testing coverage still further.
>

The script should indeed work with the workflow you described.  I'll just
run a few tests, to make sure that are no caveats, and I'll let you and
Peter know about it.

Thanks,
- Cleber.

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl7wvkYACgkQZX6NM6Xy
CfM7LQ/8C4NtgO2e38p7+0KWNYoSpW0xLHn5NSW/Sa7sk+EgUS/JKgN5lC697bRk
JUaeDVoKK6zf9twxibFLFv07/obw4dRb1Mf7hfBnJfcD2eoy4mmvrgHYYCXShUo7
wZVqmevgAHLDUhQf2HuKBg5rLKY6D/+JSwhLmbyPAh0rHDbBK/jIcbOJg1h78nmV
PzS+VUFqLSEBI3+ULicUasd6Zg2C5r/yQJyThyt1XhiKg6Mj2LGyIwP/6g6eiXvP
6JvYkU3HdHBeZrc+JCbo9dOaOKLqa80jWeyHYW+PeU6Hl40RcGPXpNSKQ+fFuydC
PRrqLGYYMJ3knNwFzP21SGCFKI3HrGt0EbKLotYwn6EyJOVebVzNu9ElXlcqdx90
i+uQgC08qk+OMDdrXmLM/3fs/fd6LUFWmP2XrNO5JocdqrwCesqNI7yCvDzYDlTq
gEvz+LqL2Kc5YUs7bGlUES9bZ8rwvNl76NX+cV/HfZskTBl+NnPaqil9CM7gpAil
CsiDfJvrv4xnH2wzpXQm3uFilBau1N64EnxaIOyg9jk6OGBUd6rsMSWYfnI6bSDz
i4vOd55xt2dbIpLQOUXPAN6D1N3ZtKHIxDdIkBigaJ/rhPBYDLt7PDQURUs3lNnR
FOnSDiGpz9DA8A7Gljs2Ud+FNuujv6iG+j71mEKaSOIt0TYeGPY=
=ZGkz
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--


