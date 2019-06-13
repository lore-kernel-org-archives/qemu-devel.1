Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B0AC31E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7015D2147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7015D2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41296 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbSNj-0006cK-J2
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 12:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55759)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hbRXg-0005BW-EC
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hbRXe-0005zC-CM
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:21:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53448
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hbRXe-0005vf-67
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:21:30 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5DFLLuA187670
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 11:21:22 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2t3qc1n3kn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 11:20:04 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Thu, 13 Jun 2019 16:20:04 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 13 Jun 2019 16:20:01 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5DFK0Gs12714244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jun 2019 15:20:00 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99FE5BE053;
 Thu, 13 Jun 2019 15:20:00 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51747BE051;
 Thu, 13 Jun 2019 15:20:00 +0000 (GMT)
Received: from localhost (unknown [9.80.81.20])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jun 2019 15:20:00 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190610134545.3743-1-peter.maydell@linaro.org>
References: <20190610134545.3743-1-peter.maydell@linaro.org>
User-Agent: alot/0.7
Date: Thu, 13 Jun 2019 10:19:46 -0500
X-TM-AS-GCONF: 00
x-cbid: 19061315-0012-0000-0000-00001743F6C1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011255; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01217423; UDB=6.00640190; IPR=6.00998534; 
 MB=3.00027295; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-13 15:20:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061315-0013-0000-0000-000057AEB110
Message-Id: <156043918624.3418.2275764093147880770@sif>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-13_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130114
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: Convert invocation documentation
 to rST
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

Quoting Peter Maydell (2019-06-10 08:45:45)
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
> ---
> This is part of my general proposals about how we should
> transition away from texinfo to sphinx (written up at
> https://wiki.qemu.org/Features/Documentation). It's the
> first part of step 3 (convert standalone manpages), so it's
> interesting as a demonstration of Sphinx generating manpages
> as well as HTML. The format of the output manpage is broadly
> the same, though there are a few minor differences because
> rST doesn't support quite the same kinds of output. (It also
> fixes a bug where the current manpage renders some text intended
> to be in bold as literally "B<unix-listen>".)
> =

> Having the infrastructure for creating a simple manpage via
> Sphinx should be a useful assist for the work in step 1 of the
> transition plan that involves conversion of the auto-generated
> qemu-ga-ref and qemu-qmp-ref (which need to produce manpages).
> =

> The non-manpage HTML version of the doc moves from qemu-doc.html
> into docs/interop/ (its final location in the new 5-manual setup).
> =

>  Makefile                 |  13 ++--
>  MAINTAINERS              |   2 +-
>  docs/conf.py             |  18 ++---
>  docs/interop/conf.py     |   7 ++
>  docs/interop/index.rst   |   1 +
>  docs/interop/qemu-ga.rst | 133 +++++++++++++++++++++++++++++++++++++
>  qemu-doc.texi            |   5 --
>  qemu-ga.texi             | 137 ---------------------------------------
>  8 files changed, 161 insertions(+), 155 deletions(-)
>  create mode 100644 docs/interop/qemu-ga.rst
>  delete mode 100644 qemu-ga.texi
> =

> diff --git a/Makefile b/Makefile
> index 8e2fc6624c3..cdada210746 100644
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
> @@ -804,7 +804,7 @@ ifdef CONFIG_TRACE_SYSTEMTAP
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
> @@ -969,12 +969,18 @@ build-manual =3D $(call quiet-command,sphinx-build =
$(if $(V),,-q) -W -n -b html -D
>  # We assume all RST files in the manual's directory are used in it
>  manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$=
1/conf.py $(SRC_PATH)/docs/conf.py
> =

> +# Canned command to build manpages from a single manual
> +build-manpages =3D $(call quiet-command,CONFDIR=3D"$(qemu_confdir)" sphi=
nx-build $(if $(V),,-q) -W -n -b man -D version=3D$(VERSION) -D release=3D"=
$(FULL_VERSION)" -d .doctrees/$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 =
,"SPHINX","$(MANUAL_BUILDDIR)/$1")
> +
>  $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
>         $(call build-manual,devel)
> =

>  $(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
>         $(call build-manual,interop)
> =

> +$(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
> +       $(call build-manpages,interop)
> +
>  qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
>         $(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"=
GEN","$@")
> =

> @@ -998,7 +1004,6 @@ qemu.1: qemu-option-trace.texi
>  qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
>  fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
>  qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
> -qemu-ga.8: qemu-ga.texi
>  docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
>  docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
>  scripts/qemu-trace-stap.1: scripts/qemu-trace-stap.texi
> @@ -1010,7 +1015,7 @@ txt: qemu-doc.txt docs/interop/qemu-qmp-ref.txt doc=
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
> index a96829ea83a..27a6ffa7431 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2024,7 +2024,7 @@ QEMU Guest Agent
>  M: Michael Roth <mdroth@linux.vnet.ibm.com>
>  S: Maintained
>  F: qga/
> -F: qemu-ga.texi
> +F: docs/interop/qemu-ga.rst
>  F: scripts/qemu-guest-agent/
>  F: tests/test-qga.c
>  F: docs/interop/qemu-ga-ref.texi
> diff --git a/docs/conf.py b/docs/conf.py
> index befbcc6c3e1..d34a94838ca 100644
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
> +confdir =3D os.getenv('CONFDIR', "/usr/local/etc")
> +rst_epilog =3D ".. |CONFDIR| replace:: ``" + confdir + "``\n"
> +

When testing this I have the following in my qemu build directory (via
./configure --prefix=3D/home/mdroth/w/qemu-install2):

  $ grep -r CONFDIR
  config-host.h-timestamp:#define CONFIG_QEMU_CONFDIR "/home/mdroth/w/qemu-=
install2/etc/qemu"
  qemu-doc.txt:     user-provided config files on SYSCONFDIR.
  config-host.h:#define CONFIG_QEMU_CONFDIR "/home/mdroth/w/qemu-install2/e=
tc/qemu"
  docs/version.texi:@set CONFDIR /home/mdroth/w/qemu-install2/etc/qemu

but the following input for the qemu-ga man page:

  qemu-ga will read a system configuration file on startup (located at
  |CONFDIR|\ ``/qemu-ga.conf`` by default),

ends up as this in the generated man page:

  qemu-ga will read a system configuration file on startup (located at /usr=
/local/etc/qemu-ga.conf
  by  default),

is this expected, or are we unexpectedly falling back to the default
value here?


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
> index 00000000000..56e17f27fca
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

<snip>

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
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +Key             Key type
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +daemon=3D         boolean
> +method=3D         string
> +path=3D           string
> +logfile=3D        string
> +pidfile=3D        string
> +fsfreeze-hook=3D  string
> +statedir=3D       string
> +verbose=3D        boolean
> +blacklist=3D      string list
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

Sphinx seems to do a better job of formatting "Key" and "Key type" into
actual table columns in the generated man/html pages (rather than just
separating them with whitespace), so I think we can drop the trailing '=3D's

Looks good otherwise (and much nicer!)


