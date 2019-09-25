Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999BDC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707D421D82
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707D421D82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDEsK-0001e5-LI
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 17:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iDEqo-0000A1-6O
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iDEqn-0008D9-0U
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:29:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iDEqZ-00088l-5R; Wed, 25 Sep 2019 17:29:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D6C3518CB8EF;
 Wed, 25 Sep 2019 21:29:12 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2440860F88;
 Wed, 25 Sep 2019 21:29:10 +0000 (UTC)
Subject: Re: [PATCH 1/3] iotests: Fix 125 for growth_mode = metadata
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190925183231.11196-1-mreitz@redhat.com>
 <20190925183231.11196-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e672c86d-e553-b6a8-6b1d-8746faa53533@redhat.com>
Date: Wed, 25 Sep 2019 16:29:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925183231.11196-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Wed, 25 Sep 2019 21:29:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

On 9/25/19 1:32 PM, Max Reitz wrote:
> If we use growth_mode = metadata, it is very much possible that the file
> uses more disk space after we have written something to the added area.
> We did indeed want to test for this case, but unfortunately we evidently
> just copied the code from the "Test creation preallocation" section and
> forgot to replace "$create_mode" by "$growth_mode".
> 
> We never noticed because we only read the first number from qemu-img
> info's "disk size" output -- and that is effectively useless, because
> qemu-img prints a human-readable value (which generally includes a
> decimal point).  That will be fixed in the patch after the next one.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/125 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
> index dc4b8f5fb9..df328a63a6 100755
> --- a/tests/qemu-iotests/125
> +++ b/tests/qemu-iotests/125
> @@ -111,7 +111,7 @@ for GROWTH_SIZE in 16 48 80; do
>                   if [ $file_length_2 -gt $file_length_1 ]; then
>                       echo "ERROR (grow): Image length has grown from $file_length_1 to $file_length_2"
>                   fi
> -                if [ $create_mode != metadata ]; then
> +                if [ $growth_mode != metadata ]; then
>                       # The host size should not have grown either
>                       if [ $host_size_2 -gt $host_size_1 ]; then
>                           echo "ERROR (grow): Host size has grown from $host_size_1 to $host_size_2"
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

