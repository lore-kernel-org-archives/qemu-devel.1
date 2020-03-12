Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CBDC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3E22067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFdQ01/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3E22067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCUVQ-0006mA-Jt
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 16:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCUUh-0005dA-JM
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 16:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCUUf-0000Id-PU
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 16:31:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21593
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCUUf-0000Ho-Lp
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 16:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584045108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8msJzzfUVkGEWWvppJCKIUTCaamh8XEzorFJLbMUlw=;
 b=RFdQ01/py98f0efLX0SA9mYe2ReNhDpCJxQFSHfSWkd8wxlI1TiUvqveMLuwAGHTNeR28/
 4dI1HFUcsetm6qHvFbFQJXZdkzdAJJopkRSDyNZbw9SUJc7gdqnJywy9N6q7inPKO+Sxb1
 CGvrJ1Ynq7wGkQIpQ4AiyfafliH6sa4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-72G8PlpVNQ-cQolhtZDu4Q-1; Thu, 12 Mar 2020 16:31:45 -0400
X-MC-Unique: 72G8PlpVNQ-cQolhtZDu4Q-1
Received: by mail-ed1-f71.google.com with SMTP id p17so6004206edt.20
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 13:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N2Wm2nvXguR8tKjYXQcfC7omrHC6KB9F8VxSTzJ/zIM=;
 b=S5ysbC3ZXr7Xm0jU8YRlGnc3vkoiWir6IR9ZHcaAkfEeZUzVZ1Y2yNcvecPM2jrF1k
 BI5G+eEu1X8MTwPiiLgpMMahGk7dapNgzDvknKUI5jMmkj2UMIMSTfugxUxabyFHtu2r
 Jt3uvLvFK6QOC7RNHh3e1mFt8rTyQwi/9zl8hdKegCEbemt9ztOmaxBgoocWfgvdZO9y
 akIpxx3XJYs0tW6CpJQukwAjBrayMk385BC6k/OinWWPIdFiPt+GrJwPoQNTytwGGapz
 gym5L70MvxYiBgi6lEcR1YLZLE3fOyhgjqNmMn/RlH+Ly5SC9QH7FYoEAVPSi4Cnu982
 Zuiw==
X-Gm-Message-State: ANhLgQ3PF6TpYK97w3/Pq/02FrJFgWEBtuICDOg9Y/RMfb5G+cgHgDfe
 i3/FF2AWjBhPRcgd2VYBvqWfLOuyUH+oA5dbYo67KKuZqsC3l2Y9f+tyJd5DBd+r67O4If/JJLi
 +DFT6pk0VNQBSU8I=
X-Received: by 2002:a05:6402:3047:: with SMTP id
 bu7mr9660393edb.44.1584045104772; 
 Thu, 12 Mar 2020 13:31:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvBvpQUoa40fWbD87TT9em07eiq5Y2lXeByzDK1ZpgbBQUX8wf3O08KziJykV7rgnA2IGVzpw==
X-Received: by 2002:a05:6402:3047:: with SMTP id
 bu7mr9660374edb.44.1584045104484; 
 Thu, 12 Mar 2020 13:31:44 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id i15sm3442885ejh.56.2020.03.12.13.31.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2020 13:31:43 -0700 (PDT)
Subject: Re: [PATCH v2] linux-user: fix socket() strace
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200312165530.53450-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <198c31d3-7047-6f14-c7c4-b6090c23fb8e@redhat.com>
Date: Thu, 12 Mar 2020 21:31:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312165530.53450-1-laurent@vivier.eu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 5:55 PM, Laurent Vivier wrote:
> print_socket_type() doesn't manage flags and the correct type cannot
> be displayed
>=20
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>=20
> Notes:
>      v2: replace gemu_log() by qemu_log() as it has been removed from qem=
u
>=20
>   linux-user/strace.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 4f7130b2ff63..69232f7e27b8 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -444,7 +444,7 @@ print_socket_domain(int domain)
>   static void
>   print_socket_type(int type)
>   {
> -    switch (type) {
> +    switch (type & TARGET_SOCK_TYPE_MASK) {
>       case TARGET_SOCK_DGRAM:
>           qemu_log("SOCK_DGRAM");
>           break;
> @@ -464,6 +464,12 @@ print_socket_type(int type)
>           qemu_log("SOCK_PACKET");
>           break;
>       }
> +    if (type & TARGET_SOCK_CLOEXEC) {
> +        qemu_log("|SOCK_CLOEXEC");
> +    }
> +    if (type & TARGET_SOCK_NONBLOCK) {
> +        qemu_log("|SOCK_NONBLOCK");
> +    }
>   }
>  =20
>   static void
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


