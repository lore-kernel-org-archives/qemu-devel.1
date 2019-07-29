Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917B9C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 00:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C742075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 00:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C742075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrtCu-00037a-Ih
	for qemu-devel@archiver.kernel.org; Sun, 28 Jul 2019 20:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38856)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hrtCW-0002cS-Ho
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 20:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hrtCV-0002XY-GL
 for qemu-devel@nongnu.org; Sun, 28 Jul 2019 20:07:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55764)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1hrtCT-0002S0-5W; Sun, 28 Jul 2019 20:07:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C288C8535C;
 Mon, 29 Jul 2019 00:07:35 +0000 (UTC)
Received: from localhost (ovpn-116-18.gru2.redhat.com [10.97.116.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08CBA60600;
 Mon, 29 Jul 2019 00:07:32 +0000 (UTC)
Date: Sun, 28 Jul 2019 21:07:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190729000730.GB4313@habkost.net>
References: <20190726225201.10561-1-jsnow@redhat.com>
 <20190726225201.10561-2-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726225201.10561-2-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 29 Jul 2019 00:07:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] iotests: add script_initialize
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 26, 2019 at 06:52:00PM -0400, John Snow wrote:
> Like script_main, but doesn't require a single point of entry.
> Replace all existing initialization sections with this drop-in replacement.
> 
> This brings debug support to all existing script-style iotests.
> 
> Note: supported_oses=['linux'] was omitted, as it is a default argument.
> Signed-off-by: John Snow <jsnow@redhat.com>
[...]

Looks good overall, I just have one comment:


> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 727730422f..5e9b2989dd 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -891,9 +891,8 @@ def execute_unittest(output, verbosity, debug):
>              sys.stderr.write(re.sub(r'Ran (\d+) tests? in [\d.]+s',
>                                      r'Ran \1 tests', output.getvalue()))
>  
> -def execute_test(test_function=None,
> -                 supported_fmts=[], supported_oses=['linux'],
> -                 supported_cache_modes=[], unsupported_fmts=[]):
> +def execute_setup_common(supported_fmts=[], supported_oses=['linux'],
> +                         supported_cache_modes=[], unsupported_fmts=[]):
>      """Run either unittest or script-style tests."""
>  
>      # We are using TEST_DIR and QEMU_DEFAULT_MACHINE as proxies to
> @@ -925,16 +924,28 @@ def execute_test(test_function=None,
>              output = io.BytesIO()
>  
>      logging.basicConfig(level=(logging.DEBUG if debug else logging.WARN))
> +    return output, verbosity, debug

Can't we make this simpler?

What about just returning `debug`, and letting execute_unittest()
take care of `verbosity` and `output`?

>  
> +def execute_test(test_function=None, *args, **kwargs):
> +    """Run either unittest or script-style tests."""
> +
> +    unittest_args = execute_setup_common(*args, **kwargs)
>      if not test_function:
> -        execute_unittest(output, verbosity, debug)
> +        execute_unittest(*unittest_args)
>      else:
>          test_function()
>  
> +# This is called from script-style iotests without a single point of entry
> +def script_initialize(*args, **kwargs):
> +    """Initialize script-style tests without running any tests."""
> +    execute_setup_common(*args, **kwargs)
> +
> +# This is called from script-style iotests with a single point of entry
>  def script_main(test_function, *args, **kwargs):
>      """Run script-style tests outside of the unittest framework"""
>      execute_test(test_function, *args, **kwargs)
>  
> +# This is called from unittest style iotests
>  def main(*args, **kwargs):
>      """Run tests using the unittest framework"""
>      execute_test(None, *args, **kwargs)
> -- 
> 2.21.0
> 

-- 
Eduardo

