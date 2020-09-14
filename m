Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21982C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D37C217BA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPmryiPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D37C217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrZ8-0004Nz-Hf
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kHqx3-0006pA-4E
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 12:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kHqwy-0001kb-ES
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 12:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600099407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ypTvtpeOJotX5D58KbIIiYckEbksuzmhdNvJT9ISg5E=;
 b=NPmryiPRuLCxG1KVJ6DGzP6fXCj2HuHD+pQgQ1Iy8sN3/QxPYdO5udDLi3auYI9p82orhL
 W1zqCB2OuVMpZXfUL/x1ZX6qhpX6LHgM8qGCYkiumsrpXXfX2wuTAzOwToeaQS7ph7yRDZ
 7a+2pCXVWM2HmgKoZoIO0cOcAIuXSEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-s9-WWLZoOX2auAsglumtoA-1; Mon, 14 Sep 2020 12:03:25 -0400
X-MC-Unique: s9-WWLZoOX2auAsglumtoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F6311005E5B;
 Mon, 14 Sep 2020 16:03:24 +0000 (UTC)
Received: from [10.3.113.68] (ovpn-113-68.phx2.redhat.com [10.3.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAC6B1002D42;
 Mon, 14 Sep 2020 16:03:23 +0000 (UTC)
Subject: Re: [PATCH v3] iotests: Drop readlink -f
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200914145606.94620-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <06b0ec10-34d0-05ab-7511-ac7878a6282a@redhat.com>
Date: Mon, 14 Sep 2020 11:03:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914145606.94620-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 9:56 AM, Max Reitz wrote:
> On macOS, (out of the box) readlink does not have -f.  We do not really
> need readlink here, though, it was just a replacement for realpath
> (which is not available on our BSD test systems), which we needed to
> make the $(dirname) into an absolute path.
> 
> Instead of using either, just use "cd; pwd" like is done for
> $source_iotests.
> 
> Fixes: b1cbc33a3971b6bb005d5ac3569feae35a71de0f
>         ("iotests: Allow running from different directory")
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Reported-by: Claudio Fontana <cfontana@suse.de>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/check | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index e14a1f354d..678b6e4910 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -44,7 +44,7 @@ then
>           _init_error "failed to obtain source tree name from check symlink"
>       fi
>       source_iotests=$(cd "$source_iotests"; pwd) || _init_error "failed to enter source tree"
> -    build_iotests=$(readlink -f $(dirname "$0"))
> +    build_iotests=$(cd "$(dirname "$0")"; pwd)

If CDPATH is set, this can produce wrong results.  Do we care?  Probably 
not, since (as you point out), $source_iotests has the same bug, and no 
one has complained yet.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


