Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B423AC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 08:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F9A0215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 08:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+xZ0ypN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9A0215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFDkj-0006SP-Lx
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 04:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iFDjs-0005q6-96
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 04:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iFDjr-0003Gs-0M
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 04:42:31 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:40211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iFDjq-0003GB-Mv
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 04:42:30 -0400
Received: by mail-wr1-x42d.google.com with SMTP id l3so14367278wru.7
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rnvHtD+xr/rpgCrlte/af+UsvQKMk3NYmQC6LWT3qCo=;
 b=K+xZ0ypN2phdJRGTPaK3m1/bAKsAxfsK3FzcuJe+VJacP7pFUvzs18jOW4Sozd+//r
 2bu1x+JwKYWE86+1QY9NrjuwCRkv+M55Kqc6eVZwGK6dzZq/kbFpHCRT9e4JdX0i3IcO
 JjPyrHUFngIGnQi0D7Tpg5/lP13Z9m2Vl+EeULn8p5nsTeccEdZ+QO8FKriQaDUPq8a6
 BieElUdbxysjWH6TuLJS78lz7SKFXQKpuT6JsUCqs+dmuB3vHZv5Wgb1bv26n2vv9dX8
 vnh59N8BMp4UURrcP+V8UurbDLk/A2ertSZq/0DAdSeNjWIMuc3IGrmFDfurmcL6/G+J
 SXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rnvHtD+xr/rpgCrlte/af+UsvQKMk3NYmQC6LWT3qCo=;
 b=JrHn71g1uHFQaOViFrBWGyrBiCYNmwjkf9nQWIGTKQnzJPNBNLgl3yGzfnPM0gGbZt
 PX2yjjVDgANdPy2FE+T78QUJeBItDRknF/y0YXD1nqKz8hAHyPfF3+/+r+N4mYh9EusU
 3goa5XQrCe2m0UzdO3BdIJalhgck1EsDDI6Snzq1W3q/ppJ26bHtNPwy63cLB2GvCWeC
 cz/oYz8t/YcdAvlp5J5f9LfclqF0LLHMjxbsffsaa/O/t8b6ZcdpCjxWf3EAejevAPqk
 B0hXbdzORRqXKqv7s7UvaeregJCvOGvojZxpxa6GtH0NzNFZ89lwyiQZELXFWfQgftkb
 24KA==
X-Gm-Message-State: APjAAAUY7ds+WJmFJi6wzuomFz+eRzHBFO1niZQJZx1rC++BCEE/WQbe
 71dOPpcOJI+XkdOzjd0bS3/J9w==
X-Google-Smtp-Source: APXvYqyJ1dRR4LGPeUbmVonc29GVKoSSAObBouwPL8QcMeaTLV4yxwbQ256PD+f2gYXVjaeSzNuXkA==
X-Received: by 2002:a5d:4751:: with SMTP id o17mr1040000wrs.113.1569919349378; 
 Tue, 01 Oct 2019 01:42:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w22sm2375865wmc.16.2019.10.01.01.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 01:42:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 007F71FF87;
 Tue,  1 Oct 2019 09:42:27 +0100 (BST)
References: <CAEfK_44VEF17nRgzNvVe+MPmAfS34kiJ_ozubWFkVYV0rm71sw@mail.gmail.com>
 <CAFEAcA9nz9S4R+O9fwa0k38dB3r1smguG4bQRzwm1s0zJCvfDA@mail.gmail.com>
 <96703fc4-cbeb-5487-89b2-78c37b40237a@redhat.com>
 <87ftkdlhet.fsf@linaro.org>
 <9cdb8f02-0aa4-f0ec-d482-244e346bfc96@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Lockup with --accel tcg,thread=single
In-reply-to: <9cdb8f02-0aa4-f0ec-d482-244e346bfc96@redhat.com>
Date: Tue, 01 Oct 2019 09:42:27 +0100
Message-ID: <87eezwluvg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Doug Gale <doug16k@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 30/09/19 21:20, Alex Benn=C3=A9e wrote:
>> Does seem to imply the vCPU CPUState is where the queue is. That's not
>> to say there shouldn't be a single work queue for thread=3Dsingle.
>
> Indeed it doesn't.  I confused this with commit a8efa60633 ("cpus: run
> work items for all vCPUs if single-threaded", 2018-11-27).
>
> Are you going to make a patch to have a single work queue, or should
> I?

What's the neatest way to do it? Are you thinking just special case
queue_work_on_cpu to special case first_cpu when mttcg is not enabled?

--
Alex Benn=C3=A9e

