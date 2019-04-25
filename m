Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865A8C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87969206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87969206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58420 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJfG9-0007sz-6e
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:21:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJfFI-0007aE-Oa
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJfFH-0002Ov-Nw
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:21:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1hJfFH-0002Oa-Hn
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:21:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDF6A7DCC4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-118.rdu2.redhat.com
	[10.10.122.118])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5BA8817A8D;
	Thu, 25 Apr 2019 14:20:59 +0000 (UTC)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<20190423212246.3542-2-ehabkost@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <b8a8e3fb-281a-7252-4899-859959a97a1d@redhat.com>
Date: Thu, 25 Apr 2019 11:20:58 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190423212246.3542-2-ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 25 Apr 2019 14:21:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] qapi: SupportStatusInfo struct
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
Cc: mprivozn@redhat.com, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425142058.yzJuBSfWdFn2m34GZdEQraLDw-BViVI4_A5yZLDFhmw@z>

Hi Eduardo,


On 04/23/2019 06:22 PM, Eduardo Habkost wrote:
> This struct will be used to represent support and deprecation
> status of QEMU features.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   qapi/common.json | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/qapi/common.json b/qapi/common.json
> index 99d313ef3b..b59d0dc66b 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -193,3 +193,27 @@
>                'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>                'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>                'x86_64', 'xtensa', 'xtensaeb' ] }
> +
> +##
> +# @SupportStatusInfo:
> +#
> +# Information on support status of a given feature
> +# (e.g. machine type)
> +#
> +# @deprecated: if true, the given feature is deprecated and may be removed
> +#              in future versions of QEMU according to the QEMU deprecation
> +#              policy.

Eventually management software will need the know the QEMU version the 
feature is planed for removal. So makes sense to include a field to 
capture that information as well or do you expect it to be added (as a 
good practice) in the 'status-message'?

- Wainer

> +#
> +# @status-message: Human readable message describing support status
> +#                  of the feature.
> +#
> +# @suggested-alternative: Optional.  Suggested alternative for a deprecated
> +#                         feature.  For machine types, this should be the name
> +#                         of an available machine-type.
> +#
> +# Since: 4.1
> +##
> +{ 'struct': 'SupportStatusInfo',
> +  'data': { 'deprecated': 'bool',
> +            '*status-message': 'str',
> +            '*suggested-alternative': 'str' } }


