Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14D2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC12C2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbmuAERV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC12C2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5U4n-0004AO-TZ
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 09:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k5U2u-0002HH-2y
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 09:10:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45197
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k5U2s-0001kK-EC
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 09:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597151425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGRyHPJCtxtYTCpOCi4N4hhw8LofxMz0uXgvCVPYdYs=;
 b=MbmuAERVQGPZMsa8OWyhz/NSUQCO0+vxotzXLWUgA7ocGEPUfns6/92lkPhR+RX7vYC7Bv
 vugvNztDAafOlUcDeuDXruhrpAO/qg0392MgKIzjr99l/z8QKMZ61947e+kumS2T85n2Yq
 5WD+H8Ato+CIc/kU7C458cS7qg6Yp2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-rp9siGJcMLWNhpdmfR4zxw-1; Tue, 11 Aug 2020 09:10:20 -0400
X-MC-Unique: rp9siGJcMLWNhpdmfR4zxw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 100F58014D8;
 Tue, 11 Aug 2020 13:10:20 +0000 (UTC)
Received: from [10.3.112.157] (ovpn-112-157.phx2.redhat.com [10.3.112.157])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4BB45F1EA;
 Tue, 11 Aug 2020 13:10:16 +0000 (UTC)
Subject: Re: [PATCH] iotests/059: Fix reference output
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200811084150.326377-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <727cd7e0-a699-fb3e-1f43-6abf5f60c4ef@redhat.com>
Date: Tue, 11 Aug 2020 08:10:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811084150.326377-1-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 02:18:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/11/20 3:41 AM, Max Reitz wrote:
> As of the patch to flush qemu-img's "Formatting" message before the
> error message, 059 has been broken for vmdk.  Fix it.
> 
> Fixes: 4e2f4418784da09cb106264340241856cd2846df
>         ("qemu-img: Flush stdout before before potential stderr messages")
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/059.out | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
> index 6d127e28d8..2b83c0c8b6 100644
> --- a/tests/qemu-iotests/059.out
> +++ b/tests/qemu-iotests/059.out
> @@ -19,8 +19,8 @@ file format: IMGFMT
>   virtual size: 2 GiB (2147483648 bytes)
>   
>   === Testing monolithicFlat with zeroed_grain ===
> -qemu-img: TEST_DIR/t.IMGFMT: Flat image can't enable zeroed grain
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2147483648
> +qemu-img: TEST_DIR/t.IMGFMT: Flat image can't enable zeroed grain
>   
>   === Testing big twoGbMaxExtentFlat ===
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824000
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


