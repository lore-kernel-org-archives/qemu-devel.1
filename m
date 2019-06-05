Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9876CC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:45:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF422075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R82E8jrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF422075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36456 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYPfq-0007Wm-LP
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 02:45:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hYPf2-0007Ep-70
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hYPf1-0005RZ-6q
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:44:36 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hYPf0-0005MT-Tg
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:44:35 -0400
Received: by mail-ot1-x344.google.com with SMTP id r10so21958167otd.4
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 23:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=x5SYcSfvw9GauI5DR/2wLsrC6DsukrNxflJl3FCoosc=;
	b=R82E8jrCJVbULh3RAGJ3Yv34pSTxvP9KvgaVZbMclIiD/9YI5z0qaKD90eFRbrIY7A
	EVhZpeDE4Tq5Wv5WtSXsFdGyZNLQZCeeKG8KC358P+cW2XWBZAQB0UzIVOMPY5tM/hyb
	9Bh8MpygR4lzqm/DlmvTje6TXD6SGy16CVFY1jPPr6OjKRyKePNtr8uL55qO07e4LCGX
	gQCR0BHbSYybc+Ydk2ata4rs1M6gKiL/eNq/THRMh7TbwDejvWtb/h9YpSKgZ9eFzERO
	5cGNJfC0VBtt/mwx9BzPwbKjk8JdfyG45fJcOX6g7+0Gws4M6M9WP9lfhyLYcaxSk95E
	PSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=x5SYcSfvw9GauI5DR/2wLsrC6DsukrNxflJl3FCoosc=;
	b=REG5rOTwu7EBdEO9AChV3xLTP5gO7/unMO/PEqSLRswylZHO+C2lcS+ctsxUCJURxl
	Ht9r4mmvtPQRAUAJikvO5RBM2regIAQ+IScaa+FoO+YdBOHyekHvlSxkyNYxIb5EA4NV
	2UxBUxM9QZVo1Qwc8g5MUqbVATloZfK8Ay3ddlNQeOf4aQ61Ru+vMR+OlCa3iNtUbhC/
	5vClbM3OG4CJmX8wLKmX0NnGqXkkK3L/rLKybAKyd3OA76J4/NgNP6nkXT0iJw00LRrj
	iehU+cPjD1oEy5t3UxoZ3H1+PNA2taHZaBRIRnbrrSRIrx2mDMVWOVkEYkYIow1Nqz2H
	4wcA==
X-Gm-Message-State: APjAAAUNvcaOV7VrNz6NxoWsdhfHkdtlBeea7lXobDPcuLNoQ4iyYQHb
	UGRdbrJx7a2mXgRoHIoWAqxewIBDznv3BoG41u8=
X-Google-Smtp-Source: APXvYqzjh1kGYtJoL5yn3ysCWDs+OYFHOfbQAU0HVBa/E4OFYzqPUa9VA7lIj13wrZ/I+L0pOI8ewUKiGu4cT7uhGnw=
X-Received: by 2002:a9d:4109:: with SMTP id o9mr8255020ote.353.1559717073501; 
	Tue, 04 Jun 2019 23:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559710447.git.lidong.chen@oracle.com>
	<2410fe0d6dc7d5afdec8e3b8901b32e71ed303a5.1559710447.git.lidong.chen@oracle.com>
In-Reply-To: <2410fe0d6dc7d5afdec8e3b8901b32e71ed303a5.1559710447.git.lidong.chen@oracle.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 5 Jun 2019 14:43:57 +0800
Message-ID: <CAKXe6S+wKV93b0=Zc0f655AmL3e3FA5pX4KUHHZP7fJmjwqz1w@mail.gmail.com>
To: Lidong Chen <lidong.chen@oracle.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [Qemu-devel PATCH v2 2/2] util/main-loop: Fix
 incorrect assertion
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	liran.alon@oracle.com, Qemu Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
	amarkovic@wavecomp.com,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Lidong Chen <lidong.chen@oracle.com> =E4=BA=8E2019=E5=B9=B46=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=882:23=E5=86=99=E9=81=93=EF=BC=9A

> The check for poll_fds in g_assert() was incorrect. The correct assertion
> should check "n_poll_fds + w->num <=3D ARRAY_SIZE(poll_fds)" because the
> subsequent for-loop is doing access to poll_fds[n_poll_fds + i] where i
> is in [0, w->num).
>
> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
> Reviewed-by: Liran Alon <liran.alon@oracle.com>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
>


Reviewed-by: Li Qiang <liq3ea@gmail.com>

Thanks,
Li Qiang



> ---
>  util/main-loop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/util/main-loop.c b/util/main-loop.c
> index e1e349c..a9f4e8d 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -422,7 +422,7 @@ static int os_host_main_loop_wait(int64_t timeout)
>      g_main_context_prepare(context, &max_priority);
>      n_poll_fds =3D g_main_context_query(context, max_priority,
> &poll_timeout,
>                                        poll_fds, ARRAY_SIZE(poll_fds));
> -    g_assert(n_poll_fds <=3D ARRAY_SIZE(poll_fds));
> +    g_assert(n_poll_fds + w->num <=3D ARRAY_SIZE(poll_fds));
>
>      for (i =3D 0; i < w->num; i++) {
>          poll_fds[n_poll_fds + i].fd =3D (DWORD_PTR)w->events[i];
> --
> 1.8.3.1
>
>
