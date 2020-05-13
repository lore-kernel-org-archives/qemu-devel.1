Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF93C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:50:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1478205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbGmwA98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1478205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYtea-0005XQ-QN
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 11:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYtdm-0004kI-BZ
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:49:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36034
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYtdk-0006W6-4u
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589384986;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kRJFou/sSvlDvCBLRpJRF185lIgl86b7f59xM4pa0oc=;
 b=SbGmwA98zGKUHYXJU6LKQY2LH6tJD9WZ02ltH6cXgLIczK6IHCGCNA/VhP7GQQqUq1oruz
 3aStm7k2R1EvhqQoMuCGZZNdI0Fiq61rrzaC13/4cY0lCnIdAM+bKTvjd0RxtxybsGc10D
 U231mW/DGixr0XddosJAhfmxmtdf0Pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-zqJVKqC8M3OyCyPkhj_pGg-1; Wed, 13 May 2020 11:49:44 -0400
X-MC-Unique: zqJVKqC8M3OyCyPkhj_pGg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E8968018AD;
 Wed, 13 May 2020 15:49:43 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BAA785C1BB;
 Wed, 13 May 2020 15:49:34 +0000 (UTC)
Date: Wed, 13 May 2020 16:49:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: xiaoqiang zhao <zxq_yx_007@163.com>
Subject: Re: [PATCH v3 2/3] tests/util-sockets: add abstract unix socket cases
Message-ID: <20200513154931.GI1253949@redhat.com>
References: <20200510061422.24841-1-zxq_yx_007@163.com>
 <20200510061422.24841-3-zxq_yx_007@163.com>
MIME-Version: 1.0
In-Reply-To: <20200510061422.24841-3-zxq_yx_007@163.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, armbru@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 10, 2020 at 02:14:21PM +0800, xiaoqiang zhao wrote:
> add cases to test tight and non-tight for abstract address type
> 
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
> ---
>  tests/test-util-sockets.c | 83 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
> index 5fd947c7bf..8042fb9276 100644
> --- a/tests/test-util-sockets.c
> +++ b/tests/test-util-sockets.c
> @@ -227,6 +227,84 @@ static void test_socket_fd_pass_num_nocli(void)
>      g_free(addr.u.fd.str);
>  }
>  
> +static gpointer unix_server_thread_func(gpointer user_data)
> +{
> +    SocketAddress addr;
> +    Error *err = NULL;
> +    int fd = -1;
> +    int connfd = -1;
> +    struct sockaddr_un un;
> +    socklen_t len = sizeof(un);
> +    char name[] = "/tmp/unix-test.sock";

Fixed filenames are bad, as even though this is the abstract
namespace and thus safe from on-disk clashes, the abstract
namespace is still OS global. We should append both the PID
and a sequence of random bytes to get something which doesnt
clash if two copies of the unit test run concurrently.

> +
> +    addr.type = SOCKET_ADDRESS_TYPE_UNIX;
> +    addr.u.q_unix.path = name;
> +    addr.u.q_unix.tight = user_data != NULL;
> +    addr.u.q_unix.abstract = true;
> +
> +    fd = socket_listen(&addr, 1, &err);
> +    g_assert_cmpint(fd, >=, 0);
> +    g_assert(fd_is_socket(fd));
> +
> +    connfd = accept(fd, (struct sockaddr *)&un, &len);
> +    g_assert_cmpint(connfd, !=, -1);
> +
> +    close(fd);
> +
> +    return NULL;
> +}
> +
> +static gpointer unix_client_thread_func(gpointer user_data)
> +{
> +    SocketAddress addr;
> +    Error *err = NULL;
> +    int fd = -1;
> +    char name[] = "/tmp/unix-test.sock";
> +
> +    addr.type = SOCKET_ADDRESS_TYPE_UNIX;
> +    addr.u.q_unix.path = name;
> +    addr.u.q_unix.tight = user_data != NULL;
> +    addr.u.q_unix.abstract = true;
> +
> +    fd = socket_connect(&addr, &err);
> +
> +    g_assert_cmpint(fd, >=, 0);
> +
> +    close(fd);
> +
> +    return NULL;
> +}
> +
> +static void test_socket_unix_abstract_good(void)
> +{
> +    /* non tight socklen serv and cli */
> +    GThread *serv = g_thread_new("abstract_unix_server",
> +                                 unix_server_thread_func,
> +                                 NULL);
> +
> +    sleep(1);
> +
> +    GThread *cli = g_thread_new("abstruct_unix_client",
> +                                unix_client_thread_func,
> +                                NULL);
> +
> +    g_thread_join(cli);
> +    g_thread_join(serv);
> +
> +    /* tight socklen serv and cli */
> +    serv = g_thread_new("abstract_unix_server",
> +                        unix_server_thread_func,
> +                        (gpointer)1);
> +
> +    sleep(1);
> +
> +    cli = g_thread_new("abstruct_unix_client",
> +                       unix_client_thread_func,
> +                       (gpointer)1);
> +
> +    g_thread_join(cli);
> +    g_thread_join(serv);
> +}
>  
>  int main(int argc, char **argv)
>  {
> @@ -265,6 +343,11 @@ int main(int argc, char **argv)
>                          test_socket_fd_pass_num_nocli);
>      }
>  
> +#ifdef __linux__
> +        g_test_add_func("/util/socket/unix-abstract/good",
> +                        test_socket_unix_abstract_good);
> +#endif
> +
>  end:
>      return g_test_run();
>  }
> -- 
> 2.17.1
> 
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


