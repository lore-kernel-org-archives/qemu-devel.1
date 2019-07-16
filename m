Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C47C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A7820665
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A7820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnKMT-00067s-Gn
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 06:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40853)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlureau@redhat.com>) id 1hnKMI-0005ey-2n
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1hnKMG-0001cm-Rj
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:06:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hnKMG-0001bh-MC
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:06:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so20420666ota.8
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 03:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dx3CdELmDXsET7wy8Jp4hI2LmL4Kww1Q6vEpM5r+8nM=;
 b=FZsBaoq4/938iiYQqxr63DVgDBcl6/cUwUfx7YoIpuSJTb21cDYkIsTbx4/+mAzD1N
 mtlQ5xiq4fFZeqFc3xYm58FkgA3k3OKvfYhy9wfuZv6MBDMRTQLWMha6hrNLN3lkEvEv
 8zjmebJBUYoy0R829hJS1HW6agrluk0sRaEcAbVbzDsYbuEuequZqF4AmSy/bcNnZGY4
 IhwdYB9w4umbyylTzHf49QQcnzy2p7pqHPuJccOMUcEzV3E8wg2TN86AaL36mh/LdPzR
 5JROc1EVlausam2MaPUCoACLBjbuLUBhvkWT+k+WW9hgU7QuMsPoN9wzMoKlJZzgRFGk
 dqEw==
X-Gm-Message-State: APjAAAULBsF8eqmbfzA3y6ejB5JgYaY8mhPdYThdxqfO/rY5NxEQFnE9
 hTE3fBwrtr++Jv6vopX99TiUtLt0iHDv5V1VhNAKGw==
X-Google-Smtp-Source: APXvYqy1KGCXj+Hc6NkOw2KuSaATaurJuyjkPr7P2pUzz8qhrWScmGPcd39jN5YEMXfdrceafy1ut1gJop+yJfXqwi0=
X-Received: by 2002:a05:6830:1009:: with SMTP id
 a9mr14585944otp.331.1563271611751; 
 Tue, 16 Jul 2019 03:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190716084240.17594-1-marcandre.lureau@redhat.com>
 <fe523ffd-43fb-3b9d-b4e1-ea11d1c63de7@redhat.com>
In-Reply-To: <fe523ffd-43fb-3b9d-b4e1-ea11d1c63de7@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jul 2019 14:06:40 +0400
Message-ID: <CAMxuvay3shknbiruw88pV9A0=AiWo=ttJgsNwnz-jaM_F8Hpxg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.65
Subject: Re: [Qemu-devel] [PATCH] nbd: fix uninitialized variable warning
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Jul 16, 2019 at 1:19 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Marc-Andr=C3=A9,
>
> On 7/16/19 10:42 AM, Marc-Andr=C3=A9 Lureau wrote:
> > ../block/nbd.c: In function 'nbd_co_request':
> > ../block/nbd.c:745:8: error: 'local_reply.type' may be used uninitializ=
ed in this function [-Werror=3Dmaybe-uninitialized]
> >      if (chunk->type =3D=3D NBD_REPLY_TYPE_NONE) {
> >         ^
> > ../block/nbd.c:710:14: note: 'local_reply.type' was declared here
> >      NBDReply local_reply;
> >               ^~~~~~~~~~~
> > ../block/nbd.c:710:14: error: 'local_reply.flags' may be used uninitial=
ized in this function [-Werror=3Dmaybe-uninitialized]
> > ../block/nbd.c:738:8: error: 'local_reply.<U4be0>.magic' may be used un=
initialized in this function [-Werror=3Dmaybe-uninitialized]
> >      if (nbd_reply_is_simple(reply) || s->quit) {
> >         ^
> > ../block/nbd.c:710:14: note: 'local_reply.<U4be0>.magic' was declared h=
ere
> >      NBDReply local_reply;
> >               ^~~~~~~~~~~
> > cc1: all warnings being treated as errors
>
> Thomas reported this error when compiling with -O3 few months ago [1].

Thanks, I couldn't find a previous report.

> Are you using that, or the latest GCC emit a warning even with no -O3?

Right, the warning seems to appear with -O3 (I happen to have it with
mingw64-gcc-8.3.0-2.fc30.x86_64)

>
> Personally I'd add:
>
> Fixes: 86f8cdf3db8

Actually, it was there before, so I'll skip that.

> Reported-by: Thomas Huth <thuth@redhat.com>
>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  block/nbd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block/nbd.c b/block/nbd.c
> > index 81edabbf35..02eef09728 100644
> > --- a/block/nbd.c
> > +++ b/block/nbd.c
> > @@ -707,7 +707,7 @@ static bool nbd_reply_chunk_iter_receive(BDRVNBDSta=
te *s,
> >                                           void **payload)
> >  {
> >      int ret, request_ret;
> > -    NBDReply local_reply;
> > +    NBDReply local_reply =3D { 0, };
>
> Yesterday [2] Peter said: "=3D {}" is our standard struct-zero-initialize=
r
> so we should prefer that.
>
> With {}:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

ok, thanks

>
> >      NBDStructuredReplyChunk *chunk;
> >      Error *local_err =3D NULL;
> >      if (s->quit) {
> >
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07007.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03431.html

