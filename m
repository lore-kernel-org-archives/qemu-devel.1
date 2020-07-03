Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07B3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E3D208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2rhfUEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E3D208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNS7-0004Pz-Sj
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jrNQK-00020l-14
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:16:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33066
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jrNQI-0003rc-Cf
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593789377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=h3UGGcqizTNqcAwOfsyCLUqIO/hz59m8C37M/G6xxzA=;
 b=V2rhfUECE91bE/vXjMFwln8h+U2tw3XeXvDv1NNbUoFXLJ0KrvSGrUI6uq6VBiys0VL7ID
 8SEyL+PC3ivTYb690RtBCTunPTl5zLq5JkOA4b05PNlF9x1AAOX3+XRdQnIVdU11PgFw0G
 h8od2HkNSdjrUh5Ze8Ml+s+LewJNqnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-58jYJ3ZxN62JTyU80GnCrg-1; Fri, 03 Jul 2020 11:16:13 -0400
X-MC-Unique: 58jYJ3ZxN62JTyU80GnCrg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81EA818FF663;
 Fri,  3 Jul 2020 15:16:12 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-87.ams2.redhat.com [10.36.112.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68B487BD5B;
 Fri,  3 Jul 2020 15:16:08 +0000 (UTC)
Subject: Re: [PATCH v3 5/9] osdep.h: For Haiku, define SIGIO as equivalent to
 SIGPOLL
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200703145614.16684-1-peter.maydell@linaro.org>
 <20200703145614.16684-6-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <31b9ddf0-c386-89e9-be50-1d8ef627518d@redhat.com>
Date: Fri, 3 Jul 2020 17:16:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200703145614.16684-6-peter.maydell@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Carlier <devnexen@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/07/2020 16.56, Peter Maydell wrote:
> From: David CARLIER <devnexen@gmail.com>
> 
> Haiku doesn't provide SIGIO; fix this up in osdep.h by defining it as
> equal to SIGPOLL.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> [PMM: Expanded commit message]
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/qemu/osdep.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 6e0cf9132d9..e090ead8262 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -425,6 +425,10 @@ void qemu_anon_ram_free(void *ptr, size_t size);
>  #define HAVE_CHARDEV_PARPORT 1
>  #endif
>  
> +#if defined(__HAIKU__)
> +#define SIGIO SIGPOLL
> +#endif
> +
>  #if defined(CONFIG_LINUX)
>  #ifndef BUS_MCEERR_AR
>  #define BUS_MCEERR_AR 4

Sounds reasonable.

Reviewed-by: Thomas Huth <thuth@redhat.com>


