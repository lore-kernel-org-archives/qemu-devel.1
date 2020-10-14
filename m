Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804B0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE27821D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nqpmb0yX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE27821D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSktP-0001lO-Ib
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 13:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSkrw-0000qF-BX
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 13:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSkro-0006Q0-BU
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 13:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602697630;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1oQqBIT22lKXATOu/Up5FCCaLkIDKG17nQafJgp9uqw=;
 b=Nqpmb0yXyXFa9djGdeRiSwMPOPUcUJbi12EG2brcQwci8t9bicmESv8pUUtyx4rCbo33hV
 qPtrp/zmx8JLxovkSqu4QyONsmfuJ1gP2pvJT+TgUwBFGP0/wYKQqzY1DPjh0IVfQdQC33
 hAPpNXG8MbioVO8LpqaGAxL7a2h2NLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-ngEgC8-lMf2K2vCvp-cCLg-1; Wed, 14 Oct 2020 13:47:06 -0400
X-MC-Unique: ngEgC8-lMf2K2vCvp-cCLg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C90B287950D;
 Wed, 14 Oct 2020 17:47:04 +0000 (UTC)
Received: from redhat.com (ovpn-113-137.ams2.redhat.com [10.36.113.137])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF7A85C1BD;
 Wed, 14 Oct 2020 17:46:58 +0000 (UTC)
Date: Wed, 14 Oct 2020 18:46:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v3 4/4] Jobs based on custom runners: add job definitions
 for QEMU's machines
Message-ID: <20201014174655.GW115189@redhat.com>
References: <20201014052140.1146924-1-crosa@redhat.com>
 <20201014052140.1146924-5-crosa@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201014052140.1146924-5-crosa@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 01:21:40AM -0400, Cleber Rosa wrote:
> The QEMU project has two machines (aarch64 and s390) that can be used
> for jobs that do build and run tests.  This introduces those jobs,
> which are a mapping of custom scripts used for the same purpose.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  .gitlab-ci.d/custom-runners.yml | 192 ++++++++++++++++++++++++++++++++
>  1 file changed, 192 insertions(+)
> 
> diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
> index 3004da2bda..5b51d1b336 100644
> --- a/.gitlab-ci.d/custom-runners.yml
> +++ b/.gitlab-ci.d/custom-runners.yml
> @@ -12,3 +12,195 @@
>  # strategy.
>  variables:
>    GIT_SUBMODULE_STRATEGY: recursive
> +
> +# All ubuntu-18.04 jobs should run successfully in an environment
> +# setup by the scripts/ci/setup/build-environment.yml task
> +# "Install basic packages to build QEMU on Ubuntu 18.04/20.04"
> +ubuntu-18.04-s390x-all-linux-static:
> + needs: []
> + stage: build
> + tags:
> + - ubuntu_18.04
> + - s390x
> + rules:
> + - if: '$CI_COMMIT_BRANCH =~ /^staging/'

IIRC, in the previous v2 (or was it v1) we discussed changing this
so that users who provide their own runners, don't have to always
use the "staging" branch name.

IIUC, the key thing is that we don't want the job running on the
"master" or "stable-*" branches in the primary QEMU git. So could
check

   $CI_PROJECT_NAMESPACE == 'qemu-project'
   &&
   $CI_COMMIT_BRANCH !~ '^master$'
   &&
   $CI_COMMIT_BRANCH !~ '^stable-$'

which would let it work on users forks no matter what branch names
they use

What happens to the job if the user doesn't have runners ? Is it
simply skipped, or does the pipeline stall and get marked as failed ?

If the jobs aren't auto-skiped, we would need to add an env variable

   (
   $CI_PROJECT_NAMESPACE == 'qemu-project'
   &&
   $CI_COMMIT_BRANCH !~ '^master$'
   &&
   $CI_COMMIT_BRANCH !~ '^stable-$'
   )
   ||
   $QEMU_ENABLE_CUSTOM_RUNNERS == 'yes'

and require the user to set the QEMU_ENABLE_CUSTOM_RUNNERS variable
in the web UI for their fork

That all said, I don't mind if you postpone this rules change to a
followup patch.

> + script:
> + # --disable-libssh is needed because of https://bugs.launchpad.net/qemu/+bug/1838763

This bug links to

  https://bugs.launchpad.net/ubuntu/+source/libssh/+bug/1847514

which is marked as fixed. So I'm thinking we can drop the --disable-libssh
arg from all these jobs

> + # --disable-glusterfs is needed because there's no static version of those libs in distro supplied packages
> + - mkdir build
> + - cd build
> + - ../configure --enable-debug --static --disable-system --disable-glusterfs --disable-libssh
> + - make --output-sync -j`nproc`
> + - make --output-sync -j`nproc` check V=1
> + - make --output-sync -j`nproc` check-tcg V=1



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


