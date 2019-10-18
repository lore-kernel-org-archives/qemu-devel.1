Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3AECA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347092089C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347092089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLMfV-0000fP-EV
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 03:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iLMeg-0008M4-Mz
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iLMef-0000Ko-9K
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:26:34 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:46603)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iLMef-0000JN-0S
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:26:33 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MmlfS-1hf7wN04VK-00jnpd; Fri, 18 Oct 2019 09:26:25 +0200
Subject: Re: [PATCH] Fix unsigned integer underflow in fd-trans.c
To: Shu-Chun Weng <scw@google.com>
References: <20191018001920.178283-1-scw@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4b34aa24-8669-7713-84f3-07e9e8400734@vivier.eu>
Date: Fri, 18 Oct 2019 09:26:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191018001920.178283-1-scw@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2Z0wHpiAFKasiu6eV0dx4EfjWNZOgruIkIQ39sng2OCbj1cLXmI
 8Z/XS9Wuy76+nmSLJpdK8AKt5p071hwrlY6fqdcqL8tuL7DEWodkaRdpK0Qj4U6fPMRYW8/
 LKOqsZpi9CVhrl0wulPGZCyE7FbfmjtuWI7FCEuqebEoteP2U+9kTyX80BBYxQ7dgUdbHQW
 6JlM6/22oJFszU0dyKZyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wBLsrMYoUxc=:cA//M5ufNAlqDDqEJ9prPL
 VBtB3aKbiWxPZdGxmHp2EAlCs80SQiHdpBUXfjWWMgDQdUbTgrKIvTSuIbbhRwmD1pujX+rHY
 B15OmN1QesvxdTgKHOCo93zrVSE0qszBVSd7bOmzdNmoX1CifqAu1HshsxODYeUDhJTLRRFf9
 b8v+kIcE9nSe5iaz354Azzd2wQlsqkbcUdtOO5Hhy8LhvjjfRuvCEz2uaDpptGhc0xw7y7ALz
 qg2WRg9M1HrfZj7qL4R2sEguWrY4WExP2qjK8DM8aBAtY7JQKDKODbllaneshCCc0fc0ENLGi
 jDEpw0hpyMtrmfVY+WkGRJoW7nisVkhNuQVw1x4Rr8ToyQzgjtKEPrpWqkcXx9J9PdF9D1bH4
 7xjryf/BTFUJiRHdwSYP6Qix38RwN4uARd0qlI7pj1w+NVdqxgkOLIEVct65lGqBkrNJWMcig
 hTNubjdHSxBqfCYsYE2M3Kp+J8y5VNGQGjLTmPJBt+ifqnLZYMZuz91G1v3ScNWSx9XBfl9PF
 ifWP2p6LpX4V93lZpA4adZq01WsSkeCzayYs2hdInWhpbujkJpp5d4Ri+sIzRytFlJ/wAONOb
 EWpiQ6se/qIIe9R0VNePAUdZroMxL4DGW5D4l9Is0h5FUlfURqpZ4JqlRkS4fTbCSrCVMGvBt
 kzSgStDQG3KuXkvvp8YkbBZLf8FJP0Y7bY6kMrbQcf1hWwSqYS91/fxNTN/eHJs/7rj09EixJ
 EmUvDaKXk6BFPj9+2mdh/CVQfSjeAjVRyqGYOzxxOTQFgHQ8feaPM9vLIKyyUXUX8U5YHtLF/
 QYNPbOK4hfpdl/YDA+/30afXt54pQbFj9cUPrMNCp1OxH9hbAGv9u7ATm9/IyvAgnMEDyDFso
 JeNtWL+cwBcwzOjirJ8Fr+714u8d3ZEFPI6F7PUQo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 18/10/2019 à 02:19, Shu-Chun Weng a écrit :
> In any of these `*_for_each_*` functions, the last entry in the buffer (so the
> "remaining length in the buffer" `len` is equal to the length of the
> entry `nlmsg_len`/`nla_len`/etc) has size that is not a multiple of the
> alignment, the aligned lengths `*_ALIGN(*_len)` will be greater than `len`.
> Since `len` is unsigned (`size_t`), it underflows and the loop will read
> pass the buffer.
> 
> This may manifest as random EINVAL or EOPNOTSUPP error on IO or network
> system calls.
> 
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>  linux-user/fd-trans.c | 51 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
> index 60077ce531..9b92386abf 100644
> --- a/linux-user/fd-trans.c
> +++ b/linux-user/fd-trans.c
> @@ -279,6 +279,7 @@ static abi_long host_to_target_for_each_nlmsg(struct nlmsghdr *nlh,
>                                                         (struct nlmsghdr *))
>  {
>      uint32_t nlmsg_len;
> +    uint32_t aligned_nlmsg_len;
>      abi_long ret;
>  
>      while (len > sizeof(struct nlmsghdr)) {
> @@ -312,8 +313,13 @@ static abi_long host_to_target_for_each_nlmsg(struct nlmsghdr *nlh,
>              break;
>          }
>          tswap_nlmsghdr(nlh);
> -        len -= NLMSG_ALIGN(nlmsg_len);
> -        nlh = (struct nlmsghdr *)(((char*)nlh) + NLMSG_ALIGN(nlmsg_len));
> +
> +        aligned_nlmsg_len = NLMSG_ALIGN(nlmsg_len);
> +        if (aligned_nlmsg_len >= len) {
> +            break;
> +        }
> +        len -= aligned_nlmsg_len;
> +        nlh = (struct nlmsghdr *)(((char*)nlh) + aligned_nlmsg_len);
>      }
>      return 0;
>  }

Nice catch.

But the first "if" in the loop is already here for that, we only need to
fix it with something like that in all the for_each functions:

@@ -285,7 +285,7 @@ static abi_long host_to_target_for_each_nlmsg(struct
nlmsghdr *nlh,

         nlmsg_len = nlh->nlmsg_len;
         if (nlmsg_len < sizeof(struct nlmsghdr) ||
-            nlmsg_len > len) {
+            NLMSG_ALIGN(nlmsg_len) > len) {
             break;
         }

Thanks,
Laurent


