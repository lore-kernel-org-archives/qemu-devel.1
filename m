Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B176C606AC
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 12:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7FD32086D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 12:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FD32086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weilnetz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkSRV-0002Kv-VY
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 08:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57191)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sw@weilnetz.de>) id 1hkSNr-0008Qg-JH
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 08:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sw@weilnetz.de>) id 1hkSNp-000601-3w
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 08:04:39 -0400
Received: from smtp.mail.uni-mannheim.de ([2001:7c0:600:60::869b:6050]:50838)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1hkSNo-0005yk-PW
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 08:04:37 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.mail.uni-mannheim.de (Postfix) with ESMTP id C40BD1034F5;
 Mon,  8 Jul 2019 14:04:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at uni-mannheim.de
Received: from smtp.mail.uni-mannheim.de ([134.155.96.80])
 by localhost (mail-r83.rz.uni-mannheim.de [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id Qs9KWNL2eVN0; Mon,  8 Jul 2019 14:04:27 +0200 (CEST)
Received: from [134.155.36.73] (edv13.bib.uni-mannheim.de [134.155.36.73])
 by smtp.mail.uni-mannheim.de (Postfix) with ESMTPSA id A766B103701;
 Mon,  8 Jul 2019 14:04:25 +0200 (CEST)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1534182832-554-5-git-send-email-aleksandar.markovic@rt-rk.com>
 <4da49ffe-902f-2cf2-8a21-2bbd511b17a4@weilnetz.de>
 <CAL1e-=jE8X1ODnA0aSXe5OCqJzYA0J47h5b6=H_UivPP11zSQA@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Openpgp: preference=signencrypt
Autocrypt: addr=sw@weilnetz.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <591d71a5-5b10-ab22-4751-01da8613d84c@weilnetz.de>
Date: Mon, 8 Jul 2019 14:04:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jE8X1ODnA0aSXe5OCqJzYA0J47h5b6=H_UivPP11zSQA@mail.gmail.com>
Content-Language: en-GB
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:7c0:600:60::869b:6050
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] Handling of fall through code (was: [PATCH v8
 04/87] target/mips: Mark switch fallthroughs with interpretable comments
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
Cc: pburton@wavecomp.com, peter.maydell@linaro.org, smarkovic@wavecomp.com,
 riku.voipio@iki.fi, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 laurent@vivier.eu, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 philippe.mathieu.daude@gmail.com, amarkovic@wavecomp.com,
 pjovanovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.07.2019 um 10:14 schrieb Aleksandar Markovic:
>
> On Jul 7, 2019 10:26 PM, "Stefan Weil" <sw@weilnetz.de
> <mailto:sw@weilnetz.de>> wrote:
> > - There is also fallthrough code which is obviously not correct
> (even in target/mips/translate.c).
>
> Can you please be more specific about those cases from
> target/mips/translate.c?
>

Hi Aleksandar,

this is the list of warnings for target/mips/translate.c:

/home/debian/src/github/qemu/qemu/target/mips/translate.c:10047:13:
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
/home/debian/src/github/qemu/qemu/target/mips/translate.c:10056:13:
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
/home/debian/src/github/qemu/qemu/target/mips/translate.c:20138:13:
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
/home/debian/src/github/qemu/qemu/target/mips/translate.c:20144:13:
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
/home/debian/src/github/qemu/qemu/target/mips/translate.c:6739:9:
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
/home/debian/src/github/qemu/qemu/target/mips/translate.c:9820:13:
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
/home/debian/src/github/qemu/qemu/target/mips/translate.c:9829:13:
warning: this statement may fall through [-Wimplicit-fallthrough=3D]

I have built using

=C2=A0=C2=A0=C2=A0 ../configure --disable-werror '--extra-cflags=3D-Wextr=
a
-Wimplicit-fallthrough=3D2'

The build process produced warnings for 79 fallthrough locations. See
build protocol:

=C2=A0=C2=A0=C2=A0 https://qemu.weilnetz.de/results/build-20190708.txt (1=
16 MiB !)

Sometimes the fallthrough comment is misplaced in the following case
statement or followed by code, so the compiler (correctly) won't accept
it. Maybe there exist also fallthrough comments although there is no
fallthrough code.

The protocol also shows 18 warnings [-Wcast-function-type] which might
indicate bugs:

/home/debian/src/github/qemu/qemu/chardev/char-fe.c:372:32: warning:
cast between incompatible function types from =E2=80=98GIOFunc=E2=80=99 {=
aka =E2=80=98int
(*)(struct _GIOChannel *, enum <anonymous>,=C2=A0 void *)=E2=80=99} to =E2=
=80=98gboolean
(*)(void *)=E2=80=99 {aka =E2=80=98int (*)(void *)=E2=80=99} [-Wcast-func=
tion-type]
/home/debian/src/github/qemu/qemu/chardev/char-io.c:92:20: warning: cast
between incompatible function types from =E2=80=98QIOChannelFunc=E2=80=99=
 {aka =E2=80=98int
(*)(struct QIOChannel *, enum <anonymous>,=C2=A0 void *)=E2=80=99} to =E2=
=80=98gboolean
(*)(void *)=E2=80=99 {aka =E2=80=98int (*)(void *)=E2=80=99} [-Wcast-func=
tion-type]
/home/debian/src/github/qemu/qemu/chardev/char-socket.c:606:42: warning:
cast between incompatible function types from =E2=80=98gboolean (*)(QIOCh=
annel
*, GIOCondition,=C2=A0 void *)=E2=80=99 {aka =E2=80=98int (*)(struct QIOC=
hannel *, enum
<anonymous>,=C2=A0 void *)=E2=80=99} to =E2=80=98gboolean (*)(void *)=E2=80=
=99 {aka =E2=80=98int (*)(void
*)=E2=80=99} [-Wcast-function-type]
/home/debian/src/github/qemu/qemu/contrib/libvhost-user/libvhost-user-gli=
b.c:59:6:
warning: cast between incompatible function types from =E2=80=98GSourceFu=
nc=E2=80=99
{aka =E2=80=98int (*)(void *)=E2=80=99} to =E2=80=98void (*)(VuDev *, int=
,=C2=A0 void *)=E2=80=99 {aka =E2=80=98void
(*)(struct VuDev *, int,=C2=A0 void *)=E2=80=99} [-Wcast-function-type]
/home/debian/src/github/qemu/qemu/contrib/libvhost-user/libvhost-user-gli=
b.c:85:33:
warning: cast between incompatible function types from =E2=80=98vu_watch_=
cb=E2=80=99
{aka =E2=80=98void (*)(struct VuDev *, int,=C2=A0 void *)=E2=80=99} to =E2=
=80=98gboolean (*)(void *)=E2=80=99
{aka =E2=80=98int (*)(void *)=E2=80=99} [-Wcast-function-type]
/home/debian/src/github/qemu/qemu/io/channel-buffer.c:182:27: warning:
cast between incompatible function types from =E2=80=98GSourceFunc=E2=80=99=
 {aka =E2=80=98int
(*)(void *)=E2=80=99} to =E2=80=98gboolean (*)(QIOChannel *, GIOCondition=
,=C2=A0 void *)=E2=80=99
{aka =E2=80=98int (*)(struct QIOChannel *, enum <anonymous>,=C2=A0 void *=
)=E2=80=99}
[-Wcast-function-type]
/home/debian/src/github/qemu/qemu/io/channel.c:315:35: warning: cast
between incompatible function types from =E2=80=98QIOChannelFunc=E2=80=99=
 {aka =E2=80=98int
(*)(struct QIOChannel *, enum <anonymous>,=C2=A0 void *)=E2=80=99} to =E2=
=80=98gboolean
(*)(void *)=E2=80=99 {aka =E2=80=98int (*)(void *)=E2=80=99} [-Wcast-func=
tion-type]
/home/debian/src/github/qemu/qemu/io/channel.c:507:27: warning: cast
between incompatible function types from =E2=80=98gboolean (*)(QIOChannel=
 *,
GIOCondition,=C2=A0 void *)=E2=80=99 {aka =E2=80=98int (*)(struct QIOChan=
nel *, enum
<anonymous>,=C2=A0 void *)=E2=80=99} to =E2=80=98gboolean (*)(void *)=E2=80=
=99 {aka =E2=80=98int (*)(void
*)=E2=80=99} [-Wcast-function-type]
/home/debian/src/github/qemu/qemu/io/channel-watch.c:216:27: warning:
cast between incompatible function types from =E2=80=98GSourceFunc=E2=80=99=
 {aka =E2=80=98int
(*)(void *)=E2=80=99} to =E2=80=98gboolean (*)(QIOChannel *, GIOCondition=
,=C2=A0 void *)=E2=80=99
{aka =E2=80=98int (*)(struct QIOChannel *, enum <anonymous>,=C2=A0 void *=
)=E2=80=99}
[-Wcast-function-type]
/home/debian/src/github/qemu/qemu/io/channel-watch.c:81:27: warning:
cast between incompatible function types from =E2=80=98GSourceFunc=E2=80=99=
 {aka =E2=80=98int
(*)(void *)=E2=80=99} to =E2=80=98gboolean (*)(QIOChannel *, GIOCondition=
,=C2=A0 void *)=E2=80=99
{aka =E2=80=98int (*)(struct QIOChannel *, enum <anonymous>,=C2=A0 void *=
)=E2=80=99}
[-Wcast-function-type]
/home/debian/src/github/qemu/qemu/io/channel-websock.c:1258:27: warning:
cast between incompatible function types from =E2=80=98GSourceFunc=E2=80=99=
 {aka =E2=80=98int
(*)(void *)=E2=80=99} to =E2=80=98gboolean (*)(QIOChannel *, GIOCondition=
,=C2=A0 void *)=E2=80=99
{aka =E2=80=98int (*)(struct QIOChannel *, enum <anonymous>,=C2=A0 void *=
)=E2=80=99}
[-Wcast-function-type]
/home/debian/src/github/qemu/qemu/io/net-listener.c:236:31: warning:
cast between incompatible function types from =E2=80=98gboolean (*)(QIOCh=
annel
*, GIOCondition,=C2=A0 void *)=E2=80=99 {aka =E2=80=98int (*)(struct QIOC=
hannel *, enum
<anonymous>,=C2=A0 void *)=E2=80=99} to =E2=80=98gboolean (*)(void *)=E2=80=
=99 {aka =E2=80=98int (*)(void
*)=E2=80=99} [-Wcast-function-type]
/home/debian/src/github/qemu/qemu/target/i386/translate.c:2850:16:
warning: cast between incompatible function types from =E2=80=98void (*)(=
struct
TCGv_ptr_d *, struct TCGv_ptr_d *, struct TCGv_ptr_d *, struct
TCGv_i32_d *)=E2=80=99 to =E2=80=98void (*)(struct TCGv_ptr_d *, struct T=
CGv_ptr_d *,
struct TCGv_ptr_d *)=E2=80=99 [-Wcast-function-type]
/home/debian/src/github/qemu/qemu/target/i386/translate.c:2850:16:
warning: cast between incompatible function types from =E2=80=98void (*)(=
struct
TCGv_ptr_d *, struct TCGv_ptr_d *, struct TCGv_ptr_d *, struct
TCGv_i64_d *)=E2=80=99 to =E2=80=98void (*)(struct TCGv_ptr_d *, struct T=
CGv_ptr_d *,
struct TCGv_ptr_d *)=E2=80=99 [-Wcast-function-type]
/home/debian/src/github/qemu/qemu/target/i386/translate.c:2851:16:
warning: cast between incompatible function types from =E2=80=98void (*)(=
struct
TCGv_ptr_d *, struct TCGv_ptr_d *, struct TCGv_ptr_d *, struct
TCGv_i32_d *)=E2=80=99 to =E2=80=98void (*)(struct TCGv_ptr_d *, struct T=
CGv_ptr_d *,
struct TCGv_ptr_d *)=E2=80=99 [-Wcast-function-type]
/home/debian/src/github/qemu/qemu/target/i386/translate.c:2851:16:
warning: cast between incompatible function types from =E2=80=98void (*)(=
struct
TCGv_ptr_d *, struct TCGv_ptr_d *, struct TCGv_ptr_d *, struct
TCGv_i64_d *)=E2=80=99 to =E2=80=98void (*)(struct TCGv_ptr_d *, struct T=
CGv_ptr_d *,
struct TCGv_ptr_d *)=E2=80=99 [-Wcast-function-type]
/home/debian/src/github/qemu/qemu/target/i386/translate.c:4469:27:
warning: cast between incompatible function types from =E2=80=98SSEFunc_0=
_epp=E2=80=99
{aka =E2=80=98void (*)(struct TCGv_ptr_d *, struct TCGv_ptr_d *, struct
TCGv_ptr_d *)=E2=80=99} to =E2=80=98void (*)(struct TCGv_ptr_d *, struct =
TCGv_ptr_d *,
struct TCGv_ptr_d *, struct TCGv_i32_d *)=E2=80=99 [-Wcast-function-type]
/home/debian/src/github/qemu/qemu/target/i386/translate.c:4469:27:
warning: cast between incompatible function types from =E2=80=98SSEFunc_0=
_epp=E2=80=99
{aka =E2=80=98void (*)(struct TCGv_ptr_d *, struct TCGv_ptr_d *, struct
TCGv_ptr_d *)=E2=80=99} to =E2=80=98void (*)(struct TCGv_ptr_d *, struct =
TCGv_ptr_d *,
struct TCGv_ptr_d *, struct TCGv_i64_d *)=E2=80=99 [-Wcast-function-type]

Daniel, here is one possible fix (I am not sure how important that is):

diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index 96f186f442..074cece468 100644
--- a/crypto/hash-nettle.c
+++ b/crypto/hash-nettle.c
@@ -28,10 +28,10 @@
=C2=A0
=C2=A0typedef void (*qcrypto_nettle_init)(void *ctx);
=C2=A0typedef void (*qcrypto_nettle_write)(void *ctx,
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uns=
igned int len,
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 siz=
e_t len,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
const uint8_t *buf);
=C2=A0typedef void (*qcrypto_nettle_result)(void *ctx,
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 unsigned int len,
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 size_t len,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint8_t *buf);

Regards
Stefan

