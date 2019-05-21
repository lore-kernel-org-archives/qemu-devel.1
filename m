Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAE8C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:16:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B64A22173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNPoearn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64A22173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55384 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT6VQ-00076l-Nz
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 11:16:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hT6UI-0006Q8-6r
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hT6UH-0000PP-B5
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:15:34 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:45756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hT6UH-0000O7-1s
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:15:33 -0400
Received: by mail-wr1-x42a.google.com with SMTP id b18so19011767wrq.12
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 08:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=32NCbMyAorIOPfPUUwwMRPAH1PvCGu8FCy5oWX8Xds4=;
	b=NNPoearnaCpXaeM4EphBqxlD6dWs4MuToNYWBzXAA8vO8qlMXNGbKX8VMhNmH85k3J
	HPKnW6JpeZu4IgOzHOjWLn59rC+hZecPU8XfbJewrYf91hFALrvOgBidLf+aeMgYrAxj
	+3zCZK60rAmeZNL6S87XBuCJa7LNga/+mmooliJZ99oia5tBET2QJukgefZc1lIFAytw
	psHxph7LKkV3Lh4xnNeE0bFRdpEeqPpK/ZnXA/MXGv5q3OWrs+uFXo7csDtvDgpK16zC
	CP2VcNov9souZuAp56zUIBzc1kZ+kauUKIfuB6O/4X5IboYKY+Dq0dZyWaF2plCb5ZkU
	xf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=32NCbMyAorIOPfPUUwwMRPAH1PvCGu8FCy5oWX8Xds4=;
	b=W/3nGeK+lpmYdJgVViLBgak9VI7GOvXqC26Xxeq143ek8zd+mQJgXKYm53iQ6MLvll
	ItwjR9grrKtDpotQEcft/dhOUe5TzovYFsCAFQ9Mo59z+zyEOAsKJBqBA6WSZwo/UTWM
	OpZPk/SvOs0sQTJvU6yGr6jykwG18gRwGCCUzPKMmf4Dz4SRQ38w0N4EMhrw2i5yEXug
	wK0zCPcJYwCi4mWCOXeZ/c9NfowYDQnExTKtJaq+vHH09qEotZc+InxLxczZdwEbTlmo
	7ZFyjbL4OSDe/rg56logJwQ6Tkqbjh5+w/tfBBE+3QJqL1o0I7r84C1zE+6OK/coD5j/
	7l2g==
X-Gm-Message-State: APjAAAWZMhBNRMA4F6xVwQ8zIhdgo6Foi/9BnQUJ0vgnaB8xYPVBy/r3
	xTC3Rhn9POikIt4eTQ4PdHN82yW/B3Tkqq39rDY=
X-Google-Smtp-Source: APXvYqwn23Aa2kCIIscduxwLbjfIgsuvlZBDt2MxjAabmAowwzOz4+iapn+Dga9ytsU96hQMJ212XRI1jwSuyRDOwg4=
X-Received: by 2002:adf:9d8a:: with SMTP id p10mr23223105wre.31.1558451731797; 
	Tue, 21 May 2019 08:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-vSebWjhbFTdfOSGHJtr8-a+DKG22JU3tS-1OoGR=VXQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-vSebWjhbFTdfOSGHJtr8-a+DKG22JU3tS-1OoGR=VXQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 May 2019 17:15:20 +0200
Message-ID: <CAJ+F1C+zsiicj2Bwx51viSzr+f-m8+5tCBX97oCwU0YPtfoMiw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: Re: [Qemu-devel] is anybody experimenting with the idea of rust
 code in QEMU?
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter

On Tue, May 21, 2019 at 4:40 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> Hi; I have on my todo list the idea of some experimentation/prototyping
> of whether being able to write some components of QEMU in Rust would
> be (a) feasible (b) beneficial (c) fun to play around with even if
> it is likely that it doesn't go anywhere :-)

I wrote slirp bindings, and a helper process that can be used by qemu
(https://github.com/elmarco/libslirp-rs &
https://www.redhat.com/archives/libvir-list/2019-April/msg01233.html).

I have done some experimentation slowly replacing slirp C code with
rust (https://gitlab.freedesktop.org/slirp/libslirp/issues/3). I
decided to try from scratch as well, using smoltcp. I have
dhcp/udp/tcp working to some extent so far (I keep in mind a future
libslirp compatible ABI, if needed).

--=20
Marc-Andr=C3=A9 Lureau

