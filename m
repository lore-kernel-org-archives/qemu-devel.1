Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9681C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490702080C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVG9G2Vp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490702080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG59N-0007Dy-FH
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kG58X-0006Hw-Bm
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kG58V-0008O9-Dh
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599677282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbvojR69c4xzKlPLFj9TZWonkDVezZj3uCDAQXNnp6U=;
 b=QVG9G2VpDDbo+NYf30K0ARTGLaG17gEZTxqEY95Yka6MclqRKb9DVXBtGImH89YpKObsla
 Cdhfy3wwfwthfGaM2+KvmiUWCCILAPsQa3DZ3zoSOd7ABnE97dg2AMIDU0rT/fdoC/2b3c
 OVvbgsJnIIExovMomDrtxu0AFJcLmg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-hojcLT5RPsqMucgC2tTeLQ-1; Wed, 09 Sep 2020 14:48:00 -0400
X-MC-Unique: hojcLT5RPsqMucgC2tTeLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DC8F1091063;
 Wed,  9 Sep 2020 18:47:58 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-234.ams2.redhat.com [10.36.112.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CD3B19C66;
 Wed,  9 Sep 2020 18:47:50 +0000 (UTC)
Subject: Re: [PATCH v6 08/25] tests: disable /char/stdio/* tests in
 test-char.c on win32
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200909184237.765-1-luoyonggang@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <70cdfb53-b1d3-0029-923b-ec33a170eedb@redhat.com>
Date: Wed, 9 Sep 2020 20:47:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200909184237.765-1-luoyonggang@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:25:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/2020 20.42, Yonggang Luo wrote:
> These tests are blocking test-char to be finished.
> Disable them by using variable is_win32, so we doesn't
> need macro to open it. and easy recover those function
> latter.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/test-char.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/test-char.c b/tests/test-char.c
> index d35cc839bc..184ddceab8 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -77,7 +77,6 @@ static void fe_event(void *opaque, QEMUChrEvent event)
>      }
>  }
>  
> -#ifdef _WIN32
>  static void char_console_test_subprocess(void)
>  {
>      QemuOpts *opts;
> @@ -102,7 +101,7 @@ static void char_console_test(void)
>      g_test_trap_assert_passed();
>      g_test_trap_assert_stdout("CONSOLE");
>  }
> -#endif
> +
>  static void char_stdio_test_subprocess(void)
>  {
>      Chardev *chr;
> @@ -1448,7 +1447,11 @@ static SocketAddress unixaddr = {
>  
>  int main(int argc, char **argv)
>  {
> -    bool has_ipv4, has_ipv6;
> +    bool has_ipv4, has_ipv6, is_win32 = false;
> +
> +#ifdef _WIN32
> +    is_win32 = true;
> +#endif
>  
>      qemu_init_main_loop(&error_abort);
>      socket_init();
> @@ -1467,12 +1470,15 @@ int main(int argc, char **argv)
>      g_test_add_func("/char/invalid", char_invalid_test);
>      g_test_add_func("/char/ringbuf", char_ringbuf_test);
>      g_test_add_func("/char/mux", char_mux_test);
> -#ifdef _WIN32
> -    g_test_add_func("/char/console/subprocess", char_console_test_subprocess);
> -    g_test_add_func("/char/console", char_console_test);
> -#endif
> -    g_test_add_func("/char/stdio/subprocess", char_stdio_test_subprocess);
> -    g_test_add_func("/char/stdio", char_stdio_test);
> +    if (0) {
> +        g_test_add_func("/char/console/subprocess", char_console_test_subprocess);
> +        g_test_add_func("/char/console", char_console_test);
> +    }

Sorry, but this looks pretty much like a work-in-progress debugging
patch. Please avoid sending such stuff to the mailing list, and if so,
clearly mark it as an RFC and describe it in the patch description.

It also does not help much if you send your series three times a day to
the list - nobody has that much reviewing band width. So please take
some time, finish your patches first, and when you're sure that they are
really finished, then post a new series to the mailing list.

Thanks,
 Thomas


> +    if (!is_win32) {
> +        g_test_add_func("/char/stdio/subprocess", char_stdio_test_subprocess);
> +        g_test_add_func("/char/stdio", char_stdio_test);
> +    }
>  #ifndef _WIN32
>      g_test_add_func("/char/pipe", char_pipe_test);
>  #endif
> @@ -1534,7 +1540,7 @@ int main(int argc, char **argv)
>      g_test_add_data_func("/char/socket/client/dupid-reconnect/" # name, \
>                           &client8 ##name, char_socket_client_dupid_test)
>  
> -    if (has_ipv4) {
> +    if (has_ipv4 && !is_win32) {
>          SOCKET_SERVER_TEST(tcp, &tcpaddr);
>          SOCKET_CLIENT_TEST(tcp, &tcpaddr);
>          g_test_add_data_func("/char/socket/server/two-clients/tcp", &tcpaddr,
> 


