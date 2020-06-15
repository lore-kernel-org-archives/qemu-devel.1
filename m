Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A515FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74FCD2068E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCBztQTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FCD2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkjbk-0005m4-Eo
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 03:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkjaW-0004qV-8a
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 03:31:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33063
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkjaU-0005Pl-7P
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 03:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592206281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=sIMEdjHcxA6U+veVKzq/6gjTB9lllPTeN7IFkaGllWw=;
 b=QCBztQTj7pKTh3maPsjsumCAp39/a22eW+7t3PN3l54AaWGPs/QV3LGmqBNjL9BEAV1reM
 gRlem7n3o8t68Mt77luyF1XI9cu4BX2hpPVJ+hzkW67vgs0mR0GSvCmi84FK3e3JGADQHS
 RZC8mOx0hWcfHznQVYg6lulGxt2VTP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-o2NCaQIrMz6FE6afyZEcyg-1; Mon, 15 Jun 2020 03:31:13 -0400
X-MC-Unique: o2NCaQIrMz6FE6afyZEcyg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0E1F8730A1;
 Mon, 15 Jun 2020 07:31:11 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-111.ams2.redhat.com [10.36.112.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D8A07CAAC;
 Mon, 15 Jun 2020 07:31:08 +0000 (UTC)
Subject: Re: [PATCH v2] configure: Let SLOF be initialized by
 ./scripts/git-submodule.sh
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200615065721.7873-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e1343dcf-6607-8e51-5287-a52722aee97c@redhat.com>
Date: Mon, 15 Jun 2020 09:31:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200615065721.7873-1-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/06/2020 08.57, Philippe Mathieu-Daudé wrote:
> The git-submodule.sh script is called by make and initialize the
> submodules listed in the GIT_SUBMODULES variable generated by
> ./configure.
> 
> Add SLOF when we build the ppc64-softmmu target for the pSeries
> machines (which use SLOF). This fixes:
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
> 
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> CI: https://travis-ci.org/github/philmd/qemu/jobs/698406512#L1596
> ---
>  configure   | 12 ++++++++++++
>  .travis.yml |  1 -
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 7c2adf36e5..f297a4b68f 100755
> --- a/configure
> +++ b/configure
> @@ -2248,6 +2248,18 @@ if test "$edk2_blobs" = "yes" && ! has bzip2; then
>    error_exit "The bzip2 program is required for building QEMU"
>  fi
>  
> +###################################
> +# SLOF is mandatory for the pSeries
> +for target in $target_list; do
> +  case $target in
> +    ppc64-softmmu)

I know it's confusing, but actually, SLOF is not required for building
ppc64-softmmu. It's required for building the s390-ccw firmware on
s390x, since it is using the libnet code from SLOF for network booting.
And that can only be built right now when we're on a s390x host and GCC
is installed.

There is already a check in configure (look for "Only build s390-ccw
bios" ...), so I'd suggest that you add the git_submodules line there
instead.

 Thanks,
  Thomas


> +      if test -e "${source_path}/.git" ; then
> +          git_submodules="${git_submodules} roms/SLOF"
> +      fi
> +    ;;
> +  esac
> +done
> +
>  feature_not_found() {
>    feature=$1
>    remedy=$2
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


