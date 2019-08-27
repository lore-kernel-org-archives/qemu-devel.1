Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721D5C3A59F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BE52080C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BE52080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2PPm-0004GC-Cb
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 20:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i2POd-0003pt-MY
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i2POc-0008K4-Et
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:31:39 -0400
Received: from nsstlmta36p.bpe.bigpond.com ([203.38.21.36]:39993)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i2POb-0008IB-R6
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:31:38 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep36p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190827003131.OUFH18913.nsstlfep36p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Tue, 27 Aug 2019 10:31:31 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudehhedgfeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuffpveftpgfvgffnuffvtfetpdfqfgfvnecuuegrihhlohhuthemucegtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefvohhnhicupfhguhihvghnuceothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucfkphepheekrddujeefrdelkedrieeknecurfgrrhgrmhephhgvlhhopehimhgrtgdrlhhotggrlhdpihhnvghtpeehkedrudejfedrleekrdeikedpmhgrihhlfhhrohhmpeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqedprhgtphhtthhopeeotghrohhsrgesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeovghhrggskhhoshhtsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehjuhhlihhordhmohhnthgvshesihhnthgvlhdrtghomheqpdhrtghpthhtohepoehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrgheqpdhrtghpthhtohepoehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from imac.local (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D3581440E06E23C; Tue, 27 Aug 2019 10:31:30 +1000
Date: Tue, 27 Aug 2019 10:31:24 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190827003124.GA23751@imac.local>
References: <20190826155832.17427-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826155832.17427-1-crosa@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.36
Subject: Re: [Qemu-devel] [PATCH v2] configure: more resilient Python
 version capture
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
Cc: Julio Montes <julio.montes@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 26, 2019 at 11:58:32AM -0400, Cleber Rosa wrote:
> The current approach to capture the Python version is fragile, as it
> was demonstrated by a very specific build of Python 3 on Fedora 29
> that, under non-interactive shells would print multiline version
> information.
> 
> The (badly) stripped version output would be sent to config-host.mak,
> producing bad syntax and rendering the makefiles unusable.  Now, the
> Python versions is printed by configure, but only a simple (and better
> controlled variable) indicating whether the build system is using
> Python 2 is kept on config-host.mak.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> 
> ---
> v2: Use python from '$python' variable instead of hardcoded 'python2'
> ---
>  configure              | 5 +++--
>  tests/Makefile.include | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index e44e454c43..95134c0180 100755
> --- a/configure
> +++ b/configure
> @@ -1864,7 +1864,7 @@ if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7))'; then
>  fi
>  
>  # Preserve python version since some functionality is dependent on it
> -python_version=$($python -V 2>&1 | sed -e 's/Python\ //')
> +python_version=$($python -c 'import sys; print("%d.%d.%d" % (sys.version_info[0], sys.version_info[1], sys.version_info[2]))' 2>/dev/null)
>  
>  # Suppress writing compiled files
>  python="$python -B"
> @@ -6511,6 +6511,7 @@ if ! $python -c 'import sys; sys.exit(sys.version_info < (3,0))'; then
>    echo
>    echo "warning: Python 2 support is deprecated" >&2
>    echo "warning: Python 3 will be required for building future versions of QEMU" >&2
> +  python2="y"
>  fi
>  
>  config_host_mak="config-host.mak"
> @@ -7333,7 +7334,7 @@ echo "INSTALL_DATA=$install -c -m 0644" >> $config_host_mak
>  echo "INSTALL_PROG=$install -c -m 0755" >> $config_host_mak
>  echo "INSTALL_LIB=$install -c -m 0644" >> $config_host_mak
>  echo "PYTHON=$python" >> $config_host_mak
> -echo "PYTHON_VERSION=$python_version" >> $config_host_mak
> +echo "PYTHON2=$python2" >> $config_host_mak
>  echo "CC=$cc" >> $config_host_mak
>  if $iasl -h > /dev/null 2>&1; then
>    echo "IASL=$iasl" >> $config_host_mak
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 49684fd4f4..f5ac09549c 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1135,7 +1135,7 @@ TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
>  AVOCADO_SHOW=app
>  AVOCADO_TAGS=$(patsubst %-softmmu,-t arch:%, $(filter %-softmmu,$(TARGET_DIRS)))
>  
> -ifneq ($(findstring v2,"v$(PYTHON_VERSION)"),v2)
> +ifneq ($(PYTHON2),y)
>  $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
>  	$(call quiet-command, \
>              $(PYTHON) -m venv --system-site-packages $@, \
> -- 
> 2.21.0
> 
> 

Reviewed-by: Tony Nguyen <tony.nguyen@bt.com>

