Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0727FC561F8
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 05:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2F122249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 05:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdRnzmqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2F122249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV76h-00080T-6y
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 01:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kV75k-0007Rv-1t
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 01:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kV75h-0001h1-KZ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 01:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603259714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTdg4weq/BvZ6AmdYSFR+4tbJH1MBPh7N3Da22AbMvE=;
 b=fdRnzmqJObHfTl8lgNkUqH7EnFEVE20/XCJkMwsv9gDhrGCoFdng+N1q40yLiQu19oZ0K9
 OFoYa+hNFZdbtlnhZnp+kPuR0FEuQDFhe7IY1IkSQMpcbNQFKBkNwvdi5EIfXM/YMqrgAA
 QpN0q4rC+LmZEP6G0OotZeynvGibG1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-aIK1YrzqMYO8mxhMIWnZog-1; Wed, 21 Oct 2020 01:54:42 -0400
X-MC-Unique: aIK1YrzqMYO8mxhMIWnZog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E30D610866A4
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 05:54:41 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-165.ams2.redhat.com [10.36.112.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2ED271001281;
 Wed, 21 Oct 2020 05:54:36 +0000 (UTC)
Subject: Re: [PATCH] os: deprecate the -enable-fips option and QEMU's FIPS
 enforcement
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201020162211.401204-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <68011f67-a938-c004-0c59-2a4de09c896e@redhat.com>
Date: Wed, 21 Oct 2020 07:54:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201020162211.401204-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/10/2020 18.22, Daniel P. Berrangé wrote:
> The -enable-fips option was added a long time ago to prevent the use of
> single DES when VNC when FIPS mode is enabled. It should never have been
> added, because apps are supposed to unconditionally honour FIPS mode
> based on the '/proc/sys/crypto/fips_enabled' file contents.
> 
> In addition there is more to achieving FIPS compliance than merely
> blocking use of certain algorithms. Those algorithms which are used
> need to perform self-tests at runtime.
> 
> QEMU's built-in cryptography provider has no support for self-tests,
> and neither does the nettle library.
> 
> If QEMU is required to be used in a FIPS enabled host, then it must be
> built with the libgcrypt library enabled, which will unconditionally
> enforce FIPS compliance in any algorithm usage.
> 
> Thus there is no need to keep either the -enable-fips option in QEMU, or
> QEMU's internal FIPS checking methods.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  docs/system/deprecated.rst | 11 +++++++++++
>  os-posix.c                 |  3 +++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 905628f3a0..faa2bc49b1 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -158,6 +158,17 @@ devices.  It is possible to use drives the board doesn't pick up with
>  -device.  This usage is now deprecated.  Use ``if=none`` instead.
>  
>  

Nit: The two empty lines should be below the new entry (i.e. before the
"QMP" title below), not before it.

> +``--enable-fips`` (since 5.2)
> +
> +This option restricts usage of certain cryptographic algorithms when
> +the host is operating in FIPS mode.
> +
> +If FIPS compliance is required, QEMU should be built with the ``libgcrypt``
> +library enabled as a cryptography provider.
> +
> +Neither the ``nettle`` library, or the built-in cryptography provider are
> +supported on FIPS enabled hosts.
> +
>  QEMU Machine Protocol (QMP) commands
>  ------------------------------------
> diff --git a/os-posix.c b/os-posix.c
> index 1de2839554..a6846f51c1 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -153,6 +153,9 @@ int os_parse_cmd_args(int index, const char *optarg)
>          break;
>  #if defined(CONFIG_LINUX)
>      case QEMU_OPTION_enablefips:
> +        warn_report("-enable-fips is deprecated, please build QEMU with "
> +                    "the `libgcrypt` library as the cryptography provider "
> +                    "to enable FIPS compliance");
>          fips_set_state(true);
>          break;
>  #endif

With the nit fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>



