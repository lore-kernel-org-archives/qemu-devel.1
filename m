Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881ADC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56406214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YS7l5Kqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56406214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugQL-00050D-0u
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iufPp-0003Ig-MC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:33:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iufPn-0004Ta-Uw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:33:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56322
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iufPn-0004TB-Re
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579797187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=XvsCxfYHPkOwJtOmxnFNVMVwLGcwQY4mid4xzGSHM5I=;
 b=YS7l5KqanGUO/dulxOP3c8/abn74wc0W8HusRksDJRKESnR6Dfq5Miz6Bv2M7hAnebEqn+
 n+Nn+w4OUqyz1zppHyFp23WCMPQSJMviqaEVU801JN4d/u75AXcBC/qyMCZSbA+A2i7Lg6
 tjtFDhkgORckWtdwX1uWNXRriBqr4pw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135--mXEEN07P46abtx8EqrWVg-1; Thu, 23 Jan 2020 11:33:05 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E6291800D78
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:33:04 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C44975DA89;
 Thu, 23 Jan 2020 16:33:03 +0000 (UTC)
Subject: Re: [PATCH REPOST v3 79/80] tests:numa-test: make top level args
 dynamic and g_autofree(cli) cleanups
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-80-git-send-email-imammedo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3b1eb789-34d2-4c05-8174-1f0033246f83@redhat.com>
Date: Thu, 23 Jan 2020 17:33:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1579779525-20065-80-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: -mXEEN07P46abtx8EqrWVg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: lvivier@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/01/2020 12.38, Igor Mammedov wrote:
> Use GString to pass argument to make_cli() so that it would be easy
> to dynamically change test case arguments from main(). The follow up
> patch will use it to change RAM size options depending on target.
> 
> While at it cleanup 'cli' freeing, using g_autofree annotation.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
[...]
> @@ -539,11 +539,11 @@ static void pc_hmat_erange_cfg(const void *data)
>  
>  int main(int argc, char **argv)
>  {
> -    const char *args = NULL;
> +    g_autoptr(GString) args = g_string_new("");

Nit: You could use g_string_new(NULL) here to save two bytes ;-)

>      const char *arch = qtest_get_arch();
>  
> -    if (strcmp(arch, "aarch64") == 0) {
> -        args = "-machine virt";
> +    if (g_str_equal(arch, "aarch64")) {
> +        g_string_append(args, " -machine virt");
>      }
>  
>      g_test_init(&argc, &argv, NULL);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


