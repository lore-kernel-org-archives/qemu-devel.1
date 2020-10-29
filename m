Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE462C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05D02076E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmnsh39d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05D02076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYDT8-00042x-Sx
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 15:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYDSO-0003am-K2
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYDSM-00034I-4q
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603999167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vKULxhDvkZvUdfuqnYhNU0+aC0R4IEsy3sP+Q/mTcY=;
 b=hmnsh39d3oHdIvjD7gmZ4eOTc/SgTOGriUfVPuA2FuMxDGQ4iUS1w9MzvT5a3y7Yeh4TiU
 4rUVH1U/RkiwR5DC8RqFNJmoEJ2yFQIYYVUOgD2Xm+2JuKQypWCMoN/wmhzjDD6yvPrV/I
 8iXOzisPuMnVrbC7wSS4c7wimtyMSeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-CauhNdoMOZGv6ERDVxZsUg-1; Thu, 29 Oct 2020 15:19:23 -0400
X-MC-Unique: CauhNdoMOZGv6ERDVxZsUg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D77B9186DD31;
 Thu, 29 Oct 2020 19:19:22 +0000 (UTC)
Received: from [10.3.112.145] (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DA8319646;
 Thu, 29 Oct 2020 19:19:15 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201029133833.3450220-1-armbru@redhat.com>
 <20201029133833.3450220-7-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Subject: Re: [PATCH 06/11] test-util-sockets: Test the complete abstract
 socket matrix
Message-ID: <2515e089-2f63-d524-8cbc-4b3c7c403d48@redhat.com>
Date: Thu, 29 Oct 2020 14:19:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029133833.3450220-7-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, berrange@redhat.com, zxq_yx_007@163.com,
 kraxel@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/20 8:38 AM, Markus Armbruster wrote:
> The test covers only two out of nine combinations.  Test all nine.
> Four turn out to be broken.  Marked /* BUG */.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-util-sockets.c | 86 ++++++++++++++++++++++++++++-----------
>  1 file changed, 63 insertions(+), 23 deletions(-)
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
> +    int i;
>  
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


