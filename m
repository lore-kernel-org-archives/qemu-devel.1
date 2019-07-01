Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92744C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674472064B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674472064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxo6-0001qs-9H
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58163)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhxVV-0003ml-2B
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhxVT-0008Iz-7J
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:42:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhxVS-0008Hj-VL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:42:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so14132954wre.12
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 07:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HpgxwG0XEloh+oBaD9aK8rEN+btHP+Bocwr7Jye9cbk=;
 b=fKJAqBOc/4Zrd6I+hO47DoKbyAQJd+o+FSetCUyUdhiHca20VZbeCygijM/Hbtil+y
 og6yiD6bq0qItveaWUJqLtRDwsgOTQoWu058AuQmIIxh8ZNLBVEwmJ3zRWfCeWGLSnm7
 T+mlZ0eZSfmMPNovRsJb2N0foe7ZTo7qztBYTtlR1LL5ov7WFcWctVfbmlTVbOABkj6j
 DTwTMSm3xznnZURZlWha1EuoLh5HKKQzlj8dfo5Xug/SDr2W+WlcbkHmZW0RyGPQVVUA
 uHTCJm7LqlIJcgsDR09tBEZZiLpHweAFuN7kVqJD/dbKSzXzZWrVIxpDafbcDtEKTAd3
 5s8A==
X-Gm-Message-State: APjAAAVa3+zSU/IqQQXUdZN1KBo2J2OCVGJ32PcLfENyO4kPXOKTR11x
 X5aYG0tnR8SXeDgk7dD8MQoQDg==
X-Google-Smtp-Source: APXvYqzLpOEmPuJ2KP9h4ojXRsbfMjUJLXJMB3TwxzDr52rLSoxboUhSSepziEKNfitTOgQSdXHSxg==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr20130740wrt.84.1561992129386; 
 Mon, 01 Jul 2019 07:42:09 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id r79sm10678882wme.2.2019.07.01.07.42.07
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 07:42:08 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20181206215026.7716-1-pbonzini@redhat.com>
 <20181206215026.7716-3-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <34baad42-1ab8-ec81-467d-f62937656bc8@redhat.com>
Date: Mon, 1 Jul 2019 16:42:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20181206215026.7716-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 2/2] test: replace gtester with a TAP driver
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
Cc: Auger Eric <eric.auger@redhat.com>, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

On 12/6/18 10:50 PM, Paolo Bonzini wrote:
> gtester is deprecated by upstream glib (see for example the announcement
> at https://blog.gtk.org/2018/07/11/news-from-glib-2-58/) and it does
> not support tests that call g_test_skip in some glib stable releases.
> 
> glib suggests instead using Automake's TAP support, which gtest itself
> supports since version 2.38 (QEMU's minimum requirement is 2.40).
> We do not support Automake, but we can use Automake's code to beautify
> the TAP output.  I chose to use the Perl copy rather than the shell/awk
> one, with some changes so that it can accept TAP through stdin, in order
> to reuse Perl's TAP parsing package.  This also avoids duplicating the
> parser between tap-driver.pl and tap-merge.pl.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> v1->v2: show failures even in non-verbose mode
>         show executable name next to PASS/FAIL
>         tweak colored output
>         improved support for "make -k check"
>         switch license blurb to https
>         support TAP version line
>         removed Eamcs epilogs
> 
[...]
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index fb0b449c02..1dda5e2596 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -799,41 +799,53 @@ tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
>  tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
>  
>  SPEED = quick
> -GTESTER_OPTIONS = -k $(if $(V),--verbose,-q)
> -GCOV_OPTIONS = -n $(if $(V),-f,)
>  
>  # gtester tests, possibly with verbose output
> +# do_test_tap runs all tests, even if some of them fail, while do_test_human
> +# stops at the first failure unless -k is given on the command line
> +
> +do_test_human = \
> +	$(call quiet-command, rc=0; \
> +	  { $(foreach COMMAND, $1, \
> +	    MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} \
> +	      $2 $(COMMAND) -m=$(SPEED) -k --tap \
> +	      | ./scripts/tap-driver.pl --test-name="$(notdir $(COMMAND))" --color=always $(if $(V),, --show-failures-only) \
> +	      || $(if $(findstring k, $(MAKEFLAGS)), rc=$$?, exit $$?); ) }; exit $$rc, \
> +	  "TEST", "$*")
> +
> +do_test_tap = \
> +	$(call quiet-command, \
> +	  { $(foreach COMMAND, $1, \
> +	    MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} \
> +	      $2 $(COMMAND) -m=$(SPEED) -k --tap | sed "s/^[a-z][a-z]* [0-9]* /&$(notdir $(COMMAND)) /" || true; ) } \
> +	      | ./scripts/tap-merge.pl | tee "$@" \
> +	      | ./scripts/tap-driver.pl --color=always $(if $(V),, --show-failures-only), \
> +	  "TAP","$@")
>  
>  .PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))
>  $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: subdir-%-softmmu $(check-qtest-y)
> -	$(call quiet-command,QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
> -		QTEST_QEMU_IMG=qemu-img$(EXESUF) \
> -		MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} \
> -		gtester $(GTESTER_OPTIONS) -m=$(SPEED) $(check-qtest-$*-y) $(check-qtest-generic-y),"GTESTER","$@")
> +	$(call do_test_human,$(check-qtest-$*-y) $(check-qtest-generic-y), \
> +	  QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
> +	  QTEST_QEMU_IMG=qemu-img$(EXESUF))

I was used to gtester filter/skip 'testpath' param:

$ gtester -h
[...]
Utility Options:
  -k, --keep-going              Continue running after tests failed
  -l                            List paths of available test cases
  -m {perf|slow|thorough|quick} Run test cases according to mode
  -m {undefined|no-undefined}   Run test cases according to mode
  -p=TESTPATH                   Only start test cases matching TESTPATH
  -s=TESTPATH                   Skip test cases matching TESTPATH

Using:

$ make check-qtest-x86_64 GTESTER_OPTIONS="-p /x86_64/acpi"

But this commit removed the use of $GTESTER_OPTIONS, however it is
still documented:

$ make check-help
[...]
The variable SPEED can be set to control the gtester speed setting.
Default options are -k and (for make V=1) --verbose; they can be
changed with variable GTESTER_OPTIONS.

Is it possible to filter the tests to run with the TAP driver?

>  .PHONY: $(patsubst %, check-%, $(check-unit-y) $(check-speed-y))
>  $(patsubst %, check-%, $(check-unit-y) $(check-speed-y)): check-%: %
> -	$(call quiet-command, \
> -		MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} \
> -		gtester $(GTESTER_OPTIONS) -m=$(SPEED) $*,"GTESTER","$*")
> +	$(call do_test_human, $*)
>  
> -# gtester tests with XML output
> +# gtester tests with TAP output
>  
> -$(patsubst %, check-report-qtest-%.xml, $(QTEST_TARGETS)): check-report-qtest-%.xml: $(check-qtest-y)
> -	$(call quiet-command,QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
> -		QTEST_QEMU_IMG=qemu-img$(EXESUF) \
> -	  gtester -q $(GTESTER_OPTIONS) -o $@ -m=$(SPEED) $(check-qtest-$*-y) $(check-qtest-generic-y),"GTESTER","$@")
> +$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-qtest-%.tap: $(check-qtest-y)
> +	$(call do_test_tap, $(check-qtest-$*-y) $(check-qtest-generic-y), \
> +	  QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
> +	  QTEST_QEMU_IMG=qemu-img$(EXESUF))
>  
> -check-report-unit.xml: $(check-unit-y)
> -	$(call quiet-command,gtester -q $(GTESTER_OPTIONS) -o $@ -m=$(SPEED) $^,"GTESTER","$@")
> +check-report-unit.tap: $(check-unit-y)
> +	$(call do_test_tap,$^)
>  
>  # Reports and overall runs
>  
> -check-report.xml: $(patsubst %,check-report-qtest-%.xml, $(QTEST_TARGETS)) check-report-unit.xml
> -	$(call quiet-command,$(SRC_PATH)/scripts/gtester-cat $^ > $@,"GEN","$@")
> -
> -check-report.html: check-report.xml
> -	$(call quiet-command,gtester-report $< > $@,"GEN","$@")
> +check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check-report-unit.tap
> +	$(call quiet-command,./scripts/tap-merge.py $^ > $@,"GEN","$@")
>  
>  # Per guest TCG tests
>  
> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
> index 0a04bfbed8..e0f18f5a41 100644
> --- a/tests/docker/dockerfiles/centos7.docker
> +++ b/tests/docker/dockerfiles/centos7.docker
> @@ -22,6 +22,7 @@ ENV PACKAGES \
>      mesa-libEGL-devel \
>      mesa-libgbm-devel \
>      nettle-devel \
> +    perl-Test-Harness \
>      pixman-devel \
>      SDL-devel \
>      spice-glib-devel \
> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
> index 24b113b76f..c66e341e5f 100644
> --- a/tests/docker/dockerfiles/debian-amd64.docker
> +++ b/tests/docker/dockerfiles/debian-amd64.docker
> @@ -16,6 +16,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>          liblzo2-dev \
>          librdmacm-dev \
>          libsnappy-dev \
> +        libtest-harness-perl \
>          libvte-dev
>  
>  # virgl
> diff --git a/tests/docker/dockerfiles/debian-ports.docker b/tests/docker/dockerfiles/debian-ports.docker
> index e05a9a9802..514ab53b80 100644
> --- a/tests/docker/dockerfiles/debian-ports.docker
> +++ b/tests/docker/dockerfiles/debian-ports.docker
> @@ -29,6 +29,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>          flex \
>          gettext \
>          git \
> +        libtest-harness-perl \
>          pkg-config \
>          psmisc \
>          python \
> diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/dockerfiles/debian-sid.docker
> index 9a3d168705..b30cbe7fc0 100644
> --- a/tests/docker/dockerfiles/debian-sid.docker
> +++ b/tests/docker/dockerfiles/debian-sid.docker
> @@ -26,6 +26,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>          ca-certificates \
>          flex \
>          git \
> +        libtest-harness-perl \
>          pkg-config \
>          psmisc \
>          python \
> diff --git a/tests/docker/dockerfiles/debian8.docker b/tests/docker/dockerfiles/debian8.docker
> index 52945631cd..cdc3f11e06 100644
> --- a/tests/docker/dockerfiles/debian8.docker
> +++ b/tests/docker/dockerfiles/debian8.docker
> @@ -29,6 +29,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>          gettext \
>          git \
>          gnupg \
> +        libtest-harness-perl \
>          pkg-config \
>          python-minimal
>  
> diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
> index 154ae2a455..9561d4f225 100644
> --- a/tests/docker/dockerfiles/debian9.docker
> +++ b/tests/docker/dockerfiles/debian9.docker
> @@ -24,6 +24,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>          flex \
>          gettext \
>          git \
> +        libtest-harness-perl \
>          pkg-config \
>          psmisc \
>          python \
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index 0c4eb9e49c..1d0e3dc4ec 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -70,6 +70,7 @@ ENV PACKAGES \
>      nss-devel \
>      numactl-devel \
>      perl \
> +    perl-Test-Harness \
>      pixman-devel \
>      python3 \
>      PyYAML \
> diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
> index 36e2b17de5..229add533c 100644
> --- a/tests/docker/dockerfiles/ubuntu.docker
> +++ b/tests/docker/dockerfiles/ubuntu.docker
> @@ -45,6 +45,7 @@ ENV PACKAGES flex bison \
>      libspice-protocol-dev \
>      libspice-server-dev \
>      libssh2-1-dev \
> +    libtest-harness-perl \
>      libusb-1.0-0-dev \
>      libusbredirhost-dev \
>      libvdeplug-dev \
> 

