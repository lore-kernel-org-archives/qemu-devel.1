Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08E9C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 979AA20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAQvhrdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979AA20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDaxo-00023p-Rk
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kDax3-0001WN-32
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:09:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kDax0-0004Tr-Gd
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599084593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=70/C/sgoXP4s3E1Vn13JXKLNatpIrMBTeNq4+64AGF8=;
 b=SAQvhrdUiM0qvPjKKLLr2x1HBnSY95QasFD9mMPsxgGKpRGDJEQ0tOW7FXb6IwcHryvPo0
 CI0JLx5+wF5+ePdUdkIlMNVw/3Ph+ZKr2UPzl6lTSOjBjkaYqUxx3OWaGVobkzB1N8rjji
 YIiVZtVlsbvsa5WANI9leTOieukc0yw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-aIHlyj45M7exoiume4jfjQ-1; Wed, 02 Sep 2020 18:09:51 -0400
X-MC-Unique: aIHlyj45M7exoiume4jfjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 528B78030D2;
 Wed,  2 Sep 2020 22:09:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-166.rdu2.redhat.com
 [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 737C119C59;
 Wed,  2 Sep 2020 22:09:46 +0000 (UTC)
Date: Wed, 2 Sep 2020 18:09:44 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 1/2] GitLab Gating CI: introduce pipeline-status
 contrib script
Message-ID: <20200902220944.GB55646@localhost.localdomain>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-2-crosa@redhat.com>
 <20200709085519.GB536480@nautilus.usersys.redhat.com>
 <538bde71-5e96-e56d-cbcd-44cf0942590e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <538bde71-5e96-e56d-cbcd-44cf0942590e@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2020 at 12:13:11PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 7/9/20 10:55 AM, Erik Skultety wrote:
> > On Wed, Jul 08, 2020 at 10:46:56PM -0400, Cleber Rosa wrote:
> >> This script is intended to be used right after a push to a branch.
> >>
> >> By default, it will look for the pipeline associated with the commit
> >> that is the HEAD of the *local* staging branch.  It can be used as a
> >> one time check, or with the `--wait` option to wait until the pipeline
> >> completes.
> >>
> >> If the pipeline is successful, then a merge of the staging branch into
> >> the master branch should be the next step.
> >>
> >> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> >> ---
> >>  scripts/ci/gitlab-pipeline-status | 156 +++++++++++++++++++++++++++++=
+
> >>  1 file changed, 156 insertions(+)
> >>  create mode 100755 scripts/ci/gitlab-pipeline-status
> >>
> >> diff --git a/scripts/ci/gitlab-pipeline-status b/scripts/ci/gitlab-pip=
eline-status
> >> new file mode 100755
> >> index 0000000000..4a9de39872
> >> --- /dev/null
> >> +++ b/scripts/ci/gitlab-pipeline-status
> >> @@ -0,0 +1,156 @@
> >> +#!/usr/bin/env python3
> >> +#
> >> +# Copyright (c) 2019-2020 Red Hat, Inc.
> >> +#
> >> +# Author:
> >> +#  Cleber Rosa <crosa@redhat.com>
> >> +#
> >> +# This work is licensed under the terms of the GNU GPL, version 2 or
> >> +# later.  See the COPYING file in the top-level directory.
> >> +
> >> +"""
> >> +Checks the GitLab pipeline status for a given commit commit
> >=20
> > s/commit$/(hash|sha|ID|)
> >=20
> >> +"""
> >> +
> >> +# pylint: disable=3DC0103
> >> +
> >> +import argparse
> >> +import http.client
> >> +import json
> >> +import os
> >> +import subprocess
> >> +import time
> >> +import sys
> >> +
> >> +
> >> +def get_local_staging_branch_commit():
> >> +    """
> >> +    Returns the commit sha1 for the *local* branch named "staging"
> >> +    """
> >> +    result =3D subprocess.run(['git', 'rev-parse', 'staging'],
> >=20
> > If one day Peter decides that "staging" is not a cool name anymore and =
use a
> > different name for the branch :) we should account for that and make it=
 a
> > variable, possibly even parametrize this function with it.
>=20
> This script can be used by any fork, not only Peter.
> So having a parameter (default to 'staging') is a requisite IMO.
>

Right, as explained in the reply to Erik, this is just used for
finding the commit ID for the staging branch.  Still, I'm making it
configurable in a new patch, and if people want, we can change the
current behavior to accept any kind of revision (but this would
probably mean changing the options or names, given that -c/--commit is
quite descriptive).

> >> +                            stdin=3Dsubprocess.DEVNULL,
> >> +                            stdout=3Dsubprocess.PIPE,
> >> +                            stderr=3Dsubprocess.DEVNULL,
> >> +                            cwd=3Dos.path.dirname(__file__),
> >> +                            universal_newlines=3DTrue).stdout.strip()
> >> +    if result =3D=3D 'staging':
> >> +        raise ValueError("There's no local staging branch")
> >=20
> > "There's no local branch named 'staging'" would IMO be more descriptive=
, so as
> > not to confuse it with staging in git.
> >=20
> >> +    if len(result) !=3D 40:
> >> +        raise ValueError("Branch staging HEAD doesn't look like a sha=
1")
> >> +    return result
> >> +
> >> +
> >> +def get_pipeline_status(project_id, commit_sha1):
> >> +    """
> >> +    Returns the JSON content of the pipeline status API response
> >> +    """
> >> +    url =3D '/api/v4/projects/{}/pipelines?sha=3D{}'.format(project_i=
d,
> >> +                                                        commit_sha1)
> >> +    connection =3D http.client.HTTPSConnection('gitlab.com')
> >> +    connection.request('GET', url=3Durl)
> >> +    response =3D connection.getresponse()
> >> +    if response.code !=3D http.HTTPStatus.OK:
> >> +        raise ValueError("Failed to receive a successful response")
> >> +    json_response =3D json.loads(response.read())
> >=20
> > a blank line separating the commentary block would slightly help readab=
ility
> >=20
> >> +    # afaict, there should one one pipeline for the same project + co=
mmit
> >=20
> > s/one one/be only one/
>=20
> 'afaict' is not a word.
>

Yes, good point.  Thomas has addressed this.

> >=20
> >> +    # if this assumption is false, we can add further filters to the
> >> +    # url, such as username, and order_by.
> >> +    if not json_response:
> >> +        raise ValueError("No pipeline found")
> >> +    return json_response[0]
> >> +
> >> +
> >> +def wait_on_pipeline_success(timeout, interval,
> >> +                             project_id, commit_sha):
> >> +    """
> >> +    Waits for the pipeline to end up to the timeout given
> >=20
> > "Waits for the pipeline to finish within the given timeout"
> >=20
> >> +    """
> >> +    start =3D time.time()
> >> +    while True:
> >> +        if time.time() >=3D (start + timeout):
> >> +            print("Waiting on the pipeline success timed out")
> >=20
> > s/success//
> > (the pipeline doesn't always have to finish with success)
> >=20
> >> +            return False
> >> +
> >> +        status =3D get_pipeline_status(project_id, commit_sha)
> >> +        if status['status'] =3D=3D 'running':
> >> +            time.sleep(interval)
> >> +            print('running...')
>=20
> If we want to automate the use of this script by a daemon, it would
> be better to use the logging class. Then maybe 'running...' is for
> the DEBUG level, Other print() calls can be updated to WARN/INFO
> levels.
>

Makes sense.  I'll look into using proper logging in a future
improvement series.

Thanks,
- Cleber.

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9QGCYACgkQZX6NM6Xy
CfP9eQ/+P8ExqAhoi7MefS10IXN0vP1bk67KXvvJrGAxPByfIrUJTS+E4CyMdgrY
gh/TwzS2e+hHVhiZ4uGacoXHGdio5LdiZOu1kEDlW90A5DVZIaLOdxEiAxqUYaQQ
bU0RiKCjHdT8+nyRu6JKY5p+/OhYI0NwidcItajWwbQLpyk3uLNvLTywyKKQljED
4Z0B3gFzN1vrDuJDGZSaHL7hgAN+mjdAMH90K5KM9nQ9tm9UmHavq7xyXcQ3qg+L
1tXdWUOs14X8pDRjq8MDr6caVJtxuhAPVAJ7JDQP+0+/N45afXWShglop/L+pL+H
PuT73ND+0hQsKY+53rpUi8j4ggD7G8OBOdtiEIRBFZSuHKJmAHHorsAbHvlUGcuI
IZ3sdqxUQaom/e4Ac5egz6BNJIEp6mmUEqw74X8+qabXUoqKHJ0Qvb/Hlk2cKEvf
1cFaXYCutNzrx4HmbWq3KQLio5kdr9owham6G+9tvU6BuP7b8ywNbFe1Fq+aS3cJ
S9LZtH6uXg1tFJPfHKMYIohE4OqUhd+I1NOp/QIdxQ/rvvVCvqplCBm+13IYUfyL
atVBBhmXbOw2hoGwby/nHAKqPW97qeSgX7qF1itoi77Fsdw3Vsb7XgwPTZBtli7z
pQGYvo8xDSnTp7hbOxOWhu8ZnNtIZzkhi4RX/+tCK9sicsftcOY=
=sO2v
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--


