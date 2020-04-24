Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46D2C2BA19
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 02:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B004020715
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 02:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSovzFnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B004020715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRoM9-0002Dm-OX
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 22:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.s.norwitz@gmail.com>) id 1jRoKx-000184-OO
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 22:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <raphael.s.norwitz@gmail.com>) id 1jRoKb-0006sF-Jr
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 22:45:00 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:35924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jRoKL-0005wX-Ki
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 22:44:31 -0400
Received: by mail-io1-xd42.google.com with SMTP id k6so8846974iob.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 19:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=6Bb+1JPzasTMTtBLH86C9ZNw2h/oZVaJQuXHgPflzIk=;
 b=cSovzFnI7Jcy+JtfNDF4ITUWgMSu0xdd5/X3ClbBg+qh+5KgrUHsaSI2ixl9NWzVUr
 ngHTnMxRis205HB4594quXMB6/zWEvEzPy4DMcPsYVd78Y4BDbClOUfQJ6/kC+c2Olys
 qwtYSLs84130MAdRoUWN0qEqerEiOPinFsvThtiFRAwWnFCCK1Pr4T5zuqsn4F+sOy0L
 dIbFToCLE4yOwYrBL5CIzw8vbSXBBKLWl84HaFR759WouUQzUNQhUDiExiHvC7jqh3Ub
 KBQW0o/Lz/sq+KqEhLUqp6UQo4jlqkmvIhRkfK+a2dCHEMWEN1gzVDeMkS+jso/hBqH5
 0xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=6Bb+1JPzasTMTtBLH86C9ZNw2h/oZVaJQuXHgPflzIk=;
 b=XtiwBN5HohHKMJWiwlXfYtWma7U9s20MjUM/sTJyGTldQigH78YPmoY7fL2uUA8Kgk
 abnMwodG164q+Vn71RFlRBT4E8Wm4OmK8Rja74sqwsRVNU4UHUCHjm3R5U6L+jvNIL5X
 AaZzeh+Hrl+PScIpgZscFXs9GhnnEiff/Qz4dEsTx8pJxZAv75Cd6XAoImlCubTUI0jG
 wKV47wu7cxA3A7T91CD0IHRTH6tsqv2g66/KsJFbYcPFxnmTH/I+PEAmVKItvANLLaZB
 4yD1Lo7zxEMzepmyjH3pVaXTlzd3XoElDBwa17xnAPiLX+Z24vY3F2wsJsN3531TJNV5
 974Q==
X-Gm-Message-State: AGi0PuZZyRsExktWJCIjVPYQoKsEJx8vGEuFqUewnYQjYlpNvmWgBNUZ
 U5WNZgbaIN/y1kljMbqcZBdd7FNUGg1edUws+GY=
X-Google-Smtp-Source: APiQypIMfjZktq5xvCAZMJ0fX8lLY8N0vVgagr2FEkbswFhgs/vlnGRuSqZWkB6ZuM+f8gOLXlEYwpmMDXEeGxdvGPM=
X-Received: by 2002:a5d:88ce:: with SMTP id i14mr6771507iol.184.1587696255241; 
 Thu, 23 Apr 2020 19:44:15 -0700 (PDT)
MIME-Version: 1.0
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 23 Apr 2020 22:44:04 -0400
Message-ID: <CAFubqFucKPk7CqrvOaVbFnOuLLwtQQG=EYeyLfAdV-TDM=+nbQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/7] contrib/vhost-user-blk: add option to simulate
 disconnect on init
To: dimastep@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I=E2=80=99m not opposed to adding this kind of debugging functionality to t=
he
vhost-user-blk sample. It could be helpful to easily test these cases
in the future.

That said, I'm not sure how others will feel about adding these kind
of debugging capabilities to libvhost-user. Marc-Andre, thoughts?

If we go this route I would prefer to add the debugging options to the
vhost-user-blk sample in a separate patch.

On Thu, Apr 23, 2020 at 09:39:32PM +0300, Dima Stepanov wrote:
>
> Add "--simulate-disconnect-stage" option for the testing purposes.
> This option can be used to test the vhost-user reconnect functionality:
>   ./vhost-user-blk ... --simulate-disconnect-stage=3D<CASENUM>
> In this case the daemon will "crash" in the middle of the VHOST comands
> communication. Case nums are as follows:
>   1 - make assert in the handler of the SET_VRING_CALL command
>   2 - make assert in the handler of the SET_VRING_NUM command
> Main purpose is to test QEMU reconnect functionality. Such fail
> injection should not lead to QEMU crash and should be handled
> successfully.
> Also update the "GOptionEntry entries" definition with the final NULL
> item according to API.
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  contrib/libvhost-user/libvhost-user.c   | 30 +++++++++++++++++++++++++++=
+++
>  contrib/libvhost-user/libvhost-user.h   | 13 +++++++++++++
>  contrib/vhost-user-blk/vhost-user-blk.c | 14 +++++++++++++-
>  3 files changed, 56 insertions(+), 1 deletion(-)

