Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00861C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF10C208D6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Culj4a/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF10C208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUUoX-00035R-R8
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 08:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jUUn9-0001UZ-3V
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jUUmD-0007Xz-TG
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:29:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42453
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jUUmD-0007Xk-G1
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588336100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1RtTyH42nMpz0CP6bXrzeOk3oZhswhv6FG6nq98ZIgE=;
 b=Culj4a/Rp+HcubSTNXtabXDZTozSyatg7rnUA0NBSb9uXo5FpbzoG+cqpJk1vfRE9QYl3Q
 YgC1/8pWXM8EeKfDscacinzZzFwKDnkaXisP2hstk8rMyfkGZpqwQxFH5KHySgJdCnktk0
 mU6FFQC4QSk7pzPlugNeA7LPXNWyRGs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-V17HJijgPJCY6GYVsy8yRg-1; Fri, 01 May 2020 08:28:17 -0400
X-MC-Unique: V17HJijgPJCY6GYVsy8yRg-1
Received: by mail-ed1-f70.google.com with SMTP id v21so3200098edq.14
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 05:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p+MmAZhhsZIi96xUKG4PqX0MYV8sNpwg4MkmC2Hq8xw=;
 b=H2BiPFGQCwkHhpXQNsAjwkp0biEBTGReiNEw0O26YT99R6WAdDvD/FZtqPpkxXkkXW
 iVIm87dJacS54xCT7jnKzhclR8fkuv77W5ULLrtlWADZwrlzIWv/jIxLuSVoWhqL72+/
 86uMZ3XpWjH7Rv16AxJUeKqw9q4IJKPQ+eTCUatfhcBQFXc/M+amBDLfrb2BiF2/18OB
 b2uWHnlHY+TDU+WxV3W3qDA719B0B/N6QgRRadsQMAe9BZMPryidBBQxAhcjaPrsg8DD
 wJcrCoCBj/VnADPrPpw8E0gnI8TUiWzVoiSM/P4Gb9hQwsRYqqBj3UwJHQ6Q6buBZk3D
 Yv+A==
X-Gm-Message-State: AGi0Pua74HiQlaEuraebWocuUHfAfjPuqc8l//FbYM/7azqnjW7HSFHs
 XoQmIT6GdmzWVy1CpUj7C3y/iFqUkADbebd7Mgjm1hS54IiLt5/20hGuwexgep87YaKTP8a916J
 PsoeOoUZj9gUlK9k=
X-Received: by 2002:a17:906:4317:: with SMTP id
 j23mr2801658ejm.377.1588336096191; 
 Fri, 01 May 2020 05:28:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypLw/OADsWzz5LJNzO7cPyVstRdU8k+eIlxtVAl8Ues3BfJRy+EjPBYi6g/8CsbjGmaK6RS2hw==
X-Received: by 2002:a17:906:4317:: with SMTP id
 j23mr2801639ejm.377.1588336095891; 
 Fri, 01 May 2020 05:28:15 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id w4sm294811eds.92.2020.05.01.05.28.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 05:28:15 -0700 (PDT)
Subject: Re: [PATCH v1 5/9] gdbstub: eliminate gdbserver_fd global
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200430190122.4592-1-alex.bennee@linaro.org>
 <20200430190122.4592-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <41826363-0a81-f33e-7f57-079e09071f07@redhat.com>
Date: Fri, 1 May 2020 14:28:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200430190122.4592-6-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 03:09:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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

On 4/30/20 9:01 PM, Alex Benn=C3=A9e wrote:
> We don't really need to track this fd beyond the initial creation of
> the socket. We already know if the system has been initialised by
> virtue of the gdbserver_state so lets remove it. This makes the later
> re-factoring easier.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> ---
> v1
>    - fix coding style issue
> ---
>   gdbstub.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index 171e150950..b5381aa520 100644
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
> @@ -3137,13 +3135,13 @@ static int gdbserver_open(int port)
>  =20
>   int gdbserver_start(int port)
>   {
> -    gdbserver_fd =3D gdbserver_open(port);
> -    if (gdbserver_fd < 0)
> +    int gdb_fd =3D gdbserver_open(port);
> +    if (gdb_fd < 0) {
>           return -1;
> +    }
>       /* accept connections */
> -    if (!gdb_accept()) {
> -        close(gdbserver_fd);
> -        gdbserver_fd =3D -1;
> +    if (!gdb_accept(gdb_fd)) {
> +        close(gdb_fd);
>           return -1;
>       }
>       return 0;
> @@ -3152,7 +3150,7 @@ int gdbserver_start(int port)
>   /* Disable gdb stub for child processes.  */
>   void gdbserver_fork(CPUState *cpu)
>   {
> -    if (gdbserver_fd < 0 || gdbserver_state.fd < 0) {
> +    if (!gdbserver_state.init || gdbserver_state.fd < 0) {
>           return;
>       }
>       close(gdbserver_state.fd);
>=20

This was also already reviewed:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg697750.html

Again:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


