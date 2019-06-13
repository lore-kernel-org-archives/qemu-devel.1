Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD4AC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7BD12082C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BD12082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43342 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbUFU-0002Q9-4U
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 14:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hbSxG-00068j-Fj
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hbSxE-0001iJ-Jh
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:52:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35868)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hbSxC-0001Rw-KW
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:52:00 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5DGgTq2081384
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 12:51:53 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t3rn6wa63-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 12:51:52 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Thu, 13 Jun 2019 17:51:52 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 13 Jun 2019 17:51:48 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5DGplXd30671326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jun 2019 16:51:47 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CF67BE053;
 Thu, 13 Jun 2019 16:51:47 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2872EBE051;
 Thu, 13 Jun 2019 16:51:47 +0000 (GMT)
Received: from localhost (unknown [9.80.81.20])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jun 2019 16:51:46 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Peter Maydell <peter.maydell@linaro.org>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAFEAcA97MUveG=si03B7_2WzDugtz7hR9x+YNQmU2xDiCF81eA@mail.gmail.com>
References: <20190610134545.3743-1-peter.maydell@linaro.org>
 <156043918624.3418.2275764093147880770@sif>
 <CAFEAcA97MUveG=si03B7_2WzDugtz7hR9x+YNQmU2xDiCF81eA@mail.gmail.com>
User-Agent: alot/0.7
Date: Thu, 13 Jun 2019 11:51:41 -0500
X-TM-AS-GCONF: 00
x-cbid: 19061316-0036-0000-0000-00000ACB79BA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011255; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01217453; UDB=6.00640208; IPR=6.00998565; 
 MB=3.00027296; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-13 16:51:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061316-0037-0000-0000-00004C36EF5B
Message-Id: <156044470155.3418.5487761086434554857@sif>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-13_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130122
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Peter Maydell (2019-06-13 10:29:33)
> On Thu, 13 Jun 2019 at 16:20, Michael Roth <mdroth@linux.vnet.ibm.com> wr=
ote:
> >
> > Quoting Peter Maydell (2019-06-10 08:45:45)
> > > The qemu-ga documentation is currently in qemu-ga.texi in
> > > Texinfo format, which we present to the user as:
> > >  * a qemu-ga manpage
> > >  * a section of the main qemu-doc HTML documentation
> > >
> > > Convert the documentation to rST format, and present it to
> > > the user as:
> > >  * a qemu-ga manpage
> > >  * part of the interop/ Sphinx manual
> > >
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> =

> > > +# Canned command to build manpages from a single manual
> > > +build-manpages =3D $(call quiet-command,CONFDIR=3D"$(qemu_confdir)" =
sphinx-build $(if $(V),,-q) -W -n -b man -D version=3D$(VERSION) -D release=
=3D"$(FULL_VERSION)" -d .doctrees/$1 $(SRC_PATH)/docs/$1
> $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
> =

> > > --- a/docs/conf.py
> > > +++ b/docs/conf.py
> > > @@ -115,6 +115,14 @@ todo_include_todos =3D False
> > >  # with "option::" in the document being processed. Turn that off.
> > >  suppress_warnings =3D ["ref.option"]
> > >
> > > +# The rst_epilog fragment is effectively included in every rST file.
> > > +# We use it to define substitutions based on build config that
> > > +# can then be used in the documentation. The fallback if the
> > > +# environment variable is not set is for the benefit of readthedocs
> > > +# style document building; our Makefile always sets the variable.
> > > +confdir =3D os.getenv('CONFDIR', "/usr/local/etc")
> > > +rst_epilog =3D ".. |CONFDIR| replace:: ``" + confdir + "``\n"
> > > +
> >
> > When testing this I have the following in my qemu build directory (via
> > ./configure --prefix=3D/home/mdroth/w/qemu-install2):
> >
> >   $ grep -r CONFDIR
> >   config-host.h-timestamp:#define CONFIG_QEMU_CONFDIR "/home/mdroth/w/q=
emu-install2/etc/qemu"
> >   qemu-doc.txt:     user-provided config files on SYSCONFDIR.
> >   config-host.h:#define CONFIG_QEMU_CONFDIR "/home/mdroth/w/qemu-instal=
l2/etc/qemu"
> >   docs/version.texi:@set CONFDIR /home/mdroth/w/qemu-install2/etc/qemu
> >
> > but the following input for the qemu-ga man page:
> >
> >   qemu-ga will read a system configuration file on startup (located at
> >   |CONFDIR|\ ``/qemu-ga.conf`` by default),
> >
> > ends up as this in the generated man page:
> >
> >   qemu-ga will read a system configuration file on startup (located at =
/usr/local/etc/qemu-ga.conf
> >   by  default),
> >
> > is this expected, or are we unexpectedly falling back to the default
> > value here?
> =

> No, if you're invoking Sphinx via the makefile then we should
> be passing CONFDIR=3D"$(qemu_confdir)" to set the environment
> variable when we invoke it. Can you try doing a build with V=3D1
> to check the sphinx command line ?

Here's the relevant output from make. The environment variable seems to
be defined as expected but I guess sphinx-build isn't picking it up for
some reason?

( echo "@set VERSION 4.0.50" && echo "@set CONFDIR /home/mdroth/w/qemu-inst=
all2/etc/qemu" )> docs/version.texi
sh /home/mdroth/w/qemu4.git/scripts/hxtool -t < /home/mdroth/w/qemu4.git/qe=
mu-options.hx > qemu-options.texi
sh /home/mdroth/w/qemu4.git/scripts/hxtool -t < /home/mdroth/w/qemu4.git/hm=
p-commands.hx > qemu-monitor.texi
sh /home/mdroth/w/qemu4.git/scripts/hxtool -t < /home/mdroth/w/qemu4.git/qe=
mu-img-cmds.hx > qemu-img-cmds.texi
sh /home/mdroth/w/qemu4.git/scripts/hxtool -t < /home/mdroth/w/qemu4.git/hm=
p-commands-info.hx > qemu-monitor-info.texi
LC_ALL=3DC makeinfo --no-split --number-sections -I docs -I /home/mdroth/w/=
qemu4.git -I . --no-headers --html /home/mdroth/w/qemu4.git/qemu-doc.texi -=
o qemu-doc.html
LC_ALL=3DC makeinfo --no-split --number-sections -I docs -I /home/mdroth/w/=
qemu4.git -I . --no-headers --plaintext /home/mdroth/w/qemu4.git/qemu-doc.t=
exi -o qemu-doc.txt
perl -Ww -- /home/mdroth/w/qemu4.git/scripts/texi2pod.pl -I docs -I /home/m=
droth/w/qemu4.git -I . -DVERSION=3D"4.0.50" -DCONFDIR=3D"/home/mdroth/w/qem=
u-install2/etc/qemu" /home/mdroth/w/qemu4.git/qemu-doc.texi qemu.1.pod && p=
od2man --utf8 --section=3D1 --center=3D" " --release=3D" " qemu.1.pod > qem=
u.1
perl -Ww -- /home/mdroth/w/qemu4.git/scripts/texi2pod.pl -I docs -I /home/m=
droth/w/qemu4.git -I . -DVERSION=3D"4.0.50" -DCONFDIR=3D"/home/mdroth/w/qem=
u-install2/etc/qemu" /home/mdroth/w/qemu4.git/qemu-img.texi qemu-img.1.pod =
&& pod2man --utf8 --section=3D1 --center=3D" " --release=3D" " qemu-img.1.p=
od > qemu-img.1
perl -Ww -- /home/mdroth/w/qemu4.git/scripts/texi2pod.pl -I docs -I /home/m=
droth/w/qemu4.git -I . -DVERSION=3D"4.0.50" -DCONFDIR=3D"/home/mdroth/w/qem=
u-install2/etc/qemu" /home/mdroth/w/qemu4.git/qemu-nbd.texi qemu-nbd.8.pod =
&& pod2man --utf8 --section=3D8 --center=3D" " --release=3D" " qemu-nbd.8.p=
od > qemu-nbd.8
CONFDIR=3D"/home/mdroth/w/qemu-install2/etc/qemu" sphinx-build  -W -n -b ma=
n -D version=3D4.0.50 -D release=3D"4.0.50 (v4.0.0-1240-g90b8a170d2-dirty)"=
 -d .doctrees/interop /home/mdroth/w/qemu4.git/docs/interop docs/interop
Running Sphinx v1.6.7
loading pickled environment... done
building [mo]: targets for 0 po files that are out of date
building [man]: all manpages
updating environment: [config changed] 7 added, 0 changed, 0 removed
reading sources... [ 14%] bitmaps
reading sources... [ 28%] index
reading sources... [ 42%] live-block-operations
reading sources... [ 57%] pr-helper
reading sources... [ 71%] qemu-ga
reading sources... [ 85%] vhost-user
reading sources... [100%] vhost-user-gpu

looking for now-outdated files... none found
pickling environment... done
checking consistency... done
writing... qemu-ga.8 { }
build succeeded.

> =

> I've just realized that I didn't also update the 'build-manual'
> macro to add the CONFDIR setting. Perhaps Sphinx ran first with
> the build-manual macro and has cached document contents created
> with that incorrect invocation and then reused them in the manpage
> creation? If so, this should be fixable by adding the CONFDIR=3D"$(qemu_c=
onfdir)"
> to the build-manual macro in the Makefile, and then deleting the .doctree=
s/
> directory from your build tree and rerunning make.

Sorry looks like it was an issue on my end actually...I guess I had a left-=
over
.doctrees from an earlier build (with no --prefix). I generally rm -rf * wi=
thin
build directory instead of 'make clean', but that was still leaving around a
stale .doctrees. Once I deleted that I could no longer reproduce (neither
with/without the additional CONFDIR setting).

> =

> > Sphinx seems to do a better job of formatting "Key" and "Key type" into
> > actual table columns in the generated man/html pages (rather than just
> > separating them with whitespace), so I think we can drop the trailing '=
=3D's
> =

> Sure; I'll change this in v2.
> =

> thanks
> -- PMM
>=20


