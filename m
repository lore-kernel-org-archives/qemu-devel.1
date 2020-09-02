Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F2FC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E907520767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZ1vhhDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E907520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDapQ-0007D7-5h
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kDaon-0006mS-J1
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:01:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33295
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kDaok-0003Zp-W2
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599084081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ennddmD2gwTE81qugDoZlHQ1zw0Fe7+JgPfD8k9KQS8=;
 b=VZ1vhhDmSkvw4PNbyFJZdHgXYww+v2bnwUxiPFbibbepsWYHId3ZASdAuibLlB2qWL3Kd8
 tMrJBn4bz+sp/QpX4atBJFWWUH9k07Y5OSfmGArpQsZ3I+5gtWtd/Mj0R1Sqv4srjWGkCu
 9eFBFd5YdHyEn0qeVjiyUK4FSh03UK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-2s1ud1WZMnWlJewhoOu83w-1; Wed, 02 Sep 2020 18:01:15 -0400
X-MC-Unique: 2s1ud1WZMnWlJewhoOu83w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B311805EE2;
 Wed,  2 Sep 2020 22:01:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-166.rdu2.redhat.com
 [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EBD9C5D9CC;
 Wed,  2 Sep 2020 22:01:09 +0000 (UTC)
Date: Wed, 2 Sep 2020 18:01:08 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Erik Skultety <eskultet@redhat.com>
Subject: Re: [PATCH v2 1/2] GitLab Gating CI: introduce pipeline-status
 contrib script
Message-ID: <20200902220108.GA55646@localhost.localdomain>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-2-crosa@redhat.com>
 <20200709085519.GB536480@nautilus.usersys.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200709085519.GB536480@nautilus.usersys.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 16:25:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2020 at 10:55:19AM +0200, Erik Skultety wrote:
> On Wed, Jul 08, 2020 at 10:46:56PM -0400, Cleber Rosa wrote:
> > This script is intended to be used right after a push to a branch.
> >
> > By default, it will look for the pipeline associated with the commit
> > that is the HEAD of the *local* staging branch.  It can be used as a
> > one time check, or with the `--wait` option to wait until the pipeline
> > completes.
> >
> > If the pipeline is successful, then a merge of the staging branch into
> > the master branch should be the next step.
> >
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  scripts/ci/gitlab-pipeline-status | 156 ++++++++++++++++++++++++++++++
> >  1 file changed, 156 insertions(+)
> >  create mode 100755 scripts/ci/gitlab-pipeline-status
> >
> > diff --git a/scripts/ci/gitlab-pipeline-status b/scripts/ci/gitlab-pipe=
line-status
> > new file mode 100755
> > index 0000000000..4a9de39872
> > --- /dev/null
> > +++ b/scripts/ci/gitlab-pipeline-status
> > @@ -0,0 +1,156 @@
> > +#!/usr/bin/env python3
> > +#
> > +# Copyright (c) 2019-2020 Red Hat, Inc.
> > +#
> > +# Author:
> > +#  Cleber Rosa <crosa@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > +# later.  See the COPYING file in the top-level directory.
> > +
> > +"""
> > +Checks the GitLab pipeline status for a given commit commit
>=20
> s/commit$/(hash|sha|ID|)
>=20

Just for the record, this was picked up by Thomas (thanks Thomas!).

> > +"""
> > +
> > +# pylint: disable=3DC0103
> > +
> > +import argparse
> > +import http.client
> > +import json
> > +import os
> > +import subprocess
> > +import time
> > +import sys
> > +
> > +
> > +def get_local_staging_branch_commit():
> > +    """
> > +    Returns the commit sha1 for the *local* branch named "staging"
> > +    """
> > +    result =3D subprocess.run(['git', 'rev-parse', 'staging'],
>=20
> If one day Peter decides that "staging" is not a cool name anymore and us=
e a
> different name for the branch :) we should account for that and make it a
> variable, possibly even parametrize this function with it.
>

This function is currently only called to set a default for the
-c/--commit command line option, so users can always set it to the
commit ID of any branch.  But, your point still holds with regards to
future extensibility.  I'll send a patch with that change.

> > +                            stdin=3Dsubprocess.DEVNULL,
> > +                            stdout=3Dsubprocess.PIPE,
> > +                            stderr=3Dsubprocess.DEVNULL,
> > +                            cwd=3Dos.path.dirname(__file__),
> > +                            universal_newlines=3DTrue).stdout.strip()
> > +    if result =3D=3D 'staging':
> > +        raise ValueError("There's no local staging branch")
>=20
> "There's no local branch named 'staging'" would IMO be more descriptive, =
so as
> not to confuse it with staging in git.
>

Ack, also picked up by Thomas.

> > +    if len(result) !=3D 40:
> > +        raise ValueError("Branch staging HEAD doesn't look like a sha1=
")
> > +    return result
> > +
> > +
> > +def get_pipeline_status(project_id, commit_sha1):
> > +    """
> > +    Returns the JSON content of the pipeline status API response
> > +    """
> > +    url =3D '/api/v4/projects/{}/pipelines?sha=3D{}'.format(project_id=
,
> > +                                                        commit_sha1)
> > +    connection =3D http.client.HTTPSConnection('gitlab.com')
> > +    connection.request('GET', url=3Durl)
> > +    response =3D connection.getresponse()
> > +    if response.code !=3D http.HTTPStatus.OK:
> > +        raise ValueError("Failed to receive a successful response")
> > +    json_response =3D json.loads(response.read())
>=20
> a blank line separating the commentary block would slightly help readabil=
ity
>

It would also be a good idea to follow PEP 257, but since there's currently
no check/enforcement, I'll defer to one it's introduced (hopefully soon).

> > +    # afaict, there should one one pipeline for the same project + com=
mit
>=20
> s/one one/be only one/
>

Ack, also picked up by Thomas (thanks again!).

> > +    # if this assumption is false, we can add further filters to the
> > +    # url, such as username, and order_by.
> > +    if not json_response:
> > +        raise ValueError("No pipeline found")
> > +    return json_response[0]
> > +
> > +
> > +def wait_on_pipeline_success(timeout, interval,
> > +                             project_id, commit_sha):
> > +    """
> > +    Waits for the pipeline to end up to the timeout given
>=20
> "Waits for the pipeline to finish within the given timeout"
>=20

Absolutely better, and also picked up by Thomas.

> > +    """
> > +    start =3D time.time()
> > +    while True:
> > +        if time.time() >=3D (start + timeout):
> > +            print("Waiting on the pipeline success timed out")
>=20
> s/success//
> (the pipeline doesn't always have to finish with success)
>

You're right, your suggestion improves the message, indeed.

But, I think the wording is still confusing as it took me some time to
understand that this timeout was about how long this script will wait.
(my fault here).  So I'm going to propose that this changes to:

"Timeout (-t/--timeout) of %i seconds reached, won't wait any longer
for the pipeline to complete".

> > +            return False
> > +
> > +        status =3D get_pipeline_status(project_id, commit_sha)
> > +        if status['status'] =3D=3D 'running':
> > +            time.sleep(interval)
> > +            print('running...')
> > +            continue
> > +
> > +        if status['status'] =3D=3D 'success':
> > +            return True
> > +
> > +        msg =3D "Pipeline ended unsuccessfully, check: %s" % status['w=
eb_url']
>=20
> I think more common expression is "Pipeline failed"
>

Agreed, and already addressed by Thomas (will I run out of thanks?).

> > +        print(msg)
> > +        return False
> > +
> ...
>=20
> Code-wise looks OK to me, but since I don't know what Peter's requirement=
s
> on/expectations of this script are, I can't do a more thorough review.
>=20
> Regards,
> Erik

Thanks Erik!

- Cleber.

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9QFiAACgkQZX6NM6Xy
CfOJpg/+JDz9GtPJFIFi9ypsp3ADvxYU4C9xYHnK7eXcIe08LDU6qFNC9sdog26d
r7YG3ddUB/CO0DrU86YHtJuN/7mx6HODaEVc9kDaZaC4QQMYr/b2pH7KS6iHmsMY
2WRbXRFKZGz2+nY+S2YatxC745/5JstdAjBL0yuhKluwoDtTGpV3FbHJXpFxRmjp
8KYnZjI/+bzP44vmMad/mmgL0SWsrYN59mtQZ5+n4HTlLkAquDZ8wbXADOYl+WFM
9gdSDJweeZQ5UTaPRaA2FJMa9zoZiGmmgg3luYkTS/oGd6JmsPNBP4fdLdag+NWS
t9dhMR7vywJ7neqqrUGN24TpZ30BOjFynNFIMmIF1XDaYezgYTxeE5meI74IWhJ7
eB/J7K8fSVKf+5WZ40LGNhg5wRleFLdkYTDKC/yST0Ni8Pghp5pOPAYK7zq4H9mr
ERvq7Qhr0FEYgDZr+V+h1fi36559TiEeSgFJaEE6hR6kIq+wylBH2D06MOTPc/bz
OCYhCOqO3WxsT4+gD89dlv74TQNbMPx1j3RSTLWG0dqkA6MkpsEvj/d6PkWXD+SX
omZXdNQSPN1ZgOi5ETAbZlb+phHGI2/UJLHU2ftozmz1ZLlRf8puZjlJOafsJtt8
fsR3AVe4qchPeREmYV/KZOVsgCb4x4rOzN0teJBN7Hg4U2xurps=
=p9Aq
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--


