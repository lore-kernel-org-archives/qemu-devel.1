Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2760CCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 19:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9896206BA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 19:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX1kT+RM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9896206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRiKD-00010K-1g
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 14:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rosen644835@gmail.com>) id 1iRiGI-0006aA-Rv
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 14:43:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rosen644835@gmail.com>) id 1iRiGH-0006jc-HF
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 14:43:38 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rosen644835@gmail.com>)
 id 1iRiGH-0006iq-AT
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 14:43:37 -0500
Received: by mail-wr1-x443.google.com with SMTP id v9so18536816wrq.5
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 11:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FCWOfgHjogs+ZHLfec3iiRsV4fR75+riOa9yclc5WgY=;
 b=fX1kT+RMbsmFV3mDrKTdsKAwLbaT+CHNxOshoKmW0WERHK6eZFKBMOkMNgHM5Bqrin
 ANre1obHzRBx38UFoa32SYyfMD/KWGqxnyWo58XOAONUp3emmyPhcfbYwPr9b5HbMKFI
 pwwguHW50nQWWtcfWbw6naEbzK9BAs0rVHOt8uTABElpbUooJE+iQSyaBmjVEeZsY+df
 R0kNhvc63LBYEMwVO7NFDYWMFAEAJj8WqbS20FHsBheypq1+xQD/TYVsQX9DpvUBkckJ
 dBLd8dXhsVNyd3T/1Nt1nWpuR5lWY/D0ibXivy2ZnWnPq2uMeQk1jhY1pHRpIbmGCh6e
 Sh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FCWOfgHjogs+ZHLfec3iiRsV4fR75+riOa9yclc5WgY=;
 b=suaPe3sJ7f52Od9AEqdBqxzJjanco7WWNRAbO43IYuY1Rq5MwF+fiqxiEEmgHAZ++q
 OxrGDjlhkx0xKmD7AltycZ6RxiXwJM8OWsuWaHoghZNYebKPfDxgJ7xVw0Vltb42qzj4
 Wmzmh1st8mE9YhuadlxmR90zwRCZu7Hsv5DNBhM190jS9my9d4uBp3QTZrqKOx0VIK/g
 nD/4Av6xXCCUV02gRYO6r8HAAvQ/qPeISWlz37rnz53Gp1uzV1kICbQsAyZQZDDMXX2f
 xHWSLxylHdvz1PHVXrUQzM0ReJimhYrKlHk5g3C9ApwTvWs16ZUBtzbk7OOPjua+qCni
 5EaQ==
X-Gm-Message-State: APjAAAUIuOqf/qTaXTlapC1/yfXSv52AYhpXC6FdXhMYJuaDkGs5GtSC
 qn9NGFXnduHI8UvFGzBSXxo=
X-Google-Smtp-Source: APXvYqztGLfkX9qXHYDrW93+KsQGOC1vARBk9E9HH+1VrmT82NfpzeBEN8gFkf9JGeOYY8yXouJ5qA==
X-Received: by 2002:adf:fd08:: with SMTP id e8mr4032690wrr.42.1572896614937;
 Mon, 04 Nov 2019 11:43:34 -0800 (PST)
Received: from localhost (207.pool85-48-187.static.orange.es. [85.48.187.207])
 by smtp.gmail.com with ESMTPSA id
 f14sm19444367wrv.17.2019.11.04.11.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 11:43:34 -0800 (PST)
Date: Mon, 4 Nov 2019 20:35:23 +0100
From: Miguel Arruga Vivas <rosen644835@gmail.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [Qemu-devel] [Fail] tests/test-util-filemonitor fails
Message-ID: <20191104171624.6e62c112@gmail.com>
In-Reply-To: <20190809091214.GD13660@redhat.com>
References: <20190808020723.GB26938@richard> <20190808080229.GA2534@redhat.com>
 <20190808084653.GB32524@richard> <20190808092213.GB2534@redhat.com>
 <20190809000609.GA4201@richard> <20190809091214.GD13660@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: marcandre.lureau@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Daniel,

I've been trying to open a bug in launchpad about exactly this, but it
always raises an error when trying to log in.  Then I found this
thread diving into the archives, so I'll try to kindly ask here about
it.

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Fri, Aug 09, 2019 at 08:06:09AM +0800, Wei Yang wrote:
> > On Thu, Aug 08, 2019 at 10:22:13AM +0100, Daniel P. Berrang=C3=A9
> > wrote: =20
> > >On Thu, Aug 08, 2019 at 04:46:53PM +0800, Wei Yang wrote: =20
> > >> On Thu, Aug 08, 2019 at 09:02:29AM +0100, Daniel P. Berrang=C3=A9
> > >> wrote: =20
> > >> >On Thu, Aug 08, 2019 at 10:07:23AM +0800, Wei Yang wrote: =20
> > >> >> Current qemu fails tests/test-util-filemonitor. =20
> > >> >
> > >> >You'll need to provide more info. The test works for me and
> > >> >passes in all the QEMU CI environments.
> > >> > =20
> > >>=20
> > >> The error message from my side is:
> > >>=20
> > >> /util/filemonitor: Expected watch id 200000000 but got 100000000
> > >> **
> > >> ERROR:tests/test-util-filemonitor.c:665:test_file_monitor_events:
> > >> assertion failed: (err =3D=3D 0)
> > >>=20
> > >> What else you'd prefer to have? =20
> > >
> > >Can you set the  "FILEMONITOR_DEBUG=3D1" env variable before running
> > >the test - it will print out lots more info
> > > =20
> >=20
> > Here is the output with more info.
> >=20
> >     $ FILEMONITOR_DEBUG=3D1
> > QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
> > tests/test-util-filemonitor =20
>=20
> >     Rmdir /tmp/test-util-filemonitor-151B6Z/fish
> >     Event id=3D200000000 event=3D4 file=3D
> >     Expected watch id 200000000 but got 100000000
> >     ** =20
>=20
> Ok, so the kernel is sending the events in an unexpected order

I've been reading about the issue and as far as I understand the inotify
man-page[http://man7.org/linux/man-pages/man7/inotify.7.html], section
"Dealing with rename() events", points out that the order nor the
atomicity of the concurrent events is something that should be relied
on.
=20
> >     ERROR:tests/test-util-filemonitor.c:665:test_file_monitor_events:
> > assertion failed: (err =3D=3D 0) Aborted (core dumped)
> >=20
> >  =20
> > >Also what operating system are you using, and what kernel version

We have hit this error on GNU Guix master
[http://issues.guix.gnu.org/issue/37860]. I'm using linux-libre 5.3.4
on x86_64.  It does not seem to be something deterministic, but I just
commented out the test the fifth time I've hit the same error.

Is there any way to change the test to not rely on the ordering of the
events from different views of the same fs action?

Best regards,
Miguel

