Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CC4C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892A4206D3
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmIqn9fg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892A4206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJw18-0003Q9-LD
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 05:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJw0W-0002ub-HP
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJw0V-0006V3-25
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:19:28 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:41800)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJw0U-0006Ur-Rc
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:19:27 -0400
Received: by mail-wr1-x434.google.com with SMTP id h9so3270384wrc.8
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lawQHY34iyxvcPzgvRM9obOKitLdPP16oBDM81cQ+hg=;
 b=BmIqn9fgTp7EC1bBYVnwS+2fQUyKMaQXeQUWeOFzo8ucg6UeigMod65rBufDpLj3vq
 sOS/vWHJRD+/VO2wMIG07T3GbBeNSWVAM+OkH/x5Ouns2k0GIqmzj09su5wxLi8Ywoeu
 PkY3zeZDjkkbwzSoavQwC3wqJa31eE5Y9b67Z447smmZq1EltwflviKHRRi6ktmLhHhW
 5Us+dOEnyl7OMSLnAHYDXdx0LL79cHJpt+szba2aEj1gRH8fo5rU8xp43YESamF4mf43
 al6f8xrk3OWWF8UAJKLtvBOgwC9LH+Iwn2bzL4M0zvrWxJtrZIS0CPSfAKcjI/tr1jP+
 m+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lawQHY34iyxvcPzgvRM9obOKitLdPP16oBDM81cQ+hg=;
 b=bXT+IB2Rog3AM26xYSTWlC/BYtqR3Xzd35LtrJQNqIeh4DhTyLD4RDYQGiXTetXQ9B
 wtH4trfvKOP3+AeTJTGM2L6QAOueB2xHojFw3+Q0KIgzTsWsnQEFpzKel1Tw+xvnpebs
 woIyemXmXd91utOwe55GvlRCsmkjO+8auhuvjDEG1ufAk6znqpGqGDbKaZV/vXH+7U6j
 XCAYlnIm6l3ST4xe1elWDmhu9tNVRtP7Fv0KnKBBn3dNXFVqjzQ1ZVXCwk/wSP+lO2Ga
 rie227F9kzVdon+O/K6LSFn7Xx6nEr93RaM25MVUp0aGIaGkn9bnbgpOd0ukN7brIYlX
 qpGw==
X-Gm-Message-State: AGi0PubuoIcq2Z/SRrtWG+3zOrsEksqAEeTJ8pJx7U6wwBtgfwDJKGXI
 loaDkLoooPz6lf6tWtuLvaTQNQ==
X-Google-Smtp-Source: APiQypLUvCwbQgMjIbHVdknu84NVSPLf7foHVUl+9x4QcaqTBpKtk44vyLEh9/1z8j9C9wuzAGcOnw==
X-Received: by 2002:adf:ce0d:: with SMTP id p13mr2471828wrn.8.1585819165512;
 Thu, 02 Apr 2020 02:19:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r9sm6439041wma.47.2020.04.02.02.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 02:19:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AD61F1FF7E;
 Thu,  2 Apr 2020 10:19:23 +0100 (BST)
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
 <87sghmbfgc.fsf@dusky.pond.sub.org> <20200402084719.GB423991@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: Questionable aspects of QEMU Error's design
In-reply-to: <20200402084719.GB423991@redhat.com>
Date: Thu, 02 Apr 2020 10:19:23 +0100
Message-ID: <87k12ydz38.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Apr 02, 2020 at 07:54:11AM +0200, Markus Armbruster wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>=20
>> > On Wed, 1 Apr 2020 at 10:03, Markus Armbruster <armbru@redhat.com> wro=
te:
>> >>
>> >> QEMU's Error was patterned after GLib's GError.  Differences include:
>> >
>> > From my POV the major problem with Error as we have it today
>> > is that it makes the simple process of writing code like
>> > device realize functions horrifically boilerplate heavy;
>> > for instance this is from hw/arm/armsse.c:
>> >
>> >         object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
>> >                                  "memory", &err);
>> >         if (err) {
>> >             error_propagate(errp, err);
>> >             return;
>> >         }
>> >         object_property_set_link(cpuobj, OBJECT(s), "idau", &err);
>> >         if (err) {
>> >             error_propagate(errp, err);
>> >             return;
>> >         }
>> >         object_property_set_bool(cpuobj, true, "realized", &err);
>> >         if (err) {
>> >             error_propagate(errp, err);
>> >             return;
>> >         }
>> >
>> > 16 lines of code just to set 2 properties on an object
>> > and realize it. It's a lot of boilerplate and as
>> > a result we frequently get it wrong or take shortcuts
>> > (eg forgetting the error-handling entirely, calling
>> > error_propagate just once for a whole sequence of
>> > calls, taking the lazy approach and using err_abort
>> > or err_fatal when we ought really to be propagating
>> > an error, etc). I haven't looked at 'auto propagation'
>> > yet, hopefully it will help?
>>=20
>> With that, you can have
>>=20
>>         object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
>>                                  "memory", errp);
>>         if (*errp) {
>>             return;
>>         }
>>         object_property_set_link(cpuobj, OBJECT(s), "idau", errp);
>>         if (*errp) {
>>             return;
>>         }
>>         object_property_set_bool(cpuobj, true, "realized", errp);
>>         if (*errp) {
>>             return;
>>         }
>>=20
>> but you have to add
>>=20
>>         ERRP_AUTO_PROPAGATE();
>>=20
>> right at the beginning of the function.
>>=20
>> It's a small improvement.  A bigger one is
>>=20
>>         if (object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]=
),
>>                                      "memory", errp)) {
>>             return;
>>         }
>>         if (object_property_set_link(cpuobj, OBJECT(s), "idau", errp)) {
>>             return;
>>         }
>>         if (object_property_set_bool(cpuobj, true, "realized", errp)) {
>>             return;
>>         }
>>=20
>> This is item "Return value conventions" in the message you replied to.
>
> Even better, we can then string the checks together
>
>         if (object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
>                                       "memory", errp) ||
>             object_property_set_link(cpuobj, OBJECT(s), "idau", errp) ||
>             object_property_set_bool(cpuobj, true, "realized", errp)) {
>              return;
>         }

You know at this point I wonder if we can't come up with some data table
that describes all these object interactions and a helper function that
processes it and tells us if it worked or not?

We are essentially just filling out an data structure anyway with all
this stuff.

>=20=20
> Regards,
> Daniel


--=20
Alex Benn=C3=A9e

