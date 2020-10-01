Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D52C4363D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 01:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320AE20738
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 01:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320AE20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNnRJ-00077q-7K
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 21:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.streetman@canonical.com>)
 id 1kNnPd-00066G-Mn
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 21:29:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <dan.streetman@canonical.com>)
 id 1kNnPb-0008SC-Ec
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 21:29:37 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <dan.streetman@canonical.com>) id 1kNnPY-0001i9-1p
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 01:29:32 +0000
Received: by mail-io1-f72.google.com with SMTP id a2so2072621iod.13
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 18:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/x3ZdjEv+f9t2cD6aFs4r3roR7tGB/U3hOitoeLCypU=;
 b=KriJCX/H/BqWgE6kPxnUHk/54mtFjBQYoyCIqJlLrRek3ejori/JSjx1k4DaWr0wB5
 sGt8YDhN7giR8DuYLU7S1RlBCka4I3b8z7pT3FYP0bGYDIFsjRUkMYqlN3TpfG54Nqzh
 H+02wbJbqRnNkzQJyzspG1C70ggnkedXjl628Fl8nG7t35/v++O74nN8zrk/wm5RxWPf
 YR/voYx0HdtQFdSgajKXojypMCX4tgHp7kLk48VKiwWMMvcEndWLRCb4MawrIhNP1tZA
 4nCYYlygoaFA0v4FMhHMq1yYD4aFMwgLTETlGl98wWft5ixlIKYLPbQFwxhKXqsYsbVt
 87PQ==
X-Gm-Message-State: AOAM530c4OT4YBHMBXl6SNCZUSvIsH6Z4f90j4ixvt+hFUC8m/bZdeA3
 y9HAJHZoIRn2kI44EelnXfwktowt3vikFSxi0V5E4/HQQcLTQs7Zb/zH25QvciVohSKI88ypDRI
 IyNJ3YnSPQWMptRUEcFSCCqTu5urZcVEJ/Nczdat4kfI3gsTF
X-Received: by 2002:a02:6623:: with SMTP id k35mr4236308jac.105.1601515770740; 
 Wed, 30 Sep 2020 18:29:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfUh+LM+b0X4MaArXeF6Sgn5R+8lq1cxLbXD+CNcevOeClvYeHfWSJ7+x5wb2y1OQqRHzakXX46Yi2DmAJmTQ=
X-Received: by 2002:a02:6623:: with SMTP id k35mr4236284jac.105.1601515770310; 
 Wed, 30 Sep 2020 18:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <e55fea6e-e403-166f-e693-9e73ae29e5cc@msgid.tls.msk.ru>
 <20200729195829.1335082-1-ddstreet@canonical.com>
 <20200922163441.GA2049853@redhat.com>
In-Reply-To: <20200922163441.GA2049853@redhat.com>
From: Dan Streetman <ddstreet@canonical.com>
Date: Wed, 30 Sep 2020 21:28:54 -0400
Message-ID: <CAOZ2QJPsSTH4MStgduBGjhvaH-5-Tgj7-++qYLbSmQnqWQPpug@mail.gmail.com>
Subject: Re: [PATCH] configure: actually disable 'git_update' mode with
 --disable-git-update
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=dan.streetman@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 21:29:32
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 12:34 PM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>
> On Wed, Jul 29, 2020 at 03:58:29PM -0400, Dan Streetman wrote:
> > The --disable-git-update configure param sets git_update=3Dno, but
> > some later checks only look for the .git dir. This changes the
> > --enable-git-update to set git_update=3Dyes but also fail if it
> > does not find a .git dir. Then all the later checks for the .git
> > dir can just be changed to a check for $git_update =3D "yes".
> >
> > Also update the Makefile to skip the 'git_update' checks if it has
> > been disabled.
> >
> > This is needed because downstream packagers, e.g. Debian, Ubuntu, etc,
> > also keep the source code in git, but do not want to enable the
> > 'git_update' mode; with the current code, that's not possible even
> > if the downstream package specifies --disable-git-update.
>
> Lets recap the original intended behaviour
>
>  1. User building from master qemu.git or a fork
>      a) git_update=3Dyes (default)
>          - Always sync submodules to required commit
>
>      b) git_update=3Dno  (--disable-git-update)
>          - Never sync submodules, user is responsible for sync
>          - Validate submodules are at correct commit and fail if not.
>
>  2. User building from tarball
>      - Never do anything git related at all
>
>
> Your change is removing the validation from  1.b).

Would you accept adding a --disable-git-submodules-check so downstream
packagers can keep the source in git, but avoid the submodule
validation?
Or do you have another suggestion for handling this?

Michael, Christian, do you have any suggestions or preference for how
this should be handled in Debian and Ubuntu?

> This is not desirable
> in general, because if a user has done a git pull and failed to sync the
> submodules, they are liable to get obscure, hard to diagnose errors later
> in the build process. This puts a burden on the user and maintainers who
> have to waste time diagnosing such problems.

Yep, this problem causes the same obscure, hard to diagnose errors
later in the build with downstream packages, but only if the .git dir
is present, because the build process is subtly changed in that case.

>
>
>
> > Signed-off-by: Dan Streetman <ddstreet@canonical.com>
> > ---
> > Note this is a rebased resend of a previous email to qemu-trivial:
> > https://lists.nongnu.org/archive/html/qemu-trivial/2020-07/msg00180.htm=
l
>
> NB, I'm removing qemu-trivial, because I don't think this patch
> qualifies as trivial.
>
>
> >
> >  Makefile  | 15 +++++++++------
> >  configure | 21 +++++++++++++--------
> >  2 files changed, 22 insertions(+), 14 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index c2120d8d48..42550ae086 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -25,6 +25,8 @@ git-submodule-update:
> >
> >  .PHONY: git-submodule-update
> >
> > +# If --disable-git-update specified, skip these git checks
> > +ifneq (no,$(GIT_UPDATE))
> >  git_module_status :=3D $(shell \
> >    cd '$(SRC_PATH)' && \
> >    GIT=3D"$(GIT)" ./scripts/git-submodule.sh status $(GIT_SUBMODULES); =
\
> > @@ -32,7 +34,12 @@ git_module_status :=3D $(shell \
> >  )
> >
> >  ifeq (1,$(git_module_status))
> > -ifeq (no,$(GIT_UPDATE))
> > +ifeq (yes,$(GIT_UPDATE))
> > +git-submodule-update:
> > +     $(call quiet-command, \
> > +          (cd $(SRC_PATH) && GIT=3D"$(GIT)" ./scripts/git-submodule.sh=
 update $(GIT_SUBMODULES)), \
> > +          "GIT","$(GIT_SUBMODULES)")
> > +else
> >  git-submodule-update:
> >       $(call quiet-command, \
> >              echo && \
> > @@ -41,11 +48,7 @@ git-submodule-update:
> >              echo "from the source directory checkout $(SRC_PATH)" && \
> >              echo && \
> >              exit 1)
> > -else
> > -git-submodule-update:
> > -     $(call quiet-command, \
> > -          (cd $(SRC_PATH) && GIT=3D"$(GIT)" ./scripts/git-submodule.sh=
 update $(GIT_SUBMODULES)), \
> > -          "GIT","$(GIT_SUBMODULES)")
> > +endif
> >  endif
> >  endif
> >
> > diff --git a/configure b/configure
> > index 2acc4d1465..e7a241e971 100755
> > --- a/configure
> > +++ b/configure
> > @@ -318,7 +318,7 @@ then
> >      git_submodules=3D"$git_submodules tests/fp/berkeley-testfloat-3"
> >      git_submodules=3D"$git_submodules tests/fp/berkeley-softfloat-3"
> >  else
> > -    git_update=3Dno
> > +    git_update=3D""
> >      git_submodules=3D""
> >
> >      if ! test -f "$source_path/ui/keycodemapdb/README"
> > @@ -1598,7 +1598,12 @@ for opt do
> >    ;;
> >    --with-git=3D*) git=3D"$optarg"
> >    ;;
> > -  --enable-git-update) git_update=3Dyes
> > +  --enable-git-update)
> > +      git_update=3Dyes
> > +      if test ! -e "$source_path/.git"; then
> > +          echo "ERROR: cannot --enable-git-update without .git"
> > +          exit 1
> > +      fi
> >    ;;
> >    --disable-git-update) git_update=3Dno
> >    ;;
> > @@ -2011,7 +2016,7 @@ fi
> >  # Consult white-list to determine whether to enable werror
> >  # by default.  Only enable by default for git builds
> >  if test -z "$werror" ; then
> > -    if test -e "$source_path/.git" && \
> > +    if test "$git_update" =3D "yes" && \
> >          { test "$linux" =3D "yes" || test "$mingw32" =3D "yes"; }; the=
n
> >          werror=3D"yes"
> >      else
> > @@ -4412,10 +4417,10 @@ EOF
> >      fdt=3Dsystem
> >    else
> >        # have GIT checkout, so activate dtc submodule
> > -      if test -e "${source_path}/.git" ; then
> > +      if test "$git_update" =3D "yes" ; then
> >            git_submodules=3D"${git_submodules} dtc"
> >        fi
> > -      if test -d "${source_path}/dtc/libfdt" || test -e "${source_path=
}/.git" ; then
> > +      if test -d "${source_path}/dtc/libfdt" || test "$git_update" =3D=
 "yes" ; then
> >            fdt=3Dgit
> >            mkdir -p dtc
> >            if [ "$pwd_is_source_path" !=3D "y" ] ; then
> > @@ -5385,7 +5390,7 @@ case "$capstone" in
> >    "" | yes)
> >      if $pkg_config capstone; then
> >        capstone=3Dsystem
> > -    elif test -e "${source_path}/.git" && test $git_update =3D 'yes' ;=
 then
> > +    elif test "$git_update" =3D "yes" ; then
> >        capstone=3Dgit
> >      elif test -e "${source_path}/capstone/Makefile" ; then
> >        capstone=3Dinternal
> > @@ -6414,7 +6419,7 @@ case "$slirp" in
> >    "" | yes)
> >      if $pkg_config slirp; then
> >        slirp=3Dsystem
> > -    elif test -e "${source_path}/.git" && test $git_update =3D 'yes' ;=
 then
> > +    elif test "$git_update" =3D "yes" ; then
> >        slirp=3Dgit
> >      elif test -e "${source_path}/slirp/Makefile" ; then
> >        slirp=3Dinternal
> > @@ -6776,7 +6781,7 @@ if test "$cpu" =3D "s390x" ; then
> >      roms=3D"$roms s390-ccw"
> >      # SLOF is required for building the s390-ccw firmware on s390x,
> >      # since it is using the libnet code from SLOF for network booting.
> > -    if test -e "${source_path}/.git" ; then
> > +    if test "$git_update" =3D "yes" ; then
> >        git_submodules=3D"${git_submodules} roms/SLOF"
> >      fi
> >    fi
> > --
> > 2.25.1
> >
> >
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

