Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4B0C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4AC206DC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWAD+QL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4AC206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYQqe-0001D4-IR
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 05:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kYQq5-0000nn-1o
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:36:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kYQq0-0007xd-AC
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604050607;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=IKmmMKjQelECBfrVllIIrt5HZhPRzaFN2JiXpKdgcWo=;
 b=AWAD+QL9U0k8YLBbg4BkKkE44uUCakRfX27w2oQTt/KxUgWOVcsP3BmB6p/mW4GgB3g6yB
 tSGDEqnxS69Us6mM4v5rsKOjrgg+7gfoYblDCVtTwTCu2uEnm5YPLeDz48RsoDlT2qn69J
 YhXRoUnbulLKgiOrpvgGao0e3D6T3aE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-he7GpeFpMjaB-__3jAIOHA-1; Fri, 30 Oct 2020 05:36:44 -0400
X-MC-Unique: he7GpeFpMjaB-__3jAIOHA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 840058030A4;
 Fri, 30 Oct 2020 09:36:43 +0000 (UTC)
Received: from redhat.com (ovpn-113-50.ams2.redhat.com [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D9405C1CF;
 Fri, 30 Oct 2020 09:36:35 +0000 (UTC)
Date: Fri, 30 Oct 2020 09:36:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 03/11] test-util-sockets: Clean up SocketAddress
 construction
Message-ID: <20201030093632.GF99222@redhat.com>
References: <20201029133833.3450220-1-armbru@redhat.com>
 <20201029133833.3450220-4-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201029133833.3450220-4-armbru@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: kwolf@redhat.com, zxq_yx_007@163.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 29, 2020 at 02:38:25PM +0100, Markus Armbruster wrote:
> The thread functions build the SocketAddress from global variable
> @abstract_sock_name and the tight flag passed as pointer
> argument (either NULL or (gpointer)1).  There is no need for such
> hackery; simply pass the SocketAddress instead.
> 
> While there, dumb down g_rand_int_range() to g_random_int().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-util-sockets.c | 62 +++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 38 deletions(-)
> 
> diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
> index 9d317e73a6..b1b5628bd5 100644
> --- a/tests/test-util-sockets.c
> +++ b/tests/test-util-sockets.c
> @@ -230,25 +230,14 @@ static void test_socket_fd_pass_num_nocli(void)
>  #endif
>  
>  #ifdef __linux__
> -static gchar *abstract_sock_name;
> -
>  static gpointer unix_server_thread_func(gpointer user_data)
>  {
> -    SocketAddress addr;

Keep this but as a pointer, and initialize it to "user_data",
so that it is clear what data type this parameter is expected
to be.

> -    Error *err = NULL;
> -    int fd = -1;
> -    int connfd = -1;
> +    int fd;
> +    int connfd;
>      struct sockaddr_un un;
>      socklen_t len = sizeof(un);
>  
> -    addr.type = SOCKET_ADDRESS_TYPE_UNIX;
> -    addr.u.q_unix.path = abstract_sock_name;
> -    addr.u.q_unix.has_tight = true;
> -    addr.u.q_unix.tight = user_data != NULL;
> -    addr.u.q_unix.has_abstract = true;
> -    addr.u.q_unix.abstract = true;
> -
> -    fd = socket_listen(&addr, 1, &err);
> +    fd = socket_listen(user_data, 1, &error_abort);

Then keep this as passing "addr"


>  
>  static gpointer unix_client_thread_func(gpointer user_data)
>  {
> -    SocketAddress addr;

Same note here

> -    Error *err = NULL;
> -    int fd = -1;
> -
> -    addr.type = SOCKET_ADDRESS_TYPE_UNIX;
> -    addr.u.q_unix.path = abstract_sock_name;
> -    addr.u.q_unix.has_tight = true;
> -    addr.u.q_unix.tight = user_data != NULL;
> -    addr.u.q_unix.has_abstract = true;
> -    addr.u.q_unix.abstract = true;
> -
> -    fd = socket_connect(&addr, &err);
> +    int fd;
>  
> +    fd = socket_connect(user_data, &error_abort);
>      g_assert_cmpint(fd, >=, 0);

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


