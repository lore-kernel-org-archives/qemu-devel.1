Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA39C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 11:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100F82175B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 11:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100F82175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40071 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJGNl-0004Bv-BF
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 07:48:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJGMA-00039I-Kn
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJG7J-0007oT-M5
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:31:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hJG29-0003qN-9L; Wed, 24 Apr 2019 07:25:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDA003E2D7;
	Wed, 24 Apr 2019 11:25:47 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BBB15DAAF;
	Wed, 24 Apr 2019 11:25:40 +0000 (UTC)
Date: Wed, 24 Apr 2019 12:25:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190424112537.GF31388@redhat.com>
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-3-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190424103747.10173-3-thuth@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Wed, 24 Apr 2019 11:25:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/6] tests/qemu-iotests/group: Introduce a
 new "ci" group for CI pipelines
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424112537.RgNyQoxrK7TTjkQGFHt9GGbV-c5QoOTM5ts2Wmx_uDA@z>

On Wed, Apr 24, 2019 at 12:37:43PM +0200, Thomas Huth wrote:
> Tests in this group are supposed to run in every possible QEMU configuration.
> That means they should run with every QEMU binary (also non-x86), without
> dependencies on an optional features, they must work at least with the qcow2
> image format and be able to run on all kind of host filesystems and users
> (i.e. also as "nobody" or "root").
> 
> The initial list has been created as a subset of the "quick" group, where
> I've disabled all tests that are failing with qemu-system-aarch64 or
> qemu-system-tricore or in one of our CI pipelines.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/group | 194 ++++++++++++++++++++-------------------
>  1 file changed, 102 insertions(+), 92 deletions(-)
> 
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index bae7718380..2ed42dcc14 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -4,63 +4,73 @@
>  # - do not start group names with a digit
>  #
>  
> +#
> +# Some notes about the groups:
> +# - Tests in the "quick" group should finish within some few seconds
> +# - Tests in the "ci" group are suitable for running in CI systems. That
> +#   means they should run with every QEMU binary (also non-x86), with
> +#   every QEMU configuration (i.e. no dependency on an optional feature),
> +#   at least with the qcow2 image format and all kind of host filesystems
> +#   and users (i.e. also as "nobody" or "root").

No dependancy on optional features feels a bit restrictive from my POV.

We have quite alot of testing coverage of stuff that depends on the
crypto libraries that is important for us to run in "CI". This includes
LUKS block drivers, qcow2 with LUKS,  NBD with TLS. Personally I expect
all of those to be tested by CI systems.

IOW for a "CI" group, the bar should be higher than "no optional features"

Since we control the env used for CI via Docker or VM images, we can ensure
that they're populated with a set of packages that maximises our coverage.
All our platforms support gnutls for example, which gets us all the crypto
bits we need.

The problem of course is the desire to put this into "make check" by default
which developers can run in any configuration.

I think this is a sign that we need two distinct groupings.

Stuff run by a generic "make check" /should not/ depend on optional features,

Stuff run by an automated CI system /should/ depend on optional features. 

IOW, we should have:

   * "ci-min" - no deps on optional things configure might disable
   * "ci-max" - as many features as possible (assume Docker & VM
                images include them)

"make check" would default to "ci-min", but our CI systems can set
SPEED=thorough, causing "make check" to use "ci-max" instead ?

> -001 rw auto quick
> -002 rw auto quick
> +001 rw auto quick ci
> +002 rw auto quick ci
>  003 rw auto
> -004 rw auto quick
> -005 img auto quick
> +004 rw auto quick ci
> +005 img auto quick ci

Does anyone call what the "auto" group is supposed to be for ?

Its name kind of suggests it was for automated CI but maybe I'm reading
too much in to that ?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

