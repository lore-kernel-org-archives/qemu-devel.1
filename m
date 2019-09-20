Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E1CC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:01:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC442054F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC442054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBEmn-0006Pn-5o
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 05:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrezanin@redhat.com>) id 1iBEjs-0003ic-FT
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrezanin@redhat.com>) id 1iBEjo-0007CM-9Y
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:58:03 -0400
Received: from 212-4-128-36.cust.selfnet.cz ([212.4.128.36]:46090
 helo=workimage.localdomain) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <mrezanin@redhat.com>) id 1iBEjn-0007Bs-WF
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:58:00 -0400
Received: by workimage.localdomain (Postfix, from userid 1000)
 id 48CC11AE442; Fri, 20 Sep 2019 10:57:56 +0200 (CEST)
Date: Fri, 20 Sep 2019 10:57:56 +0200
From: Miroslav Rezanina <mrezanin@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3] qemu-ga: Convert invocation
 documentation to rST
Message-ID: <20190920085756.luzas76jivztgxzb@lws.brq.redhat.com>
References: <20190905131040.8350-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905131040.8350-1-peter.maydell@linaro.org>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.4.128.36
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
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 05, 2019 at 02:10:40PM +0100, Peter Maydell wrote:
> The qemu-ga documentation is currently in qemu-ga.texi in
> Texinfo format, which we present to the user as:
>  * a qemu-ga manpage
>  * a section of the main qemu-doc HTML documentation
> 
> Convert the documentation to rST format, and present it to
> the user as:
>  * a qemu-ga manpage
>  * part of the interop/ Sphinx manual
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
> Now we're out of release we might as well get this in the tree.
> I saw a new manpage in texi going past the other day so perhaps
> if we have the framework for doing manpages in rst in-tree
> we can avoid adding too many more files we need to convert later.
> 
> v2->v3:
>  * no changes, just a rebase since this last went out in June
> v1->v2:
>  * filter out built manpages when installing the HTML manual
>  * default to /etc/qemu as the CONFDIR
>  * rather than duplicating the whole sphinx command line in
>    two macros, make the existing build-manual macro take an
>    extra argument to specify html or manpage creation. This
>    ensures we invoke the same way both times, which is important
>    since sphinx might cache parts of the config in .doctrees
>  * drop trailing '=' from 'key' column in table
> ---
>  Makefile                 |  24 ++++---
>  MAINTAINERS              |   2 +-
>  docs/conf.py             |  18 ++---
>  docs/interop/conf.py     |   7 ++
>  docs/interop/index.rst   |   1 +
>  docs/interop/qemu-ga.rst | 133 +++++++++++++++++++++++++++++++++++++
>  qemu-doc.texi            |   5 --
>  qemu-ga.texi             | 137 ---------------------------------------
>  8 files changed, 166 insertions(+), 161 deletions(-)
>  create mode 100644 docs/interop/qemu-ga.rst
>  delete mode 100644 qemu-ga.texi
> 
> diff --git a/Makefile b/Makefile
> index ae17a830678..92acd6b4ee5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -325,7 +325,7 @@ endif
>  endif
>  
>  ifdef BUILD_DOCS
> -DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
> +DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 docs/interop/qemu-ga.8
>  DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
>  DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
>  DOCS+=docs/qemu-block-drivers.7
> @@ -782,10 +782,11 @@ DESCS=
>  endif
>  
>  # Note that we manually filter-out the non-Sphinx documentation which
> -# is currently built into the docs/interop directory in the build tree.
> +# is currently built into the docs/interop directory in the build tree,
> +# and also any sphinx-built manpages.
>  define install-manual =
>  for d in $$(cd $(MANUAL_BUILDDIR) && find $1 -type d); do $(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/$$d"; done
> -for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' '(' -name 'qemu-*-qapi.*' -o -name 'qemu-*-ref.*' ')' ); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
> +for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' '(' -name '*.[0-9]' -o -name 'qemu-*-qapi.*' -o -name 'qemu-*-ref.*' ')' ); do $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
>  endef
>  
>  # Note that we deliberately do not install the "devel" manual: it is
> @@ -817,7 +818,7 @@ ifdef CONFIG_TRACE_SYSTEMTAP
>  	$(INSTALL_DATA) scripts/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
>  endif
>  ifneq (,$(findstring qemu-ga,$(TOOLS)))
> -	$(INSTALL_DATA) qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
> +	$(INSTALL_DATA) docs/interop/qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
>  	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)"
>  	$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
>  	$(INSTALL_DATA) docs/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
> @@ -976,18 +977,22 @@ docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
>  sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/interop/index.html $(MANUAL_BUILDDIR)/specs/index.html
>  
>  # Canned command to build a single manual
> -build-manual = $(call quiet-command,sphinx-build $(if $(V),,-q) -W -n -b html -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
> +# Arguments: $1 = manual name, $2 = Sphinx builder ('html' or 'man')
> +build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" sphinx-build $(if $(V),,-q) -W -n -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
>  # We assume all RST files in the manual's directory are used in it
>  manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
>  
>  $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
> -	$(call build-manual,devel)
> +	$(call build-manual,devel,html)
>  
>  $(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
> -	$(call build-manual,interop)
> +	$(call build-manual,interop,html)
>  
>  $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
> -	$(call build-manual,specs)
> +	$(call build-manual,specs,html)
> +
> +$(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
> +	$(call build-manual,interop,man)
>  
>  qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
>  	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
> @@ -1012,7 +1017,6 @@ qemu.1: qemu-option-trace.texi
>  qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
>  fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
>  qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
> -qemu-ga.8: qemu-ga.texi
>  docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
>  docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
>  scripts/qemu-trace-stap.1: scripts/qemu-trace-stap.texi
> @@ -1025,7 +1029,7 @@ txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
>  qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
>  	qemu-img.texi qemu-nbd.texi qemu-options.texi \
>  	qemu-tech.texi qemu-option-trace.texi \
> -	qemu-deprecated.texi qemu-monitor.texi qemu-img-cmds.texi qemu-ga.texi \
> +	qemu-deprecated.texi qemu-monitor.texi qemu-img-cmds.texi \
>  	qemu-monitor-info.texi docs/qemu-block-drivers.texi \
>  	docs/qemu-cpu-models.texi docs/security.texi
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ef6c01084b7..d7db933081b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2032,7 +2032,7 @@ QEMU Guest Agent
>  M: Michael Roth <mdroth@linux.vnet.ibm.com>
>  S: Maintained
>  F: qga/
> -F: qemu-ga.texi
> +F: docs/interop/qemu-ga.rst
>  F: scripts/qemu-guest-agent/
>  F: tests/test-qga.c
>  F: docs/interop/qemu-ga-ref.texi
> diff --git a/docs/conf.py b/docs/conf.py
> index e46b299b71f..b7edb0666b5 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -115,6 +115,14 @@ todo_include_todos = False
>  # with "option::" in the document being processed. Turn that off.
>  suppress_warnings = ["ref.option"]
>  
> +# The rst_epilog fragment is effectively included in every rST file.
> +# We use it to define substitutions based on build config that
> +# can then be used in the documentation. The fallback if the
> +# environment variable is not set is for the benefit of readthedocs
> +# style document building; our Makefile always sets the variable.
> +confdir = os.getenv('CONFDIR', "/etc/qemu")
> +rst_epilog = ".. |CONFDIR| replace:: ``" + confdir + "``\n"
> +
>  # -- Options for HTML output ----------------------------------------------
>  
>  # The theme to use for HTML and HTML Help pages.  See the documentation for
> @@ -192,14 +200,8 @@ latex_documents = [
>  
>  
>  # -- Options for manual page output ---------------------------------------
> -
> -# One entry per manual page. List of tuples
> -# (source start file, name, description, authors, manual section).
> -man_pages = [
> -    (master_doc, 'qemu', u'QEMU Documentation',
> -     [author], 1)
> -]
> -
> +# Individual manual/conf.py can override this to create man pages
> +man_pages = []
>  
>  # -- Options for Texinfo output -------------------------------------------
>  
> diff --git a/docs/interop/conf.py b/docs/interop/conf.py
> index cf3c69d4a7e..e87b8c22bec 100644
> --- a/docs/interop/conf.py
> +++ b/docs/interop/conf.py
> @@ -13,3 +13,10 @@ exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
>  # This slightly misuses the 'description', but is the best way to get
>  # the manual title to appear in the sidebar.
>  html_theme_options['description'] = u'System Emulation Management and Interoperability Guide'
> +
> +# One entry per manual page. List of tuples
> +# (source start file, name, description, authors, manual section).
> +man_pages = [
> +    ('qemu-ga', 'qemu-ga', u'QEMU Guest Agent',
> +     ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8)
> +]
> diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> index b4bfcab4171..3e33fb59332 100644
> --- a/docs/interop/index.rst
> +++ b/docs/interop/index.rst
> @@ -15,5 +15,6 @@ Contents:
>     bitmaps
>     live-block-operations
>     pr-helper
> +   qemu-ga
>     vhost-user
>     vhost-user-gpu
> diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
> new file mode 100644
> index 00000000000..1313a4ae1c9
> --- /dev/null
> +++ b/docs/interop/qemu-ga.rst
> @@ -0,0 +1,133 @@
> +QEMU Guest Agent
> +================
> +
> +Synopsis
> +--------
> +
> +**qemu-ga** [*OPTIONS*]
> +
> +Description
> +-----------
> +
> +The QEMU Guest Agent is a daemon intended to be run within virtual
> +machines. It allows the hypervisor host to perform various operations
> +in the guest, such as:
> +
> +- get information from the guest
> +- set the guest's system time
> +- read/write a file
> +- sync and freeze the filesystems
> +- suspend the guest
> +- reconfigure guest local processors
> +- set user's password
> +- ...
> +
> +qemu-ga will read a system configuration file on startup (located at
> +|CONFDIR|\ ``/qemu-ga.conf`` by default), then parse remaining
> +configuration options on the command line. For the same key, the last
> +option wins, but the lists accumulate (see below for configuration
> +file format).
> +
> +Options
> +-------
> +
> +.. program:: qemu-ga
> +
> +.. option:: -m, --method=METHOD
> +
> +  Transport method: one of ``unix-listen``, ``virtio-serial``, or
> +  ``isa-serial`` (``virtio-serial`` is the default).
> +
> +.. option:: -p, --path=PATH
> +
> +  Device/socket path (the default for virtio-serial is
> +  ``/dev/virtio-ports/org.qemu.guest_agent.0``,
> +  the default for isa-serial is ``/dev/ttyS0``)
> +
> +.. option:: -l, --logfile=PATH
> +
> +  Set log file path (default is stderr).
> +
> +.. option:: -f, --pidfile=PATH
> +
> +  Specify pid file (default is ``/var/run/qemu-ga.pid``).
> +
> +.. option:: -F, --fsfreeze-hook=PATH
> +
> +  Enable fsfreeze hook. Accepts an optional argument that specifies
> +  script to run on freeze/thaw. Script will be called with
> +  'freeze'/'thaw' arguments accordingly (default is
> +  |CONFDIR|\ ``/fsfreeze-hook``). If using -F with an argument, do
> +  not follow -F with a space (for example:
> +  ``-F/var/run/fsfreezehook.sh``).
> +
> +.. option:: -t, --statedir=PATH
> +
> +  Specify the directory to store state information (absolute paths only,
> +  default is ``/var/run``).
> +
> +.. option:: -v, --verbose
> +
> +  Log extra debugging information.
> +
> +.. option:: -V, --version
> +
> +  Print version information and exit.
> +
> +.. option:: -d, --daemon
> +
> +  Daemonize after startup (detach from terminal).
> +
> +.. option:: -b, --blacklist=LIST
> +
> +  Comma-separated list of RPCs to disable (no spaces, ``?`` to list
> +  available RPCs).
> +
> +.. option:: -D, --dump-conf
> +
> +  Dump the configuration in a format compatible with ``qemu-ga.conf``
> +  and exit.
> +
> +.. option:: -h, --help
> +
> +  Display this help and exit.
> +
> +Files
> +-----
> +
> +
> +The syntax of the ``qemu-ga.conf`` configuration file follows the
> +Desktop Entry Specification, here is a quick summary: it consists of
> +groups of key-value pairs, interspersed with comments.
> +
> +::
> +
> +    # qemu-ga configuration sample
> +    [general]
> +    daemonize = 0
> +    pidfile = /var/run/qemu-ga.pid
> +    verbose = 0
> +    method = virtio-serial
> +    path = /dev/virtio-ports/org.qemu.guest_agent.0
> +    statedir = /var/run
> +
> +The list of keys follows the command line options:
> +
> +=============  ===========
> +Key             Key type
> +=============  ===========
> +daemon         boolean
> +method         string
> +path           string
> +logfile        string
> +pidfile        string
> +fsfreeze-hook  string
> +statedir       string
> +verbose        boolean
> +blacklist      string list
> +=============  ===========
> +
> +See also
> +--------
> +
> +:manpage:`qemu(1)`
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 577d1e83764..fbdca1a992a 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2525,11 +2525,6 @@ so should only be used with trusted guest OS.
>  
>  @c man end
>  
> -@node QEMU Guest Agent
> -@chapter QEMU Guest Agent invocation
> -
> -@include qemu-ga.texi
> -
>  @node QEMU User space emulator
>  @chapter QEMU User space emulator
>  
> diff --git a/qemu-ga.texi b/qemu-ga.texi
> deleted file mode 100644
> index f00ad830f28..00000000000
> --- a/qemu-ga.texi
> +++ /dev/null
> @@ -1,137 +0,0 @@
> -@example
> -@c man begin SYNOPSIS
> -@command{qemu-ga} [@var{OPTIONS}]
> -@c man end
> -@end example
> -
> -@c man begin DESCRIPTION
> -
> -The QEMU Guest Agent is a daemon intended to be run within virtual
> -machines. It allows the hypervisor host to perform various operations
> -in the guest, such as:
> -
> -@itemize
> -@item
> -get information from the guest
> -@item
> -set the guest's system time
> -@item
> -read/write a file
> -@item
> -sync and freeze the filesystems
> -@item
> -suspend the guest
> -@item
> -reconfigure guest local processors
> -@item
> -set user's password
> -@item
> -...
> -@end itemize
> -
> -qemu-ga will read a system configuration file on startup (located at
> -@file{@value{CONFDIR}/qemu-ga.conf} by default), then parse remaining
> -configuration options on the command line. For the same key, the last
> -option wins, but the lists accumulate (see below for configuration
> -file format).
> -
> -@c man end
> -
> -@c man begin OPTIONS
> -@table @option
> -@item -m, --method=@var{method}
> -  Transport method: one of @samp{unix-listen}, @samp{virtio-serial}, or
> -  @samp{isa-serial} (@samp{virtio-serial} is the default).
> -
> -@item -p, --path=@var{path}
> -  Device/socket path (the default for virtio-serial is
> -  @samp{/dev/virtio-ports/org.qemu.guest_agent.0},
> -  the default for isa-serial is @samp{/dev/ttyS0})
> -
> -@item -l, --logfile=@var{path}
> -  Set log file path (default is stderr).
> -
> -@item -f, --pidfile=@var{path}
> -  Specify pid file (default is @samp{/var/run/qemu-ga.pid}).
> -
> -@item -F, --fsfreeze-hook=@var{path}
> -  Enable fsfreeze hook. Accepts an optional argument that specifies
> -  script to run on freeze/thaw. Script will be called with
> -  'freeze'/'thaw' arguments accordingly (default is
> -  @samp{@value{CONFDIR}/fsfreeze-hook}). If using -F with an argument, do
> -  not follow -F with a space (for example:
> -  @samp{-F/var/run/fsfreezehook.sh}).
> -
> -@item -t, --statedir=@var{path}
> -  Specify the directory to store state information (absolute paths only,
> -  default is @samp{/var/run}).
> -
> -@item -v, --verbose
> -  Log extra debugging information.
> -
> -@item -V, --version
> -  Print version information and exit.
> -
> -@item -d, --daemon
> -  Daemonize after startup (detach from terminal).
> -
> -@item -b, --blacklist=@var{list}
> -  Comma-separated list of RPCs to disable (no spaces, @samp{?} to list
> -  available RPCs).
> -
> -@item -D, --dump-conf
> -  Dump the configuration in a format compatible with @file{qemu-ga.conf}
> -  and exit.
> -
> -@item -h, --help
> -  Display this help and exit.
> -@end table
> -
> -@c man end
> -
> -@c man begin FILES
> -
> -The syntax of the @file{qemu-ga.conf} configuration file follows the
> -Desktop Entry Specification, here is a quick summary: it consists of
> -groups of key-value pairs, interspersed with comments.
> -
> -@example
> -# qemu-ga configuration sample
> -[general]
> -daemonize = 0
> -pidfile = /var/run/qemu-ga.pid
> -verbose = 0
> -method = virtio-serial
> -path = /dev/virtio-ports/org.qemu.guest_agent.0
> -statedir = /var/run
> -@end example
> -
> -The list of keys follows the command line options:
> -@table @option
> -@item daemon= boolean
> -@item method= string
> -@item path= string
> -@item logfile= string
> -@item pidfile= string
> -@item fsfreeze-hook= string
> -@item statedir= string
> -@item verbose= boolean
> -@item blacklist= string list
> -@end table
> -
> -@c man end
> -
> -@ignore
> -
> -@setfilename qemu-ga
> -@settitle QEMU Guest Agent
> -
> -@c man begin AUTHOR
> -Michael Roth <mdroth@linux.vnet.ibm.com>
> -@c man end
> -
> -@c man begin SEEALSO
> -qemu(1)
> -@c man end
> -
> -@end ignore
> -- 
> 2.20.1
> 
> 

This patch is breaking build for me. It fails on:

    perl -Ww -- /builddir/build/BUILD/qemu-4.1.0/scripts/texi2pod.pl -I docs -I scripts -I docs/interop -DVERSION="4.1.50" -DCONFDIR="/etc/qemu-kvm" scripts/texi2pod.pl docs/interop/qemu-ga.8.pod && pod2man --utf8 --section=8 --center=" " --release=" " docs/interop/qemu-ga.8.pod > docs/interop/qemu-ga.8

with:

   No filename or title

Not sure why this is happening.

Miroslav Rezanina

