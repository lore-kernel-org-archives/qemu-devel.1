Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03078C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 08:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E14204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 08:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJnYSkNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E14204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkkGS-0003lD-2g
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 04:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkkFl-0002ET-RT
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 04:14:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51935
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkkFi-0004bb-N0
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 04:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592208836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=IlJ9LcYn6+oLU9rPiNpH495Wc8APf+o+gVqskNyDWsc=;
 b=EJnYSkNvSKz7W5tsUjAgskAK2eJE8Y7ydExXxysfWzhi1dyFAJea6IGKcCpnMok9nsAaFU
 WdZlpBsjUYqFsGKXJQNqmoE7S+6m2N7kauYmTHqjwbktUL//FRjTTkoOQ5wAGDUP5HdHbE
 groP7v0hkqIEl+v61CFj19xY/H1n1tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-G4O6cxEKMseMYhwgA3vRSg-1; Mon, 15 Jun 2020 04:13:45 -0400
X-MC-Unique: G4O6cxEKMseMYhwgA3vRSg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D2D385B68A;
 Mon, 15 Jun 2020 08:13:44 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-111.ams2.redhat.com [10.36.112.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E985B1A922;
 Mon, 15 Jun 2020 08:13:40 +0000 (UTC)
Subject: Re: [PATCH v3] configure: Let SLOF be initialized by
 ./scripts/git-submodule.sh
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200615074919.12552-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e25444d6-d3b0-21b4-8bb8-b30a012f745a@redhat.com>
Date: Mon, 15 Jun 2020 10:13:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200615074919.12552-1-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:43:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/06/2020 09.49, Philippe Mathieu-Daudé wrote:
> The git-submodule.sh script is called by make and initialize the
> submodules listed in the GIT_SUBMODULES variable generated by
> ./configure.
> 
> SLOF is required for building the s390-ccw firmware on s390x, since
> it is using the libnet code from SLOF for network booting.
> 
> Add it to the GIT_SUBMODULES when buildint the s390-ccw firmware,

s/buildint/building/

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

I still somehow doubt that this will really fix the issue that you've
seen here (why should it matter where the submodule is checked out?),
but the patch is a good idea anyway, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>


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
>  
> diff --git a/.travis.yml b/.travis.yml
> index ec6367af1f..220855c1f0 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -496,7 +496,6 @@ jobs:
>          - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
>          - UNRELIABLE=true
>        script:
> -        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
>          - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
>          - |
>            if [ "$BUILD_RC" -eq 0 ] ; then
> 


