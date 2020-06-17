Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE60C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC032082F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqmP21YY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC032082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSb7-0000HC-1u
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlSXZ-0005ww-PH
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:31:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39280
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlSXW-0003Z3-NY
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592379077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Aja4NuHhJlFz7WG3qt2uX1TgPVfWdbNdD9GnYJRHAfI=;
 b=IqmP21YYrQg+dWD4BAxxyOmUCkF+CLr7W5bAyGcrJRozSYjsikW0rGAod/tBpnjLQx9GYz
 XlY7hEtX/pPEmqUwnprOkXxDu9woZlcBTlgbn5YIiIbMuy86cUOCbY44dVOwO+2Ogr3ek6
 9JT3pxB9mI+3x2BSAkoCW35W/SWezJc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-42aI74vLM5KU-veaJk9l1A-1; Wed, 17 Jun 2020 03:31:16 -0400
X-MC-Unique: 42aI74vLM5KU-veaJk9l1A-1
Received: by mail-wr1-f69.google.com with SMTP id p10so606071wrn.19
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 00:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Aja4NuHhJlFz7WG3qt2uX1TgPVfWdbNdD9GnYJRHAfI=;
 b=hgN14Vxp2aG9FaWwf5j5WWDBfRZDaUDP06DAcuoUTr8i3ZPbLtbVPKV7lS1OrlsNek
 eeqOLTKfHc9fVZjhWFVk1TvCdehIoBzPHHtxcaWBrS4i093leJjlyiW4XIsJ03hy1b+q
 NeFIM5fyUtTRjZjEtPYBf3yoNS0Sv4A568Wk4lEygDnwZwsjuqIkWBsuXWGgAK4UF3QI
 nIZCcYI2xzwd10jnV7HxhxBv0ccMOc9nAkH6UT31GWrojABqPYBtntokr2WT8KYoWQpx
 uCtLmPgAtoUQ5BaMXQIX72WePlxd8lnSMpcQ2md8LfQDoEbupS3xMZvlgjzY7k7vFwVe
 gzCw==
X-Gm-Message-State: AOAM530LmMZcDCAJBeLD5uMYQfyOuRAjn4vwvG2+rlJDzEZ+IOMEU+sA
 LE0x+i2vbzQkv2aBkSSPWCJ4aGexGFW7vONTy9mln+sQmTX4iBXUxwhN6BhlhuUs9Lo1bkQy4h+
 ntV5hg+QfCX8M7f0=
X-Received: by 2002:a5d:498f:: with SMTP id r15mr1213955wrq.175.1592379075065; 
 Wed, 17 Jun 2020 00:31:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGVl3PbewFzsjRvfUwl2EY/2hByG1gkMH63YQSiK/LwtRtnHYIBErA9q3uTwNUpKRBYSuBHg==
X-Received: by 2002:a5d:498f:: with SMTP id r15mr1213924wrq.175.1592379074816; 
 Wed, 17 Jun 2020 00:31:14 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id v24sm5857660wrd.92.2020.06.17.00.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 00:31:14 -0700 (PDT)
Subject: Re: [PATCH v9 01/10] acpi: bios-tables-test: show more context on asl
 diffs
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200617071138.11159-1-kraxel@redhat.com>
 <20200617071138.11159-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <17c3a2b5-19a1-5335-eba7-f06714a41915@redhat.com>
Date: Wed, 17 Jun 2020 09:31:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200617071138.11159-2-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 9:11 AM, Gerd Hoffmann wrote:
> Makes it easier to create good commit messages from the logs.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index b482f76c03d4..c315156858f4 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -469,7 +469,7 @@ static void test_acpi_asl(test_data *data)
>                  fflush(stderr);
>                  if (getenv("V")) {
>                      const char *diff_env = getenv("DIFF");
> -                    const char *diff_cmd = diff_env ? diff_env : "diff -u";
> +                    const char *diff_cmd = diff_env ? diff_env : "diff -U 16";
>                      char *diff = g_strdup_printf("%s %s %s", diff_cmd,
>                                                   exp_sdt->asl_file, sdt->asl_file);
>                      int out = dup(STDOUT_FILENO);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


