Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728CEC4740A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2A0206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2A0206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bXt-0000y5-BP
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7bWq-0000QP-4b
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7bWp-0007wq-1l
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:29:36 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:60199)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7bWo-0007vw-Pb
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:29:35 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N3bjH-1iFgDK0bcR-010btG; Tue, 10 Sep 2019 10:29:29 +0200
To: qemu-devel@nongnu.org
References: <20190908104816.20713-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <428dadfa-9cf3-6a5f-0a4b-bc1beedcd324@vivier.eu>
Date: Tue, 10 Sep 2019 10:29:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190908104816.20713-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Sk2bzkR7R/qIU28+H68T/D7wl/Fc5RY0HtXixdjPhVTPgPRN0/t
 ACD2+TwdA+uYSHgN6FUohCm7wsHZpL2Ik4ZGzXoEmq7WKTXitAvRZdLq5/QP/LCJZwfeob7
 mXReJH11Fj2ehqKJ3IKSJw31FtKvjtu5YIwmvYFTJWp/pqI+j7YHUc11uivjjccCCzEimxs
 mo8ojxKBOWZTNZZCGGF5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fPaP2HcUlJQ=:3N61doNwViFGECRky45Td3
 S//tNB5FSic7tP04ItIIafeklIBjq75mk4uSdoHs9cU2OSBqbkxZG4ja59N8mjxsxqwSRnXOf
 ujYcdaiNyeqPEW20RC+jUal7/5YDt+KI7e6c/NHe9ceej3ptRuCQ5z7DuuqnZNYXyu4aGIQHs
 nNE6K4SMGvrbPtsgVCXhYZgkVIupxLbT2y308sDj4m+rvrXdi0T1HPOyShauP5mZZ7oiadps7
 0L6LWAQCKRvRHBBNkdXTzpFecvwK2WQjOrDy3SbwkigFwmmrk00UHM6CfGEvQrFkmGYb5Xoc2
 cO462BssuFMcw3qEU05nE9gh+eEJpvcwpUddH1KQvtBWZtqAKuU6B3+lwMrj5aAQK+C2eT287
 seVPqlY/tjBsscykcklxg9JbwCamWxOTJFYxTItt5fEpAh0Ce/Im6XCnOLmQxwOf7l8xTD+kO
 40rpJ+p72SNydv9VDqQ8mcQ9EAqaAG/uJXF6KLtmqzUfWBJ/cOBSEgJTbyG+SJVapll6W/tQr
 9v6SADY9cCZ6135HneZ9j5nfBShiCs9VYSO94TZ5BC8TG+i7tnOgo5l1P9j7yUtMUtaezjIcC
 aX3Po8fZGjjCF+numswwXE6w69f9a1+t6kQkS7bLiqoxa6MJ+fA/6FO7OV84Z1ikPGK1y2XPh
 vzsxFu9V85u6aTXrp9dOZ/UXn9yMYTaSJ/vVzPUoXAUfw0/cdspkw3eYl6rky3/XqoSNtHKYn
 HYfqjQxZLJuVK12WKyHOQMJQOMcRa50SBD3mDfUHB/6wfTjKNMWb92dKbXRS5ToC+Kg0xh/MQ
 wufBj2hVIqGxkCe8Z69eZGutL+TGajYo8Y/0YzfmwHifLt7xGA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [PATCH v2 1/2] linux-user: remove useless variable
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

Le 08/09/2019 à 12:48, Laurent Vivier a écrit :
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
> index 47917bbb20fc..28f0065b6ddf 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -49,7 +49,6 @@
>  char *exec_path;
>  
>  int singlestep;
> -static const char *filename;
>  static const char *argv0;
>  static int gdbstub_port;
>  static envlist_t *envlist;
> @@ -586,7 +585,6 @@ static int parse_args(int argc, char **argv)
>          exit(EXIT_FAILURE);
>      }
>  
> -    filename = argv[optind];
>      exec_path = argv[optind];
>  
>      return optind;
> @@ -657,9 +655,9 @@ int main(int argc, char **argv, char **envp)
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
> @@ -784,10 +782,10 @@ int main(int argc, char **argv, char **envp)
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

Applied to my linux-user branch.

Thanks,
Laurent

