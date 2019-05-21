Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40299C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02EED217D7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02EED217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56483 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT7Ty-0005wo-AX
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 12:19:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hT7Sj-0005Rv-NB
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hT7Sf-00043A-1l
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:17:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hT7SZ-0003v4-8i
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:17:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E40466988;
	Tue, 21 May 2019 16:17:31 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 694C658C96;
	Tue, 21 May 2019 16:17:26 +0000 (UTC)
Date: Tue, 21 May 2019 13:17:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190521161724.GI10764@habkost.net>
References: <20190520184108.GA10764@habkost.net>
	<20190521085350.GF25835@redhat.com>
	<e2395213-efaf-6d6c-6cfd-d949d071b4f6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e2395213-efaf-6d6c-6cfd-d949d071b4f6@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 21 May 2019 16:17:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Introducing GSoC project: API Documentation
 Generation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 12:55:36PM +0200, Paolo Bonzini wrote:
> On 21/05/19 10:53, Daniel P. Berrang=E9 wrote:
> > Hawkmoth seems pretty attractive in its output format, but doesn't ap=
pear
> > to be part of either Debian or Fedora distros, so we would have to bu=
ndle
> > it in QEMU I expect.  My big concern there is that there have only be=
en
> > 2 contributors to Hawkmoth in its entire 3 year existance, which make=
s
> > me fear for its long term viability if the main author gives up.
>=20
> On the plus side, I think the main author is among the people that
> pushed rST and Sphinx in the kernel, so it's plausible that in the
> future the kernel will pick Hawkmoth.  I agree that we should check wit=
h
> him about his plans.
>=20
> > QEMU should pick a tool which is well established / widely used & thu=
s
> > stands a good chance of being maintained for the long term, as we don=
't
> > want to end up relying on abandonware in 5 years time.  The kernel-do=
c
> > project is not widely used, but its main user is significant enough t=
hat
> > it isn't likely to die through lack of maintainers.
>=20
> A couple years ago I didn't have problems modifying kerneldoc for QEMU'=
s
> syntax, it was a 10 lines patch.  Unfortunately I cannot find it anymor=
e.

Do you mean the following patch?

----- Forwarded message from Paolo Bonzini <pbonzini@redhat.com> -----

Date: Thu, 5 Jan 2017 17:47:30 +0100
From: Paolo Bonzini <pbonzini@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel=
@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Qemu-devel] Sphinx for QEMU docs? (and a doc-comment format=
 question)



On 07/11/2016 16:03, Peter Maydell wrote:
> 2) some of the doc-comment format differences are irritating:
>    . "function - short description" not "function: short description"
>    . "&struct.fieldname" not ".@fieldname"
>    . "&typename" not "#typename"
> 3) the most awkward part of kernel-doc syntax is that it bakes
>    in the kernel's style choice of always using "struct foo"
>    for types -- I don't think there's any way to document
>    'MemoryRegion' and 'AddressSpace' without the 'struct'
>    coming out in the documentation output.
>=20
> We could fix (2) by loosening the kernel-doc script's
> parsing if we were happy to carry around a forked version
> of it. Fixing (3) requires more serious surgery on kernel-doc
> I suspect.

I've sent some changes to kernel-doc to simplify the implementation of
these changes (http://www.spinics.net/lists/linux-doc/msg42354.html) and
they were accepted.  So with 4.10 + those patches, the local changes to
kernel-doc for QEMU would be limited to the following:

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 4c9ada36fe6b..c43ac038398d 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -215,18 +215,18 @@ my $type_func =3D '(\w+)\(\)';
 my $type_param =3D '\@(\w+(\.\.\.)?)';
 my $type_fp_param =3D '\@(\w+)\(\)';  # Special RST handling for func pt=
r params
 my $type_env =3D '(\$\w+)';
-my $type_enum =3D '\&(enum\s*([_\w]+))';
-my $type_struct =3D '\&(struct\s*([_\w]+))';
-my $type_typedef =3D '\&(typedef\s*([_\w]+))';
-my $type_union =3D '\&(union\s*([_\w]+))';
-my $type_member =3D '\&([_\w]+)(\.|->)([_\w]+)';
-my $type_fallback =3D '\&([_\w]+)';
-my $type_enum_xml =3D '\&amp;(enum\s*([_\w]+))';
-my $type_struct_xml =3D '\&amp;(struct\s*([_\w]+))';
-my $type_typedef_xml =3D '\&amp;(typedef\s*([_\w]+))';
-my $type_union_xml =3D '\&amp;(union\s*([_\w]+))';
-my $type_member_xml =3D '\&amp;([_\w]+)(\.|-\&gt;)([_\w]+)';
-my $type_fallback_xml =3D '\&amp([_\w]+)';
+my $type_enum =3D '#(enum\s*([_\w]+))';
+my $type_struct =3D '#(struct\s*([_\w]+))';
+my $type_typedef =3D '#(([A-Z][_\w]*))';
+my $type_union =3D '#(union\s*([_\w]+))';
+my $type_member =3D '#([_\w]+)(\.|->)([_\w]+)';
+my $type_fallback =3D '(?!)';    # this never matches
+my $type_enum_xml =3D $type_enum;
+my $type_struct_xml =3D $type_struct;
+my $type_typedef_xml =3D $type_typedef;
+my $type_union_xml =3D $type_union;
+my $type_member_xml =3D $type_member;
+my $type_fallback_xml =3D $type_fallback;
 my $type_member_func =3D $type_member . '\(\)';
=20
 # Output conversion substitutions.
@@ -2143,6 +2143,14 @@ sub output_blockhead {
 sub dump_declaration($$) {
     no strict 'refs';
     my ($prototype, $file) =3D @_;
+    if ($decl_type eq 'type name') {
+	if ($prototype =3D~ /^(enum|struct|union)\s+/) {
+	    $decl_type =3D $1;
+        } else {
+	    return;
+	}
+    }
+
     my $func =3D "dump_" . $decl_type;
     &$func(@_);
 }
@@ -2893,7 +2901,7 @@ sub process_file($) {
 	    }
 	    elsif (/$doc_decl/o) {
 		$identifier =3D $1;
-		if (/\s*([\w\s]+?)\s*-/) {
+		if (/\s*([\w\s]+?)(\s*-|:)/) {
 		    $identifier =3D $1;
 		}
=20
@@ -2903,7 +2911,7 @@ sub process_file($) {
 		$contents =3D "";
 		$section =3D $section_default;
 		$new_start_line =3D $. + 1;
-		if (/-(.*)/) {
+		if (/[-:](.*)/) {
 		    # strip leading/trailing/multiple spaces
 		    $descr=3D $1;
 		    $descr =3D~ s/^\s*//;
@@ -2921,7 +2929,9 @@ sub process_file($) {
 			++$warnings;
 		}
=20
-		if ($identifier =3D~ m/^struct/) {
+		if ($identifier =3D~ m/^[A-Z]/) {
+		    $decl_type =3D 'type name';
+	        } elsif ($identifier =3D~ m/^struct/) {
 		    $decl_type =3D 'struct';
 		} elsif ($identifier =3D~ m/^union/) {
 		    $decl_type =3D 'union';

which should be maintainable as a fork of Linux's kernel-doc.

I also worked a bit on support for Texinfo manuals in Sphinx.  My
current attempt is at http://people.redhat.com/pbonzini/qemu-test-doc/_bu=
ild/.
Because this uses a Texinfo->Docbook->Sphinx pipeline, I also tried some
tools with native Docbook support (Publican), but despite Sphinx's quirks
the output was less usable, and the tools were slower and harder to use.

http://wiki.qemu-project.org/Features/Documentation is another place to
brainstorm ideas on this.

Paolo


----- End forwarded message -----

--=20
Eduardo

