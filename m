Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9423CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 21:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B21214B2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 21:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lkIyYfit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B21214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN1Xa-0006YR-7t
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 17:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iN1Vu-0005no-Je
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 17:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iN1Vt-00083r-At
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 17:16:22 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iN1Vt-000839-35
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 17:16:21 -0400
Received: by mail-wm1-x341.google.com with SMTP id b24so17487554wmj.5
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 14:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1ritQ+OawXqe3VoqbbZUsskk6zEebrHgRGEunLc3bsA=;
 b=lkIyYfit97yr8/KIh+JIZgH0iYPZnOwxx7Ouu0DSDpmYmZKY8KLzIBar0USXilkVk8
 gghzpe3meh8CZsXbid2LCpn0613rzskfKgOoN6vkkW11gCqsAW+sPsNnFRS0aiPiK7sx
 YZMKt952QVEoYKbqKCagTMjMz80onHBK4QNbosIYVHXhOc0cOeJ+pxzh/jdzT0HQBApW
 TpnlUucHvh9uofmT/KpfFSO14VnPPE6nWoi9yA4DImQ1qKaczBQHLQOZKE5VpYIyTkjz
 YCNvs5JBacZRpHTJ32syigC2c5BKWcREmIi+5trRqX2XegjVlnwg++1ztzOC3jt3fRq5
 7mFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1ritQ+OawXqe3VoqbbZUsskk6zEebrHgRGEunLc3bsA=;
 b=sLVA/eFodZeyjV/2n+g3Yl6gXe8YqWbw9kyxMc/fPuwBuL/xEGH42NI6eDxDFODbqk
 nJHk1xIIHoMNvhCsksxiSIj8QbWg5VI1hANhutyWYjCfswf0u/aVcxJ+iuUJZBiugJB7
 40IH/qOlZCOup+ySkW8Jt6wfDTBSw+B8SAShfpMR3u18ioloLU843lzPYi2kuIaDXa5p
 zbvXF5Km8sWEcBASLlLBS09gj/BV0wK79r6YPgdJb7hQFpyDB0lE68N3++KOZXYZM65A
 otu5wD70d1LZ50cu3l2rxQqn/ijZ3O5DvgPgJBpYjA4VnrMV/uXDgdRsbvLV99eGuXYq
 36KQ==
X-Gm-Message-State: APjAAAUCUpL+zmS4l56NfJCjm9lIzI3N78i+5vJ4VENvGiLJ0SC3ad1J
 Wknmz+XxwosIxJ3OjHvqCaJDDw==
X-Google-Smtp-Source: APXvYqzxSWjW1PDWRYAU8xlF7VUVeV97WFJWvu33yBW0NCcT2QHLxpeIYzUZ6FRoj9zxLnCE2OJgbw==
X-Received: by 2002:a1c:4e15:: with SMTP id g21mr4407556wmh.148.1571778979082; 
 Tue, 22 Oct 2019 14:16:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g11sm18857303wmh.45.2019.10.22.14.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 14:16:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8E0531FF87;
 Tue, 22 Oct 2019 22:16:17 +0100 (BST)
References: <20191022072135.11188-1-thuth@redhat.com>
 <87a79sx6uc.fsf@linaro.org>
 <123b2e94-3f43-1a8e-2420-12ae09483e2f@redhat.com>
 <877e4wx55f.fsf@linaro.org>
 <dcbf2d6d-f7df-7bcf-78a0-bf1964663d3b@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 0/6] Enable more iotests during "make check-block"
In-reply-to: <dcbf2d6d-f7df-7bcf-78a0-bf1964663d3b@redhat.com>
Date: Tue, 22 Oct 2019 22:16:17 +0100
Message-ID: <874l00wkf2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 22/10/2019 15.48, Alex Benn=C3=A9e wrote:
>>
>> Max Reitz <mreitz@redhat.com> writes:
>>
>>> On 22.10.19 15:11, Alex Benn=C3=A9e wrote:
>>>>
>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>
>>>>> As discussed here:
>>>>>
>>>>>  https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg00697.html
>>>>>
>>>>> and here:
>>>>>
>>>>>  https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01388.html
>>>>
>>>> Queued to testing/next, thanks.
>>>
>>> It should be noted that this series depends on my SOCK_DIR series (which
>>> I have in my block branch), or the newly added tests are likely to fail
>>> in the CI environment.
>>
>> Ahh I misread....
>> <snip>
>>
>>>>> it would be good to have some more valuable iotests enabled in the
>>>>> "auto" group to get better iotest coverage during "make check".
>>>>>
>>>>> And once Max' "iotests: Add and use $SOCK_DIR" patch series has been
>>>>> merged, we can indeed enable these Python-based tests, too.
>>
>> I though these weren't enabled in this series. Do I need to drop all the
>> patches?
>
> I think it's better if the iotest patches go through Max' or Kevin's
> block tree.

OK I can drop them from my tree.

>
>  Thomas


--
Alex Benn=C3=A9e

