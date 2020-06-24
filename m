Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A5FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8C220768
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcTgeXLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8C220768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo83E-0000UG-8s
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 12:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jo81w-0007fj-4l
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:13:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52881
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jo81t-0007jY-HX
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593015220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W5nxhlEDQofemnSg/FYszW6usJuyTaMFRYmiI5js9HA=;
 b=NcTgeXLlHl7LRj3hfnQjhVtXlZm8K96rrIEDs3h8wo+tmSirthl6layduwxQ+y1LtUW7dd
 QXaIHG+EVjKD9QjhlMOMB1m80N7lJQjrj6k3/3OGgPATwzsKjZJBEPHwPT+iZ5WRbmj2+4
 ER/H5kbZnInhYK1yKMrFDjPtkQRJ0kU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-KDT7zG6tN8y9eHFHQ0kecA-1; Wed, 24 Jun 2020 12:13:38 -0400
X-MC-Unique: KDT7zG6tN8y9eHFHQ0kecA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A507B804002;
 Wed, 24 Jun 2020 16:13:37 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C9C35D9DC;
 Wed, 24 Jun 2020 16:13:36 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] tests/qmp-cmd-test: Add qmp/object-add-duplicate-id
To: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 berrange@redhat.com, ehabkost@redhat.com, armbru@redhat.com
References: <20200624124301.7112-1-eric.auger@redhat.com>
 <20200624124301.7112-3-eric.auger@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ff675de1-b338-2e2c-5b8a-94687df8f000@redhat.com>
Date: Wed, 24 Jun 2020 18:13:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200624124301.7112-3-eric.auger@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas,

On 6/24/20 2:43 PM, Eric Auger wrote:
> This new test checks that attempting to create an object
> with an existing ID gracefully fails.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  tests/qtest/qmp-cmd-test.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
> index 9f5228cd99..9510051c35 100644
> --- a/tests/qtest/qmp-cmd-test.c
> +++ b/tests/qtest/qmp-cmd-test.c
> @@ -213,6 +213,22 @@ static void test_object_add_without_props(void)
>      qtest_quit(qts);
>  }
>  
> +static void test_object_add_with_duplicate_id(void)
> +{
> +    QTestState *qts;
> +    QDict *resp;
> +
> +    qts = qtest_init(common_args);
> +    resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
> +                    " {'qom-type': 'memory-backend-ram', 'id': 'ram1', 'props': {'size': 4294967296 } } }");
> +    g_assert_nonnull(resp);
> +    g_assert(qdict_haskey(resp, "return"));
> +    resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
> +                    " {'qom-type': 'memory-backend-ram', 'id': 'ram1', 'props': {'size': 4294967296 } } }");
in v3 I will add here:
    g_assert_nonnull(resp);

Thanks
Eric
> +    qmp_assert_error_class(resp, "GenericError");
> +    qtest_quit(qts);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>      QmpSchema schema;
> @@ -225,6 +241,8 @@ int main(int argc, char *argv[])
>  
>      qtest_add_func("qmp/object-add-without-props",
>                     test_object_add_without_props);
> +    qtest_add_func("qmp/object-add-duplicate-id",
> +                   test_object_add_with_duplicate_id);
>      /* TODO: add coverage of generic object-add failure modes */
>  
>      ret = g_test_run();
> 


