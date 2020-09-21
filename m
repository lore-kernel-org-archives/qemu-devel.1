Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9ECC4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4175920888
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjqLDz6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4175920888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKQP8-0003Gu-5K
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 14:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKQBS-0008OO-B5
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 14:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKQBN-00037f-C5
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 14:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600711495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQ84asbVTglHo1OSk7EcLvjlCedWaCtV86FkOdMGtB4=;
 b=SjqLDz6Bbxp2gvWo3TfxCrD62TFJzMYIZzioPH4svL9zNqI6yddfPF1ZWOng9xwB/T7MaL
 jqOz7Zxpxj/VOXzGlI38/nAx5ejLOEWqeWUBRBd7gWq0gWB1nbllr7x69A8mneALC5wWzt
 oqdw2PDiAUr9E2n8IvoHpVj2GmD8ckY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-S3uTRnqYMeGbc_cFWr5PBg-1; Mon, 21 Sep 2020 14:04:52 -0400
X-MC-Unique: S3uTRnqYMeGbc_cFWr5PBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79525873016;
 Mon, 21 Sep 2020 18:04:51 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EECA881C41;
 Mon, 21 Sep 2020 18:04:46 +0000 (UTC)
Subject: Re: [PATCH 7/7] configure: Bump the minimum required Python version
 to 3.6
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200921174320.46062-1-thuth@redhat.com>
 <20200921174320.46062-8-thuth@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <9bd2d32f-27eb-c32c-0e19-eb16612a9400@redhat.com>
Date: Mon, 21 Sep 2020 14:04:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921174320.46062-8-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 1:43 PM, Thomas Huth wrote:
> All our supported build platforms have Python 3.6 or newer nowadays,
> and there are some useful features in Python 3.6 which are not available
> in 3.5 yet, so let's bump the minimum Python version to 3.6 now.
> 

Just to add in case anyone wonders: This isn't incrementalism for 
incrementalism's sake, but the type hint annotations added in Python 3.6 
allow us to statically type the QAPI parser.

We are already using (and enforcing) these annotations in iotests.py, 
and I believe adding this to QAPI will be of high value going forward.

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   configure | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configure b/configure
> index 7564479008..a3a643168e 100755
> --- a/configure
> +++ b/configure
> @@ -1965,8 +1965,8 @@ fi
>   
>   # Note that if the Python conditional here evaluates True we will exit
>   # with status 1 which is a shell 'false' value.
> -if ! $python -c 'import sys; sys.exit(sys.version_info < (3,5))'; then
> -  error_exit "Cannot use '$python', Python >= 3.5 is required." \
> +if ! $python -c 'import sys; sys.exit(sys.version_info < (3,6))'; then
> +  error_exit "Cannot use '$python', Python >= 3.6 is required." \
>         "Use --python=/path/to/python to specify a supported Python."
>   fi
>   
> 

Do we need to bump the minimum version in the Sphinx conf, too?

There's also a minimum version check in iotests.py that is now 
*possibly* redundant, but it does no harm.

Regardless, none of those things cause any harm:

Reviewed-by: John Snow <jsnow@redhat.com>


