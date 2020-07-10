Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10133C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9EDC20725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anVyG7kP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EDC20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtw8h-00068h-U7
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jtw7l-0005DP-KJ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:43:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48235
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jtw7j-00018X-Mf
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594399422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=InadC5TOqoqB6qQhz0nTXrTyan+cWBBU0/ongNo2P6k=;
 b=anVyG7kPYYqinA2XYd9VINU9aH0KkBIIhOHw9HdwUYeNfgqPuQ7G1OVoRvFVJUijYLKwt0
 wqPMlWRh7d+vX2bcKaniGYA1Tb2E33EuYciRFTQ3TCSlqh7c5ZfUUIH7OnJUSQTUGIoz9U
 SHkkAkFtTauYfj47fxeIJUuIheOCQyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-BNSkM2MLPN2vUtSIWsQZ0A-1; Fri, 10 Jul 2020 12:43:41 -0400
X-MC-Unique: BNSkM2MLPN2vUtSIWsQZ0A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 005F0800401;
 Fri, 10 Jul 2020 16:43:40 +0000 (UTC)
Received: from [10.3.112.178] (ovpn-112-178.phx2.redhat.com [10.3.112.178])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F8451A922;
 Fri, 10 Jul 2020 16:43:39 +0000 (UTC)
Subject: Re: [PATCH 2/2] iotests: Set LC_ALL=C for sort
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200710163253.381630-1-mreitz@redhat.com>
 <20200710163253.381630-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <10f510f8-7544-3879-0bc5-3ed421414c08@redhat.com>
Date: Fri, 10 Jul 2020 11:43:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710163253.381630-3-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 11:32 AM, Max Reitz wrote:
> Otherwise the result is basically unpredictable.
> 
> (Note that the precise environment variable to control sorting order is
> LC_COLLATE, but LC_ALL overrides LC_COLLATE, and we do not want the
> sorting order to be messed up if LC_ALL is set in the environment.)

Yep, that logic is correct.

> 
> Reported-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/common.filter | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
> index 345c3ca03e..4fd5c29b2a 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -177,7 +177,7 @@ _do_filter_img_create()
>               -e 's/^\(data_file\)/3-\1/' \
>               -e 's/^\(encryption\)/4-\1/' \
>               -e 's/^\(preallocation\)/8-\1/' \
> -        | sort \
> +        | LC_ALL=C sort \
>           | $SED -e 's/^[0-9]-//' \
>           | tr '\n\0' ' \n' \
>           | $SED -e 's/^ *$//' -e 's/ *$//'
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


