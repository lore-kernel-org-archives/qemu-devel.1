Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B97C388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D998021D46
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDdA2soq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D998021D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcAc3-0004c0-Vz
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kcAYl-0001LQ-IB
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:02:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kcAYa-00055o-Qs
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604941334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ziv47dXeWxWaSV9EdZ3y0qxoZUrUiSBmxTLORMomZy0=;
 b=jDdA2soqecvykaikDUmc243JrTB12myw93/C3lKQEBRa75Uc3p+CSFhddXpvgcFx17pmlk
 7TarwVe0vhURFtTVNqSDtZGFIbkSkVIsKq/jdpbD5aX8VULGTHQlCqonkkAT7nukukVdQ2
 TjVTMAgAVSV23HA/J6nhjikHDNo0JbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-X-s5-Fa5M_-JsMiVNE5Drw-1; Mon, 09 Nov 2020 12:02:10 -0500
X-MC-Unique: X-s5-Fa5M_-JsMiVNE5Drw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75EA8879512;
 Mon,  9 Nov 2020 17:02:09 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B23005B4CB;
 Mon,  9 Nov 2020 17:02:01 +0000 (UTC)
Subject: Re: [PATCH] qtest: Update references to parse_escape() in comments
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201109162621.18885-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <376a9acb-6f8d-7820-8a9e-fdf99394b3b7@redhat.com>
Date: Mon, 9 Nov 2020 18:02:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201109162621.18885-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/2020 17.26, Peter Maydell wrote:
> In commit 61030280ca2d67bd in 2018 we renamed the parse_escape()
> function to parse_interpolation(), but we didn't catch the references
> to this function in doc comments in libqtest.h. Update them.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Side note: ideally we would document somewhere the accepted
> %-escapes rather than requiring people to read the source code
> to parse_interpolation to determine them... "The argument to %p
> is qobject_unref()ed" is particularly non-obvious.
> ---
>  tests/qtest/libqos/libqtest.h | 18 +++++++++---------
>  tests/qtest/libqtest-single.h |  2 +-
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/qtest/libqos/libqtest.h b/tests/qtest/libqos/libqtest.h
> index 5c959f18535..724f65aa947 100644
> --- a/tests/qtest/libqos/libqtest.h
> +++ b/tests/qtest/libqos/libqtest.h
> @@ -88,7 +88,7 @@ void qtest_quit(QTestState *s);
>   * @fds: array of file descriptors
>   * @fds_num: number of elements in @fds
>   * @fmt: QMP message to send to qemu, formatted like
> - * qobject_from_jsonf_nofail().  See parse_escape() for what's
> + * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
>   * supported after '%'.
>   *
>   * Sends a QMP message to QEMU with fds and returns the response.
> @@ -101,7 +101,7 @@ QDict *qtest_qmp_fds(QTestState *s, int *fds, size_t fds_num,
>   * qtest_qmp:
>   * @s: #QTestState instance to operate on.
>   * @fmt: QMP message to send to qemu, formatted like
> - * qobject_from_jsonf_nofail().  See parse_escape() for what's
> + * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
>   * supported after '%'.
>   *
>   * Sends a QMP message to QEMU and returns the response.
> @@ -113,7 +113,7 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
>   * qtest_qmp_send:
>   * @s: #QTestState instance to operate on.
>   * @fmt: QMP message to send to qemu, formatted like
> - * qobject_from_jsonf_nofail().  See parse_escape() for what's
> + * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
>   * supported after '%'.
>   *
>   * Sends a QMP message to QEMU and leaves the response in the stream.
> @@ -138,7 +138,7 @@ void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
>   * @fds: array of file descriptors
>   * @fds_num: number of elements in @fds
>   * @fmt: QMP message to send to QEMU, formatted like
> - * qobject_from_jsonf_nofail().  See parse_escape() for what's
> + * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
>   * supported after '%'.
>   * @ap: QMP message arguments
>   *
> @@ -152,7 +152,7 @@ QDict *qtest_vqmp_fds(QTestState *s, int *fds, size_t fds_num,
>   * qtest_vqmp:
>   * @s: #QTestState instance to operate on.
>   * @fmt: QMP message to send to QEMU, formatted like
> - * qobject_from_jsonf_nofail().  See parse_escape() for what's
> + * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
>   * supported after '%'.
>   * @ap: QMP message arguments
>   *
> @@ -167,7 +167,7 @@ QDict *qtest_vqmp(QTestState *s, const char *fmt, va_list ap)
>   * @fds: array of file descriptors
>   * @fds_num: number of elements in @fds
>   * @fmt: QMP message to send to QEMU, formatted like
> - * qobject_from_jsonf_nofail().  See parse_escape() for what's
> + * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
>   * supported after '%'.
>   * @ap: QMP message arguments
>   *
> @@ -181,7 +181,7 @@ void qtest_qmp_vsend_fds(QTestState *s, int *fds, size_t fds_num,
>   * qtest_qmp_vsend:
>   * @s: #QTestState instance to operate on.
>   * @fmt: QMP message to send to QEMU, formatted like
> - * qobject_from_jsonf_nofail().  See parse_escape() for what's
> + * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
>   * supported after '%'.
>   * @ap: QMP message arguments
>   *
> @@ -636,7 +636,7 @@ void qtest_add_abrt_handler(GHookFunc fn, const void *data);
>   * qtest_qmp_assert_success:
>   * @qts: QTestState instance to operate on
>   * @fmt: QMP message to send to qemu, formatted like
> - * qobject_from_jsonf_nofail().  See parse_escape() for what's
> + * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
>   * supported after '%'.
>   *
>   * Sends a QMP message to QEMU and asserts that a 'return' key is present in
> @@ -683,7 +683,7 @@ void qtest_qmp_device_add_qdict(QTestState *qts, const char *drv,
>   * @driver: Name of the device that should be added
>   * @id: Identification string
>   * @fmt: QMP message to send to qemu, formatted like
> - * qobject_from_jsonf_nofail().  See parse_escape() for what's
> + * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
>   * supported after '%'.
>   *
>   * Generic hot-plugging test via the device_add QMP command.
> diff --git a/tests/qtest/libqtest-single.h b/tests/qtest/libqtest-single.h
> index 176979a2ce9..0d7f568678e 100644
> --- a/tests/qtest/libqtest-single.h
> +++ b/tests/qtest/libqtest-single.h
> @@ -47,7 +47,7 @@ static inline void qtest_end(void)
>  /**
>   * qmp:
>   * @fmt...: QMP message to send to qemu, formatted like
> - * qobject_from_jsonf_nofail().  See parse_escape() for what's
> + * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
>   * supported after '%'.
>   *
>   * Sends a QMP message to QEMU and returns the response.
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

... and queued for my next pull request.


