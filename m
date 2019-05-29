Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9300DC28CC1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624252081C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXpuXDOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624252081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52309 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVx53-0007qE-Ne
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 07:49:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hVx3E-00070d-Md
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hVx3D-0007aj-Si
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:47:24 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hVx3D-0007Zq-Oq
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:47:23 -0400
Received: by mail-ot1-x342.google.com with SMTP id n14so1704778otk.2
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 04:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=aExuaKYTnOHihruRIq+XtADu9811UKNFck5LVpS5Xg8=;
	b=FXpuXDOMbAC5gZcAqQ87hBvWUt395wQTfM8xbvgjdWVIiFzNNSo6ifiw7wL9VegQP3
	R0Yf6YQh7fvs5b4UIDc+20bL6m33zP1VzsHnuqIUqChiukfQMs1KY3QM3tHGmJvP7bZ4
	lrSULf4pW08wESEl8IqVsitlHDv1myIKyxMCwoueVTnN1ycrDLFtakA2WMHReitgjCdT
	g8AIEK7EJD9j44ynUKDfXX5EKW/rmWG20mCjBvruFjuQ17gE2GXCU4pNxDkRPa2Yu8Ql
	6RsafUnM9azyu/MEP+DqUzsx5L6d+NKKPR8k24l5IvcmaKI5hgkFZtVKb6joe9wwKlf+
	eXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=aExuaKYTnOHihruRIq+XtADu9811UKNFck5LVpS5Xg8=;
	b=XErsjkfm0nlAYOliJLUVcQ4UZdz3oMCAhfXtyeLjEK8YPU0k8rECU4Zfub24eM5FyZ
	DXlyvuFBqB/lpXoB++FgRGsd2oIt6CSGjJ6/SJOOIdKRvjUj7q9evmKhMCpXHlouomkr
	AxQ5vZROqtVELuedwp2nC9DJCtGMMFtOvEnqBXzuHaxo/kkl9nanfvoE5xilT5Gwveqa
	MvSJhC5ZkUDedsQcEjNHu8Igu4UJtLXZfIiLaGC1OAjfcdQJpGb+2HOFCPl0X4aa1ubo
	lohnwhObh0H1z8yJrdnCvI0Ng9fv/BVMW6uttrZJ9hyRF8nWg+Q8+bd0WnivcKz3lkDO
	Gkig==
X-Gm-Message-State: APjAAAV4jzGCkjhW4UVAniIPRaoRCsDTxDKCEaPSwrtITZI74TiYrSpi
	MYpxhc460LydQwf1/XR09CAwwX9ZITxPyuTRBxg=
X-Google-Smtp-Source: APXvYqwwVwDHWBkzjHI+zuly9b5Kid5wcJH5IbEWuT8hehOzrcF87n7D0EONPYPeJInr9jJ1Ku0PiywchamZjUsGHXU=
X-Received: by 2002:a9d:74c5:: with SMTP id a5mr4878725otl.322.1559130442610; 
	Wed, 29 May 2019 04:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190519084815.7410-1-ppandit@redhat.com>
	<CAJ+F1CLXdw4gE45vVEpStKrKsu-OYy1+5caC9wUduEtQRhjrpA@mail.gmail.com>
	<nycvar.YSQ.7.76.1905231257400.23354@xnncv>
	<CAJ+F1CLH1qN-jVVaMacMB41PWfZ5Xd9A8ycowaNxwgvQhPEvMQ@mail.gmail.com>
	<nycvar.YSQ.7.76.1905291448250.16122@xnncv>
In-Reply-To: <nycvar.YSQ.7.76.1905291448250.16122@xnncv>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 29 May 2019 13:47:11 +0200
Message-ID: <CAJ+F1C+xhBeoVqoE4aPgLqquq7rNKbZTtNSHe73FFgMyDCUzyw@mail.gmail.com>
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

On Wed, May 29, 2019 at 11:38 AM P J P <ppandit@redhat.com> wrote:
>
>   Hello Marc,
>
> +-- On Thu, 23 May 2019, Marc-Andr=C3=A9 Lureau wrote --+
> | I don't see how you could exploit this today.
> |
> | QMP parser has MAX_TOKEN_COUNT (2ULL << 20).
>
> I see, didn't realise that. I tried to reproduce it and
>
>    {"error": {"class": "GenericError", "desc": "JSON token count limit ex=
ceeded"}}
>
> got above error around ~1048570 tokens; Much earlier than 0x200000(=3D209=
7152)
> as defined by MAX_TOKEN_COUNT. I guess multiple packets are being merged =
to
> form the incoming command and there is a glitch in there.
>
> | We could have "assert(count < MAX_TOKEN_COUNT)" in the loop, if it help=
s.
>
> No, assert() doesn't seem good.

assert() is good if it's a programming error: that is if it should
never happen at run-time.
It's a decent way to document the code.

>
> I think same limit will apply to commands coming via QAPIs as well?

What do you mean? If the generated API is used internally by QEMU?
(it's not, but in this case there would be no limit)

--=20
Marc-Andr=C3=A9 Lureau

