Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10222C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E2CB206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZ9cpW6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2CB206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHitu-000583-NR
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kHiq9-0002J6-TU
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:23:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kHiq7-0002hy-KG
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600068230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8la2PXAZNU2an3S6A0fBd1Ams0shTqsEkdRIqUEKCc=;
 b=UZ9cpW6Kq92j2OBTEKUlu2t6/yas3GiIWUZNKzDSAPqNrP9g0+Z3co+Q2M1Zr/Q9vi67Zh
 +lGMErbOM7/lW+rPCbAVSMfxyvmZAVUGdjpTe5v2RYCIX+nnE+zdcQU4gRpPutZgecJ0pm
 KU93fX/mFRfz0qDdWPwgrvRl5fVuDQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-754TwMyqPbm3i-PptlZKoA-1; Mon, 14 Sep 2020 03:23:44 -0400
X-MC-Unique: 754TwMyqPbm3i-PptlZKoA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17039801AC2;
 Mon, 14 Sep 2020 07:23:43 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-134.ams2.redhat.com [10.36.112.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FB561A8AC;
 Mon, 14 Sep 2020 07:23:34 +0000 (UTC)
Subject: Re: [PATCH v8 13/27] tests: Enable crypto tests under msys2/mingw
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-14-luoyonggang@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <119be52f-fc8b-dd37-e3d6-04a13109c845@redhat.com>
Date: Mon, 14 Sep 2020 09:23:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200912224431.1428-14-luoyonggang@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/09/2020 00.44, Yonggang Luo wrote:
> Fixes following tests on msys2/mingw
>       'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
>                                    tasn1, crypto],
>       'test-crypto-tlssession': ['crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c', 'crypto-tls-psk-helpers.c',
>                                  tasn1, crypto],
>       'test-io-channel-tls': ['io-channel-helpers.c', 'crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
>                               tasn1, io, crypto]}
> These tests are failure with:
> ERROR test-crypto-tlscredsx509 - missing test plan
> ERROR test-crypto-tlssession - missing test plan
> ERROR test-io-channel-tls - missing test plan
> 
> Because on win32 those test case are all disabled in the header
> 
> Add qemu_socket_pair for cross platform support, convert file system
> handling functions to glib
> Add qemu_link function instead posix only link function.
> Use send ad recv from qemu that convert Windows Socks error
> to errno properly.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
[...]
> +static int __stream_socketpair(struct addrinfo* addr_info, int sock[2]){
> +    SOCKET listener, client, server;
> +    int opt = 1;
> +
> +    listener = server = client = INVALID_SOCKET;
> +    listener = socket(addr_info->ai_family, addr_info->ai_socktype, addr_info->ai_protocol);
> +    if (INVALID_SOCKET == listener)
> +        goto fail;
> +
> +    setsockopt(listener, SOL_SOCKET, SO_REUSEADDR,(const char*)&opt, sizeof(opt));
> +
> +    if(SOCKET_ERROR == bind(listener, addr_info->ai_addr, addr_info->ai_addrlen))
> +        goto fail;
> +
> +    if (SOCKET_ERROR == getsockname(listener, addr_info->ai_addr, (int*)&addr_info->ai_addrlen))
> +        goto fail;
> +
> +    if(SOCKET_ERROR == listen(listener, 5))
> +        goto fail;
> +
> +    client = socket(addr_info->ai_family, addr_info->ai_socktype, addr_info->ai_protocol);
> +
> +    if (INVALID_SOCKET == client)
> +        goto fail;
> +
> +    if (SOCKET_ERROR == connect(client,addr_info->ai_addr,addr_info->ai_addrlen))
> +        goto fail;
> +
> +    server = accept(listener, 0, 0);
> +
> +    if (INVALID_SOCKET == server)
> +        goto fail;
> +
> +    closesocket(listener);
> +
> +    sock[0] = client;
> +    sock[1] = server;
> +
> +    return 0;
> +fail:
> +    if(INVALID_SOCKET!=listener)
> +        closesocket(listener);
> +    if (INVALID_SOCKET!=client)
> +        closesocket(client);
> +    return -1;
> +}
> +
> +static int __dgram_socketpair(struct addrinfo* addr_info, int sock[2])
> +{
> +    SOCKET client, server;
> +    struct addrinfo addr, *result = NULL;
> +    const char* address;
> +    int opt = 1;
> +
> +    server = client = INVALID_SOCKET;
> +
> +    server = socket(addr_info->ai_family, addr_info->ai_socktype, addr_info->ai_protocol);  
> +    if (INVALID_SOCKET == server)
> +        goto fail;
> +
> +    setsockopt(server, SOL_SOCKET,SO_REUSEADDR, (const char*)&opt, sizeof(opt));
> +
> +    if(SOCKET_ERROR == bind(server, addr_info->ai_addr, addr_info->ai_addrlen))
> +        goto fail;
> +
> +    if (SOCKET_ERROR == getsockname(server, addr_info->ai_addr, (int*)&addr_info->ai_addrlen))
> +        goto fail;
> +
> +    client = socket(addr_info->ai_family, addr_info->ai_socktype, addr_info->ai_protocol); 
> +    if (INVALID_SOCKET == client)
> +        goto fail;
> +
> +    memset(&addr,0,sizeof(addr));
> +    addr.ai_family = addr_info->ai_family;
> +    addr.ai_socktype = addr_info->ai_socktype;
> +    addr.ai_protocol = addr_info->ai_protocol;
> +
> +    if (AF_INET6==addr.ai_family)
> +        address = "0:0:0:0:0:0:0:1";
> +    else
> +        address = "127.0.0.1";
> +
> +    if (getaddrinfo(address, "0", &addr, &result))
> +        goto fail;
> +
> +    setsockopt(client,SOL_SOCKET,SO_REUSEADDR,(const char*)&opt, sizeof(opt));
> +    if(SOCKET_ERROR == bind(client, result->ai_addr, result->ai_addrlen))
> +        goto fail;
> +
> +    if (SOCKET_ERROR == getsockname(client, result->ai_addr, (int*)&result->ai_addrlen))
> +        goto fail;
> +
> +    if (SOCKET_ERROR == connect(server, result->ai_addr, result->ai_addrlen))
> +        goto fail;
> +
> +    if (SOCKET_ERROR == connect(client, addr_info->ai_addr, addr_info->ai_addrlen))
> +        goto fail;
> +
> +    freeaddrinfo(result);
> +    sock[0] = client;
> +    sock[1] = server;
> +    return 0;
> +
> +fail:
> +    if (INVALID_SOCKET!=client)
> +        closesocket(client);
> +    if (INVALID_SOCKET!=server)
> +        closesocket(server);
> +    if (result)
> +        freeaddrinfo(result);
> +    return -1;
> +}
> +
> +int qemu_socketpair(int family, int type, int protocol,int recv[2]){
> +    const char* address;
> +    struct addrinfo addr_info,*p_addrinfo;
> +    int result = -1;
> +
> +    if (family == AF_UNIX)
> +    {
> +        family = AF_INET;
> +    }
> +
> +    memset(&addr_info, 0, sizeof(addr_info));
> +    addr_info.ai_family = family;
> +    addr_info.ai_socktype = type;
> +    addr_info.ai_protocol = protocol;
> +    if (AF_INET6==family)
> +        address = "0:0:0:0:0:0:0:1";
> +    else
> +        address = "127.0.0.1";
> +
> +    if (0 == getaddrinfo(address, "0", &addr_info, &p_addrinfo)){
> +        if (SOCK_STREAM == type)
> +            result = __stream_socketpair(p_addrinfo, recv);
> +        else if(SOCK_DGRAM == type)
> +            result = __dgram_socketpair(p_addrinfo, recv);
> +        freeaddrinfo(p_addrinfo);
> +    }
> +    return result;
> +}

Where do you've got this code from? It seems like this has been taken
from a 3rd party source? E.g.:

 https://blog.csdn.net/wufuhuai/article/details/79761889

What's the license of this new code? ... please clarify such details in
the commit description.

 Thanks,
  Thomas


