Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D95DC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA82C20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHioKplW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA82C20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAs5-0000iT-Uq
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIAkt-0007XI-Hg
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:12:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56797
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIAkp-00089u-Oo
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600175534;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MyCBUHTBLTae9YEHSvYfS8ckWWX+dpsGi+SJYWNBhu0=;
 b=PHioKplWHw37Zb0u1e+hEzDgNtuilZyrdUSyS3LDNFeVBQ1muP+6SyCPnnJGeo2tZogPpT
 rkD5l2wZPe2f8aC6y2B3FVUT2S5XLhHid1E/ngTPdKnIQZz6eynD4l8nrgAoupNMnL+vWq
 fGalYQlgemLLdyI85J79PhsQGFHZUj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-jF-oMj5QPdGL43vaDY0eBg-1; Tue, 15 Sep 2020 09:12:10 -0400
X-MC-Unique: jF-oMj5QPdGL43vaDY0eBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C47DC10BBEF0;
 Tue, 15 Sep 2020 13:12:08 +0000 (UTC)
Received: from redhat.com (ovpn-113-234.ams2.redhat.com [10.36.113.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 305847BE49;
 Tue, 15 Sep 2020 13:12:01 +0000 (UTC)
Date: Tue, 15 Sep 2020 14:11:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v9 12/26] tests: Enable crypto tests under msys2/mingw
Message-ID: <20200915131159.GH1502912@redhat.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
 <20200915121318.247-13-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200915121318.247-13-luoyonggang@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 15, 2020 at 08:13:04PM +0800, Yonggang Luo wrote:
> Fixes following tests on msys2/mingw
> 'test-crypto-tlscredsx509'
> test-crypto-tlssession'
> 'test-io-channel-tls'
> 
> These tests are failure with:
> ERROR test-crypto-tlscredsx509 - missing test plan
> ERROR test-crypto-tlssession - missing test plan
> ERROR test-io-channel-tls - missing test plan
> 
> Because on win32 those test case are all disabled in the header
> 
> Add qemu_socket_pair for cross platform support
> Convert file system handling functions to glib
> Add qemu_link function instead posix only link function.
> Use send ad recv from qemu that convert Windows Socks error to errno properly.
> Use g_remove instead unlink
> Use g_mkdir instead mkdir
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/crypto-tls-psk-helpers.c   |   2 +-
>  tests/crypto-tls-x509-helpers.c  | 106 ++++++++++++++++++++++++++++++-
>  tests/crypto-tls-x509-helpers.h  |   9 ++-
>  tests/test-crypto-tlscredsx509.c |  47 +++++++-------
>  tests/test-crypto-tlssession.c   |  68 +++++++++++---------
>  tests/test-io-channel-tls.c      |  51 ++++++++-------
>  6 files changed, 204 insertions(+), 79 deletions(-)
> 
> diff --git a/tests/crypto-tls-psk-helpers.c b/tests/crypto-tls-psk-helpers.c
> index 4f3bd446ad..58888d5537 100644
> --- a/tests/crypto-tls-psk-helpers.c
> +++ b/tests/crypto-tls-psk-helpers.c
> @@ -46,7 +46,7 @@ void test_tls_psk_init(const char *pskfile)
>  
>  void test_tls_psk_cleanup(const char *pskfile)
>  {
> -    unlink(pskfile);
> +    g_remove(pskfile);
>  }
>  
>  #endif /* QCRYPTO_HAVE_TLS_TEST_SUPPORT */
> diff --git a/tests/crypto-tls-x509-helpers.c b/tests/crypto-tls-x509-helpers.c
> index 01b3daf358..1238983755 100644
> --- a/tests/crypto-tls-x509-helpers.c
> +++ b/tests/crypto-tls-x509-helpers.c
> @@ -23,6 +23,8 @@
>  #include "crypto-tls-x509-helpers.h"
>  #include "crypto/init.h"
>  #include "qemu/sockets.h"
> +#include <glib.h>
> +#include <glib/gstdio.h>
>  
>  #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
>  
> @@ -133,7 +135,7 @@ void test_tls_init(const char *keyfile)
>  void test_tls_cleanup(const char *keyfile)
>  {
>      asn1_delete_structure(&pkix_asn1);
> -    unlink(keyfile);
> +    g_remove(keyfile);
>  }
>  
>  /*
> @@ -501,8 +503,108 @@ void test_tls_discard_cert(QCryptoTLSTestCertReq *req)
>      req->crt = NULL;
>  
>      if (getenv("QEMU_TEST_DEBUG_CERTS") == NULL) {
> -        unlink(req->filename);
> +        g_remove(req->filename);
>      }
>  }
>  
> +int qemu_link(const char *exist_path1, const char *new_path2)
> +{
> +#if defined(_WIN32)
> +    g_autofree gchar *current_dir = g_get_current_dir();
> +    g_autofree gchar *full_path = g_build_filename(current_dir, exist_path1, NULL);
> +    return CreateSymbolicLinkA(
> +        new_path2, full_path, 0 | SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE) ? 0 : -1;
> +#else
> +    return link(exist_path1, new_path2);
> +#endif
> +}
> +
> +#if defined(_WIN32)
> +
> +int qemu_socketpair(int family, int type, int protocol, int channel[2])
> +{
> +    struct addrinfo addr_data;
> +    struct addrinfo *addr = NULL;
> +    int sock_listener = -1;
> +    int sock_client = -1;
> +    int sock_server = -1;
> +    int one = 1;
> +
> +    memset(&addr_data, 0, sizeof(addr_data));
> +    addr_data.ai_family = AF_INET;
> +    addr_data.ai_socktype = type;
> +    addr_data.ai_protocol = protocol;
> +    if (0 != getaddrinfo("127.0.0.1", "0", &addr_data, &addr)) {


This test is backwards - QEMU style is "getaddrinfo(...) != 0"


> +        goto error;
> +    }
> +
> +    if (NULL == addr) {
> +        goto error;
> +    }
> +
> +    sock_listener = socket(addr->ai_family, addr->ai_socktype, addr->ai_protocol);
> +    if (-1 == sock_listener) {
> +        goto error;
> +    }

Normal code style is  "sock_listener < 0"

> +
> +    if (-1 == setsockopt(sock_listener, SOL_SOCKET, SO_REUSEADDR, (const char *)&one, sizeof(one))) {
> +        goto error;
> +    }

SO_REUSEADDR is not desirable on Windows -  see os-win32.c comments about
it.

> +    if (-1 == bind(sock_listener, addr->ai_addr, addr->ai_addrlen)) {
> +        goto error;
> +    }
> +    if (-1 == getsockname(sock_listener, addr->ai_addr, (int *)&(addr->ai_addrlen))) {
> +        goto error;
> +    }
> +    if (-1 == listen(sock_listener, 1)) {
> +        goto error;
> +    }
> +
> +    sock_client = socket(addr->ai_family, addr->ai_socktype, addr->ai_protocol);
> +
> +    if (-1 == sock_client) {
> +        goto error;
> +    }
> +
> +    if (-1 == connect(sock_client, addr->ai_addr, addr->ai_addrlen)) {
> +        goto error;
> +    }
> +
> +    sock_server = accept(sock_listener, 0, 0);
> +
> +    if (-1 == sock_server) {
> +        goto error;
> +    }
> +
> +    closesocket(sock_listener);
> +
> +    channel[0] = sock_client;
> +    channel[1] = sock_server;
> +    return 0;
> +
> +error:
> +    if (-1 != sock_server) {
> +        closesocket(sock_server);
> +    }
> +    if (-1 != sock_client) {
> +        closesocket(sock_client);
> +    }
> +    if (-1 != sock_listener) {
> +        closesocket(sock_listener);
> +    }
> +    if (NULL != addr) {
> +        freeaddrinfo(addr);
> +    }
> +    return -1;
> +}
> +
> +#else
> +
> +int qemu_socketpair(int family, int type, int protocol, int recv[2])
> +{
> +    return socketpair(family, type, protocol, recv);
> +}
> +
> +#endif
> +
>  #endif /* QCRYPTO_HAVE_TLS_TEST_SUPPORT */
> diff --git a/tests/crypto-tls-x509-helpers.h b/tests/crypto-tls-x509-helpers.h
> index 08efba4e19..6902d43af7 100644
> --- a/tests/crypto-tls-x509-helpers.h
> +++ b/tests/crypto-tls-x509-helpers.h
> @@ -24,8 +24,9 @@
>  #include <gnutls/gnutls.h>
>  #include <gnutls/x509.h>
>  
> -#if !(defined WIN32) && \
> -    defined(CONFIG_TASN1)
> +#include "qemu/osdep.h"
> +
> +#if defined(CONFIG_TASN1)
>  # define QCRYPTO_HAVE_TLS_TEST_SUPPORT
>  #endif
>  
> @@ -127,6 +128,10 @@ void test_tls_cleanup(const char *keyfile);
>  
>  extern const ASN1_ARRAY_TYPE pkix_asn1_tab[];
>  
> +int qemu_link(const char *exist_path1, const char *new_path2);
> +
> +int qemu_socketpair(int family, int type, int protocol, int channel[2]);
> +

THese aren't really related t the TLS tests - they're platform
portability wrappers, so osdep.{ch} and qemu-sockets.c is where
they ought to live

>  #endif /* QCRYPTO_HAVE_TLS_TEST_SUPPORT */
>  
>  #endif


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


