Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAB6C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F47221A49
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F47221A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAf3a-0002HW-43
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 14:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iAf1B-0008D2-3b
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iAf1A-0006go-3D
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:49:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iAf15-0006f5-W2; Wed, 18 Sep 2019 14:49:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D11FA3082E55;
 Wed, 18 Sep 2019 18:49:26 +0000 (UTC)
Received: from [10.10.124.73] (ovpn-124-73.rdu2.redhat.com [10.10.124.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36736600C8;
 Wed, 18 Sep 2019 18:49:26 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20190918085519.17290-1-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b0f72b9f-69b1-4e1d-4321-d30c7d85355f@redhat.com>
Date: Wed, 18 Sep 2019 14:49:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190918085519.17290-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 18 Sep 2019 18:49:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] iotests: Require Python 3.5 or later
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
Cc: mreitz@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/18/19 4:55 AM, Kevin Wolf wrote:
> Running iotests is not required to build QEMU, so we can have stricter
> version requirements for Python here and can make use of new features
> and drop compatibility code earlier.
> 
> This makes qemu-iotests skip all Python tests if a Python version before
> 3.5 is used for the build.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/check | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 875399d79f..a68f414d6c 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -633,6 +633,13 @@ then
>       export SOCKET_SCM_HELPER="$build_iotests/socket_scm_helper"
>   fi
>   
> +# Note that if the Python conditional here evaluates True we will exit
> +# with status 1 which is a shell 'false' value.
> +python_usable=false
> +if ! $PYTHON -c 'import sys; sys.exit(sys.version_info >= (3,5))'; then
> +    python_usable=true
> +fi
> +

Do we want this as a temporary fix only until we can stipulate the same 
version in the configure file?

If so, leaving a comment with "python2" in it anywhere will help locate 
this later.

>   default_machine=$($QEMU_PROG -machine help | sed -n '/(default)/ s/ .*//p')
>   default_alias_machine=$($QEMU_PROG -machine help | \
>      sed -n "/(alias of $default_machine)/ { s/ .*//p; q; }")
> @@ -809,7 +816,12 @@ do
>           start=$(_wallclock)
>   
>           if [ "$(head -n 1 "$source_iotests/$seq")" == "#!/usr/bin/env python" ]; then
> -            run_command="$PYTHON $seq"
> +            if $python_usable; then
> +                run_command="$PYTHON $seq"
> +            else
> +                run_command="false"
> +                echo "Unsupported Python version" > $seq.notrun
> +            fi
>           else
>               run_command="./$seq"
>           fi
> 

If you agree with my suggestion:

Reviewed-by: John Snow <jsnow@redhat.com>

If you don't, that's, like, your opinion, man.

