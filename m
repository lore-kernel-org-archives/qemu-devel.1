Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C034FC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2449C206FC
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afChCXcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2449C206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL420-0002FA-6d
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 08:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL40M-0001X5-RS
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL40K-00063s-8i
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600864570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L8anfiUCu5HdGONMdYMPxL4SsLhVch0SuwOiXwFYlK8=;
 b=afChCXcAHGv3RgC+/aQOMtnZrhEaxTt4IvOpVpzeIX+zFUbZQQWsmcv9/aeuoNi5gd1kcC
 1WIPPw53Ch1q95ET9kQxd7S4pRqS111fb+RpF8L3RPqU+cl4wSJmiZqnOfgER0Kzdhw6Mc
 piJNNyTNJJzKhGK0hKqZW2DprZY6F8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-r602TGNNPOaA9HMCUNuNnQ-1; Wed, 23 Sep 2020 08:36:08 -0400
X-MC-Unique: r602TGNNPOaA9HMCUNuNnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91E18186DD3D;
 Wed, 23 Sep 2020 12:36:07 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F34419728;
 Wed, 23 Sep 2020 12:36:06 +0000 (UTC)
Date: Wed, 23 Sep 2020 13:36:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v10 6/7] test: new qTest case to test the
 vhost-user-blk-server
Message-ID: <20200923123606.GC51019@stefanha-x1.localdomain>
References: <20200918080912.321299-1-coiby.xu@gmail.com>
 <20200918080912.321299-7-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200918080912.321299-7-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, bharatlkmlkvm@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 18, 2020 at 04:09:11PM +0800, Coiby Xu wrote:
> +int qtest_socket_client(char *server_socket_path)
> +{
> +    struct sockaddr_un serv_addr;
> +    int sock;
> +    int ret;
> +    int retries = 0;
> +    sock = socket(PF_UNIX, SOCK_STREAM, 0);
> +    g_assert_cmpint(sock, !=, -1);
> +    serv_addr.sun_family = AF_UNIX;
> +    snprintf(serv_addr.sun_path, sizeof(serv_addr.sun_path), "%s",
> +             server_socket_path);
> +
> +    for (retries = 0; retries < 3; retries++) {
> +        ret = connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr));
> +        if (ret == 0) {
> +            break;
> +        }
> +        g_usleep(G_USEC_PER_SEC);
> +    }

This is a race condition. On a heavily loaded machine the server might
not be available within 3 seconds and the test will fail randomly.

Solutions:
1. Wait output from the server indicating it is ready (e.g. 'Listening
   on /path/to/foo.sock...') when spawning the server process.
2. Create the listen socket and pass the fd to the server process. This
   way the socket already exists can the client will block in connect
   until the server accepts the connection.
3. Create a socketpair. Pass one side to the server and use the other
   side in the client.

However, I think this is okay for now. After my patch series that
converts the vhost-user-blk server to the new block exports API we can
consider how to pass file descriptors.

> +static void quit_storage_daemon(void *qmp_test_state)
> +{
> +    const char quit_str[] = "{ 'execute': 'quit' }";
> +
> +    /* Before quiting storate-daemon, quit qemu to avoid dubious messages */
> +    qobject_unref(qtest_qmp(global_qtest, quit_str));
> +
> +    /*
> +     * Give storage-daemon enough time to wake up&terminate
> +     * vu_client_trip coroutine so the Coroutine object could
> +     * be cleaned up. Otherwise LeakSanitizer would complain
> +     * about memory leaks.
> +     */
> +    g_usleep(1000);

Also a race that may cause random failures. This can be addressed after
the block exports API conversion.

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9rQTUACgkQnKSrs4Gr
c8ixTAgAqDd4oY7DCLK9pLozzSq/Zk5+EUyOG4icNgV2Ubphz87XooJwQtVjuCKW
Kcho3PNgKKJLM2pIbAfDVZgru3VksVFCRzmuBFLwwm2CTWWnqIkGI1qRL5zr7oLN
mFiEp7u0CMd25aSKxNvNGsrd7X3xEiCUMRpi2l14R8kmo4DzUwNz6BFy3eh8+o11
RjVVX+LKJR2Tgm0yvsVsEUTCVly/EnBWZ/qRV9Hb6ZLaRzJ2xWrkJJ6BQoadg+9s
UhKI2nSCBMzOg6d7v+P0xrHHMWReLsbsjZh5Tuc5WcXJOSjxEnxceUTcbiT+VAcW
1IwnePUPaIh/AdGslz/jOyL+anWIHQ==
=a93Z
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--


