Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31FBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3222075D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="baEaVmIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3222075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zfY-0005MH-P9
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3zZS-00067c-RI
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:25:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46537
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3zZQ-000129-RP
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596795951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JMw/echBZusTaE3upkVhLAaOEahqBEMxrUlUYgQ6ig=;
 b=baEaVmIV26kNWbn7z6wwkmDloydIzIvatv9DcMo4zbexljRmj2sZ0W73AkOTDcEiRzT/Rj
 M/479g6WR0i0L1CfWuHlBTtygyInm0zCmW8OBiPwgkWk5Zq5LTgE2CJQqgGm270IXDgXqa
 uMuBySqj5UBovNFA9wwegx0jdUJtId4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-K0zBB6FWNN-0C4cKYShBjQ-1; Fri, 07 Aug 2020 06:25:49 -0400
X-MC-Unique: K0zBB6FWNN-0C4cKYShBjQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8ED758005B0;
 Fri,  7 Aug 2020 10:25:48 +0000 (UTC)
Received: from gondolin (ovpn-112-214.ams2.redhat.com [10.36.112.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AD5B5C1D2;
 Fri,  7 Aug 2020 10:25:43 +0000 (UTC)
Date: Fri, 7 Aug 2020 12:25:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
Message-ID: <20200807122541.31681bec.cohuck@redhat.com>
In-Reply-To: <73398402-2038-ccf7-203b-e6e911d056a0@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <761b4058-7a2b-d992-2cc2-6efe654ee62e@redhat.com>
 <9c894412-b156-607e-1ea9-9e9ba14cbf1a@redhat.com>
 <6f6e9c9b-fdf6-951e-9112-3913fe44c455@redhat.com>
 <4a79a167-ccd6-159a-0f67-072192b54b0d@redhat.com>
 <f4233923-f82e-6edf-8a56-2e4f62038d0e@redhat.com>
 <73398402-2038-ccf7-203b-e6e911d056a0@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Aug 2020 12:08:17 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 07/08/20 12:02, Thomas Huth wrote:
> > Thanks! With the fix, it now gets a little bit further, but then stops with:
> > 
> >   ../meson.build:1258:3: ERROR: Key CONFIG_QEMU_PRIVATE_XTS is not in dict
> >  https://gitlab.com/huth/qemu/-/jobs/675699330#L130  
> 
> diff --git a/meson.build b/meson.build
> index d14d4bb..5bcfa09 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -944,12 +944,12 @@ summary_info += {'GNUTLS support':    config_host.has_key('CONFIG_GNUTLS')}
>  summary_info += {'libgcrypt':         config_host.has_key('CONFIG_GCRYPT')}
>  if config_host.has_key('CONFIG_GCRYPT')
>     summary_info += {'  hmac':            config_host.has_key('CONFIG_GCRYPT_HMAC')}
> -   summary_info += {'  XTS':             config_host['CONFIG_QEMU_PRIVATE_XTS'] != 'y'}
> +   summary_info += {'  XTS':             not config_host.has_key('CONFIG_QEMU_PRIVATE_XTS')}
>  endif
>  # TODO: add back version
>  summary_info += {'nettle':            config_host.has_key('CONFIG_NETTLE')}
>  if config_host.has_key('CONFIG_NETTLE')
> -   summary_info += {'  XTS':             config_host['CONFIG_QEMU_PRIVATE_XTS'] != 'y'}
> +   summary_info += {'  XTS':             not config_host.has_key('CONFIG_QEMU_PRIVATE_XTS')}
>  endif
>  summary_info += {'libtasn1':          config_host.has_key('CONFIG_TASN1')}
>  summary_info += {'PAM':               config_host.has_key('CONFIG_AUTH_PAM')}

That one also seems to have fixed my x86 build woes.


