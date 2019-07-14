Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F9DC73C66
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 16:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1C52063F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 16:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1C52063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmgy6-0005BH-2X
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 12:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43364)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hmgxs-0004mo-FR
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 12:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hmgxr-00055e-AP
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 12:03:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hmgxr-00055K-4C
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 12:03:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so12851976wmj.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 09:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=206ndfHR25+gwYZ9ORbb0lGHvvXKBQ/m5WDMJkasnd8=;
 b=NPhbP8LlWyt5viyEQZuwyUXI+LQgGeqqZwGnog4UmrAzFoXRCF/LSoB2V58TXJBjfr
 2IDlQun2S4aXDJ3Kjj/mGkFL9XmKNz/Za0fLfXxXVc+Kv+jkKBxzLNFVLkLhXv2gLVJo
 RqSI6EKYNf+ngnR45bofpSsKhtf3SkCwDsNBpj6vUIL47BDQVt0dqveULygq89xJJx14
 uP+TIMPAViVulCyjVvIkgCMhatrK2gNAxEB1wlNu1vCoW/uk1cM5RmjIB6/NX6WAuFv0
 f/DveTlK91yWwFdA0F4RgbHGbI0MjHza530E37zaggpROOfYPk7M4kuaw1ZwrQiOLIAi
 +4EA==
X-Gm-Message-State: APjAAAX1zZbcUOhAw8mVRTrrF2AoSLr9qWNCX3mLtpb4bWWqCLQ5qHGN
 0aB3wd4nzG1QkBGHpqAr4SrmhQ==
X-Google-Smtp-Source: APXvYqytVe8S5pkpPyM/g9uEo7aixV5uswJT5kabHb4YN+gbIA0Aky6nTSfsF1tHwimeb8R7n5KwIA==
X-Received: by 2002:a05:600c:214c:: with SMTP id
 v12mr19814575wml.28.1563120181664; 
 Sun, 14 Jul 2019 09:03:01 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id r5sm14757688wmh.35.2019.07.14.09.03.00
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Jul 2019 09:03:01 -0700 (PDT)
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20190714134028.315-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <533d36f2-b5a0-c89e-2a53-6fb8501caec4@redhat.com>
Date: Sun, 14 Jul 2019 18:02:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190714134028.315-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: remove useless variable
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/14/19 3:40 PM, Laurent Vivier wrote:
> filename is only used to open the file if AT_EXECFD is not provided.
> But exec_path already contains the path of the file to open.
> Remove filename as it is only used in main.c whereas exec_path is
> also used in syscall.c.
> 
> Fixes: d088d664f201 ("linux-user: identify running binary in /proc/self/exe")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/main.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index a59ae9439de1..ef8e8cb10eba 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -48,7 +48,6 @@
>  char *exec_path;
>  
>  int singlestep;
> -static const char *filename;
>  static const char *argv0;
>  static int gdbstub_port;
>  static envlist_t *envlist;
> @@ -580,7 +579,6 @@ static int parse_args(int argc, char **argv)
>          exit(EXIT_FAILURE);
>      }
>  
> -    filename = argv[optind];
>      exec_path = argv[optind];
>  
>      return optind;
> @@ -651,9 +649,9 @@ int main(int argc, char **argv, char **envp)
>  
>      execfd = qemu_getauxval(AT_EXECFD);
>      if (execfd == 0) {
> -        execfd = open(filename, O_RDONLY);
> +        execfd = open(exec_path, O_RDONLY);
>          if (execfd < 0) {
> -            printf("Error while loading %s: %s\n", filename, strerror(errno));
> +            printf("Error while loading %s: %s\n", exec_path, strerror(errno));
>              _exit(EXIT_FAILURE);
>          }
>      }
> @@ -778,10 +776,10 @@ int main(int argc, char **argv, char **envp)
>      cpu->opaque = ts;
>      task_settid(ts);
>  
> -    ret = loader_exec(execfd, filename, target_argv, target_environ, regs,
> +    ret = loader_exec(execfd, exec_path, target_argv, target_environ, regs,
>          info, &bprm);
>      if (ret != 0) {
> -        printf("Error while loading %s: %s\n", filename, strerror(-ret));
> +        printf("Error while loading %s: %s\n", exec_path, strerror(-ret));
>          _exit(EXIT_FAILURE);
>      }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

