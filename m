Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634A9C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3688E20818
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3688E20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44387 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRYFp-0001X2-ES
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:30:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hRYEx-0001Bo-AL
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hRYEw-0006m4-E8
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:29:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>)
	id 1hRYEw-0006hi-7x; Fri, 17 May 2019 04:29:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BE7785546;
	Fri, 17 May 2019 08:29:10 +0000 (UTC)
Received: from [10.72.12.168] (ovpn-12-168.pek2.redhat.com [10.72.12.168])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5A74E5D9DC;
	Fri, 17 May 2019 08:28:59 +0000 (UTC)
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20190515090805.44785-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8ff8f283-fa8f-acc1-9f31-414339a54d4d@redhat.com>
Date: Fri, 17 May 2019 16:28:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515090805.44785-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Fri, 17 May 2019 08:29:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] net/slirp: fix the IPv6 prefix length
 error message
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
Cc: qemu-trivial@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>,
	Markus Armbruster <armbru@redhat.com>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/5/15 =E4=B8=8B=E5=8D=885:08, Stefano Garzarella wrote:
> Reword and add a missing parentheses at the end of the
> error message.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
> v2:
>    - Reworded the error message (Markus)
>    - Added Marc-Andr=C3=A9's R-b
>      I made a little change to the error message, let me now
>      if I should remove yuor R-b.
> ---
>   net/slirp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/slirp.c b/net/slirp.c
> index 95934fb36d..b34cb29276 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -498,7 +498,8 @@ static int net_slirp_init(NetClientState *peer, con=
st char *model,
>       }
>       if (vprefix6_len < 0 || vprefix6_len > 126) {
>           error_setg(errp,
> -                   "Invalid prefix provided (prefix len must be in ran=
ge 0-126");
> +                   "Invalid IPv6 prefix provided "
> +                   "(IPv6 prefix length must be between 0 and 126)");
>           return -1;
>       }
>  =20


Applied.

Thanks



