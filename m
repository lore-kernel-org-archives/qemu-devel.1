Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1EDC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 19:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CD721773
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 19:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVvLz7LZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CD721773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58784 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ1Nr-0006JB-1T
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 15:47:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amitkumarrathore07@gmail.com>) id 1hJ1N0-0005z8-Es
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amitkumarrathore07@gmail.com>) id 1hJ1My-0000ls-GU
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:46:22 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:37006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <amitkumarrathore07@gmail.com>)
	id 1hJ1My-0000l5-9R
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:46:20 -0400
Received: by mail-ot1-x32e.google.com with SMTP id c16so13975538otn.4
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=8zOFy7yA8T7YdtG155u08K6grwLmP4QiMLCIVx1AYFw=;
	b=HVvLz7LZZG1TNTuXRXqUkyqKMAqTPYOdq29E32A1ThN4RyZyPzkes71GJdPUxByuRu
	t0PRwk/oD2yhsdubY+PC3qo4W57xyFt4748kgaTAuf+I8wtl8dXTCHw5/hAzpriBDhYP
	Foz2kqDczbQEWtNZ1fhvqnLL1dkfM/k0SIJygMQGkjGAMZzJAX3Fqvznr4gK9Uxt+83J
	wpVU2OxrIlRjMdAeyV7oz/CtA4mYjXbUj/I1CEg9Wqw4S6WigFkkSfuxeVN9y8OU+26l
	Op6Xf38Zasn7HIRr8BgBjhsFTGT2iZQyY8wi5M2Kl4WSJxxfd1y9JOe7ltfdfNs5w3BI
	jE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=8zOFy7yA8T7YdtG155u08K6grwLmP4QiMLCIVx1AYFw=;
	b=tiCOpxpzSaIxw25V3bqj5aytGbaypS1WHoJAkAWj2JFlC9ONRUAimOchWM7akeN6vd
	6r+UqvdgswYezpfkhDQxDwgLs14JSeoYbqzYw7csK03LKZl0ZIQIaaqVuq4vSa21N4LV
	7kVO1YSDgf0p8Wx5MqfuQ8gMP5L0XkNa6G1sf+oPGEA6KAMElQPylxV4lr8VW86bpMLi
	XFol24TWQArURi7ey1LaIFZc37ymOw8GpaHjNqZryuQU1HZntMI4DF4YzqFq/UW7cuqo
	Ij53ke5v1jOsFUMrYV97QO3cmkrfIOrjvL12CBPX5LqOr8UkHRyMw5PgsdHJ1j02kcCJ
	l28A==
X-Gm-Message-State: APjAAAU28vPM1RkbFYCKPzdYRTep7JodBLddVtoKoR75YA2FMpOTRbOc
	2jPOEMZhc5CjEyTC+KWBVsPFvKSx/E3f1ArAkxw=
X-Google-Smtp-Source: APXvYqwMit17NMh/5ahOtdYQTYL8i3cWAg/0mkshJwdzz5gFrbADHIVD1KcqiWdP7jcfL80odHb/FKsMWJG2OkknBgs=
X-Received: by 2002:a05:6830:16c3:: with SMTP id
	l3mr17346511otr.359.1556048777352; 
	Tue, 23 Apr 2019 12:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <5cbe25f0.1c69fb81.e0425.9c3b@mx.google.com>
	<20190423135215.GK32465@stefanha-x1.localdomain>
In-Reply-To: <20190423135215.GK32465@stefanha-x1.localdomain>
From: Amit Kumar Rathore <amitkumarrathore07@gmail.com>
Date: Wed, 24 Apr 2019 01:16:05 +0530
Message-ID:
 <CALxb8AG=-65qf2eF9cfAuaUOsWGCUm9yckWAmk-Yu74B+Eo89Q@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Review my proposal
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423194605.0x4n2TQWsA4vDO1ktsymgoy_SlvoM3DgJL_kIWlkcPE@z>

Thank you for your response.

On Tue, Apr 23, 2019, 7:22 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Tue, Apr 23, 2019 at 02:07:03AM +0530, amit kumar rathore wrote:
> > Sir,
> > My proposal is still not review by my mentor. My mentor is JAN KISZKA .I
> already mail him but he not responding me. What I do now? How can I know my
> proposal is view or not.
>
> Hi Amit,
> I am the organization administrator for QEMU.  I can confirm that your
> Google Summer of Code application was submitted.
>
> Google will announce results on May 6th.
>
> Stefan
>
