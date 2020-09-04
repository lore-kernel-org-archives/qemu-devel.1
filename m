Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59791C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 10:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B55207EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 10:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4SMCZsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B55207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE8aM-0005hu-8J
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 06:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kE8ZZ-0004po-Sl
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 06:03:57 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:36910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kE8ZX-0001XF-JN
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 06:03:57 -0400
Received: by mail-wr1-x42a.google.com with SMTP id z4so6144935wrr.4
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 03:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uSU4mKqU1WRx0u9JIqv+z3VDBNKKZEUGHTucVYR/fWs=;
 b=c4SMCZsVZhEqxuPYKblMMELX8QN0ja+i2GaBTV5/A8+JD3qLU71hyHOjtJGtvL8nCk
 IDkkhB+ub3DOyiRwJwvC69gxIsdUBRFDCsOEuy1b5s+IZoBYJpPUm2rUaEOX7tzBoPup
 JQaxkFdvFiUw55fvmSfdTcvASO9ihunDWn8FCo/LttENPRZPns9zWcJFNcfJUadQysL3
 uVTdMuhra4W4nALSnEvAfuI3LdSARRRRs1YwbajGyjSGBlK/82HdQP+sH/LcpG5ptFmG
 jROylhV18Uoji4tS02Li8nHDz78qRpD43tpp7Pm0NvHPTyFP4C9cAqhBJblTigs07eVI
 tw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uSU4mKqU1WRx0u9JIqv+z3VDBNKKZEUGHTucVYR/fWs=;
 b=pmQ7yZ+gENUNkoADzlRQSori5XcEhePsT1pMrcEu4oxgWj/Z9F000BTOH2vVUAQyRN
 FkThGASzHlS8NRP2RB+fLQoBjXKRiTHz5hQ5+QQktrqqdbH/Y3W30avWC0S79h7vtrf6
 FMiUAvI037bv+7r5AtdNXUhbWpKv3WFT+FKnuoj5qtBLbtXhLuPueZee1nWhBxHNsoKG
 Dt6bKYbB05hJeqN6j6TKuPyT27PuzFhveqhB02uD00nQHVLnUt8niqiqa5bUR1QxaEWI
 3Hg1xeBoMOVn+JpEtiOCItQ+L5zvtOe3F9EGDOL3xKYgfhyjVb5ZQgA4Ih8Mo2DuZxbV
 33wg==
X-Gm-Message-State: AOAM530Q0Ca07TnQdZO+veV4pDN57tu6cEOphZ5ByPTtRqrCt62wNvDR
 HZXYwdDmvnTxOggfsLCfJ9ozQg==
X-Google-Smtp-Source: ABdhPJygba4VRX4LUCVnwaumCfPbZUCd9NU0T4cwKwhNhW5gFvzj/puTzizMXU1h+bc4LIXv+fZexA==
X-Received: by 2002:adf:c404:: with SMTP id v4mr6705823wrf.17.1599213833482;
 Fri, 04 Sep 2020 03:03:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n11sm10259564wrx.91.2020.09.04.03.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 03:03:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 797F21FF7E;
 Fri,  4 Sep 2020 11:03:51 +0100 (BST)
References: <20200903112107.27367-1-alex.bennee@linaro.org>
 <20200903112107.27367-9-alex.bennee@linaro.org>
 <CABgObfZCiQZ2RhriWj+xmCuYfAXVkXmAAJFKpNA7VS0avo4qUA@mail.gmail.com>
 <8cddf56b-4115-579d-d4eb-524d2cad1385@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v1 8/8] migration: use pstrcpy to copy run state
In-reply-to: <8cddf56b-4115-579d-d4eb-524d2cad1385@redhat.com>
Date: Fri, 04 Sep 2020 11:03:51 +0100
Message-ID: <87d0315054.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, Juan Quintela <quintela@redhat.com>,
 stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org,
 qemu-devel <qemu-devel@nongnu.org>, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 stefanha@redhat.com, marcandre.lureau@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 9/3/20 2:13 PM, Paolo Bonzini wrote:
>> Il gio 3 set 2020, 13:21 Alex Benn=C3=A9e <alex.bennee@linaro.org
>> <mailto:alex.bennee@linaro.org>> ha scritto:
>>=20
>>     The gcov build triggered:
>>=20
>>       ../../migration/global_state.c:47:5: error: =E2=80=98strncpy=E2=80=
=99 specified
>>           bound 100 equals destination size [-Werror=3Dstringop-truncati=
on]
>>           strncpy((char *)global_state.runstate
>>=20
>>     As we shouldn't be using strncpy anyway lets use the suggested
>>     pstrcpy.
>>=20
>>=20
>> This is wrong, we want the all-zeros behavior of strncpy that pstrcpy la=
cks.
>
> FWIW links to previous discussions:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg584216.html

Hmm I wonder why gprof interfered with the assert. Either way I'll drop
the patch.

>
>>=20
>> Paolo


--=20
Alex Benn=C3=A9e

