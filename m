Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B322C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 031FA2067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AneMZqLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031FA2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWde-0003c9-Su
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipWc2-00023Y-5s
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipWc0-0004an-Ka
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:08:30 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipWc0-0004Su-5a
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:08:28 -0500
Received: by mail-wr1-x444.google.com with SMTP id c9so7117975wrw.8
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 04:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=pvgMkc8GtlJutYg7wm+ThtN/AGv81cMgc2rTC1/nGe8=;
 b=AneMZqLZKsoU128OKr+v60pRo2s0XhvhddB/ZCcdzSCpZxeddyPeThM6FERI1IkRC/
 L8cndN3k1qznSAhn59RWtCTMVUh2rk1rYDYt+KeTqLprrn++QWaYjwEuuR3q/pebDDwG
 ShuFdhkzW5VC+sr5Bv82+vOALsKtQLkQMGpts8dUU5k52fU1RcRlMQKtX1aVxtlj8kc7
 YOOeAogtvmOuJX9kdJx8yEcY7YVmJfCCV3zzRjkDdgTqLCigj8cwI8J+B/rYzV3E1YEU
 EbcUJRweVkCMY9lSMCC/L0bqCJqDSiNgRsSVuIV2GprcirSv2kp7A49x/rnkZMAkEIII
 7HgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=pvgMkc8GtlJutYg7wm+ThtN/AGv81cMgc2rTC1/nGe8=;
 b=sCzMAAIb6kgpdGOAzKMJsqahWsh1H3EZNrULH6zRS12kR5lSOWDt6RanvI+9tm9uSw
 cHinJaDdhaVwIQ+AMEEBDCXbv9jCCCnfcLb+39FKKDz1qyoHeDvLWT3HohCwM8O/ljRJ
 UbWy8tXASI6mtv3kLqDcv4ZnZL3B2RV2YTRcdxqWsIH/qI3/LLA8aSDzT2BQ5qTcrtTD
 f+7DSC2rVAqa1j7MJR0oWPfZ7ffcLc1C4klnViRDbWOSl3TK7uhr03Ponao8ctZ1OyZp
 T+FensIJobtwIfxcgaZ0+CwKeEM93scAgq/27TWJpVFVaLQ7Z/5dMhsfkp5iUdRf1azV
 hgFQ==
X-Gm-Message-State: APjAAAWKGnhso4MWZxskpx9L1f9E6+wzVVlrDHKnmSoGK1SvCsw6RKXM
 9l5Dm7GVXmTHnYbLLTOVD7mT6g==
X-Google-Smtp-Source: APXvYqyWYeL81c0Vu55BqLLra89FsYZrH40EtqZge2EzRAVozswZnSK836NmaGvI9l/Th9SgvxkYwA==
X-Received: by 2002:adf:d848:: with SMTP id k8mr10220810wrl.328.1578571706422; 
 Thu, 09 Jan 2020 04:08:26 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q6sm8325699wrx.72.2020.01.09.04.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 04:08:24 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 31C531FF87;
 Thu,  9 Jan 2020 12:08:24 +0000 (GMT)
References: <20191211170520.7747-1-alex.bennee@linaro.org>
 <20191211170520.7747-13-alex.bennee@linaro.org>
 <69e10c48-8bdf-cbe0-3372-815b647f8312@linaro.org>
 <87k16sdt4d.fsf@linaro.org>
 <5c6dd0a9-23ba-63ff-5738-8bac11aad810@linaro.org>
 <87eewzdtqg.fsf@linaro.org>
 <81e43d43-29f8-ec56-5270-bb90dd1bc077@linaro.org>
 <889CE29C-C705-4EB4-B52A-62F88A6121A2@arm.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alan Hayward <Alan.Hayward@arm.com>
Subject: Re: [PATCH v3 12/20] target/arm: generate xml description of our
 SVE registers
In-reply-to: <889CE29C-C705-4EB4-B52A-62F88A6121A2@arm.com>
Date: Thu, 09 Jan 2020 12:08:24 +0000
Message-ID: <87muawj0hz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: "damien.hedde@greensocs.com" <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Luis Machado <luis.machado@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "open
 list:ARM TCG CPUs" <qemu-arm@nongnu.org>, nd <nd@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alan Hayward <Alan.Hayward@arm.com> writes:

>> On 20 Dec 2019, at 13:18, Luis Machado <luis.machado@linaro.org> wrote:
>>=20
>> On 12/20/19 10:14 AM, Alex Benn=C3=A9e wrote:
>>> Luis Machado <luis.machado@linaro.org> writes:
>>>> On 12/19/19 4:15 PM, Alex Benn=C3=A9e wrote:
>>>>> Richard Henderson <richard.henderson@linaro.org> writes:
>>>>>=20
>>>>>> On 12/11/19 9:05 AM, Alex Benn=C3=A9e wrote:
>>>>>>> +static struct TypeSize vec_lanes[] =3D {
>>>>>>=20
>>>>>> const.
>>>>>>=20
>>>>>>> +    case 51:
>>>>>>> +        return gdb_get_reg64(buf, (cpu->env.vfp.zcr_el[1] & 0xf) +=
 1);
>>>>>>=20
>>>>>> You need to use sve_zcr_len_for_el to get the effective vq.
>>>>>> Also, I thought vg =3D=3D 2 * vq.
>>>>>>   > +    case 51:
>>>>>>> +    {
>>>>>>> +        uint64_t val =3D *(uint64_t *) buf;
>>>>>>> +        cpu->env.vfp.zcr_el[1] =3D (val - 1) & 0xf;
>>>>>>=20
>>>>>> You cannot hard-code EL1 without ifdef CONFIG_USER_ONLY.  If the eff=
ective vq
>>>>>> decreases, you must call aarch64_sve_narrow_vq.  You must call arm_r=
ebuild_hflags.
>>>>> I'm just going to drop vg (and therefor the ability to set it) from
>>>>> the
>>>>> regset. It was only meant to be an indicator and gdb doesn't actually
>>>>> look to it to size it's output. The likely dynamic extension will just
>>>>> re-transmit the whole XML when a change occurs.
>>>>>=20
>
> [...rebooting self after festive break]
>
> Yes, when using a gdb stub, changes to the VG value should be silently ig=
nored by the
> stub.
> In addition, if the vector length on the system does magically change whi=
lst the program
> is running, then the stub should continue to use the register sizes for t=
he originally
> transmitted XML, truncating/extending the register values as required.
>
> Why? Because once the stub has sent the XML description to GDB on program=
 start, then GDB
> assumes the XML description will never change. GDB will error if sent pac=
kets with different
> register lengths.

Ack. The test "test-sve-ioctl.py" covers this and works as expected.

<snip>
>
> When using GDB a real SVE Linux box without a stub/gdbserver, then:
>
<snip>
>
> Blindly enabling the above when using a stub results in in GDB *constantl=
y* asking the
> stub for a new XML description, spamming the pipe, so this needs somethin=
g more nuanced.=20
>
> I plan on sending Luis my ideas I had for VG changing when using a
> stub.

Is this going to be a more general solution because I'm sure there are
other cases where the XML description is out of date. A big one is
execution modes (thumb/32/64 bit) and I think x86 runs into similar
problems with it's various mode changes in early boot-up.

For now I'll just let qemu provide it's own xml without vg shenanigans.

>>> But this is all special casing for feature
>>> name=3D"org.gnu.gdb.aarch64.sve" right?
>>=20
>> Yes, vg is only available if feature org.gnu.gdb.aarch64.sve is availabl=
e.
>
> Nod.

Thanks and hi ;-)

--=20
Alex Benn=C3=A9e

