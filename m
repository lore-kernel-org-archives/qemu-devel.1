Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7E0C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1114D206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvHoUPhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1114D206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEDW3-0003rN-7A
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEDUv-0003Qi-5M
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEDUr-0005Az-Fh
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:47:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEDUr-00053a-9K
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584456428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KBMKWztyWLAIGBV+QXqOhvCdb/Gsn8A4il/tnIQs95Y=;
 b=AvHoUPhiZ3Fd8Zx/7D+PgflnyLjieK/usVyY2lHr5tL9FQrqO63AJ2RHcmpnxZUt19Jlci
 EeXZo8pAw1nxImKNDn7ldcx3I+aWpS0Ze2VZQhx6qrjE9JnwB3nadcj9WNDvFGGFHcSHK4
 Jstn5evHHqj0pYGtamylHK9FPBRnDN8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-P4ZlPbymNfWWd1y8NnLQyA-1; Tue, 17 Mar 2020 10:47:06 -0400
X-MC-Unique: P4ZlPbymNfWWd1y8NnLQyA-1
Received: by mail-wr1-f72.google.com with SMTP id v7so1336274wrp.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 07:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=JjH/1MtE07xeSroYrtGWhyPvCXDF8ckjLBpRZ0Iwg2I=;
 b=RGO/f1a10ovVFlHk+2rsY/U0y/o0zolTwsuX4HB/pF9OuNRVamGu+tgZac5m5R25WG
 CUq/VT6HzzEdU+8ROtE1aoBcojL2XOqdgxhNETU0snwG2+dvCJQ4DxpLLLUTeynCUGWk
 LOqoWPxCEJCYlVxKcaEdCtpUD2eqKK+ChuUjdWoKpG+Ogp/DbukXJIiHPII87jWlDjrF
 WDDJWhHxb5kR4GR3Xs7LWu/PCJ47ZSAmyFbc1V2vxW8DKeWvv6cfHyvceH2ggad+Gd64
 suEdwMYIMuZgsCo1NcsDCrScHcNpCNV90Ds9S/efXrsM9jtqh7UgSgUywJa8JtiUex3c
 qyrA==
X-Gm-Message-State: ANhLgQ28ZEEa99cHqk/3no2DCRXCkMgLtXPpcxh4Sukuck5vsG/Iqoz8
 W92ZDWsHG1jJbOIOmQPEtGRZxnLyrXPJOxIIkvnBBk/xPI5I18ompFvyRQN1nRiFi4bew5Y9vQx
 tA8FRbJSnAUZ9qM4=
X-Received: by 2002:adf:f503:: with SMTP id q3mr6459283wro.135.1584456425010; 
 Tue, 17 Mar 2020 07:47:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtrSC1RIynfyx3348jxCIK24oDQnFcJ/OtqGbgqtXLfeMlB6r9HLakmBmFgpxr7HF3LM9W2PQ==
X-Received: by 2002:adf:f503:: with SMTP id q3mr6459214wro.135.1584456424148; 
 Tue, 17 Mar 2020 07:47:04 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.227])
 by smtp.gmail.com with ESMTPSA id h13sm4864586wrv.39.2020.03.17.07.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 07:47:03 -0700 (PDT)
Subject: Re: [PULL v2 00/61] Misc patches for soft freeze
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <1584396375-31278-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA-W=7LQyKvy-Pxv7eUh-tLoYu5jLiObTST0-Ee0wrCX7g@mail.gmail.com>
 <da99ee7c-49fb-057e-a6bb-b2c89de86ffa@redhat.com>
 <20200317142635.GB517094@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4685b090-c480-0061-6cae-f29cc8cbd717@redhat.com>
Date: Tue, 17 Mar 2020 15:47:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317142635.GB517094@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IEJR2oFyffvWxNNDar86Fy1honSCplTPc"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: philmd@redhat.com, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IEJR2oFyffvWxNNDar86Fy1honSCplTPc
Content-Type: multipart/mixed; boundary="1Rlod7JDESHaavyNpnxSt4ezosCee3ECQ"

--1Rlod7JDESHaavyNpnxSt4ezosCee3ECQ
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17/03/20 15:26, Stefan Hajnoczi wrote:
> Yes, looks like the compiler can't figure out the control flow on
> NetBSD.
>=20
> We could drop the WITH_QEMU_LOCK_GUARD() macro and use this idiom
> instead:
>=20
>   {
>       QEMU_LOCK_GUARD(&mutex);
>       ...
>   }
>=20
> But it's unusual for C code to create scopes without a statement (for,
> if, while).

After staring at compiler dumps for a while I have just concluded that=20
this could actually be considered a bug in WITH_QEMU_LOCK_GUARD.

QEMU_MAKE_LOCKABLE returns NULL if passed a NULL argument.  This is the=20
root cause of the NetBSD failure, as the compiler doesn't figure out=20
that &timer_list->active_timers_lock is non-NULL and therefore doesn't=20
simplify the qemu_make_lockable function.

But why does that cause an uninitialized variable warning?  Because if=20
WITH_QEMU_LOCK_GUARD were passed NULL, it would not execute its body!

So I'm going to squash the following in the series, mostly through a new
patch "lockable: introduce QEMU_MAKE_LOCKABLE_NONNULL":

diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
index 44b3f4b..1aeb2cb 100644
--- a/include/qemu/lockable.h
+++ b/include/qemu/lockable.h
@@ -67,7 +67,7 @@ qemu_make_lockable(void *x, QemuLockable *lockable)
  * In C++ it would be different, but then C++ wouldn't need QemuLockable
  * either...
  */
-#define QEMU_MAKE_LOCKABLE_(x) qemu_make_lockable((x), &(QemuLockable) {  =
  \
+#define QEMU_MAKE_LOCKABLE_(x) (&(QemuLockable) {    \
         .object =3D (x),                               \
         .lock =3D QEMU_LOCK_FUNC(x),                   \
         .unlock =3D QEMU_UNLOCK_FUNC(x),               \
@@ -75,14 +75,27 @@ qemu_make_lockable(void *x, QemuLockable *lockable)
=20
 /* QEMU_MAKE_LOCKABLE - Make a polymorphic QemuLockable
  *
- * @x: a lock object (currently one of QemuMutex, CoMutex, QemuSpin).
+ * @x: a lock object (currently one of QemuMutex, QemuRecMutex, CoMutex, Q=
emuSpin).
  *
  * Returns a QemuLockable object that can be passed around
- * to a function that can operate with locks of any kind.
+ * to a function that can operate with locks of any kind, or
+ * NULL if @x is %NULL.
  */
 #define QEMU_MAKE_LOCKABLE(x)                        \
     QEMU_GENERIC(x,                                  \
                  (QemuLockable *, (x)),              \
+                 qemu_make_lockable((x), QEMU_MAKE_LOCKABLE_(x)))
+
+/* QEMU_MAKE_LOCKABLE_NONNULL - Make a polymorphic QemuLockable
+ *
+ * @x: a lock object (currently one of QemuMutex, QemuRecMutex, CoMutex, Q=
emuSpin).
+ *
+ * Returns a QemuLockable object that can be passed around
+ * to a function that can operate with locks of any kind.
+ */
+#define QEMU_MAKE_LOCKABLE_NONNULL(x)                \
+    QEMU_GENERIC(x,                                  \
+                 (QemuLockable *, (x)),              \
                  QEMU_MAKE_LOCKABLE_(x))
=20
 static inline void qemu_lockable_lock(QemuLockable *x)
@@ -112,7 +125,7 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuLockable, qemu_lockab=
le_auto_unlock)
=20
 #define WITH_QEMU_LOCK_GUARD_(x, var) \
     for (g_autoptr(QemuLockable) var =3D \
-                qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE((x))); \
+                qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x))); =
\
          var; \
          qemu_lockable_auto_unlock(var), var =3D NULL)
=20

So thank you NetBSD compiler, I guess. :P

Paolo


--1Rlod7JDESHaavyNpnxSt4ezosCee3ECQ--

--IEJR2oFyffvWxNNDar86Fy1honSCplTPc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl5w4uYACgkQv/vSX3jH
roPHowf9EaKf0tSrQbeDIQT37bsSOZB5xzk9lLydR+SmV4DLPdCHb3krYAk+Vh8x
A4DEyGFN7QiCvRKu+P7uW0K0oIhmZW0iElE72Ao7yKJO7i9YSFamm3dV1fYocFpD
+i7IgyIZP3+SkK76F//XhK0Bcg+ZXVwXUevvEtfAAX0KwCAZEZcx739/AbZXsMwU
JWOZwc1j/tM3OJh5NL1WOAk8Crkq3ssr/JQLbik9e/Kse8IBM5eugqciD+jz2g7E
waBYWqoa9tNjH9Pr6gPKvBUObFrtsWlLY6bViks7p0BsJ2Jl56LeG6rSCHsVMVJi
7fRPyyb7mceNSQboTGCs7OM1s0q/wA==
=f5Sl
-----END PGP SIGNATURE-----

--IEJR2oFyffvWxNNDar86Fy1honSCplTPc--


