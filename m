Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C6BC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 18:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB732166E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 18:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB732166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40946 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdevV-0003Qj-SM
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 14:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56435)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hdeu4-0002wM-FJ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 14:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hdeu1-0001AX-Kd
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 14:01:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8810
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hdetu-000147-JA
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 14:01:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5JHv4cQ100344; Wed, 19 Jun 2019 14:01:29 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2t7r2p5ns1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jun 2019 14:01:29 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5JHt8hu031325;
 Wed, 19 Jun 2019 18:01:28 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma01dal.us.ibm.com with ESMTP id 2t75r0xk9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jun 2019 18:01:28 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5JI1Qsw32506186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 18:01:26 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C2F013605E;
 Wed, 19 Jun 2019 18:01:25 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A413136053;
 Wed, 19 Jun 2019 18:01:25 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 19 Jun 2019 18:01:25 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190618104718.25433-1-peter.maydell@linaro.org>
References: <20190618104718.25433-1-peter.maydell@linaro.org>
Message-ID: <156096727672.4631.8497777036264668688@sif>
User-Agent: alot/0.7
Date: Wed, 19 Jun 2019 13:01:16 -0500
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-19_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906190146
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v2] qemu-ga: Convert invocation
 documentation to rST
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Peter Maydell (2019-06-18 05:47:18)
> The qemu-ga documentation is currently in qemu-ga.texi in
> Texinfo format, which we present to the user as:
>  * a qemu-ga manpage
>  * a section of the main qemu-doc HTML documentation
> =

> Convert the documentation to rST format, and present it to
> the user as:
>  * a qemu-ga manpage
>  * part of the interop/ Sphinx manual
> =

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Assuming you're planning to pull this into your overall conversion, but let
me know if you want it to go through my tree.

> ---
> v1->v2:
>  * filter out built manpages when installing the HTML manual
>  * default to /etc/qemu as the CONFDIR
>  * rather than duplicating the whole sphinx command line in
>    two macros, make the existing build-manual macro take an
>    extra argument to specify html or manpage creation. This
>    ensures we invoke the same way both times, which is important
>    since sphinx might cache parts of the config in .doctrees
>  * drop trailing '=3D' from 'key' column in table
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
> =

> diff --git a/Makefile b/Makefile
> index cfb18f15254..41c84890795 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -329,7 +329,7 @@ endif
>  endif
> =

>  ifdef BUILD_DOCS
> -DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
> +DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 docs/inte=
rop/qemu-ga.8
>  DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt doc=
s/interop/qemu-qmp-ref.7
>  DOCS+=3Ddocs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/=
interop/qemu-ga-ref.7
>  DOCS+=3Ddocs/qemu-block-drivers.7
> @@ -771,10 +771,11 @@ DESCS=3D
>  endif
> =

>  # Note that we manually filter-out the non-Sphinx documentation which
> -# is currently built into the docs/interop directory in the build tree.
> +# is currently built into the docs/interop directory in the build tree,
> +# and also any sphinx-built manpages.
>  define install-manual =3D
>  for d in $$(cd $(MANUAL_BUILDDIR) && find $1 -type d); do $(INSTALL_DIR)=
 "$(DESTDIR)$(qemu_docdir)/$$d"; done
> -for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' '(' -name 'q=
emu-*-qapi.*' -o -name 'qemu-*-ref.*' ')' ); do $(INSTALL_DATA) "$(MANUAL_B=
UILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
> +for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' '(' -name '*=
.[0-9]' -o -name 'qemu-*-qapi.*' -o -name 'qemu-*-ref.*' ')' ); do $(INSTAL=
L_DATA) "$(MANUAL_BUILDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
>  endef
> =

>  # Note that we deliberately do not install the "devel" manual: it is
> @@ -806,7 +807,7 @@ ifdef CONFIG_TRACE_SYSTEMTAP
>         $(INSTALL_DATA) scripts/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/ma=
n1"
>  endif
>  ifneq (,$(findstring qemu-ga,$(TOOLS)))
> -       $(INSTALL_DATA) qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
> +       $(INSTALL_DATA) docs/interop/qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
>         $(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_d=
ocdir)"
>         $(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_do=
cdir)"
>         $(INSTALL_DATA) docs/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/m=
an7"
> @@ -967,18 +968,22 @@ docs/version.texi: $(SRC_PATH)/VERSION config-host.=
mak
>  sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/inter=
op/index.html $(MANUAL_BUILDDIR)/specs/index.html
> =

>  # Canned command to build a single manual
> -build-manual =3D $(call quiet-command,sphinx-build $(if $(V),,-q) -W -n =
-b html -D version=3D$(VERSION) -D release=3D"$(FULL_VERSION)" -d .doctrees=
/$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)=
/$1")
> +# Arguments: $1 =3D manual name, $2 =3D Sphinx builder ('html' or 'man')
> +build-manual =3D $(call quiet-command,CONFDIR=3D"$(qemu_confdir)" sphinx=
-build $(if $(V),,-q) -W -n -b $2 -D version=3D$(VERSION) -D release=3D"$(F=
ULL_VERSION)" -d .doctrees/$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"S=
PHINX","$(MANUAL_BUILDDIR)/$1")
>  # We assume all RST files in the manual's directory are used in it
>  manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$=
1/conf.py $(SRC_PATH)/docs/conf.py
> =

>  $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
> -       $(call build-manual,devel)
> +       $(call build-manual,devel,html)
> =

>  $(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
> -       $(call build-manual,interop)
> +       $(call build-manual,interop,html)
> =

>  $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
> -       $(call build-manual,specs)
> +       $(call build-manual,specs,html)
> +
> +$(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
> +       $(call build-manual,interop,man)
> =

>  qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
>         $(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"=
GEN","$@")
> @@ -1003,7 +1008,6 @@ qemu.1: qemu-option-trace.texi
>  qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
>  fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
>  qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
> -qemu-ga.8: qemu-ga.texi
>  docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
>  docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
>  scripts/qemu-trace-stap.1: scripts/qemu-trace-stap.texi
> @@ -1015,7 +1019,7 @@ txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt doc=
s/interop/qemu-ga-ref.txt
> =

>  qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt: \
>         qemu-img.texi qemu-nbd.texi qemu-options.texi qemu-option-trace.t=
exi \
> -       qemu-deprecated.texi qemu-monitor.texi qemu-img-cmds.texi qemu-ga=
.texi \
> +       qemu-deprecated.texi qemu-monitor.texi qemu-img-cmds.texi \
>         qemu-monitor-info.texi docs/qemu-block-drivers.texi \
>         docs/qemu-cpu-models.texi docs/security.texi
> =

> diff --git a/MAINTAINERS b/MAINTAINERS
> index acbad134ecb..c93ae2b17a7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2019,7 +2019,7 @@ QEMU Guest Agent
>  M: Michael Roth <mdroth@linux.vnet.ibm.com>
>  S: Maintained
>  F: qga/
> -F: qemu-ga.texi
> +F: docs/interop/qemu-ga.rst
>  F: scripts/qemu-guest-agent/
>  F: tests/test-qga.c
>  F: docs/interop/qemu-ga-ref.texi
> diff --git a/docs/conf.py b/docs/conf.py
> index befbcc6c3e1..4a960b25b3e 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -115,6 +115,14 @@ todo_include_todos =3D False
>  # with "option::" in the document being processed. Turn that off.
>  suppress_warnings =3D ["ref.option"]
> =

> +# The rst_epilog fragment is effectively included in every rST file.
> +# We use it to define substitutions based on build config that
> +# can then be used in the documentation. The fallback if the
> +# environment variable is not set is for the benefit of readthedocs
> +# style document building; our Makefile always sets the variable.
> +confdir =3D os.getenv('CONFDIR', "/etc/qemu")
> +rst_epilog =3D ".. |CONFDIR| replace:: ``" + confdir + "``\n"
> +
>  # -- Options for HTML output -------------------------------------------=
---
> =

>  # The theme to use for HTML and HTML Help pages.  See the documentation =
for
> @@ -192,14 +200,8 @@ latex_documents =3D [
> =

> =

>  # -- Options for manual page output ------------------------------------=
---
> -
> -# One entry per manual page. List of tuples
> -# (source start file, name, description, authors, manual section).
> -man_pages =3D [
> -    (master_doc, 'qemu', u'QEMU Documentation',
> -     [author], 1)
> -]
> -
> +# Individual manual/conf.py can override this to create man pages
> +man_pages =3D []
> =

>  # -- Options for Texinfo output ----------------------------------------=
---
> =

> diff --git a/docs/interop/conf.py b/docs/interop/conf.py
> index cf3c69d4a7e..e87b8c22bec 100644
> --- a/docs/interop/conf.py
> +++ b/docs/interop/conf.py
> @@ -13,3 +13,10 @@ exec(compile(open(parent_config, "rb").read(), parent_=
config, 'exec'))
>  # This slightly misuses the 'description', but is the best way to get
>  # the manual title to appear in the sidebar.
>  html_theme_options['description'] =3D u'System Emulation Management and =
Interoperability Guide'
> +
> +# One entry per manual page. List of tuples
> +# (source start file, name, description, authors, manual section).
> +man_pages =3D [
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
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> +.. option:: -m, --method=3DMETHOD
> +
> +  Transport method: one of ``unix-listen``, ``virtio-serial``, or
> +  ``isa-serial`` (``virtio-serial`` is the default).
> +
> +.. option:: -p, --path=3DPATH
> +
> +  Device/socket path (the default for virtio-serial is
> +  ``/dev/virtio-ports/org.qemu.guest_agent.0``,
> +  the default for isa-serial is ``/dev/ttyS0``)
> +
> +.. option:: -l, --logfile=3DPATH
> +
> +  Set log file path (default is stderr).
> +
> +.. option:: -f, --pidfile=3DPATH
> +
> +  Specify pid file (default is ``/var/run/qemu-ga.pid``).
> +
> +.. option:: -F, --fsfreeze-hook=3DPATH
> +
> +  Enable fsfreeze hook. Accepts an optional argument that specifies
> +  script to run on freeze/thaw. Script will be called with
> +  'freeze'/'thaw' arguments accordingly (default is
> +  |CONFDIR|\ ``/fsfreeze-hook``). If using -F with an argument, do
> +  not follow -F with a space (for example:
> +  ``-F/var/run/fsfreezehook.sh``).
> +
> +.. option:: -t, --statedir=3DPATH
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
> +.. option:: -b, --blacklist=3DLIST
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
> +    daemonize =3D 0
> +    pidfile =3D /var/run/qemu-ga.pid
> +    verbose =3D 0
> +    method =3D virtio-serial
> +    path =3D /dev/virtio-ports/org.qemu.guest_agent.0
> +    statedir =3D /var/run
> +
> +The list of keys follows the command line options:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +Key             Key type
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +daemon         boolean
> +method         string
> +path           string
> +logfile        string
> +pidfile        string
> +fsfreeze-hook  string
> +statedir       string
> +verbose        boolean
> +blacklist      string list
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
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
> =

>  @c man end
> =

> -@node QEMU Guest Agent
> -@chapter QEMU Guest Agent invocation
> -
> -@include qemu-ga.texi
> -
>  @node QEMU User space emulator
>  @chapter QEMU User space emulator
> =

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
> -@item -m, --method=3D@var{method}
> -  Transport method: one of @samp{unix-listen}, @samp{virtio-serial}, or
> -  @samp{isa-serial} (@samp{virtio-serial} is the default).
> -
> -@item -p, --path=3D@var{path}
> -  Device/socket path (the default for virtio-serial is
> -  @samp{/dev/virtio-ports/org.qemu.guest_agent.0},
> -  the default for isa-serial is @samp{/dev/ttyS0})
> -
> -@item -l, --logfile=3D@var{path}
> -  Set log file path (default is stderr).
> -
> -@item -f, --pidfile=3D@var{path}
> -  Specify pid file (default is @samp{/var/run/qemu-ga.pid}).
> -
> -@item -F, --fsfreeze-hook=3D@var{path}
> -  Enable fsfreeze hook. Accepts an optional argument that specifies
> -  script to run on freeze/thaw. Script will be called with
> -  'freeze'/'thaw' arguments accordingly (default is
> -  @samp{@value{CONFDIR}/fsfreeze-hook}). If using -F with an argument, do
> -  not follow -F with a space (for example:
> -  @samp{-F/var/run/fsfreezehook.sh}).
> -
> -@item -t, --statedir=3D@var{path}
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
> -@item -b, --blacklist=3D@var{list}
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
> -daemonize =3D 0
> -pidfile =3D /var/run/qemu-ga.pid
> -verbose =3D 0
> -method =3D virtio-serial
> -path =3D /dev/virtio-ports/org.qemu.guest_agent.0
> -statedir =3D /var/run
> -@end example
> -
> -The list of keys follows the command line options:
> -@table @option
> -@item daemon=3D boolean
> -@item method=3D string
> -@item path=3D string
> -@item logfile=3D string
> -@item pidfile=3D string
> -@item fsfreeze-hook=3D string
> -@item statedir=3D string
> -@item verbose=3D boolean
> -@item blacklist=3D string list
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
> -- =

> 2.20.1
>=20

