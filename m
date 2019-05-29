Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092DEC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 14:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC57C23A78
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 14:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4AOXddU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC57C23A78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55623 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVzpd-0002Gh-W9
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 10:45:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hVzot-0001xx-6x
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hVzos-0002v5-9Q
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:44:47 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hVzos-0002uR-1X
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:44:46 -0400
Received: by mail-ot1-x342.google.com with SMTP id t24so2243403otl.12
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=QAqxNAEa3taE7m7nxWKzMS8hLjCvDdZtBZgUx0FYZsQ=;
	b=L4AOXddUaHvJpBVgXZ5v2QFkajQhwEnpKJFMJ9Jf/taiIi0BNJ2NgRyTEdGI468IhP
	MezSDzQJKEIKqE/3Hn6htbeYbd+DvNpv0wo7YIgJSzFO+fsSBqPyh1meozYlphDsLnHa
	XySekUSFqMNg9rHgsCppKhCdKNMP2MJExfztfMPMrFLzJ875t5bFPSPKP4VE1DfEX7Q8
	wxJmSezjxij1Q9RZErkzn9vl8QvYPf+UvapWQ63rjklB0a24ru0YZCJXY/7GO5eLDQE9
	DQEIVOfG2fwUmbG0r+R4X6taUViSHDtEeFuAY3Lk0jJeFMVJOv9T/z6im84BcflMkMBD
	jhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=QAqxNAEa3taE7m7nxWKzMS8hLjCvDdZtBZgUx0FYZsQ=;
	b=V6yiJu5VI0pzpuTKGJe+FY20wAWx+hSn9atYMVvaIwr1Utu6YhmUk/soza96QUj5zX
	yIt7+v84gf7ndYJyyTy7l1QLwnaXmxe1CqzHNqYuup5Usj6ZcDhsvAzpSizvEij0WYa+
	qie5B3JY+mX5BYfKIZ0E21tVvI2bct/uo0akgPkfHj/0mZpBM8r/Cocaikq9ndzUvx58
	8lzGN57K/pRP6BIqE+Whe7lifV36ME2Z2Os94apKE+SvYgTzfLeXEpwYBC9pIIFQaDwY
	xYnDc1wgIqg+vkmCWeOcyAEZdPOAz0Bof0kst20pDFqCntlmx7TEZUOtui2YbY4KN1w+
	MV0w==
X-Gm-Message-State: APjAAAVxcuP9vIAIS0tCp/Yz9980CEbgwz2H+UOPi6LvT9IMaVmsD6Eo
	L85RYTFloRDNedyMYpYWUQMXB3Ea44Rq5pdczKU=
X-Google-Smtp-Source: APXvYqwN6M9Eq7xYR9bUqtMiH9O3rPdrQsE5H0djq08ZzY1ucSe5/IzaxGGOwvt20mKrkxxxD0E2zBbSISB1BrHoVfI=
X-Received: by 2002:a05:6830:1104:: with SMTP id
	w4mr411969otq.165.1559141080100; 
	Wed, 29 May 2019 07:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190519084815.7410-1-ppandit@redhat.com>
	<CAJ+F1CLXdw4gE45vVEpStKrKsu-OYy1+5caC9wUduEtQRhjrpA@mail.gmail.com>
	<nycvar.YSQ.7.76.1905231257400.23354@xnncv>
	<CAJ+F1CLH1qN-jVVaMacMB41PWfZ5Xd9A8ycowaNxwgvQhPEvMQ@mail.gmail.com>
	<nycvar.YSQ.7.76.1905291448250.16122@xnncv>
	<CAJ+F1C+xhBeoVqoE4aPgLqquq7rNKbZTtNSHe73FFgMyDCUzyw@mail.gmail.com>
	<nycvar.YSQ.7.76.1905291932220.23737@xnncv>
In-Reply-To: <nycvar.YSQ.7.76.1905291932220.23737@xnncv>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 29 May 2019 16:44:28 +0200
Message-ID: <CAJ+F1CLMfGdap0dTmLRNPsvPt9jBJCUcj3qxP9-N-wEPpsLr1A@mail.gmail.com>
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2] qga: check length of command-line &
 environment variables
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
Cc: =?UTF-8?Q?Ferm=C3=ADn_J=2E_Serna?= <fjserna@gmail.com>,
	"Daniel P . Berrange" <berrange@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, May 29, 2019 at 4:35 PM P J P <ppandit@redhat.com> wrote:
>
> +-- On Wed, 29 May 2019, Marc-Andr=C3=A9 Lureau wrote --+
> | assert() is good if it's a programming error: that is if it should neve=
r
> | happen at run-time. It's a decent way to document the code.
>
>   True; But terminating server because a user sent more input parameters =
does
> not sound good.
>
>   {"error": {"class": "GenericError", "desc": "Guest agent command failed=
,
>    error was 'Failed to execute child process \u201C/bin/ls\u201D
>   (Argument list too long)'"}}
>
> returning an error, as it does, is better IMO.

The error is handled before guest_exec_get_args(), isn't it?

>
> | >
> | > I think same limit will apply to commands coming via QAPIs as well?
> |
> | What do you mean? If the generated API is used internally by QEMU?
> | (it's not, but in this case there would be no limit)
>
> IIUC, the QAPIs could be used by external libraries/clients to send
> messages/commands to qemu/qemu-ga?

The qga commands are only called through QMP, afaik.

thanks


--=20
Marc-Andr=C3=A9 Lureau

