Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC37C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 19:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48CEC2070D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 19:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CEC2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54031 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEfhH-0008IG-Kh
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 15:49:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfg2-0007fp-JC
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfg1-00029D-Lt
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:48:02 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:50369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hEfg1-00027a-AL; Thu, 11 Apr 2019 15:48:01 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MekvV-1gdxrg0k7R-00apYk; Thu, 11 Apr 2019 21:42:41 +0200
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
References: <20190304071631.27567-1-richardw.yang@linux.intel.com>
	<20190304071631.27567-3-richardw.yang@linux.intel.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9a8d8585-4113-8ffe-d025-abd49c208428@vivier.eu>
Date: Thu, 11 Apr 2019 21:42:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190304071631.27567-3-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mvG07dIpjXQpTVmKoXIWocqHus1AQClPlb9RVVuavljOXVTLXq9
	obZKYICCeZ1ezhhMBhx8j2yCQe7fePTicSMMGViA3SCxui0oWxJAzMe/aevLTvudpN9PazZ
	h0XwrOYbLVD1K5vXV8+jLizWAuQgsw7eMhgE8gQpxx1oDmC7M7oNwqSJunlJKKFOwJ6ee14
	dPHRJzrjUs+ZLZTCV674g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RwCeqARjoxo=:ggiseNMLsOERsX5/TfSw7m
	VNpJLdn9A1mSoO1umTieOgyESA1UVq98MwSmTCXJPVHxKHlGezyLS6o6auNriwzILxexWExdF
	3rhWl/2KF0jREbnZgcvRzmaK8pqJTeAJBdxMeByrU2gPIlHgvooVy3QkSQAJ5r/LkXXjlCuHL
	1u24NHRwY8BD1mbaKdVPakQ3MEwxFpBkK1ItL4zfDaxKBQsqgeisGVc0ke1tui3jCQr14FhE6
	ja6y23zNxTvPWn18bG41oOPsj1jMmo/IoXaQchUYaNrL5rJfwDPBDqop8UaR3e4NTNsoZCxEv
	xc30WzPvvs/iwNJZnuUD+RIbqksxe3WZqA/6YnkBFpdvfc7VDhJ6Byo7TRA84ZiOChlxDMQ8m
	ed55E7ppMDzdHH3vvMw0SH9BJGk3xw1FbJHuLl5ew0Ilm0/JBi2umd3+0hydC6qwxzwXm0BzH
	+0X54eZm3j5WTVki2UUCdlLJDYPssfWgeiJunLb+bnBRq57FEqa78iAFQMTrESTqPQz2ZgQIv
	00gZFbDsVNRKoAicJ/ZoxE/IlfPIKtBLNIARla5RWwJpZufQpL5p5wM9ZIgPOZhfnuU89B63H
	iZ9mBJAzZRQE0L7zwhmBrDPKhuL68juOauh+Y22ZHbuvg0ot7iKDVWYyO9xi3nyk43zkq83PQ
	KsNbfMOjVYh+l2EdnWQiSD/Al1nsuOxBj8oytr8D+ITJT/hpJRzEK5Ie2Lsu7dXwvyJAuAgww
	jJKzldGluNIYeqjbN9iEDCliqLJNJfTlIXQZ+TFa2pI5ozzOProzQ1kI2cE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v6 2/2] CODING_STYLE: indent
 example code as all others
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, mjt@tls.msk.ru, imammedo@redhat.com,
	philmd@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411194239.g8LSxXqRtIJvD74tJbipB-Ql3Y3axo7lhwuRVTvwObA@z>

On 04/03/2019 08:16, Wei Yang wrote:
> All the example code are indented with four spaces except this one.
> 
> Fix this by adding four spaces here.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  CODING_STYLE | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/CODING_STYLE b/CODING_STYLE
> index 90321e9c28..cb8edcbb36 100644
> --- a/CODING_STYLE
> +++ b/CODING_STYLE
> @@ -147,10 +147,10 @@ block to a separate function altogether.
>  When comparing a variable for (in)equality with a constant, list the
>  constant on the right, as in:
>  
> -if (a == 1) {
> -    /* Reads like: "If a equals 1" */
> -    do_something();
> -}
> +    if (a == 1) {
> +        /* Reads like: "If a equals 1" */
> +        do_something();
> +    }
>  
>  Rationale: Yoda conditions (as in 'if (1 == a)') are awkward to read.
>  Besides, good compilers already warn users when '==' is mis-typed as '=',
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

