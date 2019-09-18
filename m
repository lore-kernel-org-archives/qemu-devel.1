Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070A5C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:33:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB92B218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB92B218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAelB-0005rM-0D
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 14:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iAejv-0005Ik-SS
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iAejt-0005EP-Sz
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:31:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53498)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iAejj-00057i-03; Wed, 18 Sep 2019 14:31:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BE24C30860CF;
 Wed, 18 Sep 2019 18:31:25 +0000 (UTC)
Received: from [10.10.124.73] (ovpn-124-73.rdu2.redhat.com [10.10.124.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5EDF5D6A5;
 Wed, 18 Sep 2019 18:31:19 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190917092004.999-1-mreitz@redhat.com>
 <20190917092004.999-4-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <585141f0-167c-90cf-3583-af2c70bbb872@redhat.com>
Date: Wed, 18 Sep 2019 14:31:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190917092004.999-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 18 Sep 2019 18:31:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 3/7] iotests: Use case_skip() in
 skip_if_unsupported()
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/17/19 5:20 AM, Max Reitz wrote:
> skip_if_unsupported() should use the stronger variant case_skip(),
> because this allows it to be used even with setUp() (in a meaningful
> way).
> 
> In the process, make it explicit what we expect the first argument of
> the func_wrapper to be (namely something derived of QMPTestCase).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index e46f3b6aed..427c34697a 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -893,14 +893,14 @@ def skip_if_unsupported(required_formats=[], read_only=False):
>       '''Skip Test Decorator
>          Runs the test if all the required formats are whitelisted'''
>       def skip_test_decorator(func):
> -        def func_wrapper(*args, **kwargs):
> +        def func_wrapper(test_case: QMPTestCase, *args, **kwargs):

The dream lives!

>               usf_list = list(set(required_formats) -
>                               set(supported_formats(read_only)))
>               if usf_list:
> -                case_notrun('{}: formats {} are not whitelisted'.format(
> -                    args[0], usf_list))
> +                test_case.case_skip('{}: formats {} are not whitelisted'.format(
> +                    test_case, usf_list))
>               else:
> -                return func(*args, **kwargs)
> +                return func(test_case, *args, **kwargs)
>           return func_wrapper
>       return skip_test_decorator
>   
> 

Reviewed-by: John Snow <jsnow@redhat.com>

