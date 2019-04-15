Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B899C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 12:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D615206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 12:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D615206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49291 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG0M7-0005St-Ke
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 08:04:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hG0Kl-0004fb-Vf
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hG0Kj-0003in-Q5
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:03:35 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:57782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hG0Kh-0003gs-SK
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:03:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by hera.aquilenet.fr (Postfix) with ESMTP id F1BC0BD0F;
	Mon, 15 Apr 2019 14:03:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
	by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pDq0MFKD6h1e; Mon, 15 Apr 2019 14:03:29 +0200 (CEST)
Received: from function (dhcp-13-159.lip.ens-lyon.fr [140.77.13.159])
	by hera.aquilenet.fr (Postfix) with ESMTPSA id 0EDA7BD15;
	Mon, 15 Apr 2019 14:03:29 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hG0Ke-0000jT-IG; Mon, 15 Apr 2019 14:03:28 +0200
Date: Mon, 15 Apr 2019 14:03:28 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Message-ID: <20190415120328.bcuxvj6nrjh7b4ol@function>
References: <20190415120205.2221-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190415120205.2221-1-dgilbert@redhat.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.233.100.1
Subject: Re: [Qemu-devel] [PATCH v2] slirp: Gcc 9 -O3 fix
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
Cc: jan.kiszka@siemens.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415120328.NC_weTdM8AwJnw4kfh3Uejd44CaNUq4I2ysjuvIFpeM@z>

Dr. David Alan Gilbert (git), le lun. 15 avril 2019 13:02:05 +0100, a ecrit:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Gcc 9 needs some convincing that sopreprbuf really is going to fill
> in iov in the call from soreadbuf, even though the failure case
> shouldn't happen.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  slirp/src/socket.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/slirp/src/socket.c b/slirp/src/socket.c
> index 4a3c935e25..beb8517f1c 100644
> --- a/slirp/src/socket.c
> +++ b/slirp/src/socket.c
> @@ -181,7 +181,7 @@ soread(struct socket *so)
>  	 * No need to check if there's enough room to read.
>  	 * soread wouldn't have been called if there weren't
>  	 */
> -	sopreprbuf(so, iov, &n);
> +	assert(sopreprbuf(so, iov, &n) != 0);

Please make this through a variable, otherwise anybody building with
-DNDEBUG will get sopreprbuf not being called.

>  	nn = recv(so->s, iov[0].iov_base, iov[0].iov_len,0);
>  	if (nn <= 0) {
> @@ -257,6 +257,7 @@ int soreadbuf(struct socket *so, const char *buf, int size)
>  	 * No need to check if there's enough room to read.
>  	 * soread wouldn't have been called if there weren't
>  	 */
> +	assert(size > 0);
>  	if (sopreprbuf(so, iov, &n) < size)
>          goto err;
>  
> -- 
> 2.21.0
> 

