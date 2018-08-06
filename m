Received: from eggs.gnu.org ([2001:4830:134:3::10]:40984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fmlWh-000547-0Z
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 15:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fmlWd-0007vg-S2
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 15:50:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:41310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fmlWd-0007tk-Gi
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 15:50:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fmlWb-0005yA-GH
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 19:50:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C76852E80D4
	for <qemu-devel@nongnu.org>; Mon,  6 Aug 2018 19:50:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Aug 2018 19:41:24 -0000
From: Michele Denber <1785698@bugs.launchpad.net>
Reply-To: Bug 1785698 <1785698@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153358448492.29549.3601216229452882398.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] =?utf-8?q?=5BBug_1785698=5D_=5BNEW=5D_Solaris_build_?=
 =?utf-8?b?ZXJyb3I6IHVua25vd24gdHlwZSBuYW1lIOKAmGdjcnlfZXJyb3JfdOKAmQ==?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Building qemu 2.12.0 on a Sun Oracle Enterprise M3000 SPARC64 VII,
opencsw toolchain and gcc 7.3.0, gmake fails with a bunch of related
errors all in cypher-gcrypt.c:

/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:262:32: error: =E2=
=80=98gcry_cipher_hd_t=E2=80=99 undeclared (first use in this function); di=
d you mean =E2=80=98gcry_cipher_info=E2=80=99?
     err =3D gcry_cipher_encrypt((gcry_cipher_hd_t)ctx, dst, length, src, l=
ength);                                ^~~~~~~~~~~~~~~~
                                gcry_cipher_info
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:262:49: error: expec=
ted =E2=80=98)=E2=80=99 before =E2=80=98ctx=E2=80=99
     err =3D gcry_cipher_encrypt((gcry_cipher_hd_t)ctx, dst, length, src, l=
ength);                                                 ^~~
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:262:11: error: too f=
ew arguments to function =E2=80=98gcry_cipher_encrypt=E2=80=99
     err =3D gcry_cipher_encrypt((gcry_cipher_hd_t)ctx, dst, length, src, l=
ength);           ^~~~~~~~~~~~~~~~~~~
In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.=
c:25:0,
                 from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
/usr/include/gcrypt.h:566:5: note: declared here
 int gcry_cipher_encrypt (GcryCipherHd h,
     ^~~~~~~~~~~~~~~~~~~
In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:0:
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c: In function =E2=80=
=98qcrypto_gcrypt_xts_decrypt=E2=80=99:
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:271:5: error: unknow=
n type name =E2=80=98gcry_error_t=E2=80=99; did you mean =E2=80=98g_error=
=E2=80=99?
     gcry_error_t err;
     ^~~~~~~~~~~~
     g_error
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:272:32: error: =E2=
=80=98gcry_cipher_hd_t=E2=80=99 undeclared (first use in this function); di=
d you mean =E2=80=98gcry_cipher_info=E2=80=99?
     err =3D gcry_cipher_decrypt((gcry_cipher_hd_t)ctx, dst, length, src, l=
ength);                                ^~~~~~~~~~~~~~~~
                                gcry_cipher_info
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:272:49: error: expec=
ted =E2=80=98)=E2=80=99 before =E2=80=98ctx=E2=80=99
     err =3D gcry_cipher_decrypt((gcry_cipher_hd_t)ctx, dst, length, src, l=
ength);                                                 ^~~
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:272:11: error: too f=
ew arguments to function =E2=80=98gcry_cipher_decrypt=E2=80=99
     err =3D gcry_cipher_decrypt((gcry_cipher_hd_t)ctx, dst, length, src, l=
ength);           ^~~~~~~~~~~~~~~~~~~
In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.=
c:25:0,
                 from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
/usr/include/gcrypt.h:571:5: note: declared here
 int gcry_cipher_decrypt (GcryCipherHd h,
     ^~~~~~~~~~~~~~~~~~~
In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:0:
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c: In function =E2=80=
=98qcrypto_gcrypt_cipher_encrypt=E2=80=99:
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:284:5: error: unknow=
n type name =E2=80=98gcry_error_t=E2=80=99; did you mean =E2=80=98g_error=
=E2=80=99?
     gcry_error_t err;
     ^~~~~~~~~~~~
     g_error
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:293:21: warning: pas=
sing argument 1 of =E2=80=98xts_encrypt=E2=80=99 makes pointer from integer=
 without a cast [-Wint-conversion]
         xts_encrypt(ctx->handle, ctx->tweakhandle,
                     ^~~
In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.=
c:22:0,
                 from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
/export/home/denber/qemu-2.12.0/include/crypto/xts.h:73:6: note: expected =
=E2=80=98const void *=E2=80=99 but argument is of type =E2=80=98int=E2=80=
=99
 void xts_encrypt(const void *datactx,
      ^~~~~~~~~~~
In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:0:
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:293:34: warning: pas=
sing argument 2 of =E2=80=98xts_encrypt=E2=80=99 makes pointer from integer=
 without a cast [-Wint-conversion]
         xts_encrypt(ctx->handle, ctx->tweakhandle,
                                  ^~~
In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.=
c:22:0,
                 from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
/export/home/denber/qemu-2.12.0/include/crypto/xts.h:73:6: note: expected =
=E2=80=98const void *=E2=80=99 but argument is of type =E2=80=98int=E2=80=
=99
 void xts_encrypt(const void *datactx,
      ^~~~~~~~~~~
In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:0:
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:298:35: warning: pas=
sing argument 1 of =E2=80=98gcry_cipher_encrypt=E2=80=99 makes pointer from=
 integer without a cast [-Wint-conversion]
         err =3D gcry_cipher_encrypt(ctx->handle,
                                   ^~~
In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.=
c:25:0,
                 from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
/usr/include/gcrypt.h:566:5: note: expected =E2=80=98GcryCipherHd {aka stru=
ct gcry_cipher_handle *}=E2=80=99 but argument is of type =E2=80=98int=E2=
=80=99
 int gcry_cipher_encrypt (GcryCipherHd h,
     ^~~~~~~~~~~~~~~~~~~
In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:0:
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c: In function =E2=80=
=98qcrypto_gcrypt_cipher_decrypt=E2=80=99:
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:320:5: error: unknow=
n type name =E2=80=98gcry_error_t=E2=80=99; did you mean =E2=80=98g_error=
=E2=80=99?
     gcry_error_t err;
     ^~~~~~~~~~~~
     g_error
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:329:21: warning: pas=
sing argument 1 of =E2=80=98xts_decrypt=E2=80=99 makes pointer from integer=
 without a cast [-Wint-conversion]
         xts_decrypt(ctx->handle, ctx->tweakhandle,
                     ^~~
In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.=
c:22:0,
                 from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
/export/home/denber/qemu-2.12.0/include/crypto/xts.h:51:6: note: expected =
=E2=80=98const void *=E2=80=99 but argument is of type =E2=80=98int=E2=80=
=99
 void xts_decrypt(const void *datactx,
      ^~~~~~~~~~~
In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:0:
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:329:34: warning: pas=
sing argument 2 of =E2=80=98xts_decrypt=E2=80=99 makes pointer from integer=
 without a cast [-Wint-conversion]
         xts_decrypt(ctx->handle, ctx->tweakhandle,
                                  ^~~
In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.=
c:22:0,
                 from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
/export/home/denber/qemu-2.12.0/include/crypto/xts.h:51:6: note: expected =
=E2=80=98const void *=E2=80=99 but argument is of type =E2=80=98int=E2=80=
=99
 void xts_decrypt(const void *datactx,
      ^~~~~~~~~~~
In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:0:
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:334:35: warning: pas=
sing argument 1 of =E2=80=98gcry_cipher_decrypt=E2=80=99 makes pointer from=
 integer without a cast [-Wint-conversion]
         err =3D gcry_cipher_decrypt(ctx->handle,
                                   ^~~
In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.=
c:25:0,
                 from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
/usr/include/gcrypt.h:571:5: note: expected =E2=80=98GcryCipherHd {aka stru=
ct gcry_cipher_handle *}=E2=80=99 but argument is of type =E2=80=98int=E2=
=80=99
 int gcry_cipher_decrypt (GcryCipherHd h,
     ^~~~~~~~~~~~~~~~~~~
In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:0:
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c: In function =E2=80=
=98qcrypto_gcrypt_cipher_setiv=E2=80=99:
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:353:5: error: unknow=
n type name =E2=80=98gcry_error_t=E2=80=99; did you mean =E2=80=98g_error=
=E2=80=99?
     gcry_error_t err;
     ^~~~~~~~~~~~
     g_error
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:365:19: warning: imp=
licit declaration of function =E2=80=98gcry_cipher_setctr=E2=80=99; did you=
 mean =E2=80=98gcry_cipher_setiv=E2=80=99? [-Wimplicit-function-declaration]
             err =3D gcry_cipher_setctr(ctx->handle, iv, niv);
                   ^~~~~~~~~~~~~~~~~~
                   gcry_cipher_setiv
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:365:19: warning: nes=
ted extern declaration of =E2=80=98gcry_cipher_setctr=E2=80=99 [-Wnested-ex=
terns]
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:372:13: warning: imp=
licit declaration of function =E2=80=98gcry_cipher_reset=E2=80=99; did you =
mean =E2=80=98gcry_cipher_close=E2=80=99? [-Wimplicit-function-declaration]
             gcry_cipher_reset(ctx->handle);
             ^~~~~~~~~~~~~~~~~
             gcry_cipher_close
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:372:13: warning: nes=
ted extern declaration of =E2=80=98gcry_cipher_reset=E2=80=99 [-Wnested-ext=
erns]
/export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:373:19: warning: pas=
sing argument 1 of =E2=80=98gcry_cipher_ctl=E2=80=99 makes pointer from int=
eger without a cast [-Wint-conversion]
             err =3D gcry_cipher_setiv(ctx->handle, iv, niv);
                   ^~~~~~~~~~~~~~~~~
In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.=
c:25:0,
                 from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
/usr/include/gcrypt.h:540:5: note: expected =E2=80=98GcryCipherHd {aka stru=
ct gcry_cipher_handle *}=E2=80=99 but argument is of type =E2=80=98int=E2=
=80=99
 int gcry_cipher_ctl( GcryCipherHd h, int cmd, void *buffer, size_t buflen);
     ^~~~~~~~~~~~~~~
gmake: *** [/export/home/denber/qemu-2.12.0/rules.mak:67: crypto/cipher.o] =
Error 1

---------------------------------------------------------------------

I do have libgcrypt, libgcrypt_dev, and libgcrypt_utils installed from
opencsw.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1785698

Title:
  Solaris build error: unknown type name =E2=80=98gcry_error_t=E2=80=99

Status in QEMU:
  New

Bug description:
  Building qemu 2.12.0 on a Sun Oracle Enterprise M3000 SPARC64 VII,
  opencsw toolchain and gcc 7.3.0, gmake fails with a bunch of related
  errors all in cypher-gcrypt.c:

  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:262:32: error: =E2=
=80=98gcry_cipher_hd_t=E2=80=99 undeclared (first use in this function); di=
d you mean =E2=80=98gcry_cipher_info=E2=80=99?
       err =3D gcry_cipher_encrypt((gcry_cipher_hd_t)ctx, dst, length, src,=
 length);                                ^~~~~~~~~~~~~~~~
                                  gcry_cipher_info
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:262:49: error: exp=
ected =E2=80=98)=E2=80=99 before =E2=80=98ctx=E2=80=99
       err =3D gcry_cipher_encrypt((gcry_cipher_hd_t)ctx, dst, length, src,=
 length);                                                 ^~~
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:262:11: error: too=
 few arguments to function =E2=80=98gcry_cipher_encrypt=E2=80=99
       err =3D gcry_cipher_encrypt((gcry_cipher_hd_t)ctx, dst, length, src,=
 length);           ^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:25:0,
                   from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
  /usr/include/gcrypt.h:566:5: note: declared here
   int gcry_cipher_encrypt (GcryCipherHd h,
       ^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c: In function =E2=
=80=98qcrypto_gcrypt_xts_decrypt=E2=80=99:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:271:5: error: unkn=
own type name =E2=80=98gcry_error_t=E2=80=99; did you mean =E2=80=98g_error=
=E2=80=99?
       gcry_error_t err;
       ^~~~~~~~~~~~
       g_error
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:272:32: error: =E2=
=80=98gcry_cipher_hd_t=E2=80=99 undeclared (first use in this function); di=
d you mean =E2=80=98gcry_cipher_info=E2=80=99?
       err =3D gcry_cipher_decrypt((gcry_cipher_hd_t)ctx, dst, length, src,=
 length);                                ^~~~~~~~~~~~~~~~
                                  gcry_cipher_info
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:272:49: error: exp=
ected =E2=80=98)=E2=80=99 before =E2=80=98ctx=E2=80=99
       err =3D gcry_cipher_decrypt((gcry_cipher_hd_t)ctx, dst, length, src,=
 length);                                                 ^~~
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:272:11: error: too=
 few arguments to function =E2=80=98gcry_cipher_decrypt=E2=80=99
       err =3D gcry_cipher_decrypt((gcry_cipher_hd_t)ctx, dst, length, src,=
 length);           ^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:25:0,
                   from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
  /usr/include/gcrypt.h:571:5: note: declared here
   int gcry_cipher_decrypt (GcryCipherHd h,
       ^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c: In function =E2=
=80=98qcrypto_gcrypt_cipher_encrypt=E2=80=99:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:284:5: error: unkn=
own type name =E2=80=98gcry_error_t=E2=80=99; did you mean =E2=80=98g_error=
=E2=80=99?
       gcry_error_t err;
       ^~~~~~~~~~~~
       g_error
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:293:21: warning: p=
assing argument 1 of =E2=80=98xts_encrypt=E2=80=99 makes pointer from integ=
er without a cast [-Wint-conversion]
           xts_encrypt(ctx->handle, ctx->tweakhandle,
                       ^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:22:0,
                   from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
  /export/home/denber/qemu-2.12.0/include/crypto/xts.h:73:6: note: expected=
 =E2=80=98const void *=E2=80=99 but argument is of type =E2=80=98int=E2=80=
=99
   void xts_encrypt(const void *datactx,
        ^~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:293:34: warning: p=
assing argument 2 of =E2=80=98xts_encrypt=E2=80=99 makes pointer from integ=
er without a cast [-Wint-conversion]
           xts_encrypt(ctx->handle, ctx->tweakhandle,
                                    ^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:22:0,
                   from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
  /export/home/denber/qemu-2.12.0/include/crypto/xts.h:73:6: note: expected=
 =E2=80=98const void *=E2=80=99 but argument is of type =E2=80=98int=E2=80=
=99
   void xts_encrypt(const void *datactx,
        ^~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:298:35: warning: p=
assing argument 1 of =E2=80=98gcry_cipher_encrypt=E2=80=99 makes pointer fr=
om integer without a cast [-Wint-conversion]
           err =3D gcry_cipher_encrypt(ctx->handle,
                                     ^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:25:0,
                   from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
  /usr/include/gcrypt.h:566:5: note: expected =E2=80=98GcryCipherHd {aka st=
ruct gcry_cipher_handle *}=E2=80=99 but argument is of type =E2=80=98int=E2=
=80=99
   int gcry_cipher_encrypt (GcryCipherHd h,
       ^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c: In function =E2=
=80=98qcrypto_gcrypt_cipher_decrypt=E2=80=99:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:320:5: error: unkn=
own type name =E2=80=98gcry_error_t=E2=80=99; did you mean =E2=80=98g_error=
=E2=80=99?
       gcry_error_t err;
       ^~~~~~~~~~~~
       g_error
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:329:21: warning: p=
assing argument 1 of =E2=80=98xts_decrypt=E2=80=99 makes pointer from integ=
er without a cast [-Wint-conversion]
           xts_decrypt(ctx->handle, ctx->tweakhandle,
                       ^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:22:0,
                   from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
  /export/home/denber/qemu-2.12.0/include/crypto/xts.h:51:6: note: expected=
 =E2=80=98const void *=E2=80=99 but argument is of type =E2=80=98int=E2=80=
=99
   void xts_decrypt(const void *datactx,
        ^~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:329:34: warning: p=
assing argument 2 of =E2=80=98xts_decrypt=E2=80=99 makes pointer from integ=
er without a cast [-Wint-conversion]
           xts_decrypt(ctx->handle, ctx->tweakhandle,
                                    ^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:22:0,
                   from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
  /export/home/denber/qemu-2.12.0/include/crypto/xts.h:51:6: note: expected=
 =E2=80=98const void *=E2=80=99 but argument is of type =E2=80=98int=E2=80=
=99
   void xts_decrypt(const void *datactx,
        ^~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:334:35: warning: p=
assing argument 1 of =E2=80=98gcry_cipher_decrypt=E2=80=99 makes pointer fr=
om integer without a cast [-Wint-conversion]
           err =3D gcry_cipher_decrypt(ctx->handle,
                                     ^~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:25:0,
                   from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
  /usr/include/gcrypt.h:571:5: note: expected =E2=80=98GcryCipherHd {aka st=
ruct gcry_cipher_handle *}=E2=80=99 but argument is of type =E2=80=98int=E2=
=80=99
   int gcry_cipher_decrypt (GcryCipherHd h,
       ^~~~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153=
:0:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c: In function =E2=
=80=98qcrypto_gcrypt_cipher_setiv=E2=80=99:
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:353:5: error: unkn=
own type name =E2=80=98gcry_error_t=E2=80=99; did you mean =E2=80=98g_error=
=E2=80=99?
       gcry_error_t err;
       ^~~~~~~~~~~~
       g_error
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:365:19: warning: i=
mplicit declaration of function =E2=80=98gcry_cipher_setctr=E2=80=99; did y=
ou mean =E2=80=98gcry_cipher_setiv=E2=80=99? [-Wimplicit-function-declarati=
on]
               err =3D gcry_cipher_setctr(ctx->handle, iv, niv);
                     ^~~~~~~~~~~~~~~~~~
                     gcry_cipher_setiv
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:365:19: warning: n=
ested extern declaration of =E2=80=98gcry_cipher_setctr=E2=80=99 [-Wnested-=
externs]
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:372:13: warning: i=
mplicit declaration of function =E2=80=98gcry_cipher_reset=E2=80=99; did yo=
u mean =E2=80=98gcry_cipher_close=E2=80=99? [-Wimplicit-function-declaratio=
n]
               gcry_cipher_reset(ctx->handle);
               ^~~~~~~~~~~~~~~~~
               gcry_cipher_close
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:372:13: warning: n=
ested extern declaration of =E2=80=98gcry_cipher_reset=E2=80=99 [-Wnested-e=
xterns]
  /export/home/denber/qemu-2.12.0/crypto/cipher-gcrypt.c:373:19: warning: p=
assing argument 1 of =E2=80=98gcry_cipher_ctl=E2=80=99 makes pointer from i=
nteger without a cast [-Wint-conversion]
               err =3D gcry_cipher_setiv(ctx->handle, iv, niv);
                     ^~~~~~~~~~~~~~~~~
  In file included from /export/home/denber/qemu-2.12.0/crypto/cipher-gcryp=
t.c:25:0,
                   from /export/home/denber/qemu-2.12.0/crypto/cipher.c:153:
  /usr/include/gcrypt.h:540:5: note: expected =E2=80=98GcryCipherHd {aka st=
ruct gcry_cipher_handle *}=E2=80=99 but argument is of type =E2=80=98int=E2=
=80=99
   int gcry_cipher_ctl( GcryCipherHd h, int cmd, void *buffer, size_t bufle=
n);
       ^~~~~~~~~~~~~~~
  gmake: *** [/export/home/denber/qemu-2.12.0/rules.mak:67: crypto/cipher.o=
] Error 1

  ---------------------------------------------------------------------

  I do have libgcrypt, libgcrypt_dev, and libgcrypt_utils installed from
  opencsw.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1785698/+subscriptions
