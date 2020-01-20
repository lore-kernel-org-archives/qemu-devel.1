Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A3FC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620CD217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+M7+RTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620CD217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itd2d-0000tf-Fe
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 14:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1itd17-0008Du-8J
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:47:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1itd14-00015i-3K
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:47:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55462
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1itd13-00014N-VG
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579549637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFHsmSvzipxm9ijijYW6o70CkTd33ne/iRbUywS7kus=;
 b=N+M7+RTvJIJM7zXCjt9mrF8ovqUiy3rF+aMGkinCaPRillD/FZmpNWNGv9d+cPQxkZfgNS
 yDvfjg8YGidS08gzxVM6HfFKp/mi/2lxEKtrBSvixd+kAE8jV6DTh37/aM1BR3rbjxqvOO
 fVhz6HdTIRiRxm54c1fT76bMsNTjpro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-ucLm-nmuNuqzY-7TjFGk7g-1; Mon, 20 Jan 2020 14:47:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 511CC800D41;
 Mon, 20 Jan 2020 19:47:13 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CCC060BF7;
 Mon, 20 Jan 2020 19:47:05 +0000 (UTC)
Subject: Re: [PATCH] ui/console: Display the 'none' backend in '-display help'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200120192947.31613-1-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5653e64e-771d-1431-9039-d0f058d065a5@redhat.com>
Date: Mon, 20 Jan 2020 13:47:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200120192947.31613-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ucLm-nmuNuqzY-7TjFGk7g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/20/20 1:29 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Commit c388f408b5 added the possibility to list the display
> backends using '-display help'. Since the 'none' backend is
> is not implemented as a DisplayChangeListenerOps, it is not
> registered to the dpys[] array with qemu_display_register(),
> and is not listed in the help output.
>=20
> This might be confusing, as we list it in the man page:
>=20
>    -display type
>        Select type of display to use. This option is a replacement for
>        the old style -sdl/-curses/... options. Valid values for type are
>=20
>        none
>            Do not display video output. The guest will still see an
>            emulated graphics card, but its output will not be displayed
>            to the QEMU user. This option differs from the -nographic
>            option in that it only affects what is done with video
>            output; -nographic also changes the destination of the serial
>            and parallel port data.
>=20
> Fix by manually listing the special 'none' backend in the help.
>=20
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   ui/console.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/ui/console.c b/ui/console.c
> index 69339b028b..179901c35e 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -2338,6 +2338,7 @@ void qemu_display_help(void)
>       int idx;
>  =20
>       printf("Available display backend types:\n");
> +    printf("none\n");
>       for (idx =3D DISPLAY_TYPE_NONE; idx < DISPLAY_TYPE__MAX; idx++) {
>           if (!dpys[idx]) {
>               ui_module_load_one(DisplayType_str(idx));
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


