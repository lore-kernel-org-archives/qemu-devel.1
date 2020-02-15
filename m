Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33443C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 13:54:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6402086A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 13:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jN+47Mdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6402086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2xtV-0001KK-6G
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 08:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2xsr-0000lk-93
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 08:53:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2xso-0006cW-LM
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 08:53:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52382
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2xso-0006WF-Bk
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 08:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581774800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixqWvwlsbbjYHFgmeuxfgvMNewbGeizz9wzudD0gbwk=;
 b=jN+47MdrjkdsahQNVsL1kIs0Vz+vhEuh63ngh1QgyReB+BHnqTOIPyRu4BX4bLFdoudDVI
 NaBJh/T5mSIp0sp9v+rLB783g6gfqfPaNQPEj5cIhd//GUk9cZq7fclk1OJXumcRrS62b1
 p/hDxSxwOOG6oDXizRYoyg2bK6f8p/A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-uz32mKJGOYy7q4SVAaC5qA-1; Sat, 15 Feb 2020 08:53:14 -0500
Received: by mail-ed1-f72.google.com with SMTP id d21so9772075edy.3
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 05:53:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FU22P1ISMPXbpmkSM9GLJdpq7mDx2BnroYrC+O0sv7k=;
 b=tUAIkcOrzX+ZLgoZ9nyq80RU7CfNOqEFJ4YVwthbqLXXDInkCxy0ZusbLSFmBpMvCZ
 vDAsWh1CD4/OeNcK0u6tNx+356KCAi6/uPPyOWgHN4b+HPwuH6QGukj64tcd0aG6006G
 Nydz63mPuQb3gjo7MVLk4tpjRog1ZiuxATTEJWpNo96GlRhbMwcgJ4NUfbTDL1t9CjDs
 gsKamQRMGI9RfaRPxJGlrWUrRPbsnWI+8Tb4KaSE2jR+q75F5VhPElsWkb+pn7wSvztB
 sOvReOOvpndnXoZEmEpeH9H5TJBCJ+ypAQQVJQDK0+o6U3PTvYtJzXzrbKAcpNmooiCh
 BGGw==
X-Gm-Message-State: APjAAAUKwEC99tEIlleYKitNfgypXZ24sSRPwC9WXW2zNdgzGEig1hST
 jxKAaJO8fBxNBRpV8DqRM29ectX96G/7MMk5TMmUkXNcaM2Ww7SUnO0zRKaJXA8a4zLW6WtCJt9
 JKjaoKIJXFMIRHh8=
X-Received: by 2002:a50:c04e:: with SMTP id u14mr6768199edd.193.1581774793178; 
 Sat, 15 Feb 2020 05:53:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqw+lpGw3xbH7HhFnDPLhUIPgd9ES5tokNY5yCil4TZomIW5GsO6na4FZIgJQskQWp9n9HdyyA==
X-Received: by 2002:a50:c04e:: with SMTP id u14mr6768186edd.193.1581774792924; 
 Sat, 15 Feb 2020 05:53:12 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id lu4sm662442ejb.76.2020.02.15.05.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2020 05:53:12 -0800 (PST)
Subject: Re: Build for qemu-sh4 broken since 2445971604c
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <0895187b-e50c-28a8-bce3-9f351d29234d@physik.fu-berlin.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1e7c2c17-1907-cc9d-2bad-071bdd09650e@redhat.com>
Date: Sat, 15 Feb 2020 14:53:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0895187b-e50c-28a8-bce3-9f351d29234d@physik.fu-berlin.de>
Content-Language: en-US
X-MC-Unique: uz32mKJGOYy7q4SVAaC5qA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

Hi John,

On 2/15/20 11:53 AM, John Paul Adrian Glaubitz wrote:
> Hi!
>=20
> Currently trying to build qemu-sh4 in static configuration fails with:
>=20
> make[1]: Entering directory '/root/qemu/slirp'
> make[1]: Nothing to be done for 'all'.
> make[1]: Leaving directory '/root/qemu/slirp'
>    CC      sh4-linux-user/tcg/tcg-op-gvec.o
> /root/qemu/tcg/tcg-op-gvec.c:298:25: error: unknown type name =E2=80=98ge=
n_helper_gvec_5_ptr=E2=80=99; did you mean =E2=80=98gen_helper_gvec_4_ptr=
=E2=80=99?
>    298 |                         gen_helper_gvec_5_ptr *fn)
>        |                         ^~~~~~~~~~~~~~~~~~~~~
>        |                         gen_helper_gvec_4_ptr
> make[1]: *** [/root/qemu/rules.mak:69: tcg/tcg-op-gvec.o] Error 1
> make: *** [Makefile:497: sh4-linux-user/all] Error 2

I believe your build directory is out of date and might have dangling=20
old files.

> This seems to have been introduced with:
>=20
> commit 2445971604c1cfd3ec484457159f4ac300fb04d2
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Tue Feb 11 16:31:38 2020 -0800
>=20
>      tcg: Add tcg_gen_gvec_5_ptr
>     =20
>      Extend the vector generator infrastructure to handle
>      5 vector arguments.
>     =20
>      Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>      Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>      Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
>      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

If you look the content of this commit, the new type is properly declared:

--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -83,6 +83,13 @@ void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs,=20
uint32_t bofs,
                          uint32_t maxsz, int32_t data,
                          gen_helper_gvec_4_ptr *fn);

                          uint32_t maxsz, int32_t data,
                          gen_helper_gvec_4_ptr *fn);

+typedef void gen_helper_gvec_5_ptr(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
+                                   TCGv_ptr, TCGv_ptr, TCGv_i32);
+void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t cofs, uint32_t eofs, TCGv_ptr ptr,
+                        uint32_t oprsz, uint32_t maxsz, int32_t data,
+                        gen_helper_gvec_5_ptr *fn);
+

BTW what capstone configuration are you using?
Is that --disable-capstone or another?

Regards,

Phil.


