Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4E7C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 16:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB65206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 16:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB65206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn46p-0001gi-OJ
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 12:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36025)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hn46b-0001BB-Dn
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 12:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hn46Z-0006Y4-FD
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 12:45:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45524)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hn46X-0006Uf-FQ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 12:45:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so17807827wre.12
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 09:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RdD9ZFMqCnEp5edOsUdwqWGGqk4Byt0NvgoZsRxRYdQ=;
 b=bBxcgARVPFvQ05PvJpJOHvyi7PNr72rVF4w2edabiGXdfFxK47ktWhSH4ScILDV3v/
 OhCKzEyrFzGLKP2ASW6fkMu8kf+IAdzyzRzQAv/cIaJN4kmRcOx6JSCe8kj90OiGaAz/
 7tOmph+dYarPTN2nUj3eiLbsCsSC/H6zDeb2EQD3Sj6RwiN88hfRr6K+qJGE//FrPcMk
 lLqwskOIcMGO8pK/8FAG0+oxOzjJd1wq38svvdyoXR9y08xdRcDAVqUVDyJD7gLQrg2M
 nMJkdpsH/uXXWBQbUk/mbWAlyP+3RgZisIQsWa90JHbcoIT11N0t89stKzJFTIYv62a+
 7n8Q==
X-Gm-Message-State: APjAAAXKtq9bIsPb2c63g6dIuxG1VBI6vCFIt5sE0jlERkzzJ9+7eOfw
 54UKipnbsmBHA3vkqi2r6HPtFg==
X-Google-Smtp-Source: APXvYqxWfTrhDlXFWqVzdveCJTUn6XQ8H6Ht0qAoyEmU4Sa+ST62F/G6EBJib4PzzJWYIrC1/buf2w==
X-Received: by 2002:adf:ff84:: with SMTP id j4mr28733578wrr.71.1563209129676; 
 Mon, 15 Jul 2019 09:45:29 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id e19sm24109114wra.71.2019.07.15.09.45.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 09:45:29 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190713143311.17620-1-marcandre.lureau@redhat.com>
 <20190713143311.17620-6-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2cbc75cf-887d-630d-f4e9-835d8ad135f1@redhat.com>
Date: Mon, 15 Jul 2019 18:45:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190713143311.17620-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v3 5/6] test-char: skip tcp tests if ipv4
 check failed
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
Cc: Fam Zheng <fam@euphon.net>, pbonzini@redhat.com, berrange@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/19 4:33 PM, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/Makefile.include |  2 +-
>  tests/test-char.c      | 17 +++++++++++++----
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index a983dd32da..2bddebaf4b 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -523,7 +523,7 @@ tests/check-qlit$(EXESUF): tests/check-qlit.o $(test-util-obj-y)
>  tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test-qom-obj-y)
>  tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-qom-obj-y)
>  
> -tests/test-char$(EXESUF): tests/test-char.o $(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y) $(chardev-obj-y)
> +tests/test-char$(EXESUF): tests/test-char.o $(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y) $(chardev-obj-y) tests/socket-helpers.o
>  tests/test-coroutine$(EXESUF): tests/test-coroutine.o $(test-block-obj-y)
>  tests/test-aio$(EXESUF): tests/test-aio.o $(test-block-obj-y)
>  tests/test-aio-multithread$(EXESUF): tests/test-aio-multithread.o $(test-block-obj-y)
> diff --git a/tests/test-char.c b/tests/test-char.c
> index f9440cdcfd..2dde620afc 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -15,6 +15,7 @@
>  #include "io/channel-socket.h"
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/qapi-visit-sockets.h"
> +#include "socket-helpers.h"
>  
>  static bool quit;
>  
> @@ -1356,11 +1357,17 @@ static void char_hotswap_test(void)
>  
>  int main(int argc, char **argv)
>  {
> +    bool has_ipv4, has_ipv6;
> +
>      qemu_init_main_loop(&error_abort);
>      socket_init();
>  
>      g_test_init(&argc, &argv, NULL);
>  
> +    if (socket_check_protocol_support(&has_ipv4, &has_ipv6) < 0) {
> +        return -1;
> +    }
> +
>      module_call_init(MODULE_INIT_QOM);
>      qemu_add_opts(&qemu_chardev_opts);
>  
> @@ -1438,10 +1445,12 @@ int main(int argc, char **argv)
>      g_test_add_data_func("/char/socket/client/wait-conn-fdpass/" # name, \
>                           &client6 ##name, char_socket_client_test)
>  
> -    SOCKET_SERVER_TEST(tcp, &tcpaddr);
> -    SOCKET_CLIENT_TEST(tcp, &tcpaddr);
> -    g_test_add_data_func("/char/socket/server/two-clients/tcp", &tcpaddr,
> -                         char_socket_server_two_clients_test);
> +    if (has_ipv4) {

Why not if(has_ipv4 || has_ipv6) ?

> +        SOCKET_SERVER_TEST(tcp, &tcpaddr);
> +        SOCKET_CLIENT_TEST(tcp, &tcpaddr);
> +        g_test_add_data_func("/char/socket/server/two-clients/tcp", &tcpaddr,
> +                             char_socket_server_two_clients_test);
> +    }
>  #ifndef WIN32
>      SOCKET_SERVER_TEST(unix, &unixaddr);
>      SOCKET_CLIENT_TEST(unix, &unixaddr);
> 

