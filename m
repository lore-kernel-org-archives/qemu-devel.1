Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063DCC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D394F20820
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D394F20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51112 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfOsm-0004Ci-OR
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 09:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34605)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ptoscano@redhat.com>) id 1hfOpS-0003WB-7T
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ptoscano@redhat.com>) id 1hfOpQ-0005wr-TV
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:16:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ptoscano@redhat.com>)
 id 1hfOpN-0005on-RG; Mon, 24 Jun 2019 09:16:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD3B37FDFC;
 Mon, 24 Jun 2019 13:16:03 +0000 (UTC)
Received: from lindworm.usersys.redhat.com (unknown [10.43.2.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 759706090E;
 Mon, 24 Jun 2019 13:16:01 +0000 (UTC)
From: Pino Toscano <ptoscano@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Date: Mon, 24 Jun 2019 15:15:51 +0200
Message-ID: <5873173.t2JhDm7DL7@lindworm.usersys.redhat.com>
Organization: Red Hat
In-Reply-To: <4f34c316-2d5a-4d0c-ab3b-2c85b1a9e22f@redhat.com>
References: <20190621132324.2165-1-mreitz@redhat.com>
 <CAFEAcA9tPUcZ5BZmasT=GpccGw1EAqMTHRJhsq9cGZjJUhGs=Q@mail.gmail.com>
 <4f34c316-2d5a-4d0c-ab3b-2c85b1a9e22f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2911403.vXsD5YPWei";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 24 Jun 2019 13:16:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/8] Block patches
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nextPart2911403.vXsD5YPWei
Content-Type: multipart/mixed; boundary="nextPart2999361.5ALVSlvAT2"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart2999361.5ALVSlvAT2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Monday, 24 June 2019 14:20:11 CEST Max Reitz wrote:
> On 23.06.19 19:18, Peter Maydell wrote:
> > On Fri, 21 Jun 2019 at 14:23, Max Reitz <mreitz@redhat.com> wrote:
> >>
> >> The following changes since commit 33d609990621dea6c7d056c86f707b88113=
20ac1:
> >>
> >>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into =
staging (2019-06-18 17:00:52 +0100)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://github.com/XanClic/qemu.git tags/pull-block-2019-06-21
> >>
> >> for you to fetch changes up to e2a76186f7948b8b75d1b2b52638de7c2f7f747=
2:
> >>
> >>   iotests: Fix 205 for concurrent runs (2019-06-21 14:40:28 +0200)
> >>
> >> ----------------------------------------------------------------
> >> Block patches:
> >> - The SSH block driver now uses libssh instead of libssh2
> >> - The VMDK block driver gets read-only support for the seSparse
> >>   subformat
> >> - Various fixes
> >>
> >=20
> > Hi; this failed to build on my s390 box:
> >=20
> > /home/linux1/qemu/block/ssh.c: In function =E2=80=98check_host_key_know=
nhosts=E2=80=99:
> > /home/linux1/qemu/block/ssh.c:367:27: error: implicit declaration of
> > function =E2=80=98ssh_get_fingerprint_hash=E2=80=99
> > [-Werror=3Dimplicit-function-declaration]
> >              fingerprint =3D ssh_get_fingerprint_hash(SSH_PUBLICKEY_HAS=
H_SHA1,
> >                            ^
> > /home/linux1/qemu/block/ssh.c:367:13: error: nested extern declaration
> > of =E2=80=98ssh_get_fingerprint_hash=E2=80=99 [-Werror=3Dnested-externs]
> >              fingerprint =3D ssh_get_fingerprint_hash(SSH_PUBLICKEY_HAS=
H_SHA1,
> >              ^
> > /home/linux1/qemu/block/ssh.c:367:25: error: assignment makes pointer
> > from integer without a cast [-Werror=3Dint-conversion]
> >              fingerprint =3D ssh_get_fingerprint_hash(SSH_PUBLICKEY_HAS=
H_SHA1,
> >                          ^
> >=20
> > It looks like that function was introduced in libssh 0.8.3, and this box
> > has 0.6.3. (configure has correctly not defined HAVE_LIBSSH_0_8
> > but this usage is inside a bit of code that's compiled even when
> > that is not defined.)

Oops, sorry, I did not test the latest versions with that old libssh.

> Pino, would you be OK with dropping that piece of code for pre-0.8 and
> just replacing it with the else-error_setg()?

Some the variables in check_host_key_knownhosts must be moved within
the HAVE_LIBSSH_0_8 block now; attached fixup patch, please squash with
my patch (I can submit a v12, if needed/wanted).

=2D-=20
Pino Toscano
--nextPart2999361.5ALVSlvAT2
Content-Disposition: attachment; filename="fixup.diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="fixup.diff"

diff --git a/block/ssh.c b/block/ssh.c
index 048d0cc924..501933b855 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -277,14 +277,14 @@ static void ssh_parse_filename(const char *filename, QDict *options,
 static int check_host_key_knownhosts(BDRVSSHState *s, Error **errp)
 {
     int ret;
+#ifdef HAVE_LIBSSH_0_8
+    enum ssh_known_hosts_e state;
     int r;
     ssh_key pubkey;
     enum ssh_keytypes_e pubkey_type;
     unsigned char *server_hash = NULL;
     size_t server_hash_len;
     char *fingerprint = NULL;
-#ifdef HAVE_LIBSSH_0_8
-    enum ssh_known_hosts_e state;
 
     state = ssh_session_is_known_server(s->session);
     trace_ssh_server_status(state);
@@ -356,30 +356,9 @@ static int check_host_key_knownhosts(BDRVSSHState *s, Error **errp)
         break;
     case SSH_SERVER_KNOWN_CHANGED:
         ret = -EINVAL;
-        r = ssh_get_publickey(s->session, &pubkey);
-        if (r == 0) {
-            r = ssh_get_publickey_hash(pubkey, SSH_PUBLICKEY_HASH_SHA1,
-                                       &server_hash, &server_hash_len);
-            pubkey_type = ssh_key_type(pubkey);
-            ssh_key_free(pubkey);
-        }
-        if (r == 0) {
-            fingerprint = ssh_get_fingerprint_hash(SSH_PUBLICKEY_HASH_SHA1,
-                                                   server_hash,
-                                                   server_hash_len);
-            ssh_clean_pubkey_hash(&server_hash);
-        }
-        if (fingerprint) {
-            error_setg(errp,
-                       "host key (%s key with fingerprint %s) does not match "
-                       "the one in known_hosts; this may be a possible attack",
-                       ssh_key_type_to_char(pubkey_type), fingerprint);
-            ssh_string_free_char(fingerprint);
-        } else  {
-            error_setg(errp,
-                       "host key does not match the one in known_hosts; this "
-                       "may be a possible attack");
-        }
+        error_setg(errp,
+                   "host key does not match the one in known_hosts; this "
+                   "may be a possible attack");
         goto out;
     case SSH_SERVER_FOUND_OTHER:
         ret = -EINVAL;

--nextPart2999361.5ALVSlvAT2--

--nextPart2911403.vXsD5YPWei
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbjdOQa52nq0tQalew9FMLZhkN80FAl0QzQcACgkQw9FMLZhk
N8119BAAw7KZmCKOhWPg0U2j72gee2PDgSJyE+1claipLNc01w7/CAfm9uH3JyHN
DwRY1WcXglplDlGPcDkvVxkMY7UG9hkj0W0yrjYjfN0eeReX7DedI5OpN1P6SqZ1
WP782aCI4jn8ZT3R6iPxBf4skLqIc1ul6ovJIoLracJ8rFKy7FfgsTRkNOwo/5DL
R2EGwtJoDk09scrFn9g8Gv8aDhW8qCO7Aj0ZEjhBzU+B1Y00DmS9hgztooPW9vfM
LppR1VW+ltuOsUgNSZCt69vaX8gFfhqhaEq/zsoedK+jNLbKIK1rDktR7NZsKxXr
P+2syNiwfZlrA0KYQjWnoXmQu/D103pHvbkykJ1WGLuUjvy5/LVVaHO9788YY718
375Nf5kllwJeYWGjqZPXQtF/69UwjqENtajnsbSz9XVqTFDG8gpxTSqMpiBBQoge
uKeVS55UrG4aYtDh8OAxzJJ3ysEyyP3M5NgAkLoBnf+jZt0Uc2XSmH/Sy/ZwY7IO
UpgtAMupZsTFZ4/Z7lSeIdAPZrR5l6TtS3K2ntgn0dwM20TO1CdCpaN0VRxN5PXh
wJJrbTeE9M+HAWZpyAc4TIV2xbjeA4ya9ajRUKZMLMmD8CzhmgnBBT2A+OPgHq0i
g0Od9+zThiJSyrYci72FOZZZLsjcbAtab2hs6CVPA9UO5E4+EH8=
=omM7
-----END PGP SIGNATURE-----

--nextPart2911403.vXsD5YPWei--




