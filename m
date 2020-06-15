Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE10C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B7720663
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/gjS9kO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B7720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jklIV-0003C4-P5
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 05:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jklHW-0002MO-0v
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:19:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58099
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jklHT-0002L4-Jl
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592212789;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ScsHCVeKOSUtlUrh4OOq7nInxzd8bONOcFUmHBesw+s=;
 b=N/gjS9kOP13iX0a+LnVq88yk2/awNQ45z71J3tePKG9tL0EfaVR5C0c+nyyE0k3N9f86hz
 9TI61GxoTRwiO5Jwc3QghQEuy9aJQVp2BbQrc4SAGl+O/oyyuOe55t9/mzDGrjPEV3FJYN
 YG/EhDl3TUuSHXvCt010CA5IQQDWrYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-Ml_L3VuJN1myW4l_WHZSDQ-1; Mon, 15 Jun 2020 05:19:34 -0400
X-MC-Unique: Ml_L3VuJN1myW4l_WHZSDQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EC801009442;
 Mon, 15 Jun 2020 09:19:32 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51FA660C47;
 Mon, 15 Jun 2020 09:19:29 +0000 (UTC)
Date: Mon, 15 Jun 2020 10:19:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v3] configure: Let SLOF be initialized by
 ./scripts/git-submodule.sh
Message-ID: <20200615091925.GB269638@redhat.com>
References: <20200615074919.12552-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615074919.12552-1-f4bug@amsat.org>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:12:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 15, 2020 at 09:49:19AM +0200, Philippe Mathieu-Daudé wrote:
> The git-submodule.sh script is called by make and initialize the
> submodules listed in the GIT_SUBMODULES variable generated by
> ./configure.
> 
> SLOF is required for building the s390-ccw firmware on s390x, since
> it is using the libnet code from SLOF for network booting.
> 
> Add it to the GIT_SUBMODULES when buildint the s390-ccw firmware,
> to fix:
> 
>   $ ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
>   Submodule 'roms/SLOF' (https://git.qemu.org/git/SLOF.git) registered for path 'roms/SLOF'
>   Cloning into '/home/travis/build/user/qemu/roms/SLOF'...
>   fatal: unable to access 'https://git.qemu.org/git/SLOF.git/': Could not resolve host: git.qemu.org
>   fatal: clone of 'https://git.qemu.org/git/SLOF.git' into submodule path '/home/travis/build/user/qemu/roms/SLOF' failed
>   Failed to clone 'roms/SLOF'. Retry scheduled
>   Cloning into '/home/travis/build/user/qemu/roms/SLOF'...
>   fatal: unable to access 'https://git.qemu.org/git/SLOF.git/': Could not resolve host: git.qemu.org
>   fatal: clone of 'https://git.qemu.org/git/SLOF.git' into submodule path '/home/travis/build/user/qemu/roms/SLOF' failed
>   Failed to clone 'roms/SLOF' a second time, aborting
>   The command "( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )" exited with 1.

The "git-submodule.sh" script just invokes "git submodule". So if
you are getting DNS failures from "git submodule", using git-submodule.sh
instead is not going to fix the problem.

> 
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  configure   | 5 +++++
>  .travis.yml | 1 -
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index bb7fd12612..927e4a3d06 100755
> --- a/configure
> +++ b/configure
> @@ -6533,6 +6533,11 @@ if test "$cpu" = "s390x" ; then
>    write_c_skeleton
>    if compile_prog "-march=z900" ""; then
>      roms="$roms s390-ccw"
> +    # SLOF is required for building the s390-ccw firmware on s390x,
> +    # since it is using the libnet code from SLOF for network booting.
> +    if test -e "${source_path}/.git" ; then
> +      git_submodules="${git_submodules} roms/SLOF"
> +    fi
>    fi
>  fi

This whole bit of configure looks a bit dubious.

For all the other firmware images we ship as pre-built blobs, we never
try to re-build them even if the host compiler supports it. So I don't
think we need to make SLOF special. If someone wants to build SLOF
they should do so explicitly. IOW, I'd just remove this code that
automatically enables rebuilds of it, which will presumable fix the
DNS problem by virtue of never running that code.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


