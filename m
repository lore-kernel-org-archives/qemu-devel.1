Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EFCC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 08:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2770E2073E
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 08:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="howMDJVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2770E2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwiBv-0005um-93
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 04:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1jwiBH-0005Br-1H
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 04:26:51 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:34558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1jwiBF-00073Y-6J
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 04:26:50 -0400
Received: by mail-ej1-x62c.google.com with SMTP id y10so13285528eje.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2020 01:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Am5CUqmKpyGWr6oxn5dv5qUF34Ei1+z0p6EziGYaZo0=;
 b=howMDJVOHUYcxqWB7zoHedkfBxwSzMCIy9HY815JfObzFadNDqDG3DOvz3MNuTmO3O
 CiWoHPEgjVMy7i51wXMiDDbbfGEsD07eXX6UIpYQ6f5wwt4EegtGT/lrGG95bg3c4L39
 L6/7PdCIua55I1YmejaBQzuky8qNikRyOwAWf76NKtZz+kCIWA6pvQDiOvMER9tGYcG4
 DgkFF3fVQXvFTOdPMd61lc1+Fm5P4nFfDHlz60slmDPkCeR8UznjGjnS/EIeOHbHogcR
 Vhlr44KaeE+jcXzMLmsx/8McDL4F24eKZulTWpRmLFUMEEGkpzPpJ9rcHQNWI886E/O2
 5xDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Am5CUqmKpyGWr6oxn5dv5qUF34Ei1+z0p6EziGYaZo0=;
 b=HzRoe3LVMtbJoEMQUm0JX0To57NviQvDOIAi7GhDzTPpISaaf6xAT7pYOdSt/TxFOf
 dmrmHDX2debnLFZdX/1UM1OgF434rxDwAbK6X0zeayowK4Cx+jnL+vY0WTEUuAwi3WLy
 i4n8a7si+XQVD2lkJa/CVoi0D32+8/2cFSr/xOsXtZf08rfF0KNHRpTWgUFW0Y7LPJCg
 CE+xweb13rCg7tUllFgNt6MDicIczM1SDdrEKKOQAIIKDTaUrckkTwPP2Qw6+krJUsVU
 4EA3H4fgv6MMLa7eY9bprE3J/4xiGcLbSwPyBSr6UyvYyFrcs1PhKHajmbeDKfQIlLm3
 PiXg==
X-Gm-Message-State: AOAM532M7SXvm7fTmM+M4LpdWMX4LSlVrLa3EwI+JqG69JZWQxYCDrio
 LS26EFS2vwOkHW9n2w2rYHSrEw==
X-Google-Smtp-Source: ABdhPJyzr9IaK16nQzsiRT/jMIzz+PjPtggOovldHvjXomNn2+XutoJZMdLLOhRaR6qw9CFb/fYRag==
X-Received: by 2002:a17:906:b217:: with SMTP id
 p23mr12518059ejz.98.1595060806146; 
 Sat, 18 Jul 2020 01:26:46 -0700 (PDT)
Received: from wks.local ([188.26.49.79])
 by smtp.gmail.com with ESMTPSA id 23sm10699468edx.75.2020.07.18.01.26.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 18 Jul 2020 01:26:45 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: instance_init() and the realize() functions
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <CA+aXn+E2r1ZFyd1AZnwyvnxB1VsStkJC8vqkhmqZ4JDE_0LwMg@mail.gmail.com>
Date: Sat, 18 Jul 2020 11:26:44 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <FEBB6630-0908-4097-BA78-ACB12932703A@livius.net>
References: <CA+aXn+E2r1ZFyd1AZnwyvnxB1VsStkJC8vqkhmqZ4JDE_0LwMg@mail.gmail.com>
To: Pratik Parvati <pratikp@vayavyalabs.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Received-SPF: none client-ip=2a00:1450:4864:20::62c;
 envelope-from=ilg@livius.net; helo=mail-ej1-x62c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 18 Jul 2020, at 10:09, Pratik Parvati <pratikp@vayavyalabs.com> =
wrote:
>=20
> The class_init() function is straight forward (it is similar to the =
constructor in C++ OOP

The C++ constructor initialises class **instances**, i.e. C++ objects, =
not C++ classes.

In QEMU, the OOP functionality is implemented with nested structures =
used to store class and instance definitions, and callbacks as virtual =
methods.


The .class_init callbacks are called early, by a mechanism similar to =
C++ static constructors, and they initialise the structures used to =
store the class definitions. They are recursively chained, i.e. first =
the parent callback is called to initialise the parent structure =
members, then the current callback is called, to fill in its own =
members.

The .instance_init callback are automatically called when new =
**instances** of a class are created. Similarly, they are also =
recursively chained.

.instance_init may also create children objects, recursively.


.realize is a bit trickier. If .instance_init is the very first thing =
automatically called when creating an object, .realize is the very last =
thing, it is called manually when the whole hierarchy of objects is =
created and it signals that everything is ready, a kind of 'rien ne va =
plus'.

.realize usually has to manually call the parent .realize.

---

For me it was difficult to draw a line of what initialisations should be =
done in .instance_init and what in .realize, but given that .realise is =
called when the whole hierarchy is ready, it might do links between =
objects, which are not available when .instance_init is called.

A simple rule would be for .instance_init to ensure that all members =
have default values and properties associated with them, and defer all =
functional initialisations to .realize.


Hope this helps,

Liviu















