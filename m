Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72639C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FF420878
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FF420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39075 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJEzo-0000SH-VB
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 06:19:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJEwp-00073a-9V
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJEwo-0004JO-7D
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:16:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJEwn-0004HG-W1
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:16:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so3845018wmj.3
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 03:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=tJLOgWc8QKvYvirBddXuT74ANygnrVpJfNs9Q1ooarA=;
	b=GmaEnYTn1EFDc7Ys2cwpR1Z5XfGVYYhZ8cYGMXgMDBQxHxzdiHneygupW9P6q27kzP
	SOBXb4/KTqNFP3BLZKen6zP1xeVlHijenEf3Mfdoi6o0ULIcsKH0BA53cznUwEvn3YPB
	KFtWB3tAkzND0YlB5iQK4I3oXRtBadWwcH2uqtNUASeBRcNMlF1IWYLLY7SEn4gW5Tyu
	HIRzsP8c0Q0NbloeR3zsxsYo1VnNArDH1v0v8/bxjwuhNzUxGPBAfAPolIXwpYKYWWf0
	OBEcJw6VUPI/MMT6/6qx33NyXbpgifKEtJyU2bwt0kGxKG/7Ug+GErZxBZ84U+GUe+ki
	LkvQ==
X-Gm-Message-State: APjAAAUpAIMCt10nxg2Xl7zNmPoQiwXc+Dm6+iS5hFIRiBdunjcVoQE6
	omQ6EfLg21U7tw7mY767stPBwQ==
X-Google-Smtp-Source: APXvYqz06KJwG+FLPIX2dswTT0CdjKQLiEW464MEIeBoR1QHnKQHb/uXI++6xc2TMISyhLQj0dvZeQ==
X-Received: by 2002:a1c:730c:: with SMTP id d12mr6057686wmb.10.1556100972737; 
	Wed, 24 Apr 2019 03:16:12 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	c11sm10423515wrs.86.2019.04.24.03.16.11
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 03:16:11 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
	Stefan Berger <stefanb@linux.ibm.com>
References: <20190424094557.28404-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <042ac170-3fe9-61d5-6fdb-0a43e58b9b4c@redhat.com>
Date: Wed, 24 Apr 2019 12:16:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424094557.28404-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] tests/tpm-tests: Use g_test_skip() to mark
 skipped tests
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424101611.fb65WUAyoZhKsLGW680NnejoDINpjdXBUQ9xNqf5Mv4@z>

On 4/24/19 11:45 AM, Thomas Huth wrote:
> Since we do not use gtester anymore (which had a bug here),
> we can now use g_test_skip() to mark skipped tests.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/tpm-tests.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tpm-tests.c b/tests/tpm-tests.c
> index 582ec0cfd4..e640777aa9 100644
> --- a/tests/tpm-tests.c
> +++ b/tests/tpm-tests.c
> @@ -22,7 +22,7 @@ static bool
>  tpm_test_swtpm_skip(void)
>  {
>      if (!tpm_util_swtpm_has_tpm2()) {
> -        g_test_message("swtpm not in PATH or missing --tpm2 support");
> +        g_test_skip("swtpm not in PATH or missing --tpm2 support");
>          return true;
>      }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

