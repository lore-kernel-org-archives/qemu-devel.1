Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFB7C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1C420656
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBqHImar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1C420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyH2I-00005z-Ux
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 10:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1hyH0f-0007dS-6w
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hyH0c-0005wL-GA
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:45:49 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hyH0c-0005vN-9W
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:45:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id b16so2431645wrq.9
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=gr2ZOYCI3DXPPFZ99wVrTGHMpO9u7sXtf/eSec5Mrck=;
 b=lBqHImarQKRJYI6mX3XQnnZna3nv9nM1/ThxWCqBSpK3lXUT6G1/ionpxloByouONt
 ud/dnwap0qYmvDN1UTn1PwEWeiH+K73Ijbh3T2LIY9myMZJZ4BzgUHe31JP5UwYsJgrM
 EA+hL1puPkgJCYHVV2SChXcu14fL3QQCGjdRwU4S8fh6YyMPx2nr2A1GWPixt+lO2Lt3
 ukCrKbMjS60izVg/dArRpeBiotVzSfXE9GZqQX4DV5xuCig5OQWgVZpOc2AmtYq66bjy
 x5r8qCeKdZ9idu/ir5wI/FuunJEDlcOAjEJ4UsJMm5/YJeRceRxJ/Vybt32cvDVvSn+2
 v+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gr2ZOYCI3DXPPFZ99wVrTGHMpO9u7sXtf/eSec5Mrck=;
 b=dHlgDX45fgfjEOm02VrXstRP+QdBCjaYBDlks+pYzNwSpecWFjd9feQ3QBVHKjyNUA
 +ftR4bt4W0DjYeanGKB1V9vnJcVOYvHMqop/vPTym/n6nwQ7nProrwvL32UPIDEJyV7g
 5IeolmNqwBa9K/CsVHIgIs0AZMxTGZvAs8VOy+7PjcWcvgipEpirgg9Cw/hbMx5Xrdqg
 IGzQO8D0dui9EQ/QucSuj7sy8Txx7wRD4fExHh0Brg2encolZG/sS1cBMPOAoVhoEhGa
 LLj3Xv8clp9z7LlWIgOEK8Ay8CzzzINIzAeUlbW5DY65tEV/9e6mAlsJl8bhMitkdcph
 +dew==
X-Gm-Message-State: APjAAAXSfABo89nUAffufUd4ZzZsFGUyB1GN/ka26G83qaaeWsNAwUIL
 aqX4IvE+tHc8d4dJuYBVfDcuzSIwZdM=
X-Google-Smtp-Source: APXvYqxy5DpsSMf6aEo0LKPw1/IPu6eC5+t4CZcCHNj1UyKbr5k0Sum/hHabEvOIXu8MwPlGG6tgDA==
X-Received: by 2002:a5d:6b11:: with SMTP id v17mr5728002wrw.323.1565880344955; 
 Thu, 15 Aug 2019 07:45:44 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id g14sm5214831wrb.38.2019.08.15.07.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2019 07:45:44 -0700 (PDT)
Date: Thu, 15 Aug 2019 15:45:42 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190815144542.GH10996@stefanha-x1.localdomain>
References: <20190815120247.13413-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WIIRZ1HQ6FgrlPgb"
Content-Disposition: inline
In-Reply-To: <20190815120247.13413-1-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] trace: Clarify DTrace/SystemTap help
 message
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WIIRZ1HQ6FgrlPgb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2019 at 02:02:47PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Most tracing backends are implemented within QEMU, except the
> DTrace/SystemTap backends.
>=20
> One side effect is when running 'qemu -trace help', an incomplete
> list of trace events is displayed when using the DTrace/SystemTap
> backends.
>=20
> This is partly due to trace events registered as modules with
> trace_init(), and since the events are not used within QEMU,
> the linker optimize and remove the unused modules (which is
> OK in this particular case).
> Currently only the events compiled in trace-root.o and in the
> last trace.o member of libqemuutil.a are linked, resulting in
> an incomplete list of events.
>=20
> To avoid confusion, improve the help message, recommending to
> use the proper systemtap script to display the events list.
>=20
> Before:
>=20
>   $ lm32-softmmu/qemu-system-lm32 -trace help 2>&1 | wc -l
>   70
>=20
> After:
>=20
>   $ lm32-softmmu/qemu-system-lm32 -trace help
>   Run 'qemu-trace-stap list qemu-system-lm32' to print a list
>   of names of trace points with the DTrace/SystemTap backends.
>=20
>   $ qemu-trace-stap list qemu-system-lm32 | wc -l
>   1136
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  trace/control.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/trace/control.c b/trace/control.c
> index 43fb7868db..bc2fe0859d 100644
> --- a/trace/control.c
> +++ b/trace/control.c
> @@ -159,12 +159,19 @@ TraceEvent *trace_event_iter_next(TraceEventIter *i=
ter)
> =20
>  void trace_list_events(void)
>  {
> +#ifdef CONFIG_TRACE_DTRACE
> +    fprintf(stderr, "Run 'qemu-trace-stap list %s' to print a list\n"
> +                    "of names of trace points with the DTrace/SystemTap"
> +                    " backends.\n",
> +                    error_get_progname());
> +#else
>      TraceEventIter iter;
>      TraceEvent *ev;
>      trace_event_iter_init(&iter, NULL);
>      while ((ev =3D trace_event_iter_next(&iter)) !=3D NULL) {
>          fprintf(stderr, "%s\n", trace_event_get_name(ev));
>      }
> +#endif

Multiple trace backends can be built into QEMU.  In that case the list
might be complete and the user may not be using stap at all.  Perhaps
the message should be turned into a warning instead and the list should
still be printed:

  This list of trace events may be incompletel.  Run 'qemu-trace-stap
  list %s' to print a list of names of trace events with the
  DTrace/SystemTap backends.

Stefan

--WIIRZ1HQ6FgrlPgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1VcBYACgkQnKSrs4Gr
c8iAhgf/R34Nbzzc2pAFcqPG6d5d0iDIlLx7KPN9esY2ybgYP5I6LCI4HiRMM8hU
lhg+y+VRvPE6YZ9b3/jD6sOjz+tVB3dh3dblSUoWrC/3XzPUmw6fChCp4vBKKIvO
I5OFcyX7SX9rvrhbLbcscAay1RMTY6TteV7z3ch5EBIjqUYtkz/4y3AwHvPOSSRc
qXxl9VnIEZb25whnNQUb8V3/GJYrptCwbfnprEBecq0zHuo/e5VSpBoXsE5J+UBs
kWRRr2eoVN2m4Hh0ZF0+C99uAtr1YGyugqet6i4LO4ZejtKQDiX9Ky8BtFp4Ko6h
M0qzW/ooZOJAZMIyXL6uYK1+OeYQyQ==
=0Zod
-----END PGP SIGNATURE-----

--WIIRZ1HQ6FgrlPgb--

