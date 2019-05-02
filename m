Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A5AC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 17:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0337F205F4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 17:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcOB6e8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0337F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56457 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMFV0-0005Ck-1I
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 13:27:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMFTx-0004dK-Ir
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMFTw-00028q-II
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:26:53 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:45764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hMFTw-00027t-7K; Thu, 02 May 2019 13:26:52 -0400
Received: by mail-lj1-x241.google.com with SMTP id w12so2896748ljh.12;
	Thu, 02 May 2019 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=yL6hsLLHLUnpmjBqOuiRzGyVC4wKuA+peggResZAqGo=;
	b=EcOB6e8LZhtdCHNCNAVpkun58Fj8wuVNlsngFzQQPXiuL6MoPiV/orOopYyYvRqbUu
	n/Q9lG5eIVV4NEaHpy1pM+uOA6KFBYxAFzv3TdSBPZq7F61ezyl0H5qbuuO6RA+O4/vw
	+9LBZB8MBfo1FB+KoRveQw6dbA20++Won9falCmzr/JlF7eLlPAzISAv3ydgMYblHij8
	oz1tMzRHuROkbC29WS8wiaz+YP7+rqGXvcq4rDI7ix519H9ZtnhEzDRi6FM5KIhw1jZV
	S9bnjmM2Zcf0xNosFGMDWiferMg9yFSmMZMJdzdrwjn+MDlXpaYDJ+FhqQ6gVPCneLnT
	H8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=yL6hsLLHLUnpmjBqOuiRzGyVC4wKuA+peggResZAqGo=;
	b=XAEaGPz1QnZRh3xWxxCnIdZOvHkHLt9p0bmrwP3Bpjg1LGLZSVvMtpE99Euzkd0jsI
	b2ptY7dZAUqqhsFGjrrgBqqMoVXJbFSASalHooZfjuFwxFdZhdItD1g88KommXcrcdKE
	0O3eX14IBs3oe0qAcd6uUbs+k2b5Ti2i6Y+FNQzWOLIZfb90xQ1e6epVfFje0Zw4T4Zk
	1ZZ1VVVl0X/ZPbN6DU+dOIDo/iIaFpBClDfDX3nLbBlvDIUzXQHvzz/ZMzWGXX/X4Ahk
	2Nsi99T5/yS718yUohjngI4OBAnixO64eXQoGhSPq9b8U3Ra4cNMpuRc1sUjDCy5if47
	jvyw==
X-Gm-Message-State: APjAAAXkRSwMCkdTX4csScuWtPdxUM1bur0zqVF9ytsRjy+GnrC4Idik
	xyxgpd8AcxIfpn6L/zp97g8jRUa5tsxwcUTLjfE=
X-Google-Smtp-Source: APXvYqwYMo9uY/sMg2UrGD3vPvPUQxMTZYsbF16rFUWKvi08P6a9TU9tRi4TZs9IO6UIOiURXv2e4LoIzGpNhRQK2kY=
X-Received: by 2002:a2e:2b8c:: with SMTP id r12mr2743802ljr.115.1556818010621; 
	Thu, 02 May 2019 10:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<14aab381eaa678eca875d0b8bd456feb22a21bd8.1556666645.git.alistair.francis@wdc.com>
	<503a1f5f-7dad-1e4e-e1b1-aaeeeac9739f@vivier.eu>
	<af19377f-4874-0374-99b6-ee9ab5b0f446@redhat.com>
In-Reply-To: <af19377f-4874-0374-99b6-ee9ab5b0f446@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 May 2019 10:24:53 -0700
Message-ID:
 <CAKmqyKP+o6MfqBQfkOmSXvoj-BX43KJD+ayzxZA6t-N-DucD5w@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v2 4/5] linux-user/uname: Fix GCC 9 build
 warnings
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	Laurent Vivier <laurent@vivier.eu>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502172453.lCC-zq9i434cccSkS5DNp8OngZlPWKfQmU2O1wC6yxc@z>

On Wed, May 1, 2019 at 5:00 AM Eric Blake <eblake@redhat.com> wrote:
>
> On 5/1/19 4:40 AM, Laurent Vivier wrote:
> > On 01/05/2019 01:28, Alistair Francis wrote:
> >> Fix this warning when building with GCC9 on Fedora 30:
> >> In function =E2=80=98strncpy=E2=80=99,
> >>     inlined from =E2=80=98sys_uname=E2=80=99 at /home/alistair/qemu/li=
nux-user/uname.c:94:3:
> >> /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin=
_strncpy=E2=80=99 output may be truncated copying 64 bytes from a string of=
 length 64 [-Werror=3Dstringop-truncation]
> >>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos =
(__dest));
> >>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
> >>
> >> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

I'm dropping this patch in favour of the other one.

Alistair

> >> ---
> >>  linux-user/uname.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/linux-user/uname.c b/linux-user/uname.c
> >> index 313b79dbad..2fc6096a5b 100644
> >> --- a/linux-user/uname.c
> >> +++ b/linux-user/uname.c
> >> @@ -73,7 +73,7 @@ const char *cpu_to_uname_machine(void *cpu_env)
> >>  #define COPY_UTSNAME_FIELD(dest, src) \
> >>    do { \
> >>        /* __NEW_UTS_LEN doesn't include terminating null */ \
> >> -      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
> >> +      (void) memcpy((dest), (src), MIN(strlen(src), __NEW_UTS_LEN)); =
\
> >
> > You should use MIN(strlen(src) + 1, __NEW_UTS_LEN) to copy the NUL
> > character if it is present and fit in __NEW_UTS_LEN.
>
> No, the NUL character is already present, due to the memset() prior to
> any use of COPY_UTSNAME_FIELD().  However, the commit message should
> call that out, as it is not part of the default 3-line diff.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>

