Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F7CC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10AEE21929
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyKr/3Ds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AEE21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS0kI-0005u5-V8
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 10:27:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iS0jK-0005FU-S2
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iS0jJ-0003wM-Q6
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:26:50 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iS0jJ-0003r7-GM
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:26:49 -0500
Received: by mail-wr1-x444.google.com with SMTP id i10so1181353wrs.7
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 07:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=c12a9dTq3zgsxLu4TAtViwDFUc1v6funY72g8W8fKHI=;
 b=cyKr/3DsekS+l5x2rUIvRnRwBgNA7JeiWWm479ROe+RP5M/BoSF1d0/AFH8bK63FxG
 7j2HsjPi3QIXAa2u/a6eNPvxvxfeQV0Xr0ap45FM6XNMQwMPftVoh+3mz499q8YjXYg4
 Chaw5FScBzR2cIoYZQdADfCXYvN227YHcg+N3+smAUufVDcl4MSYpFEnXcW1PF4v5ZJK
 i1zHSWworbt/pvNGM1IXnnlDU2X9Hjv+TursdXF48sarDQpEdQHKSWFTOU/21idinQG0
 ZBli+qFwgrBgTv9bxKEQy37/b9erOsDodE2JoOwbEmIAckzpUZMmTAfACHRFXIjS1BUT
 2vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=c12a9dTq3zgsxLu4TAtViwDFUc1v6funY72g8W8fKHI=;
 b=fzxjO26QWXwbbupE/XRoPxVPgKdNoNQQVYpJmLcFLTMtakyQi9R/OiL4RM544zyAI5
 khsxfDPtSWhN5dH7xHQZhcWLHwQhg18ezDwk/6wg0pu6geCVHSKCDGulpdFzt1wo+051
 VmzjdszkC89X2G7U7aL4yXu6yDOkQEXcMjCpE0ovcdZW541c/rbgxSELplzSM9xO9f/E
 qQClAjDdNAWOBUYC7NEV5oWfqhngOWX2uN2yNhFll4aGo7tDkKhTsewEY1NSJDicMD9A
 nil7vO8Yww/ud1U2vYIOae79/LjeBc97iFN2tkvJSrNiAs/MW27E8mte59v7Ao+UP5Fe
 skvQ==
X-Gm-Message-State: APjAAAUiKPFdXPJgS9vOZW7HgN0AErETnzvPpQU3uDPmcoTooYzPKiFV
 P7Z7iQ2itRf9KdJfX/JnjT4=
X-Google-Smtp-Source: APXvYqwOxS2NT1UO0zafyu/EFJEZIu4fD/Srwbncc5ZBX0J+UhwYv/JMaxNz5bF+nDakB3btAtvRkg==
X-Received: by 2002:adf:9e92:: with SMTP id a18mr27979626wrf.34.1572967608369; 
 Tue, 05 Nov 2019 07:26:48 -0800 (PST)
Received: from localhost (91.141.1.3.wireless.dyn.drei.com. [91.141.1.3])
 by smtp.gmail.com with ESMTPSA id f18sm18766185wmh.43.2019.11.05.07.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 07:26:47 -0800 (PST)
Date: Tue, 5 Nov 2019 16:26:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] audio: add -audiodev pa,in|out.latency= to documentation
Message-ID: <20191105152645.GB166646@stefanha-x1.localdomain>
References: <20191004125641.24383-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <20191004125641.24383-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2019 at 01:56:41PM +0100, Stefan Hajnoczi wrote:
> The "latency" parameter wasn't covered by the documentation.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Hi Gerd,
> You asked me to resend this patch because there was a conflict.  I have
> rebased it onto qemu.git/master (4f59102571fc).
>=20
>  qemu-options.hx | 5 +++++
>  1 file changed, 5 insertions(+)

Ping?

> diff --git a/qemu-options.hx b/qemu-options.hx
> index 2a04ca6ac5..5c27c57273 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -470,6 +470,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
>      "-audiodev pa,id=3Did[,prop[=3Dvalue][,...]]\n"
>      "                server=3D PulseAudio server address\n"
>      "                in|out.name=3D source/sink device name\n"
> +    "                in|out.latency=3D desired latency in microseconds\n"
>  #endif
>  #ifdef CONFIG_AUDIO_SDL
>      "-audiodev sdl,id=3Did[,prop[=3Dvalue][,...]]\n"
> @@ -630,6 +631,10 @@ Sets the PulseAudio @var{server} to connect to.
>  @item in|out.name=3D@var{sink}
>  Use the specified source/sink for recording/playback.
> =20
> +@item in|out.latency=3D@var{usecs}
> +Desired latency in microseconds.  The PulseAudio server will try to hono=
r this
> +value but actual latencies may be lower or higher.
> +
>  @end table
> =20
>  @item -audiodev sdl,id=3D@var{id}[,@var{prop}[=3D@var{value}][,...]]
> --=20
> 2.21.0
>=20
>=20

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3BlLUACgkQnKSrs4Gr
c8jwKAf/apFkOUpvKitr4c4CuQOQ1l8/TYWwL3Z1lvrtJf05Q7hGDh0hVOzN56pm
7gIaUnQEwpRecAKu8RjLse391ILxelHjgWo1mKmSThf6pm4pL0T3QiR0uC8n/h+Y
HHa55A1O6oG4yUxxVl913ZMuNkL2rp7cRcNJQygDWCbddAGlLNZoXa+oHuGZBEc/
roxVRRn8S3JpZFv+/Rs5nsUmKdVGklV6bzY3hLEKsrlJY0RBgUvVLlhB/YFtXWcE
za5e01NdLQObmJ2+5OCOC0gvUh9m61f6Nm/YmQnTkMlmawfRwusbwfd3Goel3nMr
G9IW23HJECnLF83EBZhwCYlLyyROkg==
=BzE2
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--

