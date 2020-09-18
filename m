Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC96C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2A623719
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="luJ8kBfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2A623719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJGE0-000323-Mw
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJGCN-0001ct-Mm
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:13:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJGCH-0000Pu-I2
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:13:11 -0400
Received: by mail-wr1-x442.google.com with SMTP id z1so5597356wrt.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dIa+6Q6iw1OwL5Mje7PaL6CjhM7u+Oe3XAYg36930oo=;
 b=luJ8kBfn1lRNIH9LL3CBJfbCsWH8QsndIgklYcLF9vgqZ5eoZ5Iqe0C6XxaV0aq3iw
 Rr05Bp7Gmy6rZBOK97hobUAn6KCxTns2EX6f867mEC1ieHGs5UGyksDc1avRuTQ4bDuc
 Fhlg5LnQoWcn24VAkwba30MUdZifBSvZx0EhTzcpBUEKVFw5eoJsQkDzLGtvM5E27/Cv
 yFvgx8dBdjYjrC1vY84KXkDUR0oIg45HCxNEpCvCNQipENYZXwUL4zt4FCbigJD0sF2j
 Jd9pDQcTk+fXimfXFpY4qm4sHsztaVMPBsivcmM6GzgKqry2uYrvac55QScIzXcptEg8
 nu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dIa+6Q6iw1OwL5Mje7PaL6CjhM7u+Oe3XAYg36930oo=;
 b=FvyilGYfzrqe9Calx0XTWhx5p3UCpte54No6OnPEbmQNWecD36YjmPwWfsAxeOj/ss
 ycMnMGGIPWzuyeUDCxY38cuS9nmAb27lncRRjgVwykQG5z0+Pb9+11TU2T48oZmPvozA
 L2Q8fRIx4a9WVdl6vu1Nbmeu5a63FUeyghHkeeMAhvFhN3J34gm0R2saOBQ6DbuNlroO
 OkIb9/j4eR7E07iquOF9FG8p/k75RYjSEV+Ocdild7FOAL6npnqk3yo3Ft4ae7x1aHvY
 cyT+eHUdUzK6YfrngU9m3JfVvieKucHr2g9izf9zXQ7xsXje1t3vSMl0T6MCA2UuPGJg
 gYgg==
X-Gm-Message-State: AOAM533mIJcqKjBYxi8KBKy87kh5UCKx8cJv5wiAcpLthw7IuIxDzJ6j
 8GEpAI1M4W6XMtJc1NMIGZyyAJrVSc/Kv4DEDqG1fw==
X-Google-Smtp-Source: ABdhPJygDvwc2wBcAedQLhuJRVnUYGB8z2/xYjBmoL9UMnyjfNQtM4/XI6toJDIW0G2hBMR3eKxaGVKSS6g/1p1CcZE=
X-Received: by 2002:adf:e410:: with SMTP id g16mr28217348wrm.76.1600434784041; 
 Fri, 18 Sep 2020 06:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200918084111.15339-1-ani@anisinha.ca>
 <2fe7283a-6d5b-c62f-52cb-35dc6d94bad5@redhat.com>
In-Reply-To: <2fe7283a-6d5b-c62f-52cb-35dc6d94bad5@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Fri, 18 Sep 2020 18:42:52 +0530
Message-ID: <CAARzgwy3REJBnMkAJPpDbkt_F5_cJjb50oCtQ51+TFhGupk5Og@mail.gmail.com>
Subject: Re: [PATCH v10 00/13] i440fx/acpi: addition of feature and bug fixes.
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::442;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x442.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 3:26 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 9/18/20 10:40 AM, Ani Sinha wrote:
> > Final patch series with all the patches reviewed or ack'd and marked as=
 such.
> > Thanks Julia and Igor for the reviews. Hope this series gets pulled in =
soon.
>
> FYI there is no need to collect tags on the final version.
> Tools already do that for you, see:
> https://patchew.org/QEMU/20200918072325.9933-1-ani@anisinha.ca/
>
> The maintainer can import the patches with the proper Message-Id /
> Reviewed-by / Acked-by / Tested-by tags added using:
> https://patchew.org/QEMU/20200918072325.9933-1-ani@anisinha.ca/mbox

Interesting!

>
> Regards,
>
> Phil.
>

