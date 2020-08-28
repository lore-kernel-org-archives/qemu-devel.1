Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13C6C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F272086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LltHzRMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F272086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBdvZ-00017N-Tr
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 08:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBduP-0008R8-JK
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:55:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBduN-0007es-Bn
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598619306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wFQ0hC3xlvILHGNIsCdu15pM3IFiQtwqggo27qGtIU=;
 b=LltHzRMCcK82A2cwomqh4r/REfGqu+3qnU4xGl44+mpoylAYzX8ecxHCyKW9XgXVHdOxV7
 qC8iOr5vUAxHO2F1fqbGJnzhbEQiV1fmf4g5m9yeR2f4PHzYzed/8K18o51wA93vaZXQXr
 LuXwsR8mn+5R6k+YULZvlPB7d4shohI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-kWtpLcc_PpWMtQZAyvE2Cg-1; Fri, 28 Aug 2020 08:55:04 -0400
X-MC-Unique: kWtpLcc_PpWMtQZAyvE2Cg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75E94195D563
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 12:55:02 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-79.ams2.redhat.com [10.36.112.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9742210429DD;
 Fri, 28 Aug 2020 12:54:53 +0000 (UTC)
Subject: Re: [PATCH 05/16] tests: qga has virtio-serial by default when host
 has it
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20200828110734.1638685-1-marcandre.lureau@redhat.com>
 <20200828110734.1638685-6-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e3840569-5aa5-34f7-5962-7f63c51451ae@redhat.com>
Date: Fri, 28 Aug 2020 14:54:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200828110734.1638685-6-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 02:09:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/08/2020 13.07, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> When dumping the default configuration, don't expect virtio-serial as
> the configured method, unless the host has CONFIG_VIRTIO_SERIAL.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/test-qga.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/test-qga.c b/tests/test-qga.c
> index 4ac4c22109..122730d326 100644
> --- a/tests/test-qga.c
> +++ b/tests/test-qga.c
> @@ -728,10 +728,12 @@ static void test_qga_config(gconstpointer data)
>      g_assert_false(g_key_file_get_boolean(kf, "general", "daemon", &error));
>      g_assert_no_error(error);
>  
> +#ifdef CONFIG_VIRTIO_SERIAL
>      str = g_key_file_get_string(kf, "general", "method", &error);
>      g_assert_no_error(error);
>      g_assert_cmpstr(str, ==, "virtio-serial");
>      g_free(str);
> +#endif
>  
>      str = g_key_file_get_string(kf, "general", "path", &error);
>      g_assert_no_error(error);

Does this work as expected? I thought that CONFIG_VIRTIO_SERIAL is a
*target* specific config switch, not a host specific one ?

 Thomas


