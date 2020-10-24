Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6977C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 07:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F092176B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 07:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMU8ePsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F092176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWDeh-0001mX-EH
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 03:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWDe8-0001N3-N2
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 03:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWDe6-0006zZ-I7
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 03:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603523241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c//kOxrPMm8y5r7Oc/Pvpn4Qk2QsxRyrTam0KvrTwRo=;
 b=VMU8ePslU/V/Ig/Th+VvtMDfo4qUX+q5R3Ub/aeG6guormDnHWx0UDEw2IBXWX0wjG3w+O
 5beYObiANy9BPnN4qfwBii9tQcoFzmhtCXAO4SJQF7dugHMoeholi/l/YOAzMgutYY2S+Y
 BI5BXzCNBIY+d+eXTXgjDI+fVXJVNDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-2o5G-S--N7OatjNhc4a3xQ-1; Sat, 24 Oct 2020 03:07:19 -0400
X-MC-Unique: 2o5G-S--N7OatjNhc4a3xQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53ADA805F0C;
 Sat, 24 Oct 2020 07:07:17 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-13.ams2.redhat.com [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 468C7614F5;
 Sat, 24 Oct 2020 07:07:08 +0000 (UTC)
Subject: Re: [PATCH v4 2/4] tests: Add tests for query-netdev command
To: Alexey Kirillov <lekiravi@yandex-team.ru>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20200921191912.105305-1-lekiravi@yandex-team.ru>
 <20200921191912.105305-3-lekiravi@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <27303d7b-e202-286f-9881-28bf87eb7c69@redhat.com>
Date: Sat, 24 Oct 2020 09:07:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200921191912.105305-3-lekiravi@yandex-team.ru>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 01:17:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Vincenzo Maffione <v.maffione@gmail.com>, yc-core@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/09/2020 21.19, Alexey Kirillov wrote:
> Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
> ---
>  tests/qtest/meson.build         |   3 +
>  tests/qtest/test-query-netdev.c | 115 ++++++++++++++++++++++++++++++++
>  2 files changed, 118 insertions(+)
>  create mode 100644 tests/qtest/test-query-netdev.c
[...]
> +static void test_query_netdev(void)
> +{
> +    const char *arch = qtest_get_arch();
> +    QObject *resp;
> +    QTestState *state;
> +
> +    /* Skip test for some MCU */
> +    if (g_str_equal(arch, "avr") ||
> +        g_str_equal(arch, "rx")) {
> +        return;
> +    }
> +
> +    if (g_str_equal(arch, "arm") ||
> +        g_str_equal(arch, "aarch64")) {
> +        state = qtest_init(
> +            "-nodefaults "
> +            "-M virt "
> +            "-netdev user,id=slirp0");
> +    } else if (g_str_equal(arch, "tricore")) {
> +        state = qtest_init(
> +            "-nodefaults "
> +            "-M tricore_testboard "
> +            "-netdev user,id=slirp0");
> +    } else {
> +        state = qtest_init(
> +            "-nodefaults "
> +            "-netdev user,id=slirp0");
> +    }
> +    g_assert(state);

Have you tried manually selecting a machine for the avr and rx targets? It
worked with the iotests, see commit
733dafe4914ef2e6d6a9d546b7fdbb429f3590e7, i.e. on avr you could try "-M
mega2560" and on rx you could try "-M gdbsim-r5f562n8".

> +    qmp_query_netdev_no_error(state, 1);
> +
> +    resp = wait_command(state,
> +        "{'execute': 'netdev_add', 'arguments': {"
> +        " 'id': 'slirp1',"
> +        " 'type': 'user'}}");
> +    qobject_unref(resp);
> +
> +    qmp_query_netdev_no_error(state, 2);
> +
> +    resp = wait_command(state,
> +        "{'execute': 'netdev_del', 'arguments': {"
> +        " 'id': 'slirp1'}}");
> +    qobject_unref(resp);
> +
> +    qmp_query_netdev_no_error(state, 1);
> +
> +    qtest_quit(state);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    int ret = 0;
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/net/qapi/query_netdev", test_query_netdev);
> +
> +    ret = g_test_run();
> +
> +    return ret;
> +}
> 

Acked-by: Thomas Huth <thuth@redhat.com>


