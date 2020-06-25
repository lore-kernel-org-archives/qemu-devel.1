Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74ADC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE0C2089D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvFo55sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE0C2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUEF-0005eZ-AW
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUCC-0001q9-NW
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:53:48 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUCA-0004Zq-Oz
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:53:48 -0400
Received: by mail-ot1-x342.google.com with SMTP id k15so5688574otp.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 08:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lCqacN0oNjCIot3IKwSzhdFjBZMB9QoxP2p6lBtvsY0=;
 b=rvFo55smgGP6XJ06p9QvUNZMtMZIOjJ/lKRiW+5I00HvfncCSFVfPPjJlMzLnktDlB
 Hp6c9xulhfHs0porL0IBLRy9+GSXbhdUzpUzgjkzPUdVHbEc9ozR9mGKTtWWfsaM6aAb
 4+Y62Y2mcgo3vmbrXozEX2S6+QBddvPLvhhNuGw3/6QvPlx4XUKGmGhaQ9lYRtbzl2Ao
 Uf9JXrNLm7QXVpoP7avbRfIdDjYzjzGvyJVtKIOxaae2AUvBRrtgOvkJh4mXAODwJRCu
 p3qGjQe3hkmZkJMPS6Ad//6Zzh0R7kkAApsvZe71xNSwjYKYE+YYzy2NjzMUCJz3eY/g
 qDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lCqacN0oNjCIot3IKwSzhdFjBZMB9QoxP2p6lBtvsY0=;
 b=MspyuzY+JqDJ610XA99cA7WLPTXwrkYeNKwWVYwPYmht5dv0hPQ/TLOJ2w8HhhPUjJ
 l/O2luIzbTKUj3Krmkhp23Tz8cXUw4urVJVg0Pm5oX47nhC501MGldgwf9vnPM7SDGFK
 vMf+7dJseUgUJHh2usXVj30H5y4dOMIqskxtGL+z6Z7aY2pyvDUlW9/qiR8CIWVSH2jt
 bfzwguGY+kNMLOztlhLvZX1OHLN9hLp1evZrgAq6m0MGQ7UxaVe9I6oqNoH3m8uH37Zz
 rw4efHL70gkrrfcDAwg3NjVj/EbAQczMGbqwvLFWfGXdZ7zRILFZ+/WPq0TDYahvPqty
 KqYA==
X-Gm-Message-State: AOAM533G8YABfAfWE5WinrwTAB7r2gP7SD1tlxPneWWMGoKfTzfLYBd1
 7Vb3tupYxWUtInvkswHeUw0ccjWLs7jONtg7jNyazg==
X-Google-Smtp-Source: ABdhPJyPCJyFkIaU8/5UqvpiHGVd/aUo9CTrajsOwwGQgusjuTqFoIAbdWY4FSS8n/2X2gy8sXDypibNS64Md25IaBk=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr13542693oth.135.1593100425638; 
 Thu, 25 Jun 2020 08:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200623072723.6324-1-f4bug@amsat.org>
 <ff9aec64-419c-330c-bbd3-3b04be70eadd@kaod.org>
 <a1013609-914c-3843-4aba-a5eaa911e59f@amsat.org>
In-Reply-To: <a1013609-914c-3843-4aba-a5eaa911e59f@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 16:53:34 +0100
Message-ID: <CAFEAcA95D6Xek_sL1tX2k6LWSRPShcW9CvsutS3kj2muoxJNkg@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] hw/misc/pca9552: Trace GPIO change events
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 12:09, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> On 6/23/20 10:14 AM, C=C3=A9dric Le Goater wrote:
> > On 6/23/20 9:27 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> >> This series add trace events to better display GPIO changes.
> >> We'll continue in the following series by connecting LEDs to
> >> these GPIOs.
> >>
> >> This helps me to work on a generic LED device, see:
> >> https://www.mail-archive.com/qemu-devel@nongnu.org/msg711917.html
> >
> >
> > Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> Thanks :)
>
> Note to the maintainer, this series is now fully reviewed/tested.



Applied to target-arm.next, thanks.

-- PMM

