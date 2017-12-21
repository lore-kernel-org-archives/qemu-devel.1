Received: from eggs.gnu.org ([2001:4830:134:3::10]:40663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eS4UA-00027f-BS
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:18:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eS4U6-0001uN-CE
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:18:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eS4U6-0001tx-5v
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:18:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61A747EA90
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 17:18:17 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 572CF2C336
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 17:18:17 +0000 (UTC)
Date: Thu, 21 Dec 2017 12:18:17 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1943438857.2269649.1513876697276.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171221170716.10709-5-maxime.coquelin@redhat.com>
References: <20171221170716.10709-1-maxime.coquelin@redhat.com>
	<20171221170716.10709-5-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] vhost-user-test: fix features mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com

Hi

----- Original Message -----
> VIRTIO_NET_F_MAC is a bit position, not a bit mask.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Fixing this before patch 3 would make sense.

> ---
>  tests/vhost-user-test.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index be7a401789..6a144e8d7e 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -652,7 +652,7 @@ static void test_read_guest_mem(void)
>      s = qtest_start(qemu_cmd);
>      g_free(qemu_cmd);
>  
> -    init_virtio_dev(server, VIRTIO_NET_F_MAC);
> +    init_virtio_dev(server, 1u << VIRTIO_NET_F_MAC);
>  
>      read_guest_mem(server);
>  
> @@ -681,7 +681,7 @@ static void test_migrate(void)
>      from = qtest_start(cmd);
>      g_free(cmd);
>  
> -    init_virtio_dev(s, VIRTIO_NET_F_MAC);
> +    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
>      wait_for_fds(s);
>      size = get_log_size(s);
>      g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
> @@ -803,7 +803,7 @@ static void test_reconnect_subprocess(void)
>      qtest_start(cmd);
>      g_free(cmd);
>  
> -    init_virtio_dev(s, VIRTIO_NET_F_MAC);
> +    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
>      wait_for_fds(s);
>      wait_for_rings_started(s, 2);
>  
> @@ -841,7 +841,7 @@ static void test_connect_fail_subprocess(void)
>      qtest_start(cmd);
>      g_free(cmd);
>  
> -    init_virtio_dev(s, VIRTIO_NET_F_MAC);
> +    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
>      wait_for_fds(s);
>      wait_for_rings_started(s, 2);
>  
> @@ -871,7 +871,7 @@ static void test_flags_mismatch_subprocess(void)
>      qtest_start(cmd);
>      g_free(cmd);
>  
> -    init_virtio_dev(s, VIRTIO_NET_F_MAC);
> +    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
>      wait_for_fds(s);
>      wait_for_rings_started(s, 2);
>  
> --
> 2.14.3
> 
> 
