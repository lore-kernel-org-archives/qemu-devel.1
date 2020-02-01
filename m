Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9833FC33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 16:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B27D205F4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 16:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B27D205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixvEI-000122-KQ
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 11:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixvDb-0000Y7-RV
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 11:02:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixvDa-0006Cg-3z
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 11:01:59 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39096)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixvDZ-0006BA-VN; Sat, 01 Feb 2020 11:01:58 -0500
Received: by mail-yw1-f65.google.com with SMTP id h126so8186485ywc.6;
 Sat, 01 Feb 2020 08:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RUhkBX5ugvtgVEtwfFT3sOmjFQyA3qnVa2rfRvw9MpU=;
 b=ioQQdZXqaIa3eGJMOtRnfFl6avAPA1mAfToUQt+CVSL9jpt3man9yw0v2iMakJDmPw
 s//Lgt/MKEF983byxDMcSkF3ZFY8CbzhOtMvOi7hrbuQIBKaysLzbFpf4C6MUza7l/gG
 96f9Sh+bZnOpbM/X3MtDWMnLNI0aNW+wfpykKEmezEnEHCeC7iGHJoBPOswnuknwlXJk
 xoJIYsclcpoG/dl1BsY6golChY2dcJmNFlOkBJUwh9Z3rVbY8F5fLezp6WcucW0WHLtd
 v7BVThY9SUKrEJFuH+uKzRlutR/h8kn83YRrXKWj0ia0FFW7B5602t9hCQDBLtuzKpti
 0/ig==
X-Gm-Message-State: APjAAAUQfAqRtO1lyeZD7ov3f90KepyYUp1MptGe931kRQpimioq/Dn8
 dhDyUfdR56W1q1w6BteFaVIBPdsJDILdqWmleZ4=
X-Google-Smtp-Source: APXvYqw33MKxszIP5RTyPm49ZZ4Gbed52UtTWx0qnXg59c8jOSIliC0ulTKCJAJshLQhH/qtwi3R3Iez6OQg/l92FM4=
X-Received: by 2002:a81:3ad0:: with SMTP id h199mr11427186ywa.37.1580572916034; 
 Sat, 01 Feb 2020 08:01:56 -0800 (PST)
MIME-Version: 1.0
References: <20190620200840.17655-1-ptoscano@redhat.com>
 <8f91b94b-8ba3-8aed-f2fb-aacdbc35cfd9@redhat.com>
In-Reply-To: <8f91b94b-8ba3-8aed-f2fb-aacdbc35cfd9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 1 Feb 2020 17:01:44 +0100
Message-ID: <CAAdtpL7p+BG=O8b4+fjAhGO4y-ongpcYX0N5gcLDSYq8q9z2Rg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v11] ssh: switch from libssh2 to libssh
To: Pino Toscano <ptoscano@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.65
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, "Richard W . M . Jones" <rjones@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 On Thu, Jun 20, 2019 at 10:36 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 6/20/19 10:08 PM, Pino Toscano wrote:
> > Rewrite the implementation of the ssh block driver to use libssh instea=
d
> > of libssh2.  The libssh library has various advantages over libssh2:
> > - easier API for authentication (for example for using ssh-agent)
> > - easier API for known_hosts handling
> > - supports newer types of keys in known_hosts
> >
> > Use APIs/features available in libssh 0.8 conditionally, to support
> > older versions (which are not recommended though).
> >
> > Adjust the iotest 207 according to the different error message, and to
> > find the default key type for localhost (to properly compare the
> > fingerprint with).
> > Contributed-by: Max Reitz <mreitz@redhat.com>
> >
> > Adjust the various Docker/Travis scripts to use libssh when available
> > instead of libssh2. The mingw/mxe testing is dropped for now, as there
> > are no packages for it.
> >
> > Signed-off-by: Pino Toscano <ptoscano@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> > ---
> >
> > Changes from v10:
> > - improve error message for key mismatch
> > - integrate Max Reitz' fix to iotest 207 to detect the key type used by
> >   localhost
> >
> > Changes from v9:
> > - restored "default" case in the server status switch for libssh < 0.8.=
0
> > - print the host key type & fingerprint on mismatch with known_hosts
> > - improve/fix message for failed socket_set_nodelay()
> > - reset s->sock properly
> >
> > Changes from v8:
> > - use a newer key type in iotest 207
> > - improve the commit message
> >
> > Changes from v7:
> > - #if HAVE_LIBSSH_0_8 -> #ifdef HAVE_LIBSSH_0_8
> > - ptrdiff_t -> size_t
> >
> > Changes from v6:
> > - fixed few checkpatch style issues
> > - detect libssh 0.8 via symbol detection
> > - adjust travis/docker test material
> > - remove dead "default" case in a switch
> > - use variables for storing MIN() results
> > - adapt a documentation bit
> >
> > Changes from v5:
> > - adapt to newer tracing APIs
> > - disable ssh compression (mimic what libssh2 does by default)
> > - use build time checks for libssh 0.8, and use newer APIs directly
> >
> > Changes from v4:
> > - fix wrong usages of error_setg/session_error_setg/sftp_error_setg
> > - fix few return code checks
> > - remove now-unused parameters in few internal functions
> > - allow authentication with "none" method
> > - switch to unsigned int for the port number
> > - enable TCP_NODELAY on the socket
> > - fix one reference error message in iotest 207
> >
> > Changes from v3:
> > - fix socket cleanup in connect_to_ssh()
> > - add comments about the socket cleanup
> > - improve the error reporting (closer to what was with libssh2)
> > - improve EOF detection on sftp_read()
> >
> > Changes from v2:
> > - used again an own fd
> > - fixed co_yield() implementation
> >
> > Changes from v1:
> > - fixed jumbo packets writing
> > - fixed missing 'err' assignment
> > - fixed commit message
> >
> >  .travis.yml                                   |   4 +-
> >  block/Makefile.objs                           |   6 +-
> >  block/ssh.c                                   | 669 ++++++++++--------
> >  block/trace-events                            |  14 +-
> >  configure                                     |  65 +-
> >  docs/qemu-block-drivers.texi                  |   2 +-
> >  .../dockerfiles/debian-win32-cross.docker     |   1 -
> >  .../dockerfiles/debian-win64-cross.docker     |   1 -
> >  tests/docker/dockerfiles/fedora.docker        |   4 +-
> >  tests/docker/dockerfiles/ubuntu.docker        |   2 +-
> >  tests/docker/dockerfiles/ubuntu1804.docker    |   2 +-
> >  tests/qemu-iotests/207                        |  54 +-
> >  tests/qemu-iotests/207.out                    |   2 +-
> >  13 files changed, 468 insertions(+), 358 deletions(-)
> >
[...]
> > diff --git a/configure b/configure
> > index b091b82cb3..5c7914570e 100755
> > --- a/configure
> > +++ b/configure
> > @@ -472,7 +472,7 @@ auth_pam=3D""
> >  vte=3D""
> >  virglrenderer=3D""
> >  tpm=3D""
> > -libssh2=3D""
> > +libssh=3D""
> >  live_block_migration=3D"yes"
> >  numa=3D""
> >  tcmalloc=3D"no"
> > @@ -1439,9 +1439,9 @@ for opt do
> >    ;;
> >    --enable-tpm) tpm=3D"yes"
> >    ;;
> > -  --disable-libssh2) libssh2=3D"no"

Now than I'm bisecting over this commit, I realize removing this
option was not a good idea, we should have done like commit
cb6414dfec8 or 315d3184525:

  @@ -886,10 +885,6 @@ for opt do
  -  --disable-uuid) uuid=3D"no"
  -  ;;
  -  --enable-uuid) uuid=3D"yes"
  -  ;;
  ...
  +  --enable-uuid|--disable-uuid)
  +      echo "$0: $opt is obsolete, UUID support is always built" >&2
  +  ;;

> > +  --disable-libssh) libssh=3D"no"
> >    ;;
> > -  --enable-libssh2) libssh2=3D"yes"
> > +  --enable-libssh) libssh=3D"yes"
> >    ;;
> >    --disable-live-block-migration) live_block_migration=3D"no"
> >    ;;
> > @@ -1810,7 +1810,7 @@ disabled with --disable-FEATURE, default is enabl=
ed if available:
> >    coroutine-pool  coroutine freelist (better performance)
> >    glusterfs       GlusterFS backend
> >    tpm             TPM support
> > -  libssh2         ssh block device support
> > +  libssh          ssh block device support
> >    numa            libnuma support
> >    libxml2         for Parallels image format
> >    tcmalloc        tcmalloc support
> > @@ -3914,43 +3914,34 @@ EOF
> >  fi
> >
> >  ##########################################
> > -# libssh2 probe
> > -min_libssh2_version=3D1.2.8
> > -if test "$libssh2" !=3D "no" ; then
> > -  if $pkg_config --atleast-version=3D$min_libssh2_version libssh2; the=
n
> > -    libssh2_cflags=3D$($pkg_config libssh2 --cflags)
> > -    libssh2_libs=3D$($pkg_config libssh2 --libs)
> > -    libssh2=3Dyes
> > +# libssh probe
> > +if test "$libssh" !=3D "no" ; then
> > +  if $pkg_config --exists libssh; then
> > +    libssh_cflags=3D$($pkg_config libssh --cflags)
> > +    libssh_libs=3D$($pkg_config libssh --libs)
> > +    libssh=3Dyes
> >    else
> > -    if test "$libssh2" =3D "yes" ; then
> > -      error_exit "libssh2 >=3D $min_libssh2_version required for --ena=
ble-libssh2"
> > +    if test "$libssh" =3D "yes" ; then
> > +      error_exit "libssh required for --enable-libssh"
> >      fi
> > -    libssh2=3Dno
> > +    libssh=3Dno
> >    fi
> >  fi
> >
> >  ##########################################
> > -# libssh2_sftp_fsync probe
> > +# Check for libssh 0.8
> > +# This is done like this instead of using the LIBSSH_VERSION_* and
> > +# SSH_VERSION_* macros because some distributions in the past shipped
> > +# snapshots of the future 0.8 from Git, and those snapshots did not
> > +# have updated version numbers (still referring to 0.7.0).
> >
> > -if test "$libssh2" =3D "yes"; then
> > +if test "$libssh" =3D "yes"; then
> >    cat > $TMPC <<EOF
> > -#include <stdio.h>
> > -#include <libssh2.h>
> > -#include <libssh2_sftp.h>
> > -int main(void) {
> > -    LIBSSH2_SESSION *session;
> > -    LIBSSH2_SFTP *sftp;
> > -    LIBSSH2_SFTP_HANDLE *sftp_handle;
> > -    session =3D libssh2_session_init ();
> > -    sftp =3D libssh2_sftp_init (session);
> > -    sftp_handle =3D libssh2_sftp_open (sftp, "/", 0, 0);
> > -    libssh2_sftp_fsync (sftp_handle);
> > -    return 0;
> > -}
> > +#include <libssh/libssh.h>
> > +int main(void) { return ssh_get_server_publickey(NULL, NULL); }
> >  EOF
> > -  # libssh2_cflags/libssh2_libs defined in previous test.
> > -  if compile_prog "$libssh2_cflags" "$libssh2_libs" ; then
> > -    QEMU_CFLAGS=3D"-DHAS_LIBSSH2_SFTP_FSYNC $QEMU_CFLAGS"
> > +  if compile_prog "$libssh_cflags" "$libssh_libs"; then
> > +    libssh_cflags=3D"-DHAVE_LIBSSH_0_8 $libssh_cflags"
> >    fi
> >  fi
> >
> > @@ -6451,7 +6442,7 @@ echo "GlusterFS support $glusterfs"
> >  echo "gcov              $gcov_tool"
> >  echo "gcov enabled      $gcov"
> >  echo "TPM support       $tpm"
> > -echo "libssh2 support   $libssh2"
> > +echo "libssh support    $libssh"
> >  echo "QOM debugging     $qom_cast_debug"
> >  echo "Live block migration $live_block_migration"
> >  echo "lzo support       $lzo"
> > @@ -7144,10 +7135,10 @@ if test "$glusterfs_iocb_has_stat" =3D "yes" ; =
then
> >    echo "CONFIG_GLUSTERFS_IOCB_HAS_STAT=3Dy" >> $config_host_mak
> >  fi
> >
> > -if test "$libssh2" =3D "yes" ; then
> > -  echo "CONFIG_LIBSSH2=3Dm" >> $config_host_mak
> > -  echo "LIBSSH2_CFLAGS=3D$libssh2_cflags" >> $config_host_mak
> > -  echo "LIBSSH2_LIBS=3D$libssh2_libs" >> $config_host_mak
> > +if test "$libssh" =3D "yes" ; then
> > +  echo "CONFIG_LIBSSH=3Dm" >> $config_host_mak
> > +  echo "LIBSSH_CFLAGS=3D$libssh_cflags" >> $config_host_mak
> > +  echo "LIBSSH_LIBS=3D$libssh_libs" >> $config_host_mak
> >  fi
> >
> >  if test "$live_block_migration" =3D "yes" ; then
[...]

