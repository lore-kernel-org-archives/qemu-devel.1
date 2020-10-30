Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BBAC55179
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6CC20728
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPp/ezzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6CC20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYQnu-0008Nj-89
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 05:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kYQmp-000780-5R
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kYQmn-0006ee-Ap
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604050408;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9ix7n7d7n8YfkbOQMMWxG9ulRPCtIt+wTJ0pkqTOoIM=;
 b=bPp/ezzWi1kXxzCd3jluVg77HKsmxNpv07VCoYJgC/e/gBxfBK3+A2/S5rSv18W5139HiN
 vaKYWKw917N3awCx38xWaYawql4xnjTYE8dcExXyj6psUjY0D80zfvTLxFazsVf9ZieMbN
 sAs2+86+JGOe26rGc3b3efES0ffGP5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-By0528ulMuCp5QBFusIwQw-1; Fri, 30 Oct 2020 05:33:26 -0400
X-MC-Unique: By0528ulMuCp5QBFusIwQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 811EA1868408;
 Fri, 30 Oct 2020 09:33:25 +0000 (UTC)
Received: from redhat.com (ovpn-113-50.ams2.redhat.com [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B96775D9D5;
 Fri, 30 Oct 2020 09:33:15 +0000 (UTC)
Date: Fri, 30 Oct 2020 09:33:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 06/11] test-util-sockets: Test the complete abstract
 socket matrix
Message-ID: <20201030093312.GE99222@redhat.com>
References: <20201029133833.3450220-1-armbru@redhat.com>
 <20201029133833.3450220-7-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201029133833.3450220-7-armbru@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 29, 2020 at 02:38:28PM +0100, Markus Armbruster wrote:
> The test covers only two out of nine combinations.  Test all nine.
> Four turn out to be broken.  Marked /* BUG */.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-util-sockets.c | 86 ++++++++++++++++++++++++++++-----------
>  1 file changed, 63 insertions(+), 23 deletions(-)
> 
> diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
> index c2802f69ee..f8b6586e70 100644
> --- a/tests/test-util-sockets.c
> +++ b/tests/test-util-sockets.c
> @@ -230,59 +230,99 @@ static void test_socket_fd_pass_num_nocli(void)
>  #endif
>  
>  #ifdef __linux__
> +
> +#define ABSTRACT_SOCKET_VARIANTS 3
> +
> +typedef struct {
> +    SocketAddress *server, *client[ABSTRACT_SOCKET_VARIANTS];
> +    bool expect_connect[ABSTRACT_SOCKET_VARIANTS];
> +} abstract_socket_matrix_row;

snip

>  
> -static void test_socket_unix_abstract_good(void)
> +static void test_socket_unix_abstract(void)
>  {
> -    SocketAddress addr;
> +    SocketAddress addr, addr_tight, addr_padded;
> +    abstract_socket_matrix_row matrix[ABSTRACT_SOCKET_VARIANTS] = {
> +        { &addr,
> +          { &addr_tight, &addr_padded, &addr },
> +          { false /* BUG */, true /* BUG */, true } },
> +        { &addr_tight,
> +          { &addr_padded, &addr, &addr_tight },
> +          { false, false /* BUG */, true } },
> +        { &addr_padded,
> +          { &addr, &addr_tight, &addr_padded },
> +          { true /* BUG */, false, true } }
> +    };

This is overloading multiple separate tests in one, which is bad for
test result reporting.


> @@ -329,8 +369,8 @@ int main(int argc, char **argv)
>      }
>  
>  #ifdef __linux__
> -    g_test_add_func("/util/socket/unix-abstract/good",
> -                    test_socket_unix_abstract_good);
> +    g_test_add_func("/util/socket/unix-abstract",
> +                    test_socket_unix_abstract);

We should instead be registering multiple test funcs, passing in
param to say which scenario to test.  This ensures we still see
the test name reflecting which scenario is being run.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


