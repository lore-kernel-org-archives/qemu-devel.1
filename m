Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A165CC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F31C20863
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F31C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7JQQ-0002SX-KP
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 09:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i7JPG-0001uS-73
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i7JPF-0008G5-1I
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:08:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59642)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i7JPE-0008FR-QH
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:08:32 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CC5FC8E00B
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 13:08:31 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id 32so2918407wrk.15
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 06:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MUzOlOuiyWN6TlMFc+i/uQ2Ofkif5avzzip9pXQ60lo=;
 b=JNGLyMvftMIQPRU3ZrIOhHPof1o6v6FL/HC88CaGhyq52TB6K7O/725rzAV7vksS7m
 PD3sJMT5zoZaeUBFnu74o7XiEKrAFylHW/Hogb2jBbg9Jw0xBHvSBas2ayzVoUHtJGjM
 rhJ3/TibiCHXWgHyF+4JILfM+WUM+Tmckg1g2NbcEE/oqE1w2rxb0XEguVthVfbKJhxe
 gGnf7vvIk2lpKFH7PDbEQJIjo5iVNzoQiuHVsbig8sBr57O/E7E82uuUPWBlSJeVBtY/
 GI9cVCVrWWqaVK8HToyXup5nE88ipi8uC1eR6v1mYpE3lneqKp9WnlrJnFHBYz+m8KdF
 qzow==
X-Gm-Message-State: APjAAAVzRnx66Wi4/fhi+9ZNRs36NlK1jQ/MVDs4z7ix/8I/oX/ss0xA
 +q245jdZLSEe9aoZqeOtqfoaSGTt7lzG6eLcFtIG9Ga4WoGAUBbmFyohlHWWCaDE9n3eaLuD1Zt
 sZ6Lu1YtosvDPSOI=
X-Received: by 2002:a1c:5451:: with SMTP id p17mr18916893wmi.103.1568034510471; 
 Mon, 09 Sep 2019 06:08:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx1CuUb3+ulgkViKEyTkVYJMV9GnDOHX4PothNN7hR4SDCMzNJ/naIKZRLrSmNnAGww9PAn/A==
X-Received: by 2002:a1c:5451:: with SMTP id p17mr18916832wmi.103.1568034509620; 
 Mon, 09 Sep 2019 06:08:29 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id s3sm11162552wmj.48.2019.09.09.06.08.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2019 06:08:29 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190909130655.24495-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d3a4c936-89db-710f-7116-b1f5b77a205f@redhat.com>
Date: Mon, 9 Sep 2019 15:08:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190909130655.24495-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] test-char: fix AddressSanitizer failure
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
Cc: marcandre.lureau@redhat.com, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/19 3:06 PM, Paolo Bonzini wrote:
> The CharSocketServerTestConfig and CharSocketClientTestConfig
> objects escape after they are passed to g_test_add_data_func,
> but they cease existing after the scope that defines them is
> closed.  Make them static to fix this issue.
>=20
> Fixes: e7b6ba4186f243f149b0d8cddc129fe681ba3912
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  tests/test-char.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/tests/test-char.c b/tests/test-char.c
> index f3ebdffd87..525a476b89 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -1403,13 +1403,13 @@ int main(int argc, char **argv)
>  #endif
> =20
>  #define SOCKET_SERVER_TEST(name, addr)                                =
  \
> -    CharSocketServerTestConfig server1 ## name =3D                    =
    \
> +    static CharSocketServerTestConfig server1 ## name =3D             =
    \
>          { addr, false, false };                                       =
  \
> -    CharSocketServerTestConfig server2 ## name =3D                    =
    \
> +    static CharSocketServerTestConfig server2 ## name =3D             =
    \
>          { addr, true, false };                                        =
  \
> -    CharSocketServerTestConfig server3 ## name =3D                    =
    \
> +    static CharSocketServerTestConfig server3 ## name =3D             =
    \
>          { addr, false, true };                                        =
  \
> -    CharSocketServerTestConfig server4 ## name =3D                    =
    \
> +    static CharSocketServerTestConfig server4 ## name =3D             =
    \
>          { addr, true, true };                                         =
  \
>      g_test_add_data_func("/char/socket/server/mainloop/" # name,      =
  \
>                           &server1 ##name, char_socket_server_test);   =
  \
> @@ -1421,17 +1421,17 @@ int main(int argc, char **argv)
>                           &server4 ##name, char_socket_server_test)
> =20
>  #define SOCKET_CLIENT_TEST(name, addr)                                =
  \
> -    CharSocketClientTestConfig client1 ## name =3D                    =
    \
> +    static CharSocketClientTestConfig client1 ## name =3D             =
    \
>          { addr, NULL, false, false };                                 =
  \
> -    CharSocketClientTestConfig client2 ## name =3D                    =
    \
> +    static CharSocketClientTestConfig client2 ## name =3D             =
    \
>          { addr, NULL, true, false };                                  =
  \
> -    CharSocketClientTestConfig client3 ## name =3D                    =
    \
> +    static CharSocketClientTestConfig client3 ## name =3D             =
    \
>          { addr, ",reconnect=3D1", false };                            =
    \
> -    CharSocketClientTestConfig client4 ## name =3D                    =
    \
> +    static CharSocketClientTestConfig client4 ## name =3D             =
    \
>          { addr, ",reconnect=3D1", true };                             =
    \
> -    CharSocketClientTestConfig client5 ## name =3D                    =
    \
> +    static CharSocketClientTestConfig client5 ## name =3D             =
    \
>          { addr, NULL, false, true };                                  =
  \
> -    CharSocketClientTestConfig client6 ## name =3D                    =
    \
> +    static CharSocketClientTestConfig client6 ## name =3D             =
    \
>          { addr, NULL, true, true };                                   =
  \
>      g_test_add_data_func("/char/socket/client/mainloop/" # name,      =
  \
>                           &client1 ##name, char_socket_client_test);   =
  \
>=20

