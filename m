Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D806AC3524D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFBD2084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhhIkTuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFBD2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyer-0006Xp-Sh
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iyyeH-000694-Kh
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iyyeF-0006Qe-4t
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:53:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56314
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iyyeE-0006Nu-LD
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580824429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+T5XPGrMJBpU3XKv+/Wx3DJ2l7v2sfaz2ytjbBXD6CA=;
 b=KhhIkTuGPjqVo1KZh6oyqCOy8Jf0vo/9yS9UVDM+X976nYo6Usiy/oyVBu1yp2UQawc1d3
 ZPO7UjsdDAHDxFZx4eUKw3WsPEZVZYReQN+nb2s89ihsxr2ZVH7KWGOtqIWAnRcP21BrgG
 kVgU4UDwKUWaCbjqq9Sz0LNcgJlKx4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-9_syVmn8OC6vhr9IwhpNRw-1; Tue, 04 Feb 2020 08:53:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D24CE801F76;
 Tue,  4 Feb 2020 13:53:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-4.gru2.redhat.com [10.97.116.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D6CF88873;
 Tue,  4 Feb 2020 13:53:41 +0000 (UTC)
Subject: Re: [PATCH 1/2] configure: Allow user to specify sphinx-build binary
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200203132533.21850-1-peter.maydell@linaro.org>
 <20200203132533.21850-2-peter.maydell@linaro.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <21a00fe7-1c19-ce6c-8d2c-bb3a54165d73@redhat.com>
Date: Tue, 4 Feb 2020 11:53:39 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200203132533.21850-2-peter.maydell@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 9_syVmn8OC6vhr9IwhpNRw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2/3/20 11:25 AM, Peter Maydell wrote:
> Currently we insist on using 'sphinx-build' from the $PATH;
> allow the user to specify the binary to use. This will be
> more useful as we become pickier about the capabilities
> we require (eg needing a Python 3 sphinx-build).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I went with the most common convention for specifying "here's
> an executable", like --make=, --install=, --python=....
>
> The only odd one out for our current configure options seems to be
> that we want --with-git=GIT, not --git=GIT. You could argue that
> that's a better convention, but it makes more sense to me to
> stick with the convention we currently mostly have. (Perhaps
> we should even change --with-git= to --git= ?)
>
>   configure | 10 +++++++++-
>   Makefile  |  2 +-
>   2 files changed, 10 insertions(+), 2 deletions(-)


Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> diff --git a/configure b/configure
> index 5095f017283..830f325822a 100755
> --- a/configure
> +++ b/configure
> @@ -584,6 +584,7 @@ query_pkg_config() {
>   }
>   pkg_config=query_pkg_config
>   sdl2_config="${SDL2_CONFIG-${cross_prefix}sdl2-config}"
> +sphinx_build=sphinx-build
>   
>   # If the user hasn't specified ARFLAGS, default to 'rv', just as make does.
>   ARFLAGS="${ARFLAGS-rv}"
> @@ -975,6 +976,8 @@ for opt do
>     ;;
>     --python=*) python="$optarg"
>     ;;
> +  --sphinx-build=*) sphinx_build="$optarg"
> +  ;;
>     --gcov=*) gcov_tool="$optarg"
>     ;;
>     --smbd=*) smbd="$optarg"
> @@ -1677,6 +1680,7 @@ Advanced options (experts only):
>     --make=MAKE              use specified make [$make]
>     --install=INSTALL        use specified install [$install]
>     --python=PYTHON          use specified python [$python]
> +  --sphinx-build=SPHINX    use specified sphinx-build [$sphinx_build]
>     --smbd=SMBD              use specified smbd [$smbd]
>     --with-git=GIT           use specified git [$git]
>     --static                 enable static build [$static]
> @@ -4799,7 +4803,7 @@ has_sphinx_build() {
>       # sphinx-build doesn't exist at all or if it is too old.
>       mkdir -p "$TMPDIR1/sphinx"
>       touch "$TMPDIR1/sphinx/index.rst"
> -    sphinx-build -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
> +    $sphinx_build -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
>   }
>   
>   # Check if tools are available to build documentation.
> @@ -6474,6 +6478,9 @@ echo "QEMU_LDFLAGS      $QEMU_LDFLAGS"
>   echo "make              $make"
>   echo "install           $install"
>   echo "python            $python ($python_version)"
> +if test "$docs" != "no"; then
> +    echo "sphinx-build      $sphinx_build"
> +fi
>   echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
>   if test "$slirp" != "no" ; then
>       echo "smbd              $smbd"
> @@ -7503,6 +7510,7 @@ echo "INSTALL_DATA=$install -c -m 0644" >> $config_host_mak
>   echo "INSTALL_PROG=$install -c -m 0755" >> $config_host_mak
>   echo "INSTALL_LIB=$install -c -m 0644" >> $config_host_mak
>   echo "PYTHON=$python" >> $config_host_mak
> +echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
>   echo "CC=$cc" >> $config_host_mak
>   if $iasl -h > /dev/null 2>&1; then
>     echo "IASL=$iasl" >> $config_host_mak
> diff --git a/Makefile b/Makefile
> index a6f5d440828..1f37523b528 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1024,7 +1024,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
>   # Note the use of different doctree for each (manual, builder) tuple;
>   # this works around Sphinx not handling parallel invocation on
>   # a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
> -build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" sphinx-build $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
> +build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" $(SPHINX_BUILD) $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
>   # We assume all RST files in the manual's directory are used in it
>   manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) \
>                 $(wildcard $(SRC_PATH)/docs/$1/*.rst.inc) \


