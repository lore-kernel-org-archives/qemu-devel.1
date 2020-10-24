Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23498C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 06:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 793832225F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 06:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxOSKIk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793832225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWCgF-0003ov-Jx
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 02:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWCfI-00032I-0r
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 02:04:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWCfG-0002SL-7P
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 02:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603519468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pb5138dnXb1P08LCn3UkMswVSxUo+bTyE9UxEnHYgD8=;
 b=NxOSKIk/GffDCYKyI2c/LTizSiFKWJVQk+bob8OAzCczCRj5XAKWu3XF/w3Yab1AU5/fQ3
 xFyBAhkcCLvzH4wS8Vm3m/mu1fSweijDojgvHiL8HUgSWYmtea6gYrtWHoPJt5QbP6QpEY
 hmAymp0TAXCMYIDTPHn+3EI0+pmFTVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-wL3vwPUbMhiV4eL24qnJjQ-1; Sat, 24 Oct 2020 02:04:26 -0400
X-MC-Unique: wL3vwPUbMhiV4eL24qnJjQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E8FE805F01;
 Sat, 24 Oct 2020 06:04:25 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-13.ams2.redhat.com [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68D345C1C4;
 Sat, 24 Oct 2020 06:04:22 +0000 (UTC)
Subject: Re: [PATCH v4 04/12] libqos/qgraph: add qos_dump_graph()
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <cover.1602182956.git.qemu_oss@crudebyte.com>
 <5f493b816595f0f6fe50a3f83e46432ab48d881b.1602182956.git.qemu_oss@crudebyte.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8c8c8cf1-ed97-3f27-2d0e-7440433169f7@redhat.com>
Date: Sat, 24 Oct 2020 08:04:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5f493b816595f0f6fe50a3f83e46432ab48d881b.1602182956.git.qemu_oss@crudebyte.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 01:26:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/10/2020 20.34, Christian Schoenebeck wrote:
> This new function is purely for debugging purposes. It prints the
> current qos graph to stdout and allows to identify problems in the
> created qos graph e.g. when writing new qos tests.
> 
> Coloured output is used to mark available nodes in green colour,
> whereas unavailable nodes are marked in red colour.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  tests/qtest/libqos/qgraph.c | 56 +++++++++++++++++++++++++++++++++++++
>  tests/qtest/libqos/qgraph.h | 20 +++++++++++++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/tests/qtest/libqos/qgraph.c b/tests/qtest/libqos/qgraph.c
> index 61faf6b27d..af93e38dcb 100644
> --- a/tests/qtest/libqos/qgraph.c
> +++ b/tests/qtest/libqos/qgraph.c
> @@ -805,3 +805,59 @@ void qos_delete_cmd_line(const char *name)
>          node->command_line = NULL;
>      }
>  }
> +
> +#define RED(txt) (    \
> +    "\033[0;91m" txt  \
> +    "\033[0m"         \
> +)
> +
> +#define GREEN(txt) (  \
> +    "\033[0;92m" txt  \
> +    "\033[0m"         \
> +)

I don't think this is very portable - and it will only make logs ugly to
read in text editors. Could you please simply drop these macros?

 Thomas


