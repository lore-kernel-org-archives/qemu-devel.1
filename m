Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36617C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0DF206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0DF206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnHsG-0008Df-3c
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 03:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45872)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hnHs5-0007pP-3M
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hnHs4-0002Oq-21
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:27:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40816)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hnHs3-0002Nl-RF
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:27:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so19679468wrl.7
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 00:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zdZuA734CWiIh2pm5IsgJa21qyg/gIdm0iv06XhXuEg=;
 b=IyvUZnk2L0+ZYQy5VPKKPCxkY6R6gRVHbsu2mq7dpa8kvUFMdrfIEJ+dBUdIvGZ1iS
 +qTTGtt3Tnc15Z4lBZLwUjfPuy4G+nIOLrSOeTt/07EfE9B3VzfbJ7d5I+N10HYlK04U
 LuQCAA3BQqc5Iv+ltl9+YnHP8xiC/IZi/WRZMIvSQwyCSowC7nhAzQ0F6zrPv7TXn23X
 C9gRRxjwujOfU2bT575e9hWuZKD0deyBDzJ2CPNOLoAYsV4Uu4FvuBuj3VhT0aApPaxf
 LGrPAd31Bgrpc/8SMN1EDG9uJrnqiAAL3aLE3iZF8W2aVGSn7Ab96wOir4j87Gq1whXS
 pXYw==
X-Gm-Message-State: APjAAAW0pSbMAYU+gq+OA17OjBYGEzdM3T7GbfFjuKlteM/zHNJos+yF
 xZE4MigKtQAZQwLZUR3sncaykw==
X-Google-Smtp-Source: APXvYqziy/ysknyic+EzPoLgbzJznNnAx0t+f6xCAOHDLjtFTlCFY8De5sdH6MxB5KETWRc87kSi6g==
X-Received: by 2002:a5d:494d:: with SMTP id r13mr35267221wrs.152.1563262050748; 
 Tue, 16 Jul 2019 00:27:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b159:8d52:3041:ae0d?
 ([2001:b07:6468:f312:b159:8d52:3041:ae0d])
 by smtp.gmail.com with ESMTPSA id f3sm4544968wrt.56.2019.07.16.00.27.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 00:27:30 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
References: <20190716072127.2000-1-richardw.yang@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e5169a0a-327a-df29-9a07-0055cd0a73f3@redhat.com>
Date: Tue, 16 Jul 2019 09:27:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716072127.2000-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] vl: make sure char-pty message displayed
 by moving setbuf to the beginning
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/07/19 09:21, Wei Yang wrote:
> Recently we found a behavior change after commit 6ade45f2ac93611
> ('char-pty: Print "char device redirected" message to stdout').
> 
> When we redirect output to a file, the message "char device redirected
> to PTY_NAME (label LABEL)" would not be seen at the beginning of the
> file. Instead, the message is displayed after QEMU quit. This will block
> test automation.
> 
> The reason is this message is printed after we set line buffer mode. So
> move this to the beginning.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  vl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 5089fce6c5..a5808f9a02 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2890,6 +2890,8 @@ int main(int argc, char **argv, char **envp)
>      char *dir, **dirs;
>      BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
>  
> +    os_set_line_buffering();
> +
>      error_init(argv[0]);
>      module_call_init(MODULE_INIT_TRACE);
>  
> @@ -4246,8 +4248,6 @@ int main(int argc, char **argv, char **envp)
>          semihosting_arg_fallback(kernel_filename, kernel_cmdline);
>      }
>  
> -    os_set_line_buffering();
> -
>      /* spice needs the timers to be initialized by this point */
>      qemu_spice_init();
>  
> 

Queued, thanks.

Paolo

