Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B25BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:17:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A132074B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBtQbyod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A132074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0j9G-00007u-HX
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 06:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0j8W-00087o-Hq
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:16:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0j8U-0000Ss-K9
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:16:36 -0400
Received: by mail-wr1-x442.google.com with SMTP id a14so21101539wra.5
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 03:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8uWkdfkp4X5NJOBKPmtfC9riOfG48fZvrnOEFsfWFQo=;
 b=eBtQbyodUlu7e5DvAGFDreK4RUZq1zF7JGb8Qy6306bOO+SQdZ1awzXpL38bIdHwXG
 AhqoSdQdRTk0Xz40rs/tE8ITfNJsGjwmzqoREJf0ie91gEzcCYXkKaT5gwUjaKPDgLMn
 XRAj261AoKyg1mV0bzyIBD9uipDIWR0keVFuAubPSkamiGfy3ygEJIUqOO22+Tf0BWJq
 tPrHJF34vDsNjU6KscoGJWiRSQuG/hwGG1F2MRRgk161+wzQ2EVdyGPYmv0cZ+r1JuTq
 BDKDIQR3aMq2jS1jToJxZHqA84SCQgenp+SUEv8TfFyn40KCfe0tZszF6eG2jwztVtbJ
 biLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8uWkdfkp4X5NJOBKPmtfC9riOfG48fZvrnOEFsfWFQo=;
 b=MoUdt2NU6oKPHnCSquGIPCv0L+EKuJrt8dUJ22Z7QVJLGZyK++b9vazZ4ovpynRRpT
 dPqhy+1FqBwH+KL3cPfgK/ljegdwwCOp1JyjPIR/apzua8IGHvbenYOHjuGHtqgyFmmG
 KGzSzGfYLzvD9QXDt82vUzFDTctkIMmg8Qkd39tUYQWBXXQuGwNQIQnCkQIrHJt9DVc/
 6WjYNDZqtZFpywnUjCrmkvx643vO/PQWhQNWuvJawJGj280rt7fabMAsaRD5v9ujvwVr
 +3swpVMWsqhHFucSnQD/Y2JeBDrDA/ef1Q4rWz8iJdsUdsJvTJsIC+25igyPp4jQQjP9
 vz2A==
X-Gm-Message-State: AOAM532MZpxS8mU69Zfr5ajmHq/TQlTTOahwGxfKtGkZ9gh/xiOG6xlk
 fXHi2itdbuFlI3HsgvccfaU=
X-Google-Smtp-Source: ABdhPJx60yUfZEawuNrdJkbyaI58DdJkIY1JW0UxdfFShWBQ3trpCsQ6bES1kdsHn4s0Dc36OtPZCw==
X-Received: by 2002:adf:bbc1:: with SMTP id z1mr28539715wrg.173.1596017792491; 
 Wed, 29 Jul 2020 03:16:32 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v15sm4204275wrm.23.2020.07.29.03.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 03:16:31 -0700 (PDT)
Date: Wed, 29 Jul 2020 11:16:29 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
Message-ID: <20200729101629.GA37763@stefanha-x1.localdomain>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-3-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20200709024657.2500558-3-crosa@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2020 at 10:46:57PM -0400, Cleber Rosa wrote:

Awesome, thanks for creating this stuff! Minor suggestions:

> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index c1ff24370b..f8dab788ea 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -1003,3 +1003,150 @@ exercise as many corner cases as possible. It is =
a useful test suite
>  to run to exercise QEMU's linux-user code::
> =20
>    https://linux-test-project.github.io/
> +
> +CI
> +=3D=3D
> +
> +QEMU has configurations enabled for a number of different CI services.
> +The most update information about them and their status can be found
> +at::
> +
> +   https://wiki.qemu.org/Testing/CI
> +
> +Gating CI
> +----------
> +
> +A Pull Requests will only to be merged if they successfully go through
> +a different set of CI jobs.  GitLab's CI is the service/framework used

s/A Pull Requests/Pull Requests/
s/will only to be merged/will only be merged/

I suggest simplifying the first sentence:

  Code is only merged after passing the "gating" set of CI jobs.

Whether they are called Pull Requests or Merge Requests shouldn't matter
:).

> +for executing the gating jobs.
> +
> +The architecture of GitLab's CI service allows different machines to be
> +setup with GitLab's "agent", called gitlab-runner, which will take care

s/setup/set up/ throughout this document
https://grammarist.com/spelling/set-up-vs-setup/

> +of running jobs created by events such as a push to a branch.
> +
> +Even though gitlab-runner can execute jobs on environments such as
> +containers, this initial implementation assumes the shell executor is
> +used, effectively running jobs on the same machine (be them physical

s/them/they/

> +or virtual) the gitlab-runner agent is running.  This means those

s/the/where the/

> +machines must be setup in advance, with the requirements matching the
> +jobs expected to be executed there.
> +
> +Machine configuration for gating jobs
> +-------------------------------------
> +
> +The GitLab's CI architecture allows different parties to provide
> +different machines that will run different jobs.  At this point, QEMU
> +will deploy a limited set of machines and jobs.  Documentation and/or
> +scripts to setup those machines is located under::
> +
> +  scripts/ci/setup
> +
> +Ansible playbooks have been provided to perform two different tasks
> +related to setting gitlab-runner and the build environment.

s/setting/setting up/

> +
> +Other organizations involved in QEMU development may, in the near
> +future, contribute their own setup documentation/scripts under

Comments about relative time lack context in a long-lived document like
this one:
s/in the near future//

> diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/bu=
ild-environment.yml
> new file mode 100644
> index 0000000000..89b35386c7
> --- /dev/null
> +++ b/scripts/ci/setup/build-environment.yml
> @@ -0,0 +1,217 @@
> +---
> +- name: Installation of basic packages to build QEMU
> +  hosts: all
> +  vars_files:
> +    - vars.yml
> +  tasks:
> +    - name: Install basic packages to build QEMU on Ubuntu 18.04/20.04
> +      apt:
> +        update_cache: yes
> +        # This matches the packages on tests/docker/Dockerfiles/ubuntu18=
04.docker

These comments will not age well :). If you really want to leave a note
then I suggest "Originally from
tests/docker/Dockerfiles/ubuntu1804.docker".

> diff --git a/scripts/ci/setup/inventory b/scripts/ci/setup/inventory
> new file mode 100644
> index 0000000000..8bb7ba6b33
> --- /dev/null
> +++ b/scripts/ci/setup/inventory
> @@ -0,0 +1,2 @@
> +[local]
> +localhost
> diff --git a/scripts/ci/setup/vars.yml b/scripts/ci/setup/vars.yml

Perhaps this file can be called vars.yml.template and an entry for
vars.yml can be added to .gitignore. A file that needs local editing
should not be commited to git in-place. Otherwise it's easy to
accidentally commit the local changes to git (and expose the private
GitLab token!).

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8hTH0ACgkQnKSrs4Gr
c8ic/AgApLILZ0M94P3EEH5tnkRqwclTBBTO/a9UT1+5LUJrqUwqGHec4uyxctSH
LXmhDuvktrDzft0/GXZuaMklCpFjPYanPOC9Ha6hygdBLiXfmR95qlN+ss5EFnfa
tNg9q0ENXDSMWU6Kb11w4JoJO0Q4hBPRAFR0S9KZsHNwtZ78ml3fY4NG8c3Jgn7f
V3G4oJDeQRDoYlyWP+IkNTZk7LNBCgNo0ZAylh/NREs1VWRnFf+KZAQ+se3rMcSE
Uu58DixCIQi5Pk2LHBUZnJ5tHA6WcjIa2Mx6QhHT/4nL5fkGWyvMriVRZAsfD2mA
kZSOKy9xw0qe5hvQ61e50hvuMgO0Yg==
=MIGD
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

