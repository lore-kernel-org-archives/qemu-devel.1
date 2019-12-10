Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BFEC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 17:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5F4207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 17:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXLuYQfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5F4207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iejMz-0000Z3-K5
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 12:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iejMA-00006E-PG
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iejM8-0006od-39
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:31:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53202
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iejM7-0006ms-VY
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575999086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lqVFWxUZcVYtpz/c/hQYWMC8LJXKaQyspaGPeaIq+0I=;
 b=HXLuYQfLURAGJR7xWCfgfkOdEhHdlm/REprzm4S/V6npuMefl91RFGu4YYEUI1DMRkQkBx
 ZepXVWrYZ9/cJ+tHgnHko5tUdRVwP+4AH8Yg29d3aT90T6THIBMQccwtds1OoY94CrKqf4
 LC9VsO0XUEffWu5QkMakYtkH1d/fZcQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-rJuHBBtlOleDOUzY4zbCLQ-1; Tue, 10 Dec 2019 12:31:23 -0500
Received: by mail-qt1-f198.google.com with SMTP id l25so2428024qtu.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 09:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gJalgkxDukGTyafY4TBUqKx/omKp7CQyyg3DT7ZlT5U=;
 b=PdpOWQ5rXAzVIkX4ejy7iKtNw5TVQX5JEF2AZO7SzO6dmtMmdcNtbwl3HMyh0G8Gml
 4KZGsVpffOfmo2sxT6QhSlLLNV+NmcyelV5BjMPTyYrYu5IB+19cdEZDYYRvGcLD8sy+
 ISc0cxjTTirG4EIBRDaDsLLsc4rjkubtejv5aQPu5hTy8xHFKPbmrvOdu4VBrNZ4MJhW
 UpXfADB+0vrqyiy7jmaWyuf4+uKmlXBX+D/Km4J6kTufcPDuld5Huajhk5bLFVQdJsVx
 qKeDLmx6btDQ90lQEFAiocjFCVbUWhVhBryQ6UFXS9Q9DawAyNGhEtsHMYJgiRQSoi+N
 MLGg==
X-Gm-Message-State: APjAAAUP+lm9xxJ6OpxiRRo/nfvQWbRyQlQkzf4+885Ti5K553OFJFy9
 n0p1AtsCZOvfngfd4RtDrHwTQ0N/N01eXATjw/IVrVCy47CLRSbRG+6HaNV4HqZS7oRwjcGgZCO
 97I0nhNAa0uLWXKs=
X-Received: by 2002:a37:7ac1:: with SMTP id v184mr1103713qkc.447.1575999082735; 
 Tue, 10 Dec 2019 09:31:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxtfVf16Jj7TZZA9imcKj7c5/yLdeBpd3NCHNgyQn4UHEBkah0fARXyaNBWJkxvg63ALOOVGg==
X-Received: by 2002:a37:7ac1:: with SMTP id v184mr1103692qkc.447.1575999082471; 
 Tue, 10 Dec 2019 09:31:22 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id n19sm1123391qkn.52.2019.12.10.09.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 09:31:21 -0800 (PST)
Date: Tue, 10 Dec 2019 12:31:20 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v6] migration: Support QLIST migration
Message-ID: <20191210173120.GG3352@xz-x1>
References: <20191122171621.1307-1-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191122171621.1307-1-eric.auger@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-MC-Unique: rJuHBBtlOleDOUzY4zbCLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 06:16:21PM +0100, Eric Auger wrote:
> Support QLIST migration using the same principle as QTAILQ:
> 94869d5c52 ("migration: migrate QTAILQ").
>=20
> The VMSTATE_QLIST_V macro has the same proto as VMSTATE_QTAILQ_V.
> The change mainly resides in QLIST RAW macros: QLIST_RAW_INSERT_HEAD
> and QLIST_RAW_REVERSE.
>=20
> Tests also are provided.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

https://patchew.org/QEMU/20191023150237.17324-1-eric.auger@redhat.com/diff/=
20191122171621.1307-1-eric.auger@redhat.com/

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


