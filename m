Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF77C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7EAC20728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9iFbvCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EAC20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRiVY-00060U-Vr
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiUV-0005Lc-8T
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiUU-0001h7-GD
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:30:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48715
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRiUU-0001gm-2O
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587673833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v43s6SVfjmdAwXa7zDB02ENhKXx6Km964SLvYKlJPEY=;
 b=g9iFbvCJ50KNwFcGlu+yYUJXWagjJ+kgnoeGkNZ0tqFyXXQQAjRp29CMAMOQwYi6is5erj
 6czRO8cgduW5WdN0Bl6xVPLvDGelH3RLnv7k3D7a4ctxB0blaka4Q8Btson6XujIu+9bLV
 7d/YM+pKyTa0ZrfSZvB8CNu7tIYP1hQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-1EBLzvWlOeGZdfleDF5Hug-1; Thu, 23 Apr 2020 16:30:31 -0400
X-MC-Unique: 1EBLzvWlOeGZdfleDF5Hug-1
Received: by mail-wr1-f72.google.com with SMTP id o8so2955800wrm.11
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0oep5T6chixsIs+XJQp+Cn4NjLgmPdY0pFdULK4DLiY=;
 b=OWt8wBK+5LU9Am1EpI64bbCjXoLKmoz8DA9TMrg0Cdf6gL7BDlUQlx1+s/w43J5DIW
 nJAZ9m8lioasNKSpVBraO1Lg8JV0cgUUXzX9kiqwHyOCbqPsOg7ohvIay+EYcLYk1sVu
 tVFMIoYp6A+mmcM0BltbAqB/nbPugTd7op1jESstXJTZ3feGzuk7+g9Ligs4uYTmypzM
 2wytxgoJPQZJ3ZgCtTytEn+8T5NIhayrpkihmremnO/9vrOFmBrPHxIQqS4TX4r8hvuv
 LetXh9egO9yl/3CdchbyhHlTRgOS7Nb+CjWCWnyT5qT1H0XN6LleHYcfQRipchOiMJsa
 Shbg==
X-Gm-Message-State: AGi0PubFzrgH0rqRK4cA5mLiUDDDJCX6iL/UptO5zNOLHW7EMXpGCtwa
 KeQXlUJYbfORcGNM4SNOY2jjJ4mClY4WpIP1dWEs79CNZtVNOhDVH+RZ/eH12zpfWev6PxuU3On
 ZShljLwXe9ZK64ms=
X-Received: by 2002:a5d:6107:: with SMTP id v7mr6571378wrt.270.1587673829863; 
 Thu, 23 Apr 2020 13:30:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypINiAKl2k7dloxpvgJc2g9cF26wGKq9mp5Ht1FRKMvoKwbLi37NF09k5+Xeip2JCN1sDwE/Gg==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr6571343wrt.270.1587673829414; 
 Thu, 23 Apr 2020 13:30:29 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm5453977wmc.30.2020.04.23.13.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 13:30:28 -0700 (PDT)
Subject: Re: [PATCH v1 09/14] gdbstub: eliminate gdbserver_fd global
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200423170557.31106-1-alex.bennee@linaro.org>
 <20200423170557.31106-10-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fccbc7d7-f370-5aed-0258-3507184ccff4@redhat.com>
Date: Thu, 23 Apr 2020 22:30:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200423170557.31106-10-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 7:05 PM, Alex Benn=C3=A9e wrote:
> We don't really need to track this fd beyond the initial creation of
> the socket. We already know if the system has been initialised by
> virtue of the gdbserver_state so lets remove it. This makes the later
> re-factoring easier.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   gdbstub.c | 23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index 171e150950..8c53cc0e1c 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -398,8 +398,6 @@ static void reset_gdbserver_state(void)
>   bool gdb_has_xml;
>  =20
>   #ifdef CONFIG_USER_ONLY
> -/* XXX: This is not thread safe.  Do we care?  */
> -static int gdbserver_fd =3D -1;
>  =20
>   static int get_char(void)
>   {
> @@ -2964,7 +2962,7 @@ void gdb_exit(CPUArchState *env, int code)
>         return;
>     }
>   #ifdef CONFIG_USER_ONLY
> -  if (gdbserver_fd < 0 || gdbserver_state.fd < 0) {
> +  if (gdbserver_state.fd < 0) {
>         return;
>     }
>   #endif
> @@ -3011,7 +3009,7 @@ gdb_handlesig(CPUState *cpu, int sig)
>       char buf[256];
>       int n;
>  =20
> -    if (gdbserver_fd < 0 || gdbserver_state.fd < 0) {
> +    if (!gdbserver_state.init || gdbserver_state.fd < 0) {
>           return sig;
>       }
>  =20
> @@ -3060,7 +3058,7 @@ void gdb_signalled(CPUArchState *env, int sig)
>   {
>       char buf[4];
>  =20
> -    if (gdbserver_fd < 0 || gdbserver_state.fd < 0) {
> +    if (!gdbserver_state.init || gdbserver_state.fd < 0) {
>           return;
>       }
>  =20
> @@ -3068,7 +3066,7 @@ void gdb_signalled(CPUArchState *env, int sig)
>       put_packet(buf);
>   }
>  =20
> -static bool gdb_accept(void)
> +static bool gdb_accept(int gdb_fd)
>   {
>       struct sockaddr_in sockaddr;
>       socklen_t len;
> @@ -3076,7 +3074,7 @@ static bool gdb_accept(void)
>  =20
>       for(;;) {
>           len =3D sizeof(sockaddr);
> -        fd =3D accept(gdbserver_fd, (struct sockaddr *)&sockaddr, &len);
> +        fd =3D accept(gdb_fd, (struct sockaddr *)&sockaddr, &len);
>           if (fd < 0 && errno !=3D EINTR) {
>               perror("accept");
>               return false;
> @@ -3137,13 +3135,12 @@ static int gdbserver_open(int port)
>  =20
>   int gdbserver_start(int port)
>   {
> -    gdbserver_fd =3D gdbserver_open(port);
> -    if (gdbserver_fd < 0)
> +    int gdb_fd =3D gdbserver_open(port);
> +    if (gdb_fd < 0)
>           return -1;
>       /* accept connections */
> -    if (!gdb_accept()) {
> -        close(gdbserver_fd);
> -        gdbserver_fd =3D -1;
> +    if (!gdb_accept(gdb_fd)) {
> +        close(gdb_fd);
>           return -1;
>       }
>       return 0;
> @@ -3152,7 +3149,7 @@ int gdbserver_start(int port)
>   /* Disable gdb stub for child processes.  */
>   void gdbserver_fork(CPUState *cpu)
>   {
> -    if (gdbserver_fd < 0 || gdbserver_state.fd < 0) {
> +    if (!gdbserver_state.init || gdbserver_state.fd < 0) {
>           return;
>       }
>       close(gdbserver_state.fd);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


