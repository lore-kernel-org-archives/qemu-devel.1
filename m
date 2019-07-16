Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9D8C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1E6206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1E6206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnKO2-0000Hv-Bk
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 06:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41327)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlureau@redhat.com>) id 1hnKNs-0008Kk-Vp
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1hnKNs-0002tf-3d
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:08:32 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37561)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hnKNr-0002tE-V9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:08:32 -0400
Received: by mail-ot1-f65.google.com with SMTP id s20so20434529otp.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 03:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ts7UVcPIP0ANFsKvIWEurU1wrAWE6EjXIDzM9Y/pI8w=;
 b=ivV28GkcYDkwKxBNwMn3p+PPLEU3sXgA+eESq1WgXZffF1KeUDaHCqepn0XmdGUi/8
 N4zO1TXKtzk/3ivfg6FjFCbimZ41G8RcNvVWkw9w4T3K3gzrMAmYHo2KDKlSJo+NDhEv
 /vlyxSYfjfOejP1BjZUkc/bRAJu/6EjnCR4V9k/590DwtGQ7LEVlCvY/N4L4y1wR37oF
 irhdzx7xVkw1smyC7jJRqhJnF+ZMxL7qHRFsTgy7Nfe68zOVZPU5RN1BDHx01IcquZ2x
 IspMqm0lamBF6ZDOsh+o/NerGzUJEqAwN20eK7r4dINsKNANUFf3S+QoIqg/AiQ638FU
 /WJA==
X-Gm-Message-State: APjAAAW56uf7zWp5hq9lmEjiCuPj6gTO6yprjq2ccXQ13WzIxk/wtnZ2
 7R0t5zYBVpLNifjD3jVx8fPhk0Zcfy9LQAyaDFB+HmB/
X-Google-Smtp-Source: APXvYqzfPybjU8ZItLgIEhc0fZNrNihTW1NXM/KVtLc4a7nv+cXg8wNhU16TXw5qUXcgZmmog3qZr2LRs18NCZpOBhM=
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr3788302otq.38.1563271710979; 
 Tue, 16 Jul 2019 03:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190716100719.29722-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190716100719.29722-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jul 2019 14:08:19 +0400
Message-ID: <CAMxuvawhGEP3vgOrkiwQGUCM+PJfUV3oQngoTPOA3hO1r9g+_Q@mail.gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.65
Subject: Re: [Qemu-devel] [PATCH 1/2] rdmacm-mux: fix strcpy string warning
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
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 16, 2019 at 2:07 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> ../contrib/rdmacm-mux/main.c: In function =E2=80=98parse_args=E2=80=99:
> ../contrib/rdmacm-mux/main.c:118:13: error: =E2=80=98strncpy=E2=80=99 spe=
cified bound 3835 equals destination size [-Werror=3Dstringop-truncation]
>   118 |             strncpy(unix_socket_path, optarg, SOCKET_PATH_MAX);
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

oops resend by mistake, please ignore

> ---
>  contrib/rdmacm-mux/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c
> index 30c7052651..de53048f06 100644
> --- a/contrib/rdmacm-mux/main.c
> +++ b/contrib/rdmacm-mux/main.c
> @@ -115,7 +115,7 @@ static void parse_args(int argc, char *argv[])
>
>          case 's':
>              /* This is temporary, final name will build below */
> -            strncpy(unix_socket_path, optarg, SOCKET_PATH_MAX);
> +            strncpy(unix_socket_path, optarg, SOCKET_PATH_MAX - 1);
>              break;
>
>          case 'p':
> --
> 2.22.0.428.g6d5b264208
>

