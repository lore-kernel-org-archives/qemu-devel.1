Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2F9C4742C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3CC206F9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jk6wanU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3CC206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZd50-0003hG-Pf
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 11:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kZd2u-0002Br-2X
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:51:06 -0500
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:43343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kZd2q-0003RL-1b
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:51:03 -0500
Received: by mail-vs1-xe44.google.com with SMTP id f7so2044845vsh.10
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 08:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wbrbG9ukBQgWC7v+i0ha5DcgXvXrBCVKYGR1HshYXAQ=;
 b=Jk6wanU6OzFlgeH9+HOxpQxN6tjjZ95SGZwkiEL6sdp1O4jzZPrvzBtCs7eZL1OZi8
 XBqJqfHNLNTt5rKooe6mKj7osmGhr/uZwJYvEDZe0DppGU7E7MhKHmnx0jQSJQS+zkRu
 OFmdyOEyMYjXvoMY6XkpXuP6Dg4TsGDuMS63jMq3IPJBGM3tv+s2kEQlWLMTqcB9FEsO
 T4Ed+eLwlqQv5M4ublYDFLMAWAIuUu2C8KRdpjdMSaZsPLYjUzSajMJUFFWDPpb8+qZF
 7AG4ZwWPH4fsCsnCNcnqNI7zld0cLw0P1QuaxcoL3ZQYj/KkfBUA40srmzDQPLhuJM91
 rr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wbrbG9ukBQgWC7v+i0ha5DcgXvXrBCVKYGR1HshYXAQ=;
 b=YoIcXeW0UUYvT4WAOuJhaHGHiB5G/32GqoLtiPHZ/fu/KEwEQ6LedFVGLwLLN/ZjtY
 b539eyvW8GNQ3LCMaq46tzeG+cbVDYefBzGIcOclY5MZXsZigd+cL5JMPyaW3x8VPWEt
 48e/FqbfLpnv5N+3AkEqr2zc8NrHZ1Ji5gzdbGHVf4PhPkh26mSDU+1C0BRfgD/fG0Jc
 7Z0xRXZuXXd+BwzO7uZcO8MtWHffjAr5rSIIeL2woolz8S6rDEAMX2OSi+Y7bn7Hjo5l
 xPOusU1nNEqABPK26BFFU2+zpjA6Z3Lucr5v0CgxMWFzjJvbKCFuDXO3Dq5w9dqc0//M
 tBpw==
X-Gm-Message-State: AOAM531NVG7KdFTIx8w62E7kS83vJeRq+kb5+g5HqZDU36iuA/MDtwX8
 hwYu9jsOSH5aMxgzuo92Zh/pAnE7GzPSuHJQWk1PXA==
X-Google-Smtp-Source: ABdhPJyhINS/dz3a73Gzja6CgicXbT4voJfJ62oV/249+zNErKHzLXRdkYVUJhcR6kUDr0geAvPEJXn72d1qhTBzp5g=
X-Received: by 2002:a67:3256:: with SMTP id y83mr9493078vsy.48.1604335858220; 
 Mon, 02 Nov 2020 08:50:58 -0800 (PST)
MIME-Version: 1.0
References: <20201023210637.351238-1-hskinnemoen@google.com>
 <20201023210637.351238-5-hskinnemoen@google.com>
 <CAFEAcA8YvmFA7=7+CGVpubVScuKPdy+OQdmJdfMD+Fmk+Hb0SA@mail.gmail.com>
In-Reply-To: <CAFEAcA8YvmFA7=7+CGVpubVScuKPdy+OQdmJdfMD+Fmk+Hb0SA@mail.gmail.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Mon, 2 Nov 2020 08:50:47 -0800
Message-ID: <CAFQmdRZOKLb6=NJoeY9U3eYq3rbG_OWGFDDZdGTf8vjVOA11TQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] hw/misc: Add npcm7xx random number generator
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 CS20 KFTing <kfting@nuvoton.com>, 
 Patrick Venture <venture@google.com>, Hao Wu <wuhaotsh@google.com>,
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e44;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 2, 2020 at 3:36 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 23 Oct 2020 at 22:06, Havard Skinnemoen <hskinnemoen@google.com> wrote:
> >
> > The RNG module returns a byte of randomness when the Data Valid bit is
> > set.
> >
> > This implementation ignores the prescaler setting, and loads a new value
> > into RNGD every time RNGCS is read while the RNG is enabled and random
> > data is available.
> >
> > A qtest featuring some simple randomness tests is included.
>
> > +int main(int argc, char **argv)
> > +{
> > +    int ret;
> > +
> > +    g_test_init(&argc, &argv, NULL);
> > +    g_test_set_nonfatal_assertions();
>
> While I was looking at this test case I noticed that it
> calls g_test_set_nonfatal_assertions(). Why does it do that?
> In our entire set of tests, only the npcm7xx test cases call
> that function, and they don't explain why they're a special
> case that needs to do so.

It's often useful to see more than the first failure when debugging
tests. Using the randomness flakiness as an example, it's very useful
to know if more than just one of the randomness tests fail. If I
remove g_test_set_nonfatal_assertions, I get:

**
ERROR:../../../tests/qtest/npcm7xx_rng-test.c:256:test_first_byte_runs:
assertion failed (calc_runs_p(buf.l, sizeof(buf) * BITS_PER_BYTE) >
0.01): (0.00204666737 > 0.01)
Bail out! ERROR:../../../tests/qtest/npcm7xx_rng-test.c:256:test_first_byte_runs:
assertion failed (calc_runs_p(buf.l, sizeof(buf) * BITS_PER_BYTE) >
0.01): (0.00204666737 > 0.01)
Aborted

which doesn't even tell me the name of the test that failed, let alone
anything about whether any subsequent tests passed.

Also note that it doesn't provide a clear "not ok" signal, which makes
life difficult for any downstream processing of the TAP output. It
looks like the test unexpectedly crashed.

Compare this to the output with g_test_set_nonfatal_assertions:

**
ERROR:../../../tests/qtest/npcm7xx_rng-test.c:232:test_first_byte_monobit:
assertion failed (calc_monobit_p(buf, sizeof(buf)) > 0.01):
(4.78548397e-05 > 0.01)
# ERROR:../../../tests/qtest/npcm7xx_rng-test.c:232:test_first_byte_monobit:
assertion failed (calc_monobit_p(buf, sizeof(buf)) > 0.01):
(4.78548397e-05 > 0.01)
not ok 5 /arm/npcm7xx_rng/first_byte/monobit
ok 6 /arm/npcm7xx_rng/first_byte/runs

which clearly shows that the "first_byte/monobit" test failed, and the
subsequent "first_byte/runs" test passed.

But none of this is really specific to the RNG test, so I can remove
it if you prefer for consistency.

Havard

