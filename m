Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3301EC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 09:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 005D121743
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 09:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005D121743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnJcZ-0006IB-6H
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 05:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53886)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnJcO-0005oc-1a
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnJcM-0000Js-G9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:19:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnJcM-0000IU-9Y
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:19:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so20150851wru.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 02:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6E9YK+rHyPPAtcHMbb0mtBA+te6/8aI6Cfpn3vJEJwk=;
 b=MBqmsKSG+35rN+2NmrQtV+DIrg3JV1wXUw0QcWImyVgphPWvdgirZ5uQkxfM0U60Rt
 f7kug5CHPbDAVWVmXeXpv/A1MYSRlCvlfktOo+1wp7IQ/FR53IoQcgNOfOYkbyENYTJT
 DTLKKpC7ekhl0If7sEImxaDdeArJVSEYCm8PZImb9lncEI0EdJ5ceVClsO/ABmy1Qbak
 JfS2cp2m9fcI/udVhXsTF8UlQHZE/MxekOENPHSg1GkrMfIE5uXEbeze0F8Y1XileaZJ
 mUJlSSjG1yplYWGibJ1TOwPiZg7vwWOSZaXepjPyWqNdFUskUWUEFPNOdVIOgtb5N7nV
 K9NA==
X-Gm-Message-State: APjAAAVb5m1vXi+q52H4od1py0mDNJkLWzbxzDjPz6wR/48M6jcfMIam
 MaSy1hbFdC18grlSVY7ivN8oMA==
X-Google-Smtp-Source: APXvYqxVpbXbfUp2VRHIWlAJziRCPr0SrrbUdVQv2LcYdFWJoItyi6Wp3dnaD7Ta9/Drz9GuQy7FlA==
X-Received: by 2002:a5d:53c2:: with SMTP id a2mr35814127wrw.8.1563268764157;
 Tue, 16 Jul 2019 02:19:24 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id x16sm15299082wmj.4.2019.07.16.02.19.23
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 02:19:23 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190716084240.17594-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fe523ffd-43fb-3b9d-b4e1-ea11d1c63de7@redhat.com>
Date: Tue, 16 Jul 2019 11:19:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190716084240.17594-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] nbd: fix uninitialized variable warning
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Marc-André,

On 7/16/19 10:42 AM, Marc-André Lureau wrote:
> ../block/nbd.c: In function 'nbd_co_request':
> ../block/nbd.c:745:8: error: 'local_reply.type' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>      if (chunk->type == NBD_REPLY_TYPE_NONE) {
>         ^
> ../block/nbd.c:710:14: note: 'local_reply.type' was declared here
>      NBDReply local_reply;
>               ^~~~~~~~~~~
> ../block/nbd.c:710:14: error: 'local_reply.flags' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> ../block/nbd.c:738:8: error: 'local_reply.<U4be0>.magic' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>      if (nbd_reply_is_simple(reply) || s->quit) {
>         ^
> ../block/nbd.c:710:14: note: 'local_reply.<U4be0>.magic' was declared here
>      NBDReply local_reply;
>               ^~~~~~~~~~~
> cc1: all warnings being treated as errors

Thomas reported this error when compiling with -O3 few months ago [1].
Are you using that, or the latest GCC emit a warning even with no -O3?

Personally I'd add:

Fixes: 86f8cdf3db8
Reported-by: Thomas Huth <thuth@redhat.com>

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  block/nbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 81edabbf35..02eef09728 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -707,7 +707,7 @@ static bool nbd_reply_chunk_iter_receive(BDRVNBDState *s,
>                                           void **payload)
>  {
>      int ret, request_ret;
> -    NBDReply local_reply;
> +    NBDReply local_reply = { 0, };

Yesterday [2] Peter said: "= {}" is our standard struct-zero-initializer
so we should prefer that.

With {}:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>      NBDStructuredReplyChunk *chunk;
>      Error *local_err = NULL;
>      if (s->quit) {
> 

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07007.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03431.html

