Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D231C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 16:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7C720826
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 16:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZluOuLJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7C720826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jctjb-0000oB-98
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 12:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jctij-0008J9-LN
 for qemu-devel@nongnu.org; Sun, 24 May 2020 12:43:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56247
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jctii-0006MK-I5
 for qemu-devel@nongnu.org; Sun, 24 May 2020 12:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590338607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NpihC6Zre0wnlzsl0deTjkDQ79DMxIDvcdF2ikdit4o=;
 b=ZluOuLJm1EXfbWsncm62Rys7BWncPOVokMPdTPrLrLn4HDMF3Sj8OdqPpoHnCcxTxo/u+/
 M6MLAqqOC57hU8KiMmjyseByjo4WSbZpdmvHxCEBRs+NMBOiUnZ662QTZoFAjjTnJVDMzB
 stSu+otfln5Ea8YPQnccaJRCOoQmkeg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-x9k-VBLyMhyiyCg6EdWQLw-1; Sun, 24 May 2020 12:43:26 -0400
X-MC-Unique: x9k-VBLyMhyiyCg6EdWQLw-1
Received: by mail-wm1-f71.google.com with SMTP id k185so310554wme.8
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 09:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=NpihC6Zre0wnlzsl0deTjkDQ79DMxIDvcdF2ikdit4o=;
 b=njxBrB9JC/zagJgs0NYfb0ocVyVzCLsut8uxE8DYAOmi9HhbnzTNMVft6f8EUpaGDK
 FcDR+5m8Kpyn+zGPGBxMqkuQYWvGOFVy1CZnomoqyoUGTC1PATh3jAMZKdRJ4VFDext3
 yyQw61tDjzBQ/K9BVDM7VdAtmWxqUxYOrttP3ZSU07BZy96wHPzhc+sJ50GXbG7eujVo
 Lh6ONfOotb4Y3vK3dkDX2lqAH7M6GGGQMAf+M9YA5+XPExWAfKyPIq1Di6kf6ANrROPa
 NU5Vo53b+AZvwzfODedTrj6NmexDKSPFkGCYSRBFnBZ5OIbdrzP4n959rlChM+wQP6sJ
 fWrA==
X-Gm-Message-State: AOAM533yU1PaKQbmfJsVqAqqVGtEOWnmatoaFHRFOMxvAf/0MLBPpcUM
 //ZUKW1X134aSn1ueJNvopRJY2kJYrKXhSrmfSTnd8p/CaTdlGIFfZZntddjYdmriIFv172n+kV
 22PPnF570eytN3Xc=
X-Received: by 2002:a05:600c:2dd7:: with SMTP id
 e23mr21095307wmh.96.1590338604817; 
 Sun, 24 May 2020 09:43:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPsw3OU/sQzkYhZCtD/aZM+DRCXES0dQ0R9PXRJj+BgnDv8ggLYKlYPujB+RLwF/LtFkQctg==
X-Received: by 2002:a05:600c:2dd7:: with SMTP id
 e23mr21095299wmh.96.1590338604608; 
 Sun, 24 May 2020 09:43:24 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id o8sm8238514wmb.20.2020.05.24.09.43.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 May 2020 09:43:23 -0700 (PDT)
Subject: Re: [PATCH] fuzz: add information about useful libFuzzer flags
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200524143738.23218-1-alxndr@bu.edu>
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
Message-ID: <5a052c47-82ec-25ae-47ed-4a684a0119d0@redhat.com>
Date: Sun, 24 May 2020 18:43:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200524143738.23218-1-alxndr@bu.edu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 12:43:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/24/20 4:37 PM, Alexander Bulekov wrote:
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  docs/devel/fuzzing.txt | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
> index 324d2cd92b..3458763e53 100644
> --- a/docs/devel/fuzzing.txt
> +++ b/docs/devel/fuzzing.txt
> @@ -45,6 +45,39 @@ Information about these is available by passing -help=1
>  Now the only thing left to do is wait for the fuzzer to trigger potential
>  crashes.
>  
> +== Useful libFuzzer flags ==
> +
> +As mentioned above, libFuzzer accepts some arguments. Passing -help=1 will list
> +the available arguments. In particular, these arguments might be helpful:
> +
> +$CORPUS_DIR/ : Specify a directory as the last argument to libFuzzer. libFuzzer
> +stores each "interesting" input in this corpus directory. The next time you run
> +libFuzzer, it will read all of the inputs from the corpus, and continue fuzzing
> +from there.

Maybe describe we can use multiple directories, the first one is where
new inputs are written.

> +
> +-max_len=4096 : specify the maximum byte-length of the inputs libFuzzer will
> +generate.
> +
> +-close_fd_mask={1,2,3} : close, stderr, or both. Useful for targets that
> +trigger many debug/error messages, or create output on the serial console.
> +
> +-jobs=4 -workers=4 : These arguments configure libFuzzer to run 4 fuzzers in
> +parallel.

The difference between job/worker is not clear...

> Replace 4 with a number appropriate for your machine. Make sure to
> +specify a $CORPUS_DIR, which will allow the parallel fuzzers to share
> +information about the interesting inputs they find.
> +
> +-use_value_profile=1 : For each comparison operation, libFuzzer computes 
> +(caller_pc&4095) | (popcnt(Arg1 ^ Arg2) << 12) and places this in the coverage
> +table. Useful for targets with "magic" constants. If Arg1 came from the fuzzer's
> +input and Arg2 is a magic constant, then each time the hamming distance

"Hamming" (lastname).

Thanks!

> +between Arg1 and Arg2 decreases, libFuzzer adds the input to the corpus.
> +
> +-shrink=1 : Tries to make elements of the corpus "smaller". Might lead to
> +better coverage performance, depending on the target.
> +
> +Note that libFuzzer's exact behavior will depend on the version of
> +clang and libFuzzer used to build the device fuzzers.
> +
>  == Adding a new fuzzer ==
>  Coverage over virtual devices can be improved by adding additional fuzzers.
>  Fuzzers are kept in tests/qtest/fuzz/ and should be added to
> 


